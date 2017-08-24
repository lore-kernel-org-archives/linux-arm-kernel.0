From: sricharan@codeaurora.org (Sricharan R)
Date: Thu, 24 Aug 2017 12:51:33 +0530
Subject: [PATCH v2 11/20] rpmsg: glink: Fix idr_lock from mutex to spinlock
In-Reply-To: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
References: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1503559302-3744-12-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The channel members lcids, rcids synchronised using
the idr_lock is accessed in both atomic/non-atomic
contexts. The readers are not currently synchronised.
That no correct, so add the readers as well under the
lock and use a spinlock.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 58 +++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 777ac6b..588a56c 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -92,7 +92,7 @@ struct qcom_glink {
 
 	struct mutex tx_lock;
 
-	struct mutex idr_lock;
+	spinlock_t idr_lock;
 	struct idr lcids;
 	struct idr rcids;
 	unsigned long features;
@@ -309,14 +309,15 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
 	int name_len = strlen(channel->name) + 1;
 	int req_len = ALIGN(sizeof(req.msg) + name_len, 8);
 	int ret;
+	unsigned long flags;
 
 	kref_get(&channel->refcount);
 
-	mutex_lock(&glink->idr_lock);
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	ret = idr_alloc_cyclic(&glink->lcids, channel,
 			       RPM_GLINK_CID_MIN, RPM_GLINK_CID_MAX,
 			       GFP_KERNEL);
-	mutex_unlock(&glink->idr_lock);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 	if (ret < 0)
 		return ret;
 
@@ -334,10 +335,10 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
 	return 0;
 
 remove_idr:
-	mutex_lock(&glink->idr_lock);
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	idr_remove(&glink->lcids, channel->lcid);
 	channel->lcid = 0;
-	mutex_unlock(&glink->idr_lock);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 
 	return ret;
 }
@@ -463,6 +464,7 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 	unsigned int chunk_size;
 	unsigned int left_size;
 	unsigned int rcid;
+	unsigned long flags;
 
 	if (avail < sizeof(hdr)) {
 		dev_dbg(glink->dev, "Not enough data in fifo\n");
@@ -482,7 +484,9 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 		return -EINVAL;
 
 	rcid = le16_to_cpu(hdr.msg.param1);
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	channel = idr_find(&glink->rcids, rcid);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 	if (!channel) {
 		dev_dbg(glink->dev, "Data on non-existing channel\n");
 
@@ -543,11 +547,13 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
 {
 	struct glink_channel *channel;
 
+	spin_lock(&glink->idr_lock);
 	channel = idr_find(&glink->lcids, lcid);
 	if (!channel) {
 		dev_err(glink->dev, "Invalid open ack packet\n");
 		return -EINVAL;
 	}
+	spin_unlock(&glink->idr_lock);
 
 	complete(&channel->open_ack);
 
@@ -621,6 +627,7 @@ static struct glink_channel *qcom_glink_create_local(struct qcom_glink *glink,
 {
 	struct glink_channel *channel;
 	int ret;
+	unsigned long flags;
 
 	channel = qcom_glink_alloc_channel(glink, name);
 	if (IS_ERR(channel))
@@ -644,9 +651,9 @@ static struct glink_channel *qcom_glink_create_local(struct qcom_glink *glink,
 
 err_timeout:
 	/* qcom_glink_send_open_req() did register the channel in lcids*/
-	mutex_lock(&glink->idr_lock);
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	idr_remove(&glink->lcids, channel->lcid);
-	mutex_unlock(&glink->idr_lock);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 
 release_channel:
 	/* Release qcom_glink_send_open_req() reference */
@@ -703,11 +710,14 @@ static struct rpmsg_endpoint *qcom_glink_create_ept(struct rpmsg_device *rpdev,
 	const char *name = chinfo.name;
 	int cid;
 	int ret;
+	unsigned long flags;
 
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	idr_for_each_entry(&glink->rcids, channel, cid) {
 		if (!strcmp(channel->name, name))
 			break;
 	}
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 
 	if (!channel) {
 		channel = qcom_glink_create_local(glink, name);
@@ -829,11 +839,14 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
 	struct device_node *node;
 	int lcid;
 	int ret;
+	unsigned long flags;
 
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	idr_for_each_entry(&glink->lcids, channel, lcid) {
 		if (!strcmp(channel->name, name))
 			break;
 	}
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 
 	if (!channel) {
 		channel = qcom_glink_alloc_channel(glink, name);
@@ -844,15 +857,15 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
 		create_device = true;
 	}
 
-	mutex_lock(&glink->idr_lock);
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	ret = idr_alloc(&glink->rcids, channel, rcid, rcid + 1, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(glink->dev, "Unable to insert channel into rcid list\n");
-		mutex_unlock(&glink->idr_lock);
+		spin_unlock_irqrestore(&glink->idr_lock, flags);
 		goto free_channel;
 	}
 	channel->rcid = ret;
-	mutex_unlock(&glink->idr_lock);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 
 	complete(&channel->open_req);
 
@@ -886,10 +899,10 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
 free_rpdev:
 	kfree(rpdev);
 rcid_remove:
-	mutex_lock(&glink->idr_lock);
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	idr_remove(&glink->rcids, channel->rcid);
 	channel->rcid = 0;
-	mutex_unlock(&glink->idr_lock);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 free_channel:
 	/* Release the reference, iff we took it */
 	if (create_device)
@@ -902,8 +915,11 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 {
 	struct rpmsg_channel_info chinfo;
 	struct glink_channel *channel;
+	unsigned long flags;
 
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	channel = idr_find(&glink->rcids, rcid);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 	if (WARN(!channel, "close request on unknown channel\n"))
 		return;
 
@@ -917,10 +933,10 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 
 	qcom_glink_send_close_ack(glink, channel->rcid);
 
-	mutex_lock(&glink->idr_lock);
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	idr_remove(&glink->rcids, channel->rcid);
 	channel->rcid = 0;
-	mutex_unlock(&glink->idr_lock);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 
 	kref_put(&channel->refcount, qcom_glink_channel_release);
 }
@@ -928,15 +944,18 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 static void qcom_glink_rx_close_ack(struct qcom_glink *glink, unsigned int lcid)
 {
 	struct glink_channel *channel;
+	unsigned long flags;
 
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	channel = idr_find(&glink->lcids, lcid);
-	if (WARN(!channel, "close ack on unknown channel\n"))
+	if (WARN(!channel, "close ack on unknown channel\n")) {
+		spin_unlock_irqrestore(&glink->idr_lock, flags);
 		return;
+	}
 
-	mutex_lock(&glink->idr_lock);
 	idr_remove(&glink->lcids, channel->lcid);
 	channel->lcid = 0;
-	mutex_unlock(&glink->idr_lock);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 
 	kref_put(&channel->refcount, qcom_glink_channel_release);
 }
@@ -1017,7 +1036,7 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 	INIT_LIST_HEAD(&glink->rx_queue);
 	INIT_WORK(&glink->rx_work, qcom_glink_work);
 
-	mutex_init(&glink->idr_lock);
+	spin_lock_init(&glink->idr_lock);
 	idr_init(&glink->lcids);
 	idr_init(&glink->rcids);
 
@@ -1060,6 +1079,7 @@ void qcom_glink_native_remove(struct qcom_glink *glink)
 	struct glink_channel *channel;
 	int cid;
 	int ret;
+	unsigned long flags;
 
 	disable_irq(glink->irq);
 	cancel_work_sync(&glink->rx_work);
@@ -1068,12 +1088,14 @@ void qcom_glink_native_remove(struct qcom_glink *glink)
 	if (ret)
 		dev_warn(glink->dev, "Can't remove GLINK devices: %d\n", ret);
 
+	spin_lock_irqsave(&glink->idr_lock, flags);
 	/* Release any defunct local channels, waiting for close-ack */
 	idr_for_each_entry(&glink->lcids, channel, cid)
 		kref_put(&channel->refcount, qcom_glink_channel_release);
 
 	idr_destroy(&glink->lcids);
 	idr_destroy(&glink->rcids);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
 	mbox_free_channel(glink->mbox_chan);
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
