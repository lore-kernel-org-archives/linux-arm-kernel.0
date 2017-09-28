From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Sep 2017 14:11:39 +0100
Subject: [PATCH v3 15/22] firmware: arm_scmi: abstract mailbox interface
In-Reply-To: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1506604306-20739-16-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the mailbox controller expects controller specific data in order
to implement simple doorbell mechanism as expected by SCMI specification.

This patch creates a shim layer to abstract the mailbox interface so
that it can support any mailbox controller. It also provides default
implementation which maps to standard mailbox client APIs, so that
controllers implementing doorbell mechanism need not require any
additional layer.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/Makefile  |  2 +-
 drivers/firmware/arm_scmi/driver.c  | 84 ++++++++++---------------------------
 drivers/firmware/arm_scmi/mbox_if.c | 80 +++++++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/mbox_if.h | 68 ++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+), 62 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/mbox_if.c
 create mode 100644 drivers/firmware/arm_scmi/mbox_if.h

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index f9dee5ad0aa0..733157c5b4e2 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_ARM_SCMI_PROTOCOL)	= arm_scmi.o
-arm_scmi-y = base.o clock.o driver.o perf.o power.o sensors.o
+arm_scmi-y = base.o clock.o driver.o mbox_if.o perf.o power.o sensors.o
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 92ef21d6aa5a..97285a22dfaa 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -30,7 +30,6 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -38,6 +37,7 @@
 #include <linux/slab.h>
 
 #include "common.h"
+#include "mbox_if.h"
 
 #define MSG_ID_SHIFT		0
 #define MSG_ID_MASK		0xff
@@ -90,36 +90,6 @@ struct scmi_xfers_info {
 };
 
 /**
- * struct scmi_desc - Description of SoC integration
- *
- * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
- * @max_msg: Maximum number of messages that can be pending
- *	simultaneously in the system
- * @max_msg_size: Maximum size of data per message that can be handled.
- */
-struct scmi_desc {
-	int max_rx_timeout_ms;
-	int max_msg;
-	int max_msg_size;
-};
-
-/**
- * struct scmi_chan_info - Structure representing a SCMI channel informfation
- *
- * @cl: Mailbox Client
- * @chan: Transmit/Receive mailbox channel
- * @payload: Transmit/Receive mailbox channel payload area
- * @dev: Reference to device in the SCMI hierarchy corresponding to this
- *	 channel
- */
-struct scmi_chan_info {
-	struct mbox_client cl;
-	struct mbox_chan *chan;
-	void __iomem *payload;
-	struct device *dev;
-};
-
-/**
  * struct scmi_info - Structure representing a  SCMI instance
  *
  * @dev: Device pointer
@@ -137,6 +107,7 @@ struct scmi_chan_info {
 struct scmi_info {
 	struct device *dev;
 	const struct scmi_desc *desc;
+	struct scmi_mbox_ops *mbox_ops;
 	struct scmi_revision_info version;
 	struct scmi_handle handle;
 	struct scmi_xfers_info minfo;
@@ -146,7 +117,6 @@ struct scmi_info {
 	int users;
 };
 
-#define client_to_scmi_chan_info(c) container_of(c, struct scmi_chan_info, cl)
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
 
 /*
@@ -221,10 +191,10 @@ static void scmi_fetch_response(struct scmi_xfer *xfer,
 }
 
 /**
- * scmi_rx_callback() - mailbox client callback for receive messages
+ * scmi_generic_rx_callback() -generic mailbox client callback for receive
+ * messages
  *
- * @cl: client pointer
- * @m: mailbox message
+ * @cinfo: pointer to structure with SCMI mailbox channels information
  *
  * Processes one received message to appropriate transfer information and
  * signals completion of the transfer.
@@ -232,11 +202,10 @@ static void scmi_fetch_response(struct scmi_xfer *xfer,
  * NOTE: This function will be invoked in IRQ context, hence should be
  * as optimal as possible.
  */
-static void scmi_rx_callback(struct mbox_client *cl, void *m)
+void scmi_generic_rx_callback(struct scmi_chan_info *cinfo)
 {
 	u16 xfer_id;
 	struct scmi_xfer *xfer;
-	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
 	struct device *dev = cinfo->dev;
 	struct scmi_info *info = dev_get_drvdata(dev);
 	struct scmi_xfers_info *minfo = &info->minfo;
@@ -280,18 +249,18 @@ static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
 }
 
 /**
- * scmi_tx_prepare() - mailbox client callback to prepare for the transfer
+ * scmi_generic_tx_prepare() - generic mailbox client callback to prepare for
+ * the transfer
  *
- * @cl: client pointer
+ * @cinfo: pointer to structure with SCMI mailbox channels information
  * @m: mailbox message
  *
  * This function prepares the shared memory which contains the header and the
  * payload.
  */
-static void scmi_tx_prepare(struct mbox_client *cl, void *m)
+void scmi_generic_tx_prepare(struct scmi_chan_info *cinfo, void *m)
 {
 	struct scmi_xfer *t = m;
-	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
 	struct scmi_shared_mem *mem = cinfo->payload;
 
 	mem->channel_status = 0x0; /* Mark channel busy + clear error */
@@ -384,9 +353,8 @@ void scmi_one_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 }
 
 static bool
-scmi_xfer_poll_done(const struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
+scmi_xfer_poll_done(struct scmi_shared_mem *mem, struct scmi_xfer *xfer)
 {
-	struct scmi_shared_mem *mem = cinfo->payload;
 	u16 xfer_id = MSG_XTRACT_TOKEN(le32_to_cpu(mem->msg_header));
 
 	if (xfer->hdr.seq != xfer_id)
@@ -419,7 +387,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	if (unlikely(!cinfo))
 		return -EINVAL;
 
-	ret = mbox_send_message(cinfo->chan, xfer);
+	ret = info->mbox_ops->send_message(cinfo, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "mbox send fail %d\n", ret);
 		return ret;
@@ -430,7 +398,8 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 
 	if (xfer->hdr.poll_completion) {
 		timeout = info->desc->max_rx_timeout_ms * 100;
-		while (!scmi_xfer_poll_done(cinfo, xfer) && timeout--)
+		while (!scmi_xfer_poll_done(cinfo->payload, xfer) &&
+		       timeout--)
 			udelay(10);
 		if (timeout)
 			scmi_fetch_response(xfer, cinfo->payload);
@@ -676,12 +645,6 @@ const struct scmi_handle *devm_scmi_handle_get(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_scmi_handle_get);
 
-static const struct scmi_desc scmi_generic_desc = {
-	.max_rx_timeout_ms = 30,	/* we may increase this if required */
-	.max_msg = 20,		/* Limited by MBOX_TX_QUEUE_LEN */
-	.max_msg_size = 128,
-};
-
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
 	{ .compatible = "arm,scmi", .data = &scmi_generic_desc },
@@ -775,13 +738,14 @@ static int scmi_mailbox_check(struct device_node *np)
 	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
 }
 
-static int scmi_mbox_free_channel(int id, void *p, void *data)
+static int scmi_free_channel(int id, void *p, void *data)
 {
-	struct scmi_chan_info *cinfo = p;
 	struct idr *idr = data;
+	struct scmi_chan_info *cinfo = p;
+	struct scmi_info *info = dev_get_drvdata(cinfo->dev);
 
 	if (!IS_ERR_OR_NULL(cinfo->chan)) {
-		mbox_free_channel(cinfo->chan);
+		info->mbox_ops->free_channel(cinfo);
 		cinfo->chan = NULL;
 	}
 
@@ -807,7 +771,7 @@ static int scmi_remove(struct platform_device *pdev)
 
 	if (!ret) {
 		/* Safe to free channels since no more users */
-		ret = idr_for_each(idr, scmi_mbox_free_channel, idr);
+		ret = idr_for_each(idr, scmi_free_channel, idr);
 		idr_destroy(&info->tx_idr);
 	}
 
@@ -834,11 +798,8 @@ scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
 		return -ENOMEM;
 
 	cinfo->dev = dev;
-
 	cl = &cinfo->cl;
 	cl->dev = dev;
-	cl->rx_callback = scmi_rx_callback;
-	cl->tx_prepare = scmi_tx_prepare;
 	cl->tx_block = false;
 	cl->knows_txdone = true;
 
@@ -858,9 +819,8 @@ scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
 	}
 
 	/* Transmit channel is first entry i.e. index 0 */
-	cinfo->chan = mbox_request_channel(cl, 0);
-	if (IS_ERR(cinfo->chan)) {
-		ret = PTR_ERR(cinfo->chan);
+	ret = info->mbox_ops->request_channel(cinfo, 0);
+	if (ret) {
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "failed to request SCMI Tx mailbox\n");
 		return ret;
@@ -924,6 +884,8 @@ static int scmi_probe(struct platform_device *pdev)
 
 	info->dev = dev;
 	info->desc = desc;
+	/* set up mailbox operations */
+	info->mbox_ops = desc->mbox_ops;
 	INIT_LIST_HEAD(&info->node);
 
 	ret = scmi_xfer_info_init(info);
diff --git a/drivers/firmware/arm_scmi/mbox_if.c b/drivers/firmware/arm_scmi/mbox_if.c
new file mode 100644
index 000000000000..dc2bcc060f30
--- /dev/null
+++ b/drivers/firmware/arm_scmi/mbox_if.c
@@ -0,0 +1,80 @@
+/*
+ * System Control and Management Interface (SCMI) default mailbox interface
+ *
+ * Copyright (C) 2017 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "mbox_if.h"
+
+static void scmi_tx_prepare(struct mbox_client *cl, void *m)
+{
+	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
+
+	scmi_generic_tx_prepare(cinfo, m);
+}
+
+static void scmi_rx_callback(struct mbox_client *cl, void *m)
+{
+	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
+
+	scmi_generic_rx_callback(cinfo);
+}
+
+static int scmi_mbox_request_channel(struct scmi_chan_info *cinfo, int index)
+{
+	int ret = 0;
+	struct mbox_client *cl = &cinfo->cl;
+
+	cl->rx_callback = scmi_rx_callback;
+	cl->tx_prepare = scmi_tx_prepare;
+
+	cinfo->chan = mbox_request_channel(cl, index);
+	if (IS_ERR(cinfo->chan))
+		ret = PTR_ERR(cinfo->chan);
+
+	return ret;
+}
+
+static int scmi_mbox_send_message(struct scmi_chan_info *cinfo, void *msg)
+{
+	return mbox_send_message(cinfo->chan, msg);
+}
+
+static void scmi_mbox_client_txdone(struct scmi_chan_info *cinfo, int r)
+{
+	mbox_client_txdone(cinfo->chan, r);
+}
+
+static void scmi_mbox_free_channel(struct scmi_chan_info *cinfo)
+{
+	mbox_free_channel(cinfo->chan);
+}
+
+static struct scmi_mbox_ops scmi_default_mbox_ops = {
+	.request_channel = scmi_mbox_request_channel,
+	.send_message = scmi_mbox_send_message,
+	.client_txdone = scmi_mbox_client_txdone,
+	.free_channel = scmi_mbox_free_channel,
+};
+
+const struct scmi_desc scmi_generic_desc = {
+	.max_rx_timeout_ms = 30,	/* we may increase this if required */
+	.max_msg = 20,		/* Limited by MBOX_TX_QUEUE_LEN */
+	.max_msg_size = 128,
+	.mbox_ops = &scmi_default_mbox_ops,
+};
diff --git a/drivers/firmware/arm_scmi/mbox_if.h b/drivers/firmware/arm_scmi/mbox_if.h
new file mode 100644
index 000000000000..02baa73e8613
--- /dev/null
+++ b/drivers/firmware/arm_scmi/mbox_if.h
@@ -0,0 +1,68 @@
+/*
+ * System Control and Management Interface (SCMI) mailbox interface header
+ *
+ * Copyright (C) 2017 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/mailbox_client.h>
+
+/**
+ * struct scmi_chan_info - Structure representing a SCMI channel informfation
+ *
+ * @cl: Mailbox Client
+ * @tx_chan: Transmit mailbox channel
+ * @rx_chan: Receive mailbox channel
+ * @tx_payload: Transmit mailbox channel payload area
+ * @rx_payload: Receive mailbox channel payload area
+ * @dev: Reference to device in the SCMI hierarchy corresponding to this
+ *	 channel
+ */
+struct scmi_chan_info {
+	struct mbox_client cl;
+	struct mbox_chan *chan;
+	void __iomem *payload;
+	struct device *dev;
+	void *priv;
+};
+
+#define client_to_scmi_chan_info(c) container_of(c, struct scmi_chan_info, cl)
+
+struct scmi_mbox_ops {
+	int (*request_channel)(struct scmi_chan_info *cinfo, int index);
+	int (*send_message)(struct scmi_chan_info *cinfo, void *msg);
+	void (*client_txdone)(struct scmi_chan_info *cinfo, int r);
+	void (*free_channel)(struct scmi_chan_info *cinfo);
+};
+
+/**
+ * struct scmi_desc - Description of SoC integration
+ *
+ * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
+ * @max_msg: Maximum number of messages that can be pending
+ *	simultaneously in the system
+ * @max_msg_size: Maximum size of data per message that can be handled.
+ * @mbox_ops: Function to initialise the mailbox operations
+ */
+struct scmi_desc {
+	int max_rx_timeout_ms;
+	int max_msg;
+	int max_msg_size;
+	struct scmi_mbox_ops *mbox_ops;
+};
+
+void scmi_generic_rx_callback(struct scmi_chan_info *cinfo);
+void scmi_generic_tx_prepare(struct scmi_chan_info *cinfo, void *m);
+
+extern const struct scmi_desc scmi_generic_desc;
-- 
2.7.4
