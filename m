From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Sep 2017 14:11:40 +0100
Subject: [PATCH v3 16/22] firmware: arm_scmi: add arm_mhu specific mailbox
 interface
In-Reply-To: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1506604306-20739-17-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ARM MHU specific mailbox interface for SCMI.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/Makefile     |   1 +
 drivers/firmware/arm_scmi/arm_mhu_if.c | 106 +++++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/driver.c     |   3 +
 drivers/firmware/arm_scmi/mbox_if.h    |   3 +
 4 files changed, 113 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/arm_mhu_if.c

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 733157c5b4e2..7fb026c71833 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ARM_SCMI_PROTOCOL)	= arm_scmi.o
 arm_scmi-y = base.o clock.o driver.o mbox_if.o perf.o power.o sensors.o
+arm_scmi-$(CONFIG_ARM_MHU) += arm_mhu_if.o
diff --git a/drivers/firmware/arm_scmi/arm_mhu_if.c b/drivers/firmware/arm_scmi/arm_mhu_if.c
new file mode 100644
index 000000000000..2271a4811378
--- /dev/null
+++ b/drivers/firmware/arm_scmi/arm_mhu_if.c
@@ -0,0 +1,106 @@
+/*
+ * System Control and Management Interface (SCMI) MHU mailbox interface
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
+#include "common.h"
+#include "mbox_if.h"
+
+union mhu_data {
+	void *ptr;
+	u32 val;
+};
+
+static void mhu_tx_prepare(struct mbox_client *cl, void *m)
+{
+	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
+	union mhu_data tmp;
+
+	scmi_generic_tx_prepare(cinfo, m);
+
+	/* clear only the relavant bit */
+	tmp.ptr = cinfo->priv;
+	*(u32 *)m &= tmp.val;
+}
+
+static void mhu_rx_callback(struct mbox_client *cl, void *m)
+{
+	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
+
+	scmi_generic_rx_callback(cinfo);
+}
+
+static int mhu_mbox_request_channel(struct scmi_chan_info *cinfo, int index)
+{
+	int ret = 0;
+	struct mbox_client *cl = &cinfo->cl;
+	struct device_node *np = cl->dev->of_node;
+	union mhu_data tmp = {0};
+
+	if (index != 0 && index != 1) /* Tx = 0, Rx =1 */
+		return -EINVAL;
+
+	cl->rx_callback = mhu_rx_callback;
+	cl->tx_prepare = mhu_tx_prepare;
+
+	ret = of_property_read_u32_index(np, "mbox-data", index, &tmp.val);
+	if (ret)
+		return ret;
+
+	cinfo->chan = mbox_request_channel(cl, index);
+	if (IS_ERR(cinfo->chan))
+		ret = PTR_ERR(cinfo->chan);
+
+	cinfo->priv = tmp.ptr;
+
+	return ret;
+}
+
+static int mhu_mbox_send_message(struct scmi_chan_info *cinfo, void *msg)
+{
+	struct scmi_xfer *t = msg;
+
+	t->con_priv = cinfo->priv;
+
+	return mbox_send_message(cinfo->chan, msg);
+}
+
+static void mhu_mbox_client_txdone(struct scmi_chan_info *cinfo, int r)
+{
+	mbox_client_txdone(cinfo->chan, r);
+}
+
+static void mhu_mbox_free_channel(struct scmi_chan_info *cinfo)
+{
+	mbox_free_channel(cinfo->chan);
+}
+
+static struct scmi_mbox_ops arm_mhu_mbox_ops = {
+	.request_channel = mhu_mbox_request_channel,
+	.send_message = mhu_mbox_send_message,
+	.client_txdone = mhu_mbox_client_txdone,
+	.free_channel = mhu_mbox_free_channel,
+};
+
+const struct scmi_desc mhu_scmi_desc = {
+	.max_rx_timeout_ms = 30,
+	.max_msg = 20,
+	.max_msg_size = 128,
+	.mbox_ops = &arm_mhu_mbox_ops,
+};
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 97285a22dfaa..bdc9c566e6c1 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -648,6 +648,9 @@ EXPORT_SYMBOL_GPL(devm_scmi_handle_get);
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
 	{ .compatible = "arm,scmi", .data = &scmi_generic_desc },
+#if IS_REACHABLE(CONFIG_ARM_MHU)
+	{ .compatible = "arm,mhu-scmi", .data = &mhu_scmi_desc },
+#endif
 	{ /* Sentinel */ },
 };
 
diff --git a/drivers/firmware/arm_scmi/mbox_if.h b/drivers/firmware/arm_scmi/mbox_if.h
index 02baa73e8613..a23fc6d7a91f 100644
--- a/drivers/firmware/arm_scmi/mbox_if.h
+++ b/drivers/firmware/arm_scmi/mbox_if.h
@@ -66,3 +66,6 @@ void scmi_generic_rx_callback(struct scmi_chan_info *cinfo);
 void scmi_generic_tx_prepare(struct scmi_chan_info *cinfo, void *m);
 
 extern const struct scmi_desc scmi_generic_desc;
+#if IS_REACHABLE(CONFIG_ARM_MHU)
+extern const struct scmi_desc mhu_scmi_desc;
+#endif
-- 
2.7.4
