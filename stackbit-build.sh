#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://a4d0871e.ngrok.io/project/5de6379ead870c1ef451a115/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://a4d0871e.ngrok.io/pull/5de6379ead870c1ef451a115 
fi
curl -s -X POST https://a4d0871e.ngrok.io/project/5de6379ead870c1ef451a115/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://a4d0871e.ngrok.io/project/5de6379ead870c1ef451a115/webhook/build/publish > /dev/null
