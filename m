From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue,  2 Jan 2018 14:42:36 +0000
Subject: [PATCH v5 14/20] firmware: arm_scmi: add per-protocol channels
 support using idr objects
In-Reply-To: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1514904162-11201-15-git-send-email-sudeep.holla@arm.com>
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
 drivers/firmware/arm_scmi/driver.c | 54 +++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 24acb421208c..6734a035bcc6 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -118,6 +118,7 @@ struct scmi_chan_info {
 	struct mbox_chan *chan;
 	void __iomem *payload;
 	struct device *dev;
+	struct scmi_handle *handle;
 };
 
 /**
@@ -129,7 +130,7 @@ struct scmi_chan_info {
  * @version: SCMI revision information containing protocol version,
  *	implementation version and (sub-)vendor identification.
  * @minfo: Message info
- * @tx_cinfo: Reference to SCMI channel information
+ * @tx_idr: IDR object to map protocol id to channel info pointer
  * @protocols_imp: list of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
  * @node: list head
@@ -141,7 +142,7 @@ struct scmi_info {
 	struct scmi_revision_info version;
 	struct scmi_handle handle;
 	struct scmi_xfers_info minfo;
-	struct scmi_chan_info *tx_cinfo;
+	struct idr tx_idr;
 	u8 *protocols_imp;
 	struct list_head node;
 	int users;
@@ -232,7 +233,7 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
 	struct scmi_xfer *xfer;
 	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
 	struct device *dev = cinfo->dev;
-	struct scmi_info *info = dev_get_drvdata(dev);
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 	struct scmi_xfers_info *minfo = &info->minfo;
 	struct scmi_shared_mem __iomem *mem = cinfo->payload;
 
@@ -409,7 +410,11 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	int timeout;
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct device *dev = info->dev;
-	struct scmi_chan_info *cinfo = info->tx_cinfo;
+	struct scmi_chan_info *cinfo;
+
+	cinfo = idr_find(&info->tx_idr, xfer->hdr.protocol_id);
+	if (unlikely(!cinfo))
+		return -EINVAL;
 
 	ret = mbox_send_message(cinfo->chan, xfer);
 	if (ret < 0) {
@@ -681,13 +686,18 @@ static int scmi_mailbox_check(struct device_node *np)
 	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
 }
 
-static int scmi_mbox_free_channel(struct scmi_chan_info *cinfo)
+static int scmi_mbox_free_channel(int id, void *p, void *data)
 {
+	struct scmi_chan_info *cinfo = p;
+	struct idr *idr = data;
+
 	if (!IS_ERR_OR_NULL(cinfo->chan)) {
 		mbox_free_channel(cinfo->chan);
 		cinfo->chan = NULL;
 	}
 
+	idr_remove(idr, id);
+
 	return 0;
 }
 
@@ -695,6 +705,7 @@ static int scmi_remove(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct scmi_info *info = platform_get_drvdata(pdev);
+	struct idr *idr = &info->tx_idr;
 
 	mutex_lock(&scmi_list_mutex);
 	if (info->users)
@@ -703,28 +714,34 @@ static int scmi_remove(struct platform_device *pdev)
 		list_del(&info->node);
 	mutex_unlock(&scmi_list_mutex);
 
-	if (!ret)
+	if (!ret) {
 		/* Safe to free channels since no more users */
-		return scmi_mbox_free_channel(info->tx_cinfo);
+		ret = idr_for_each(idr, scmi_mbox_free_channel, idr);
+		idr_destroy(&info->tx_idr);
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
+		cinfo = idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
+		goto idr_alloc;
+	}
+
 	cinfo = devm_kzalloc(info->dev, sizeof(*cinfo), GFP_KERNEL);
 	if (!cinfo)
 		return -ENOMEM;
 
-	info->tx_cinfo = cinfo;
 	cinfo->dev = dev;
 
 	cl = &cinfo->cl;
@@ -758,6 +775,14 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
 		return ret;
 	}
 
+idr_alloc:
+	ret = idr_alloc(&info->tx_idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
+	if (ret != prot_id) {
+		dev_err(dev, "unable to allocate SCMI idr slot err %d\n", ret);
+		return ret;
+	}
+
+	cinfo->handle = &info->handle;
 	return 0;
 }
 
@@ -774,6 +799,11 @@ scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
 		return;
 	}
 
+	if (scmi_mbox_chan_setup(info, &sdev->dev, prot_id)) {
+		dev_err(&sdev->dev, "failed to setup transport\n");
+		scmi_device_destroy(sdev);
+	}
+
 	/* setup handle now as the transport is ready */
 	scmi_set_handle(sdev);
 }
@@ -808,19 +838,19 @@ static int scmi_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, info);
+	idr_init(&info->tx_idr);
 
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
-		scmi_mbox_free_channel(info->tx_cinfo);
 		return ret;
 	}
 
-- 
2.7.4
