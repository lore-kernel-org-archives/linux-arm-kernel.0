From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 Aug 2017 22:48:54 +0530
Subject: [PATCH 01/18] rpmsg: glink: Rename glink_rpm_xx functions to
 qcom_glink_xx
In-Reply-To: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1502903951-5403-2-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Renaming the glink_rpm_xx functions and structs to qcom_glink_xx
equivalents helps to reuse the core glink protocol while adding
support for smem based glink transport in the later patches.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_rpm.c | 248 +++++++++++++++++++++--------------------
 1 file changed, 128 insertions(+), 120 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
index 3559a3e..56a0a66 100644
--- a/drivers/rpmsg/qcom_glink_rpm.c
+++ b/drivers/rpmsg/qcom_glink_rpm.c
@@ -101,7 +101,7 @@ struct glink_defer_cmd {
  * @lcids:	idr of all channels with a known local channel id
  * @rcids:	idr of all channels with a known remote channel id
  */
-struct glink_rpm {
+struct qcom_glink {
 	struct device *dev;
 
 	struct mbox_client mbox_client;
@@ -134,7 +134,7 @@ enum {
  * struct glink_channel - internal representation of a channel
  * @rpdev:	rpdev reference, only used for primary endpoints
  * @ept:	rpmsg endpoint this channel is associated with
- * @glink:	glink_rpm context handle
+ * @glink:	qcom_glink context handle
  * @refcount:	refcount for the channel object
  * @recv_lock:	guard for @ept.cb
  * @name:	unique channel name/identifier
@@ -150,7 +150,7 @@ struct glink_channel {
 	struct rpmsg_endpoint ept;
 
 	struct rpmsg_device *rpdev;
-	struct glink_rpm *glink;
+	struct qcom_glink *glink;
 
 	struct kref refcount;
 
@@ -184,8 +184,8 @@ struct glink_channel {
 
 #define GLINK_FEATURE_INTENTLESS	BIT(1)
 
-static struct glink_channel *glink_rpm_alloc_channel(struct glink_rpm *glink,
-						     const char *name)
+static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
+						      const char *name)
 {
 	struct glink_channel *channel;
 
@@ -206,7 +206,7 @@ static struct glink_channel *glink_rpm_alloc_channel(struct glink_rpm *glink,
 	return channel;
 }
 
-static void glink_rpm_channel_release(struct kref *ref)
+static void qcom_glink_channel_release(struct kref *ref)
 {
 	struct glink_channel *channel = container_of(ref, struct glink_channel,
 						     refcount);
@@ -215,7 +215,7 @@ static void glink_rpm_channel_release(struct kref *ref)
 	kfree(channel);
 }
 
-static size_t glink_rpm_rx_avail(struct glink_rpm *glink)
+static size_t qcom_glink_rx_avail(struct qcom_glink *glink)
 {
 	struct glink_rpm_pipe *pipe = &glink->rx_pipe;
 	unsigned int head;
@@ -230,8 +230,8 @@ static size_t glink_rpm_rx_avail(struct glink_rpm *glink)
 		return head - tail;
 }
 
-static void glink_rpm_rx_peak(struct glink_rpm *glink,
-			      void *data, size_t count)
+static void qcom_glink_rx_peak(struct qcom_glink *glink,
+			       void *data, size_t count)
 {
 	struct glink_rpm_pipe *pipe = &glink->rx_pipe;
 	unsigned int tail;
@@ -251,8 +251,8 @@ static void glink_rpm_rx_peak(struct glink_rpm *glink,
 	}
 }
 
-static void glink_rpm_rx_advance(struct glink_rpm *glink,
-				 size_t count)
+static void qcom_glink_rx_advance(struct qcom_glink *glink,
+				  size_t count)
 {
 	struct glink_rpm_pipe *pipe = &glink->rx_pipe;
 	unsigned int tail;
@@ -266,7 +266,7 @@ static void glink_rpm_rx_advance(struct glink_rpm *glink,
 	writel(tail, pipe->tail);
 }
 
-static size_t glink_rpm_tx_avail(struct glink_rpm *glink)
+static size_t qcom_glink_tx_avail(struct qcom_glink *glink)
 {
 	struct glink_rpm_pipe *pipe = &glink->tx_pipe;
 	unsigned int head;
@@ -281,9 +281,9 @@ static size_t glink_rpm_tx_avail(struct glink_rpm *glink)
 		return tail - head;
 }
 
-static unsigned int glink_rpm_tx_write(struct glink_rpm *glink,
-				       unsigned int head,
-				       const void *data, size_t count)
+static unsigned int qcom_glink_tx_write(struct qcom_glink *glink,
+					unsigned int head,
+					const void *data, size_t count)
 {
 	struct glink_rpm_pipe *pipe = &glink->tx_pipe;
 	size_t len;
@@ -306,8 +306,8 @@ static unsigned int glink_rpm_tx_write(struct glink_rpm *glink,
 	return head;
 }
 
-static int glink_rpm_tx(struct glink_rpm *glink,
-			const void *hdr, size_t hlen,
+static int qcom_glink_tx(struct qcom_glink *glink,
+			 const void *hdr, size_t hlen,
 			const void *data, size_t dlen, bool wait)
 {
 	struct glink_rpm_pipe *pipe = &glink->tx_pipe;
@@ -326,7 +326,7 @@ static int glink_rpm_tx(struct glink_rpm *glink,
 	if (ret)
 		return ret;
 
-	while (glink_rpm_tx_avail(glink) < tlen) {
+	while (qcom_glink_tx_avail(glink) < tlen) {
 		if (!wait) {
 			ret = -ENOMEM;
 			goto out;
@@ -336,8 +336,8 @@ static int glink_rpm_tx(struct glink_rpm *glink,
 	}
 
 	head = readl(pipe->head);
-	head = glink_rpm_tx_write(glink, head, hdr, hlen);
-	head = glink_rpm_tx_write(glink, head, data, dlen);
+	head = qcom_glink_tx_write(glink, head, hdr, hlen);
+	head = qcom_glink_tx_write(glink, head, data, dlen);
 	writel(head, pipe->head);
 
 	mbox_send_message(glink->mbox_chan, NULL);
@@ -349,7 +349,7 @@ static int glink_rpm_tx(struct glink_rpm *glink,
 	return ret;
 }
 
-static int glink_rpm_send_version(struct glink_rpm *glink)
+static int qcom_glink_send_version(struct qcom_glink *glink)
 {
 	struct glink_msg msg;
 
@@ -357,10 +357,10 @@ static int glink_rpm_send_version(struct glink_rpm *glink)
 	msg.param1 = cpu_to_le16(1);
 	msg.param2 = cpu_to_le32(GLINK_FEATURE_INTENTLESS);
 
-	return glink_rpm_tx(glink, &msg, sizeof(msg), NULL, 0, true);
+	return qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
 }
 
-static void glink_rpm_send_version_ack(struct glink_rpm *glink)
+static void qcom_glink_send_version_ack(struct qcom_glink *glink)
 {
 	struct glink_msg msg;
 
@@ -368,11 +368,11 @@ static void glink_rpm_send_version_ack(struct glink_rpm *glink)
 	msg.param1 = cpu_to_le16(1);
 	msg.param2 = cpu_to_le32(0);
 
-	glink_rpm_tx(glink, &msg, sizeof(msg), NULL, 0, true);
+	qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
 }
 
-static void glink_rpm_send_open_ack(struct glink_rpm *glink,
-					 struct glink_channel *channel)
+static void qcom_glink_send_open_ack(struct qcom_glink *glink,
+				     struct glink_channel *channel)
 {
 	struct glink_msg msg;
 
@@ -380,11 +380,11 @@ static void glink_rpm_send_open_ack(struct glink_rpm *glink,
 	msg.param1 = cpu_to_le16(channel->rcid);
 	msg.param2 = cpu_to_le32(0);
 
-	glink_rpm_tx(glink, &msg, sizeof(msg), NULL, 0, true);
+	qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
 }
 
 /**
- * glink_rpm_send_open_req() - send a RPM_CMD_OPEN request to the remote
+ * qcom_glink_send_open_req() - send a RPM_CMD_OPEN request to the remote
  * @glink:
  * @channel:
  *
@@ -393,8 +393,8 @@ static void glink_rpm_send_open_ack(struct glink_rpm *glink,
  *
  * Returns 0 on success, negative errno otherwise.
  */
-static int glink_rpm_send_open_req(struct glink_rpm *glink,
-					 struct glink_channel *channel)
+static int qcom_glink_send_open_req(struct qcom_glink *glink,
+				    struct glink_channel *channel)
 {
 	struct {
 		struct glink_msg msg;
@@ -420,7 +420,7 @@ static int glink_rpm_send_open_req(struct glink_rpm *glink,
 	req.msg.param2 = cpu_to_le32(name_len);
 	strcpy(req.name, channel->name);
 
-	ret = glink_rpm_tx(glink, &req, req_len, NULL, 0, true);
+	ret = qcom_glink_tx(glink, &req, req_len, NULL, 0, true);
 	if (ret)
 		goto remove_idr;
 
@@ -435,8 +435,8 @@ static int glink_rpm_send_open_req(struct glink_rpm *glink,
 	return ret;
 }
 
-static void glink_rpm_send_close_req(struct glink_rpm *glink,
-					  struct glink_channel *channel)
+static void qcom_glink_send_close_req(struct qcom_glink *glink,
+				      struct glink_channel *channel)
 {
 	struct glink_msg req;
 
@@ -444,10 +444,11 @@ static void glink_rpm_send_close_req(struct glink_rpm *glink,
 	req.param1 = cpu_to_le16(channel->lcid);
 	req.param2 = 0;
 
-	glink_rpm_tx(glink, &req, sizeof(req), NULL, 0, true);
+	qcom_glink_tx(glink, &req, sizeof(req), NULL, 0, true);
 }
 
-static void glink_rpm_send_close_ack(struct glink_rpm *glink, unsigned int rcid)
+static void qcom_glink_send_close_ack(struct qcom_glink *glink,
+				      unsigned int rcid)
 {
 	struct glink_msg req;
 
@@ -455,16 +456,16 @@ static void glink_rpm_send_close_ack(struct glink_rpm *glink, unsigned int rcid)
 	req.param1 = cpu_to_le16(rcid);
 	req.param2 = 0;
 
-	glink_rpm_tx(glink, &req, sizeof(req), NULL, 0, true);
+	qcom_glink_tx(glink, &req, sizeof(req), NULL, 0, true);
 }
 
-static int glink_rpm_rx_defer(struct glink_rpm *glink, size_t extra)
+static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
 {
 	struct glink_defer_cmd *dcmd;
 
 	extra = ALIGN(extra, 8);
 
-	if (glink_rpm_rx_avail(glink) < sizeof(struct glink_msg) + extra) {
+	if (qcom_glink_rx_avail(glink) < sizeof(struct glink_msg) + extra) {
 		dev_dbg(glink->dev, "Insufficient data in rx fifo");
 		return -ENXIO;
 	}
@@ -475,19 +476,19 @@ static int glink_rpm_rx_defer(struct glink_rpm *glink, size_t extra)
 
 	INIT_LIST_HEAD(&dcmd->node);
 
-	glink_rpm_rx_peak(glink, &dcmd->msg, sizeof(dcmd->msg) + extra);
+	qcom_glink_rx_peak(glink, &dcmd->msg, sizeof(dcmd->msg) + extra);
 
 	spin_lock(&glink->rx_lock);
 	list_add_tail(&dcmd->node, &glink->rx_queue);
 	spin_unlock(&glink->rx_lock);
 
 	schedule_work(&glink->rx_work);
-	glink_rpm_rx_advance(glink, sizeof(dcmd->msg) + extra);
+	qcom_glink_rx_advance(glink, sizeof(dcmd->msg) + extra);
 
 	return 0;
 }
 
-static int glink_rpm_rx_data(struct glink_rpm *glink, size_t avail)
+static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 {
 	struct glink_channel *channel;
 	struct {
@@ -504,7 +505,7 @@ static int glink_rpm_rx_data(struct glink_rpm *glink, size_t avail)
 		return -EAGAIN;
 	}
 
-	glink_rpm_rx_peak(glink, &hdr, sizeof(hdr));
+	qcom_glink_rx_peak(glink, &hdr, sizeof(hdr));
 	chunk_size = le32_to_cpu(hdr.chunk_size);
 	left_size = le32_to_cpu(hdr.left_size);
 
@@ -522,7 +523,8 @@ static int glink_rpm_rx_data(struct glink_rpm *glink, size_t avail)
 		dev_dbg(glink->dev, "Data on non-existing channel\n");
 
 		/* Drop the message */
-		glink_rpm_rx_advance(glink, ALIGN(sizeof(hdr) + chunk_size, 8));
+		qcom_glink_rx_advance(glink,
+				      ALIGN(sizeof(hdr) + chunk_size, 8));
 		return 0;
 	}
 
@@ -536,17 +538,18 @@ static int glink_rpm_rx_data(struct glink_rpm *glink, size_t avail)
 		channel->buf_offset = 0;
 	}
 
-	glink_rpm_rx_advance(glink, sizeof(hdr));
+	qcom_glink_rx_advance(glink, sizeof(hdr));
 
 	if (channel->buf_size - channel->buf_offset < chunk_size) {
 		dev_err(glink->dev, "Insufficient space in input buffer\n");
 
 		/* The packet header lied, drop payload */
-		glink_rpm_rx_advance(glink, chunk_size);
+		qcom_glink_rx_advance(glink, chunk_size);
 		return -ENOMEM;
 	}
 
-	glink_rpm_rx_peak(glink, channel->buf + channel->buf_offset, chunk_size);
+	qcom_glink_rx_peak(glink, channel->buf + channel->buf_offset,
+			   chunk_size);
 	channel->buf_offset += chunk_size;
 
 	/* Handle message when no fragments remain to be received */
@@ -567,12 +570,12 @@ static int glink_rpm_rx_data(struct glink_rpm *glink, size_t avail)
 	}
 
 	/* Each message starts at 8 byte aligned address */
-	glink_rpm_rx_advance(glink, ALIGN(chunk_size, 8));
+	qcom_glink_rx_advance(glink, ALIGN(chunk_size, 8));
 
 	return 0;
 }
 
-static int glink_rpm_rx_open_ack(struct glink_rpm *glink, unsigned int lcid)
+static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
 {
 	struct glink_channel *channel;
 
@@ -587,9 +590,9 @@ static int glink_rpm_rx_open_ack(struct glink_rpm *glink, unsigned int lcid)
 	return 0;
 }
 
-static irqreturn_t glink_rpm_intr(int irq, void *data)
+static irqreturn_t qcom_glink_intr(int irq, void *data)
 {
-	struct glink_rpm *glink = data;
+	struct qcom_glink *glink = data;
 	struct glink_msg msg;
 	unsigned int param1;
 	unsigned int param2;
@@ -598,11 +601,11 @@ static irqreturn_t glink_rpm_intr(int irq, void *data)
 	int ret;
 
 	for (;;) {
-		avail = glink_rpm_rx_avail(glink);
+		avail = qcom_glink_rx_avail(glink);
 		if (avail < sizeof(msg))
 			break;
 
-		glink_rpm_rx_peak(glink, &msg, sizeof(msg));
+		qcom_glink_rx_peak(glink, &msg, sizeof(msg));
 
 		cmd = le16_to_cpu(msg.cmd);
 		param1 = le16_to_cpu(msg.param1);
@@ -613,21 +616,21 @@ static irqreturn_t glink_rpm_intr(int irq, void *data)
 		case RPM_CMD_VERSION_ACK:
 		case RPM_CMD_CLOSE:
 		case RPM_CMD_CLOSE_ACK:
-			ret = glink_rpm_rx_defer(glink, 0);
+			ret = qcom_glink_rx_defer(glink, 0);
 			break;
 		case RPM_CMD_OPEN_ACK:
-			ret = glink_rpm_rx_open_ack(glink, param1);
-			glink_rpm_rx_advance(glink, ALIGN(sizeof(msg), 8));
+			ret = qcom_glink_rx_open_ack(glink, param1);
+			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
 		case RPM_CMD_OPEN:
-			ret = glink_rpm_rx_defer(glink, param2);
+			ret = qcom_glink_rx_defer(glink, param2);
 			break;
 		case RPM_CMD_TX_DATA:
 		case RPM_CMD_TX_DATA_CONT:
-			ret = glink_rpm_rx_data(glink, avail);
+			ret = qcom_glink_rx_data(glink, avail);
 			break;
 		case RPM_CMD_READ_NOTIF:
-			glink_rpm_rx_advance(glink, ALIGN(sizeof(msg), 8));
+			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 
 			mbox_send_message(glink->mbox_chan, NULL);
 			mbox_client_txdone(glink->mbox_chan, 0);
@@ -648,17 +651,17 @@ static irqreturn_t glink_rpm_intr(int irq, void *data)
 }
 
 /* Locally initiated rpmsg_create_ept */
-static struct glink_channel *glink_rpm_create_local(struct glink_rpm *glink,
-						    const char *name)
+static struct glink_channel *qcom_glink_create_local(struct qcom_glink *glink,
+						     const char *name)
 {
 	struct glink_channel *channel;
 	int ret;
 
-	channel = glink_rpm_alloc_channel(glink, name);
+	channel = qcom_glink_alloc_channel(glink, name);
 	if (IS_ERR(channel))
 		return ERR_CAST(channel);
 
-	ret = glink_rpm_send_open_req(glink, channel);
+	ret = qcom_glink_send_open_req(glink, channel);
 	if (ret)
 		goto release_channel;
 
@@ -670,34 +673,34 @@ static struct glink_channel *glink_rpm_create_local(struct glink_rpm *glink,
 	if (!ret)
 		goto err_timeout;
 
-	glink_rpm_send_open_ack(glink, channel);
+	qcom_glink_send_open_ack(glink, channel);
 
 	return channel;
 
 err_timeout:
-	/* glink_rpm_send_open_req() did register the channel in lcids*/
+	/* qcom_glink_send_open_req() did register the channel in lcids*/
 	mutex_lock(&glink->idr_lock);
 	idr_remove(&glink->lcids, channel->lcid);
 	mutex_unlock(&glink->idr_lock);
 
 release_channel:
-	/* Release glink_rpm_send_open_req() reference */
-	kref_put(&channel->refcount, glink_rpm_channel_release);
-	/* Release glink_rpm_alloc_channel() reference */
-	kref_put(&channel->refcount, glink_rpm_channel_release);
+	/* Release qcom_glink_send_open_req() reference */
+	kref_put(&channel->refcount, qcom_glink_channel_release);
+	/* Release qcom_glink_alloc_channel() reference */
+	kref_put(&channel->refcount, qcom_glink_channel_release);
 
 	return ERR_PTR(-ETIMEDOUT);
 }
 
 /* Remote initiated rpmsg_create_ept */
-static int glink_rpm_create_remote(struct glink_rpm *glink,
-				   struct glink_channel *channel)
+static int qcom_glink_create_remote(struct qcom_glink *glink,
+				    struct glink_channel *channel)
 {
 	int ret;
 
-	glink_rpm_send_open_ack(glink, channel);
+	qcom_glink_send_open_ack(glink, channel);
 
-	ret = glink_rpm_send_open_req(glink, channel);
+	ret = qcom_glink_send_open_req(glink, channel);
 	if (ret)
 		goto close_link;
 
@@ -714,21 +717,23 @@ static int glink_rpm_create_remote(struct glink_rpm *glink,
 	 * Send a close request to "undo" our open-ack. The close-ack will
 	 * release the last reference.
 	 */
-	glink_rpm_send_close_req(glink, channel);
+	qcom_glink_send_close_req(glink, channel);
 
-	/* Release glink_rpm_send_open_req() reference */
-	kref_put(&channel->refcount, glink_rpm_channel_release);
+	/* Release qcom_glink_send_open_req() reference */
+	kref_put(&channel->refcount, qcom_glink_channel_release);
 
 	return ret;
 }
 
-static struct rpmsg_endpoint *glink_rpm_create_ept(struct rpmsg_device *rpdev,
-						  rpmsg_rx_cb_t cb, void *priv,
-						  struct rpmsg_channel_info chinfo)
+static struct rpmsg_endpoint *qcom_glink_create_ept(struct rpmsg_device *rpdev,
+						    rpmsg_rx_cb_t cb,
+						    void *priv,
+						    struct rpmsg_channel_info
+						    chinfo)
 {
 	struct glink_channel *parent = to_glink_channel(rpdev->ept);
 	struct glink_channel *channel;
-	struct glink_rpm *glink = parent->glink;
+	struct qcom_glink *glink = parent->glink;
 	struct rpmsg_endpoint *ept;
 	const char *name = chinfo.name;
 	int cid;
@@ -740,11 +745,11 @@ static struct rpmsg_endpoint *glink_rpm_create_ept(struct rpmsg_device *rpdev,
 	}
 
 	if (!channel) {
-		channel = glink_rpm_create_local(glink, name);
+		channel = qcom_glink_create_local(glink, name);
 		if (IS_ERR(channel))
 			return NULL;
 	} else {
-		ret = glink_rpm_create_remote(glink, channel);
+		ret = qcom_glink_create_remote(glink, channel);
 		if (ret)
 			return NULL;
 	}
@@ -758,10 +763,10 @@ static struct rpmsg_endpoint *glink_rpm_create_ept(struct rpmsg_device *rpdev,
 	return ept;
 }
 
-static void glink_rpm_destroy_ept(struct rpmsg_endpoint *ept)
+static void qcom_glink_destroy_ept(struct rpmsg_endpoint *ept)
 {
 	struct glink_channel *channel = to_glink_channel(ept);
-	struct glink_rpm *glink = channel->glink;
+	struct qcom_glink *glink = channel->glink;
 	unsigned long flags;
 
 	spin_lock_irqsave(&channel->recv_lock, flags);
@@ -771,13 +776,13 @@ static void glink_rpm_destroy_ept(struct rpmsg_endpoint *ept)
 	/* Decouple the potential rpdev from the channel */
 	channel->rpdev = NULL;
 
-	glink_rpm_send_close_req(glink, channel);
+	qcom_glink_send_close_req(glink, channel);
 }
 
-static int __glink_rpm_send(struct glink_channel *channel,
+static int __qcom_glink_send(struct glink_channel *channel,
 			     void *data, int len, bool wait)
 {
-	struct glink_rpm *glink = channel->glink;
+	struct qcom_glink *glink = channel->glink;
 	struct {
 		struct glink_msg msg;
 		__le32 chunk_size;
@@ -793,27 +798,27 @@ static int __glink_rpm_send(struct glink_channel *channel,
 	req.chunk_size = cpu_to_le32(len);
 	req.left_size = cpu_to_le32(0);
 
-	return glink_rpm_tx(glink, &req, sizeof(req), data, len, wait);
+	return qcom_glink_tx(glink, &req, sizeof(req), data, len, wait);
 }
 
-static int glink_rpm_send(struct rpmsg_endpoint *ept, void *data, int len)
+static int qcom_glink_send(struct rpmsg_endpoint *ept, void *data, int len)
 {
 	struct glink_channel *channel = to_glink_channel(ept);
 
-	return __glink_rpm_send(channel, data, len, true);
+	return __qcom_glink_send(channel, data, len, true);
 }
 
-static int glink_rpm_trysend(struct rpmsg_endpoint *ept, void *data, int len)
+static int qcom_glink_trysend(struct rpmsg_endpoint *ept, void *data, int len)
 {
 	struct glink_channel *channel = to_glink_channel(ept);
 
-	return __glink_rpm_send(channel, data, len, false);
+	return __qcom_glink_send(channel, data, len, false);
 }
 
 /*
  * Finds the device_node for the glink child interested in this channel.
  */
-static struct device_node *glink_rpm_match_channel(struct device_node *node,
+static struct device_node *qcom_glink_match_channel(struct device_node *node,
 						    const char *channel)
 {
 	struct device_node *child;
@@ -835,16 +840,16 @@ static struct device_node *glink_rpm_match_channel(struct device_node *node,
 }
 
 static const struct rpmsg_device_ops glink_device_ops = {
-	.create_ept = glink_rpm_create_ept,
+	.create_ept = qcom_glink_create_ept,
 };
 
 static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
-	.destroy_ept = glink_rpm_destroy_ept,
-	.send = glink_rpm_send,
-	.trysend = glink_rpm_trysend,
+	.destroy_ept = qcom_glink_destroy_ept,
+	.send = qcom_glink_send,
+	.trysend = qcom_glink_trysend,
 };
 
-static void glink_rpm_rpdev_release(struct device *dev)
+static void qcom_glink_rpdev_release(struct device *dev)
 {
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct glink_channel *channel = to_glink_channel(rpdev->ept);
@@ -853,14 +858,15 @@ static void glink_rpm_rpdev_release(struct device *dev)
 	kfree(rpdev);
 }
 
-static int glink_rpm_rx_open(struct glink_rpm *glink, unsigned int rcid,
-			     char *name)
+static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
+			      char *name)
 {
 	struct glink_channel *channel;
 	struct rpmsg_device *rpdev;
 	bool create_device = false;
 	int lcid;
 	int ret;
+	struct device_node *node;
 
 	idr_for_each_entry(&glink->lcids, channel, lcid) {
 		if (!strcmp(channel->name, name))
@@ -868,7 +874,7 @@ static int glink_rpm_rx_open(struct glink_rpm *glink, unsigned int rcid,
 	}
 
 	if (!channel) {
-		channel = glink_rpm_alloc_channel(glink, name);
+		channel = qcom_glink_alloc_channel(glink, name);
 		if (IS_ERR(channel))
 			return PTR_ERR(channel);
 
@@ -901,9 +907,10 @@ static int glink_rpm_rx_open(struct glink_rpm *glink, unsigned int rcid,
 		rpdev->dst = RPMSG_ADDR_ANY;
 		rpdev->ops = &glink_device_ops;
 
-		rpdev->dev.of_node = glink_rpm_match_channel(glink->dev->of_node, name);
+		node = qcom_glink_match_channel(glink->dev->of_node, name);
+		rpdev->dev.of_node = node;
 		rpdev->dev.parent = glink->dev;
-		rpdev->dev.release = glink_rpm_rpdev_release;
+		rpdev->dev.release = qcom_glink_rpdev_release;
 
 		ret = rpmsg_register_device(rpdev);
 		if (ret)
@@ -924,12 +931,12 @@ static int glink_rpm_rx_open(struct glink_rpm *glink, unsigned int rcid,
 free_channel:
 	/* Release the reference, iff we took it */
 	if (create_device)
-		kref_put(&channel->refcount, glink_rpm_channel_release);
+		kref_put(&channel->refcount, qcom_glink_channel_release);
 
 	return ret;
 }
 
-static void glink_rpm_rx_close(struct glink_rpm *glink, unsigned int rcid)
+static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 {
 	struct rpmsg_channel_info chinfo;
 	struct glink_channel *channel;
@@ -946,17 +953,17 @@ static void glink_rpm_rx_close(struct glink_rpm *glink, unsigned int rcid)
 		rpmsg_unregister_device(glink->dev, &chinfo);
 	}
 
-	glink_rpm_send_close_ack(glink, channel->rcid);
+	qcom_glink_send_close_ack(glink, channel->rcid);
 
 	mutex_lock(&glink->idr_lock);
 	idr_remove(&glink->rcids, channel->rcid);
 	channel->rcid = 0;
 	mutex_unlock(&glink->idr_lock);
 
-	kref_put(&channel->refcount, glink_rpm_channel_release);
+	kref_put(&channel->refcount, qcom_glink_channel_release);
 }
 
-static void glink_rpm_rx_close_ack(struct glink_rpm *glink, unsigned int lcid)
+static void qcom_glink_rx_close_ack(struct qcom_glink *glink, unsigned int lcid)
 {
 	struct glink_channel *channel;
 
@@ -969,12 +976,13 @@ static void glink_rpm_rx_close_ack(struct glink_rpm *glink, unsigned int lcid)
 	channel->lcid = 0;
 	mutex_unlock(&glink->idr_lock);
 
-	kref_put(&channel->refcount, glink_rpm_channel_release);
+	kref_put(&channel->refcount, qcom_glink_channel_release);
 }
 
-static void glink_rpm_work(struct work_struct *work)
+static void qcom_glink_work(struct work_struct *work)
 {
-	struct glink_rpm *glink = container_of(work, struct glink_rpm, rx_work);
+	struct qcom_glink *glink = container_of(work, struct qcom_glink,
+						rx_work);
 	struct glink_defer_cmd *dcmd;
 	struct glink_msg *msg;
 	unsigned long flags;
@@ -999,18 +1007,18 @@ static void glink_rpm_work(struct work_struct *work)
 
 		switch (cmd) {
 		case RPM_CMD_VERSION:
-			glink_rpm_send_version_ack(glink);
+			qcom_glink_send_version_ack(glink);
 			break;
 		case RPM_CMD_VERSION_ACK:
 			break;
 		case RPM_CMD_OPEN:
-			glink_rpm_rx_open(glink, param1, msg->data);
+			qcom_glink_rx_open(glink, param1, msg->data);
 			break;
 		case RPM_CMD_CLOSE:
-			glink_rpm_rx_close(glink, param1);
+			qcom_glink_rx_close(glink, param1);
 			break;
 		case RPM_CMD_CLOSE_ACK:
-			glink_rpm_rx_close_ack(glink, param1);
+			qcom_glink_rx_close_ack(glink, param1);
 			break;
 		default:
 			WARN(1, "Unknown defer object %d\n", cmd);
@@ -1098,7 +1106,7 @@ static int glink_rpm_parse_toc(struct device *dev,
 
 static int glink_rpm_probe(struct platform_device *pdev)
 {
-	struct glink_rpm *glink;
+	struct qcom_glink *glink;
 	struct device_node *np;
 	void __iomem *msg_ram;
 	size_t msg_ram_size;
@@ -1116,7 +1124,7 @@ static int glink_rpm_probe(struct platform_device *pdev)
 	mutex_init(&glink->tx_lock);
 	spin_lock_init(&glink->rx_lock);
 	INIT_LIST_HEAD(&glink->rx_queue);
-	INIT_WORK(&glink->rx_work, glink_rpm_work);
+	INIT_WORK(&glink->rx_work, qcom_glink_work);
 
 	mutex_init(&glink->idr_lock);
 	idr_init(&glink->lcids);
@@ -1151,7 +1159,7 @@ static int glink_rpm_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(dev, irq,
-			       glink_rpm_intr,
+			       qcom_glink_intr,
 			       IRQF_NO_SUSPEND | IRQF_SHARED,
 			       "glink-rpm", glink);
 	if (ret) {
@@ -1161,7 +1169,7 @@ static int glink_rpm_probe(struct platform_device *pdev)
 
 	glink->irq = irq;
 
-	ret = glink_rpm_send_version(glink);
+	ret = qcom_glink_send_version(glink);
 	if (ret)
 		return ret;
 
@@ -1179,7 +1187,7 @@ static int glink_rpm_remove_device(struct device *dev, void *data)
 
 static int glink_rpm_remove(struct platform_device *pdev)
 {
-	struct glink_rpm *glink = platform_get_drvdata(pdev);
+	struct qcom_glink *glink = platform_get_drvdata(pdev);
 	struct glink_channel *channel;
 	int cid;
 	int ret;
@@ -1193,7 +1201,7 @@ static int glink_rpm_remove(struct platform_device *pdev)
 
 	/* Release any defunct local channels, waiting for close-ack */
 	idr_for_each_entry(&glink->lcids, channel, cid)
-		kref_put(&channel->refcount, glink_rpm_channel_release);
+		kref_put(&channel->refcount, qcom_glink_channel_release);
 
 	idr_destroy(&glink->lcids);
 	idr_destroy(&glink->rcids);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
