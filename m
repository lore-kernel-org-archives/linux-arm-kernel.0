From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri,  7 Oct 2016 21:23:11 -0700
Subject: [PATCH 1/5] rpmsg: smd: Reduce restrictions when finding channel
Message-ID: <1475900595-8375-1-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMD channels are created by the remotes in "opening" state, but
sometimes as we close and try to reopen them they linger in closing
state.

Following the search for a matching channel the create_ept() will verify
that the channel is in a suitable state, so we can lax the restrictions
of the search function to work around above difference in behaviour.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_smd.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 06fef2b4c814..92efa74a0024 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -820,20 +820,13 @@ qcom_smd_find_channel(struct qcom_smd_edge *edge, const char *name)
 	struct qcom_smd_channel *channel;
 	struct qcom_smd_channel *ret = NULL;
 	unsigned long flags;
-	unsigned state;
 
 	spin_lock_irqsave(&edge->channels_lock, flags);
 	list_for_each_entry(channel, &edge->channels, list) {
-		if (strcmp(channel->name, name))
-			continue;
-
-		state = GET_RX_CHANNEL_INFO(channel, state);
-		if (state != SMD_CHANNEL_OPENING &&
-		    state != SMD_CHANNEL_OPENED)
-			continue;
-
-		ret = channel;
-		break;
+		if (!strcmp(channel->name, name)) {
+			ret = channel;
+			break;
+		}
 	}
 	spin_unlock_irqrestore(&edge->channels_lock, flags);
 
-- 
2.5.0
