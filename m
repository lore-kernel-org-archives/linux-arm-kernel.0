From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 Aug 2017 22:49:10 +0530
Subject: [PATCH 17/18] rpmsg: glink: Request for intents when unavailable
In-Reply-To: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1502903951-5403-18-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While sending data, we search for suitable sized
intent to map and simply fail if a intent is not
found. Instead request for a intent of required
size and wait till one is alloted.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 73 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 7b43adc..cfacf4d 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -174,6 +174,10 @@ struct glink_channel {
 
 	struct completion open_ack;
 	struct completion open_req;
+
+	struct mutex intent_req_lock;
+	bool intent_req_result;
+	struct completion intent_req_comp;
 };
 
 #define to_glink_channel(_ept) container_of(_ept, struct glink_channel, ept)
@@ -335,6 +339,24 @@ static void qcom_glink_send_open_ack(struct qcom_glink *glink,
 	qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
 }
 
+static void qcom_glink_handle_intent_req_ack(struct qcom_glink *glink,
+					     unsigned int cid, bool granted)
+{
+	struct glink_channel *channel;
+	unsigned long flags;
+
+	spin_lock_irqsave(&glink->idr_lock, flags);
+	channel = idr_find(&glink->rcids, cid);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
+	if (!channel) {
+		dev_err(glink->dev, "unable to find channel\n");
+		return;
+	}
+
+	channel->intent_req_result = granted;
+	complete(&channel->intent_req_comp);
+}
+
 /**
  * qcom_glink_send_open_req() - send a RPM_CMD_OPEN request to the remote
  * @glink:
@@ -933,6 +955,10 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 		case RPM_CMD_INTENT:
 			qcom_glink_handle_intent(glink, param1, param2, avail);
 			break;
+		case RPM_CMD_RX_INTENT_REQ_ACK:
+			qcom_glink_handle_intent_req_ack(glink, param1, param2);
+			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
+			break;
 		default:
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
@@ -1099,6 +1125,42 @@ static void qcom_glink_destroy_ept(struct rpmsg_endpoint *ept)
 	qcom_glink_send_close_req(glink, channel);
 }
 
+static int qcom_glink_request_intent(struct qcom_glink *glink,
+				     struct glink_channel *channel,
+				     size_t size)
+{
+	struct {
+		u16 id;
+		u16 cid;
+		u32 size;
+	} __packed cmd;
+
+	int ret;
+
+	mutex_lock(&channel->intent_req_lock);
+
+	reinit_completion(&channel->intent_req_comp);
+
+	cmd.id = RPM_CMD_RX_INTENT_REQ;
+	cmd.cid = channel->lcid;
+	cmd.size = size;
+
+	ret = qcom_glink_tx(glink, &cmd, sizeof(cmd), NULL, 0, true);
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_timeout(&channel->intent_req_comp, 10 * HZ);
+	if (!ret) {
+		dev_err(glink->dev, "intent request timed out\n");
+		ret = -ETIMEDOUT;
+	} else {
+		ret = channel->intent_req_result ? 0 : -ECANCELED;
+	}
+
+	mutex_unlock(&channel->intent_req_lock);
+	return ret;
+}
+
 static int __qcom_glink_send(struct glink_channel *channel,
 			     void *data, int len, bool wait)
 {
@@ -1115,7 +1177,7 @@ static int __qcom_glink_send(struct glink_channel *channel,
 	unsigned long flags;
 
 	if (!glink->intentless) {
-		if (!intent) {
+		while (!intent) {
 			spin_lock_irqsave(&channel->intent_lock, flags);
 			idr_for_each_entry(&channel->riids, tmp, iid) {
 				if (tmp->size >= len && !tmp->in_use) {
@@ -1127,8 +1189,15 @@ static int __qcom_glink_send(struct glink_channel *channel,
 			spin_unlock_irqrestore(&channel->intent_lock, flags);
 
 			/* We found an available intent */
-			if (!intent)
+			if (intent)
+				break;
+
+			if (!wait)
 				return -EBUSY;
+
+			ret = qcom_glink_request_intent(glink, channel, len);
+			if (ret < 0)
+				return ret;
 		}
 
 		iid = intent->id;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
