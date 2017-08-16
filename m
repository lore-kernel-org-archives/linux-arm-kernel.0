From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 Aug 2017 22:49:09 +0530
Subject: [PATCH 16/18] rpmsg: glink: Use the intents passed by remote
In-Reply-To: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1502903951-5403-17-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While sending data, use the remote intent id buffer
of suitable size that was passed by remote previously.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 738303e..7b43adc 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1103,19 +1103,50 @@ static int __qcom_glink_send(struct glink_channel *channel,
 			     void *data, int len, bool wait)
 {
 	struct qcom_glink *glink = channel->glink;
+	struct glink_core_rx_intent *intent = NULL;
+	struct glink_core_rx_intent *tmp;
+	int iid = 0;
 	struct {
 		struct glink_msg msg;
 		__le32 chunk_size;
 		__le32 left_size;
 	} __packed req;
+	int ret;
+	unsigned long flags;
+
+	if (!glink->intentless) {
+		if (!intent) {
+			spin_lock_irqsave(&channel->intent_lock, flags);
+			idr_for_each_entry(&channel->riids, tmp, iid) {
+				if (tmp->size >= len && !tmp->in_use) {
+					tmp->in_use = true;
+					intent = tmp;
+					break;
+				}
+			}
+			spin_unlock_irqrestore(&channel->intent_lock, flags);
+
+			/* We found an available intent */
+			if (!intent)
+				return -EBUSY;
+		}
+
+		iid = intent->id;
+	}
 
 	req.msg.cmd = cpu_to_le16(RPM_CMD_TX_DATA);
 	req.msg.param1 = cpu_to_le16(channel->lcid);
-	req.msg.param2 = cpu_to_le32(channel->rcid);
+	req.msg.param2 = cpu_to_le32(iid);
 	req.chunk_size = cpu_to_le32(len);
 	req.left_size = cpu_to_le32(0);
 
-	return qcom_glink_tx(glink, &req, sizeof(req), data, len, wait);
+	ret = qcom_glink_tx(glink, &req, sizeof(req), data, len, wait);
+
+	/* Mark intent available if we failed */
+	if (ret)
+		intent->in_use = false;
+
+	return ret;
 }
 
 static int qcom_glink_send(struct rpmsg_endpoint *ept, void *data, int len)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
