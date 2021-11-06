# I'm expecting some greps to fail, so we want to continue running whenever we encounter errors.
set +e

# Create the label of interest first, in case it doesn't already exist.
CREATION_RESPONSE=$(curl \
  -X POST \
  -d '{"name":"${LABEL}"}'
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  https://api.github.com/repos/${GITHUB_REPOSITORY}/labels)
echo "creation_response: $CREATION_RESPONSE"

# We already know that the pull request should have the label of interest but doesn't. Let's rectify that.
echo "Adding PR label."
PR_NUMBER=${GITHUB_EVENT_NUMBER}
RESPONSE=$(curl \
  -X POST \
  -d '{"labels":["${LABEL}"]}'
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${PR_NUMBER}/labels)
echo "response: $RESPONSE"
