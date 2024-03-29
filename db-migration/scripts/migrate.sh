#!/bin/sh
cd `dirname $0`

curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.1.2/cloud-sql-proxy.linux.amd64
chmod +x cloud-sql-proxy

./cloud-sql-proxy --private-ip ${INSTANCE_CONNECTION_NAME} & sleep 2;

URL="postgres://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}?search_path=public&sslmode=disable"

atlas migrate apply --dir "file://../migrations" --url ${URL}
