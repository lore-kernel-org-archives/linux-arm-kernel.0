From: sricharan@codeaurora.org (Sricharan R)
Date: Thu, 24 Aug 2017 12:51:42 +0530
Subject: [PATCH v2 20/20] rpmsg: glink: Handle remote rx done command
In-Reply-To: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
References: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1503559302-3744-21-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once the remote side sends a rx done ack, check
for the intent reuse information from it and
suitably discard or reuse the remote passed
intent buffers.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 42 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 54ddb66..08953ca 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -657,6 +657,40 @@ static int qcom_glink_advertise_intent(struct qcom_glink *glink,
 	return intent;
 }
 
+static void qcom_glink_handle_rx_done(struct qcom_glink *glink,
+				      u32 cid, uint32_t iid,
+				      bool reuse)
+{
+	struct glink_core_rx_intent *intent;
+	struct glink_channel *channel;
+	unsigned long flags;
+
+	spin_lock_irqsave(&glink->idr_lock, flags);
+	channel = idr_find(&glink->rcids, cid);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
+	if (!channel) {
+		dev_err(glink->dev, "invalid channel id received\n");
+		return;
+	}
+
+	spin_lock_irqsave(&channel->intent_lock, flags);
+	intent = idr_find(&channel->riids, iid);
+
+	if (!intent) {
+		spin_unlock_irqrestore(&channel->intent_lock, flags);
+		dev_err(glink->dev, "invalid intent id received\n");
+		return;
+	}
+
+	intent->in_use = false;
+
+	if (!reuse) {
+		idr_remove(&channel->riids, intent->id);
+		kfree(intent);
+	}
+	spin_unlock_irqrestore(&channel->intent_lock, flags);
+}
+
 /**
  * qcom_glink_handle_intent_req() - Receive a request for rx_intent
  *					    from remote side
@@ -965,6 +999,14 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 		case RPM_CMD_INTENT:
 			qcom_glink_handle_intent(glink, param1, param2, avail);
 			break;
+		case RPM_CMD_RX_DONE:
+			qcom_glink_handle_rx_done(glink, param1, param2, false);
+			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
+			break;
+		case RPM_CMD_RX_DONE_W_REUSE:
+			qcom_glink_handle_rx_done(glink, param1, param2, true);
+			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
+			break;
 		case RPM_CMD_RX_INTENT_REQ_ACK:
 			qcom_glink_handle_intent_req_ack(glink, param1, param2);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
