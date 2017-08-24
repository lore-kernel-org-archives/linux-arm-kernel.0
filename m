From: sricharan@codeaurora.org (Sricharan R)
Date: Thu, 24 Aug 2017 12:51:34 +0530
Subject: [PATCH v2 12/20] rpmsg: glink: Add support for TX intents
In-Reply-To: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
References: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1503559302-3744-13-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Intents are nothing but pre-allocated buffers of
appropriate size that are allocated on the local
side and communicated to the remote side and the
remote stores the list of intent ids that it is
informed.

Later when remote side is intenting to send data,
it picks up a right intent (based on the size) and
sends the data buffer and the intent id. Local side
receives the data and copies it to the local intent
buffer.

The whole idea is to avoid stalls on the transport
for allocating memory, used for copy based transports.

When the remote request to allocate buffers using
CMD_RX_INTENT_REQ, we allocate buffers of requested
size, store the buffer id locally and also communicate
the intent id to the remote.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 167 +++++++++++++++++++++++++++++++++++++-
 drivers/rpmsg/qcom_glink_native.h |   3 +-
 drivers/rpmsg/qcom_glink_rpm.c    |   3 +-
 drivers/rpmsg/qcom_glink_smem.c   |   5 +-
 4 files changed, 173 insertions(+), 5 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 588a56c..7778e57 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -60,6 +60,26 @@ struct glink_defer_cmd {
 };
 
 /**
+ * struct glink_core_rx_intent - RX intent
+ * RX intent
+ *
+ * data: pointer to the data (may be NULL for zero-copy)
+ * id: remote or local intent ID
+ * size: size of the original intent (do not modify)
+ * reuse: To mark if the intent can be reused after first use
+ * in_use: To mark if intent is already in use for the channel
+ * offset: next write offset (initially 0)
+ */
+struct glink_core_rx_intent {
+	void *data;
+	u32 id;
+	size_t size;
+	bool reuse;
+	bool in_use;
+	u32 offset;
+};
+
+/**
  * struct qcom_glink - driver context, relates to one remote subsystem
  * @dev:	reference to the associated struct device
  * @mbox_client: mailbox client
@@ -117,6 +137,8 @@ enum {
  * @name:	unique channel name/identifier
  * @lcid:	channel id, in local space
  * @rcid:	channel id, in remote space
+ * @intent_lock: lock for protection of @liids
+ * @liids:	idr of all local intents
  * @buf:	receive buffer, for gathering fragments
  * @buf_offset:	write offset in @buf
  * @buf_size:	size of current @buf
@@ -137,6 +159,9 @@ struct glink_channel {
 	unsigned int lcid;
 	unsigned int rcid;
 
+	spinlock_t intent_lock;
+	struct idr liids;
+
 	void *buf;
 	int buf_offset;
 	int buf_size;
@@ -154,6 +179,9 @@ struct glink_channel {
 #define RPM_CMD_OPEN			2
 #define RPM_CMD_CLOSE			3
 #define RPM_CMD_OPEN_ACK		4
+#define RPM_CMD_INTENT			5
+#define RPM_CMD_RX_INTENT_REQ		7
+#define RPM_CMD_RX_INTENT_REQ_ACK	8
 #define RPM_CMD_TX_DATA			9
 #define RPM_CMD_CLOSE_ACK		11
 #define RPM_CMD_TX_DATA_CONT		12
@@ -172,12 +200,14 @@ static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
 
 	/* Setup glink internal glink_channel data */
 	spin_lock_init(&channel->recv_lock);
+	spin_lock_init(&channel->intent_lock);
 	channel->glink = glink;
 	channel->name = kstrdup(name, GFP_KERNEL);
 
 	init_completion(&channel->open_req);
 	init_completion(&channel->open_ack);
 
+	idr_init(&channel->liids);
 	kref_init(&channel->refcount);
 
 	return channel;
@@ -187,6 +217,11 @@ static void qcom_glink_channel_release(struct kref *ref)
 {
 	struct glink_channel *channel = container_of(ref, struct glink_channel,
 						     refcount);
+	unsigned long flags;
+
+	spin_lock_irqsave(&channel->intent_lock, flags);
+	idr_destroy(&channel->liids);
+	spin_unlock_irqrestore(&channel->intent_lock, flags);
 
 	kfree(channel->name);
 	kfree(channel);
@@ -424,6 +459,130 @@ static void qcom_glink_receive_version_ack(struct qcom_glink *glink,
 	}
 }
 
+/**
+ * qcom_glink_send_intent_req_ack() - convert an rx intent request ack cmd to
+				      wire format and transmit
+ * @glink:	The transport to transmit on.
+ * @channel:	The glink channel
+ * @granted:	The request response to encode.
+ *
+ * Return: 0 on success or standard Linux error code.
+ */
+static int qcom_glink_send_intent_req_ack(struct qcom_glink *glink,
+					  struct glink_channel *channel,
+					  bool granted)
+{
+	struct glink_msg msg;
+
+	msg.cmd = cpu_to_le16(RPM_CMD_RX_INTENT_REQ_ACK);
+	msg.param1 = cpu_to_le16(channel->lcid);
+	msg.param2 = cpu_to_le32(granted);
+
+	qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
+
+	return 0;
+}
+
+/**
+ * qcom_glink_advertise_intent - convert an rx intent cmd to wire format and
+ *			   transmit
+ * @glink:	The transport to transmit on.
+ * @channel:	The local channel
+ * @size:	The intent to pass on to remote.
+ *
+ * Return: 0 on success or standard Linux error code.
+ */
+static int qcom_glink_advertise_intent(struct qcom_glink *glink,
+				       struct glink_channel *channel,
+				       struct glink_core_rx_intent *intent)
+{
+	struct command {
+		u16 id;
+		u16 lcid;
+		u32 count;
+		u32 size;
+		u32 liid;
+	} __packed;
+	struct command cmd;
+
+	cmd.id = cpu_to_le16(RPM_CMD_INTENT);
+	cmd.lcid = cpu_to_le16(channel->lcid);
+	cmd.count = cpu_to_le32(1);
+	cmd.size = cpu_to_le32(intent->size);
+	cmd.liid = cpu_to_le32(intent->id);
+
+	qcom_glink_tx(glink, &cmd, sizeof(cmd), NULL, 0, true);
+
+	return 0;
+}
+
+static struct glink_core_rx_intent *
+qcom_glink_alloc_intent(struct qcom_glink *glink,
+			struct glink_channel *channel,
+			size_t size,
+			bool reuseable)
+{
+	struct glink_core_rx_intent *intent;
+	int ret;
+	unsigned long flags;
+
+	intent = kzalloc(sizeof(*intent), GFP_KERNEL);
+
+	if (!intent)
+		return NULL;
+
+	intent->data = kzalloc(size, GFP_KERNEL);
+	if (!intent->data)
+		return NULL;
+
+	spin_lock_irqsave(&channel->intent_lock, flags);
+	ret = idr_alloc_cyclic(&channel->liids, intent, 1, -1, GFP_ATOMIC);
+	if (ret < 0) {
+		spin_unlock_irqrestore(&channel->intent_lock, flags);
+		return NULL;
+	}
+	spin_unlock_irqrestore(&channel->intent_lock, flags);
+
+	intent->id = ret;
+	intent->size = size;
+	intent->reuse = reuseable;
+
+	return intent;
+}
+
+/**
+ * qcom_glink_handle_intent_req() - Receive a request for rx_intent
+ *					    from remote side
+ * if_ptr:      Pointer to the transport interface
+ * rcid:	Remote channel ID
+ * size:	size of the intent
+ *
+ * The function searches for the local channel to which the request for
+ * rx_intent has arrived and allocates and notifies the remote back
+ */
+static void qcom_glink_handle_intent_req(struct qcom_glink *glink,
+					 u32 cid, size_t size)
+{
+	struct glink_core_rx_intent *intent;
+	struct glink_channel *channel;
+	unsigned long flags;
+
+	spin_lock_irqsave(&glink->idr_lock, flags);
+	channel = idr_find(&glink->rcids, cid);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
+
+	if (!channel) {
+		pr_err("%s channel not found for cid %d\n", __func__, cid);
+		return;
+	}
+
+	intent = qcom_glink_alloc_intent(glink, channel, size, false);
+	if (intent)
+		qcom_glink_advertise_intent(glink, channel, intent);
+
+	qcom_glink_send_intent_req_ack(glink, channel, !!intent);
+}
+
 static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
 {
 	struct glink_defer_cmd *dcmd;
@@ -586,6 +745,7 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 		case RPM_CMD_VERSION_ACK:
 		case RPM_CMD_CLOSE:
 		case RPM_CMD_CLOSE_ACK:
+		case RPM_CMD_RX_INTENT_REQ:
 			ret = qcom_glink_rx_defer(glink, 0);
 			break;
 		case RPM_CMD_OPEN_ACK:
@@ -1003,6 +1163,9 @@ static void qcom_glink_work(struct work_struct *work)
 		case RPM_CMD_CLOSE_ACK:
 			qcom_glink_rx_close_ack(glink, param1);
 			break;
+		case RPM_CMD_RX_INTENT_REQ:
+			qcom_glink_handle_intent_req(glink, param1, param2);
+			break;
 		default:
 			WARN(1, "Unknown defer object %d\n", cmd);
 			break;
@@ -1015,7 +1178,8 @@ static void qcom_glink_work(struct work_struct *work)
 struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 					   unsigned long features,
 					   struct qcom_glink_pipe *rx,
-					   struct qcom_glink_pipe *tx)
+					   struct qcom_glink_pipe *tx,
+					   bool intentless)
 {
 	int irq;
 	int ret;
@@ -1030,6 +1194,7 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 	glink->rx_pipe = rx;
 
 	glink->features = features;
+	glink->intentless = intentless;
 
 	mutex_init(&glink->tx_lock);
 	spin_lock_init(&glink->rx_lock);
diff --git a/drivers/rpmsg/qcom_glink_native.h b/drivers/rpmsg/qcom_glink_native.h
index 456ec79..92e0881 100644
--- a/drivers/rpmsg/qcom_glink_native.h
+++ b/drivers/rpmsg/qcom_glink_native.h
@@ -37,7 +37,8 @@ struct qcom_glink_pipe {
 struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 					   unsigned long features,
 					   struct qcom_glink_pipe *rx,
-					   struct qcom_glink_pipe *tx);
+					   struct qcom_glink_pipe *tx,
+					   bool intentless);
 void qcom_glink_native_remove(struct qcom_glink *glink);
 
 void qcom_glink_native_unregister(struct qcom_glink *glink);
diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
index 7d039cd..5a86e08 100644
--- a/drivers/rpmsg/qcom_glink_rpm.c
+++ b/drivers/rpmsg/qcom_glink_rpm.c
@@ -305,7 +305,8 @@ static int glink_rpm_probe(struct platform_device *pdev)
 	glink = qcom_glink_native_probe(&pdev->dev,
 					0,
 					&rx_pipe->native,
-					&tx_pipe->native);
+					&tx_pipe->native,
+					true);
 	if (IS_ERR(glink))
 		return PTR_ERR(glink);
 
diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index b78874b..9d73ced 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -284,8 +284,9 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 	*tx_pipe->head = 0;
 
 	glink = qcom_glink_native_probe(dev,
-					GLINK_FEATURE_TRACER_PKT,
-					&rx_pipe->native, &tx_pipe->native);
+					GLINK_FEATURE_INTENT_REUSE,
+					&rx_pipe->native, &tx_pipe->native,
+					false);
 	if (IS_ERR(glink)) {
 		ret = PTR_ERR(glink);
 		goto err_put_dev;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
