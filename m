From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  4 Aug 2017 15:31:39 +0100
Subject: [PATCH v2 13/18] firmware: arm_scmi: add per-protocol channels
 support using idr objects
In-Reply-To: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1501857104-11279-14-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to maintain the channel information per protocol, we need
some sort of list or hashtable to hold all this information. IDR
provides sparse array mapping of small integer ID numbers onto arbitrary
pointers. In this case the arbitrary pointers can be pointers to the
channel information.

This patch adds support for per-protocol channels using those idr
objects.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 50 +++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 3eaf619858bb..b59cbdde0237 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -112,6 +112,8 @@ struct scmi_desc {
  * @tx_payload: Transmit mailbox channel payload area
  * @rx_payload: Receive mailbox channel payload area
  * @info: Reference to SCMI instance corresponding to this channel
+ * @dev: Reference to device in the SCMI hierarchy corresponding to this
+ *	 channel
  */
 struct scmi_chan_info {
 	struct mbox_client cl;
@@ -120,6 +122,7 @@ struct scmi_chan_info {
 	void __iomem *tx_payload;
 	void __iomem *rx_payload;
 	struct scmi_info *info;
+	struct device *dev;
 };
 
 /**
@@ -131,7 +134,7 @@ struct scmi_chan_info {
  * @version: SCMI revision information containing protocol version,
  *	implementation version and (sub-)vendor identification.
  * @minfo: Message info
- * @cinfo: Reference to SCMI channel information
+ * @idr: IDR object to map protocol id to channel info pointer
  * @protocols_imp: list of protocols implemented
  * @node: list head
  * @users: Number of users of this instance
@@ -142,7 +145,7 @@ struct scmi_info {
 	struct scmi_revision_info version;
 	struct scmi_handle handle;
 	struct scmi_xfers_info minfo;
-	struct scmi_chan_info *cinfo;
+	struct idr idr;
 	u8 *protocols_imp;
 	struct list_head node;
 	int users;
@@ -412,7 +415,11 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	int timeout;
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct device *dev = info->dev;
-	struct scmi_chan_info *cinfo = info->cinfo;
+	struct scmi_chan_info *cinfo;
+
+	cinfo = idr_find(&info->idr, xfer->hdr.protocol_id);
+	if (unlikely(!cinfo))
+		return -EINVAL;
 
 	ret = mbox_send_message(cinfo->tx_chan, xfer);
 	if (ret < 0) {
@@ -772,8 +779,11 @@ static int scmi_mailbox_check(struct device_node *np)
 	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
 }
 
-static int scmi_mbox_free_channel(struct scmi_chan_info *cinfo)
+static int scmi_mbox_free_channel(int id, void *p, void *data)
 {
+	struct scmi_chan_info *cinfo = p;
+	struct idr *idr = data;
+
 	if (!IS_ERR_OR_NULL(cinfo->tx_chan)) {
 		mbox_free_channel(cinfo->tx_chan);
 		cinfo->tx_chan = NULL;
@@ -783,6 +793,8 @@ static int scmi_mbox_free_channel(struct scmi_chan_info *cinfo)
 		cinfo->rx_chan = NULL;
 	}
 
+	idr_remove(idr, id);
+
 	return 0;
 }
 
@@ -790,6 +802,7 @@ static int scmi_remove(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct scmi_info *info = platform_get_drvdata(pdev);
+	struct idr *idr = &info->idr;
 
 	of_platform_depopulate(&pdev->dev);
 
@@ -800,28 +813,34 @@ static int scmi_remove(struct platform_device *pdev)
 		list_del(&info->node);
 	mutex_unlock(&scmi_list_mutex);
 
-	if (!ret)
+	if (!ret) {
 		/* Safe to free channels since no more users */
-		return scmi_mbox_free_channel(info->cinfo);
+		ret = idr_for_each(idr, scmi_mbox_free_channel, idr);
+		idr_destroy(&info->idr);
+	}
 
 	return ret;
 }
 
-static inline int scmi_mbox_chan_setup(struct scmi_info *info)
+static inline int
+scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
 {
 	int ret;
 	struct resource res;
 	resource_size_t size;
-	struct device *dev = info->dev;
 	struct device_node *shmem, *np = dev->of_node;
 	struct scmi_chan_info *cinfo;
 	struct mbox_client *cl;
 
+	if (scmi_mailbox_check(np)) {
+		cinfo = idr_find(&info->idr, SCMI_PROTOCOL_BASE);
+		goto idr_alloc;
+	}
+
 	cinfo = devm_kzalloc(info->dev, sizeof(*cinfo), GFP_KERNEL);
 	if (!cinfo)
 		return -ENOMEM;
 
-	info->cinfo = cinfo;
 	cinfo->info = info;
 
 	cl = &cinfo->cl;
@@ -854,6 +873,13 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
 		return ret;
 	}
 
+idr_alloc:
+	ret = idr_alloc(&info->idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
+	if (ret != prot_id) {
+		dev_err(dev, "unable to allocate SCMI idr slot err %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -887,19 +913,19 @@ static int scmi_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, info);
+	idr_init(&info->idr);
 
 	handle = &info->handle;
 	handle->dev = info->dev;
 	handle->version = &info->version;
 
-	ret = scmi_mbox_chan_setup(info);
+	ret = scmi_mbox_chan_setup(info, dev, SCMI_PROTOCOL_BASE);
 	if (ret)
 		return ret;
 
 	ret = scmi_base_protocol_init(handle);
 	if (ret) {
 		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
-		scmi_mbox_free_channel(info->cinfo);
 		return ret;
 	}
 
@@ -931,6 +957,8 @@ static int scmi_probe(struct platform_device *pdev)
 				continue;
 			}
 
+			scmi_mbox_chan_setup(info, &cdev->dev, prot_id);
+
 			init_ret = match->fn(handle);
 			if (init_ret) {
 				dev_err(dev, "SCMI protocol %d init error %d\n",
-- 
2.7.4
