From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Sep 2017 14:11:37 +0100
Subject: [PATCH v3 13/22] firmware: arm_scmi: refactor in preparation to
 support per-protocol channels
In-Reply-To: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1506604306-20739-14-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support per-protocol channels if available, we need to
factor out all the mailbox channel information(Tx/Rx payload and
channel handle) out of the main SCMI instance information structure.

This patch refactors the existing channel information into a separate
chan_info structure.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 84 ++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index e1abedf15cb0..93b3bd8d437f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -104,6 +104,22 @@ struct scmi_desc {
 };
 
 /**
+ * struct scmi_chan_info - Structure representing a SCMI channel informfation
+ *
+ * @cl: Mailbox Client
+ * @chan: Transmit/Receive mailbox channel
+ * @payload: Transmit/Receive mailbox channel payload area
+ * @dev: Reference to device in the SCMI hierarchy corresponding to this
+ *	 channel
+ */
+struct scmi_chan_info {
+	struct mbox_client cl;
+	struct mbox_chan *chan;
+	void __iomem *payload;
+	struct device *dev;
+};
+
+/**
  * struct scmi_info - Structure representing a  SCMI instance
  *
  * @dev: Device pointer
@@ -111,10 +127,8 @@ struct scmi_desc {
  * @handle: Instance of SCMI handle to send to clients
  * @version: SCMI revision information containing protocol version,
  *	implementation version and (sub-)vendor identification.
- * @cl: Mailbox Client
- * @tx_chan: Transmit mailbox channel
- * @tx_payload: Transmit mailbox channel payload area
  * @minfo: Message info
+ * @tx_cinfo: Reference to SCMI channel information
  * @protocols_imp: list of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
  * @node: list head
@@ -125,16 +139,14 @@ struct scmi_info {
 	const struct scmi_desc *desc;
 	struct scmi_revision_info version;
 	struct scmi_handle handle;
-	struct mbox_client cl;
-	struct mbox_chan *tx_chan;
-	void __iomem *tx_payload;
 	struct scmi_xfers_info minfo;
+	struct scmi_chan_info *tx_cinfo;
 	u8 *protocols_imp;
 	struct list_head node;
 	int users;
 };
 
-#define client_to_scmi_info(c)	container_of(c, struct scmi_info, cl)
+#define client_to_scmi_chan_info(c) container_of(c, struct scmi_chan_info, cl)
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
 
 /*
@@ -224,10 +236,11 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
 {
 	u16 xfer_id;
 	struct scmi_xfer *xfer;
-	struct scmi_info *info = client_to_scmi_info(cl);
+	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
+	struct device *dev = cinfo->dev;
+	struct scmi_info *info = dev_get_drvdata(dev);
 	struct scmi_xfers_info *minfo = &info->minfo;
-	struct device *dev = info->dev;
-	struct scmi_shared_mem *mem = info->tx_payload;
+	struct scmi_shared_mem *mem = cinfo->payload;
 
 	xfer_id = MSG_XTRACT_TOKEN(le32_to_cpu(mem->msg_header));
 
@@ -278,8 +291,8 @@ static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
 static void scmi_tx_prepare(struct mbox_client *cl, void *m)
 {
 	struct scmi_xfer *t = m;
-	struct scmi_info *info = client_to_scmi_info(cl);
-	struct scmi_shared_mem *mem = info->tx_payload;
+	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
+	struct scmi_shared_mem *mem = cinfo->payload;
 
 	mem->channel_status = 0x0; /* Mark channel busy + clear error */
 	mem->flags = t->hdr.poll_completion ? 0 :
@@ -371,9 +384,9 @@ void scmi_one_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 }
 
 static bool
-scmi_xfer_poll_done(const struct scmi_info *info, struct scmi_xfer *xfer)
+scmi_xfer_poll_done(const struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
 {
-	struct scmi_shared_mem *mem = info->tx_payload;
+	struct scmi_shared_mem *mem = cinfo->payload;
 	u16 xfer_id = MSG_XTRACT_TOKEN(le32_to_cpu(mem->msg_header));
 
 	if (xfer->hdr.seq != xfer_id)
@@ -400,8 +413,9 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	int timeout;
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct device *dev = info->dev;
+	struct scmi_chan_info *cinfo = info->tx_cinfo;
 
-	ret = mbox_send_message(info->tx_chan, xfer);
+	ret = mbox_send_message(cinfo->chan, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "mbox send fail %d\n", ret);
 		return ret;
@@ -412,10 +426,10 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 
 	if (xfer->hdr.poll_completion) {
 		timeout = info->desc->max_rx_timeout_ms * 100;
-		while (!scmi_xfer_poll_done(info, xfer) && timeout--)
+		while (!scmi_xfer_poll_done(cinfo, xfer) && timeout--)
 			udelay(10);
 		if (timeout)
-			scmi_fetch_response(xfer, info->tx_payload);
+			scmi_fetch_response(xfer, cinfo->payload);
 		else
 			ret = -ETIMEDOUT;
 	} else {
@@ -435,7 +449,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	 * Unfortunately, we have to kick the mailbox framework after we have
 	 * received our message.
 	 */
-	mbox_client_txdone(info->tx_chan, ret);
+	mbox_client_txdone(cinfo->chan, ret);
 
 	return ret;
 }
@@ -757,11 +771,11 @@ static int scmi_mailbox_check(struct device_node *np)
 	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
 }
 
-static int scmi_mbox_free_channel(struct scmi_info *info)
+static int scmi_mbox_free_channel(struct scmi_chan_info *cinfo)
 {
-	if (!IS_ERR_OR_NULL(info->tx_chan)) {
-		mbox_free_channel(info->tx_chan);
-		info->tx_chan = NULL;
+	if (!IS_ERR_OR_NULL(cinfo->chan)) {
+		mbox_free_channel(cinfo->chan);
+		cinfo->chan = NULL;
 	}
 
 	return 0;
@@ -783,7 +797,7 @@ static int scmi_remove(struct platform_device *pdev)
 
 	if (!ret)
 		/* Safe to free channels since no more users */
-		return scmi_mbox_free_channel(info);
+		return scmi_mbox_free_channel(info->tx_cinfo);
 
 	return ret;
 }
@@ -795,9 +809,17 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
 	resource_size_t size;
 	struct device *dev = info->dev;
 	struct device_node *shmem, *np = dev->of_node;
+	struct scmi_chan_info *cinfo;
 	struct mbox_client *cl;
 
-	cl = &info->cl;
+	cinfo = devm_kzalloc(info->dev, sizeof(*cinfo), GFP_KERNEL);
+	if (!cinfo)
+		return -ENOMEM;
+
+	info->tx_cinfo = cinfo;
+	cinfo->dev = dev;
+
+	cl = &cinfo->cl;
 	cl->dev = dev;
 	cl->rx_callback = scmi_rx_callback;
 	cl->tx_prepare = scmi_tx_prepare;
@@ -813,16 +835,16 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
 	}
 
 	size = resource_size(&res);
-	info->tx_payload = devm_ioremap(dev, res.start, size);
-	if (!info->tx_payload) {
+	cinfo->payload = devm_ioremap(info->dev, res.start, size);
+	if (!cinfo->payload) {
 		dev_err(dev, "failed to ioremap SCMI Tx payload\n");
 		return -EADDRNOTAVAIL;
 	}
 
 	/* Transmit channel is first entry i.e. index 0 */
-	info->tx_chan = mbox_request_channel(cl, 0);
-	if (IS_ERR(info->tx_chan)) {
-		ret = PTR_ERR(info->tx_chan);
+	cinfo->chan = mbox_request_channel(cl, 0);
+	if (IS_ERR(cinfo->chan)) {
+		ret = PTR_ERR(cinfo->chan);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "failed to request SCMI Tx mailbox\n");
 		return ret;
@@ -844,6 +866,8 @@ scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
 		return;
 	}
 
+	platform_set_drvdata(cdev, info);
+
 	init_ret = match->fn(&info->handle);
 	if (init_ret) {
 		dev_err(info->dev, "SCMI protocol %d init error %d\n",
@@ -894,7 +918,7 @@ static int scmi_probe(struct platform_device *pdev)
 	ret = scmi_base_protocol_init(handle);
 	if (ret) {
 		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
-		scmi_mbox_free_channel(info);
+		scmi_mbox_free_channel(info->tx_cinfo);
 		return ret;
 	}
 
-- 
2.7.4
