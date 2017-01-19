From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Wed, 18 Jan 2017 17:39:39 -0800
Subject: [PATCH v2 2/3] mailbox: Add iProc mailbox controller driver
In-Reply-To: <1484789980-6812-1-git-send-email-jonathan.richardson@broadcom.com>
References: <1484789980-6812-1-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <1484789980-6812-3-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom iProc mailbox controller handles all communication with a
Cortex-M0 MCU processor that provides support for power, clock, and
reset management.

Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
Reviewed-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
---
 drivers/mailbox/Kconfig                   |  10 ++
 drivers/mailbox/Makefile                  |   2 +
 drivers/mailbox/bcm-iproc-mailbox.c       | 199 ++++++++++++++++++++++++++++++
 include/linux/mailbox/bcm_iproc_mailbox.h |  32 +++++
 4 files changed, 243 insertions(+)
 create mode 100644 drivers/mailbox/bcm-iproc-mailbox.c
 create mode 100644 include/linux/mailbox/bcm_iproc_mailbox.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 11eebfe..284916d 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -143,4 +143,14 @@ config BCM_PDC_MBOX
 	  Mailbox implementation for the Broadcom PDC ring manager,
 	  which provides access to various offload engines on Broadcom
 	  SoCs. Say Y here if you want to use the Broadcom PDC.
+
+config BCM_IPROC_MBOX
+	bool "Broadcom iProc Mailbox"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	default ARCH_BCM_IPROC
+	help
+	  Broadcom iProc architected SoC's have an always on Cortex-M0 MCU processor
+	  that handles support for power, clock, and reset management. The iProc
+	  mailbox controller handles all communication with this processor.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index ace6fed..f96eab6 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -29,3 +29,5 @@ obj-$(CONFIG_XGENE_SLIMPRO_MBOX) += mailbox-xgene-slimpro.o
 obj-$(CONFIG_HI6220_MBOX)	+= hi6220-mailbox.o
 
 obj-$(CONFIG_BCM_PDC_MBOX)	+= bcm-pdc-mailbox.o
+
+obj-$(CONFIG_BCM_IPROC_MBOX)	+= bcm-iproc-mailbox.o
diff --git a/drivers/mailbox/bcm-iproc-mailbox.c b/drivers/mailbox/bcm-iproc-mailbox.c
new file mode 100644
index 0000000..36ecad5
--- /dev/null
+++ b/drivers/mailbox/bcm-iproc-mailbox.c
@@ -0,0 +1,199 @@
+/*
+ * Copyright (C) 2017 Broadcom.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/bcm_iproc_mailbox.h>
+#include <linux/delay.h>
+
+#define IPROC_CRMU_MAILBOX0_OFFSET       0x0
+#define IPROC_CRMU_MAILBOX1_OFFSET       0x4
+
+#define M0_IPC_CMD_DONE_MASK             0x80000000
+#define M0_IPC_CMD_REPLY_MASK            0x3fff0000
+#define M0_IPC_CMD_REPLY_SHIFT           16
+
+/* Max time the M0 will take to respond to a message. */
+#define MAX_M0_TIMEOUT_MS                2
+
+struct iproc_mbox {
+	struct device         *dev;
+	void __iomem          *base;
+	spinlock_t            lock;
+	struct mbox_controller controller;
+	u32                   num_chans;
+};
+
+static const struct of_device_id iproc_mbox_of_match[] = {
+	{ .compatible = "brcm,iproc-mailbox" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, iproc_mbox_of_match);
+
+/*
+ * Sends a message to M0. The mailbox framework prevents multiple accesses to
+ * the same channel but there is only one h/w "channel". This driver allows
+ * multiple clients to create channels to the controller but must serialize
+ * access to the mailbox registers used to communicate with the M0.
+ */
+static int iproc_mbox_send_data_m0(struct mbox_chan *chan, void *data)
+{
+	struct iproc_mbox *mbox = dev_get_drvdata(chan->mbox->dev);
+	struct iproc_mbox_msg *msg = (struct iproc_mbox_msg *)data;
+		unsigned long flags;
+	int err = 0;
+	const int poll_period_us = 5;
+	const int max_retries = (MAX_M0_TIMEOUT_MS * 1000) / poll_period_us;
+
+	if (!msg)
+		return -EINVAL;
+
+	spin_lock_irqsave(&mbox->lock, flags);
+
+	dev_dbg(mbox->dev, "Send msg to M0: cmd=0x%x, param=0x%x, wait_ack=%d\n",
+		msg->cmd, msg->param, msg->wait_ack);
+
+	writel(msg->cmd, mbox->base + IPROC_CRMU_MAILBOX0_OFFSET);
+	writel(msg->param, mbox->base + IPROC_CRMU_MAILBOX1_OFFSET);
+
+	if (msg->wait_ack) {
+		int retries;
+
+		err = msg->reply_code = -ETIMEDOUT;
+		for (retries = 0; retries < max_retries; retries++) {
+			u32 val = readl(
+				mbox->base + IPROC_CRMU_MAILBOX0_OFFSET);
+			if (val & M0_IPC_CMD_DONE_MASK) {
+				/*
+				 * M0 replied - save reply code and
+				 * clear error.
+				 */
+				msg->reply_code = (val &
+					M0_IPC_CMD_REPLY_MASK) >>
+					M0_IPC_CMD_REPLY_SHIFT;
+				err = 0;
+				break;
+			}
+			udelay(poll_period_us);
+		}
+	}
+
+	spin_unlock_irqrestore(&mbox->lock, flags);
+
+	return err;
+}
+
+static int iproc_mbox_startup(struct mbox_chan *chan)
+{
+	/* Do nothing. */
+	return 0;
+}
+
+static void iproc_mbox_shutdown(struct mbox_chan *chan)
+{
+	/* Do nothing. */
+}
+
+static struct mbox_chan_ops iproc_mbox_ops = {
+	.send_data    = iproc_mbox_send_data_m0,
+	.startup      = iproc_mbox_startup,
+	.shutdown     = iproc_mbox_shutdown,
+};
+
+static int iproc_mbox_probe(struct platform_device *pdev)
+{
+	int err;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct iproc_mbox *iproc_mbox;
+	struct device_node *node;
+	const char *mbox_prop_name = "mboxes";
+	struct mbox_chan *chans;
+
+	dev_info(&pdev->dev, "Initializing iproc mailbox controller\n");
+
+	iproc_mbox = devm_kzalloc(dev, sizeof(*iproc_mbox), GFP_KERNEL);
+	if (!iproc_mbox)
+		return -ENOMEM;
+
+	iproc_mbox->dev = dev;
+	spin_lock_init(&iproc_mbox->lock);
+
+	platform_set_drvdata(pdev, iproc_mbox);
+
+	/* Count number of "mboxes" properties to determine # channels. */
+	for_each_of_allnodes(node) {
+		struct property *prop = of_find_property(
+			node, mbox_prop_name, NULL);
+		if (prop) {
+			struct device_node *mbox_phandle = of_parse_phandle(
+				node, mbox_prop_name, 0);
+			if (mbox_phandle == dev->of_node)
+				iproc_mbox->num_chans++;
+		}
+	}
+
+	if (iproc_mbox->num_chans == 0) {
+		dev_err(dev, "No mailbox clients configured\n");
+		return -ENODEV;
+	}
+
+	chans = devm_kzalloc(&pdev->dev,
+		sizeof(*chans) * iproc_mbox->num_chans, GFP_KERNEL);
+	if (!chans)
+		return -ENOMEM;
+
+	/* Initialize mailbox controller. */
+	iproc_mbox->controller.dev = iproc_mbox->dev;
+	iproc_mbox->controller.num_chans = iproc_mbox->num_chans;
+	iproc_mbox->controller.chans = chans;
+	iproc_mbox->controller.ops = &iproc_mbox_ops;
+	iproc_mbox->controller.txdone_irq = false;
+	iproc_mbox->controller.txdone_poll = false;
+	err = mbox_controller_register(&iproc_mbox->controller);
+	if (err) {
+		dev_err(&pdev->dev, "Register mailbox failed\n");
+		return err;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	iproc_mbox->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(iproc_mbox->base)) {
+		dev_err(&pdev->dev, "unable to map I/O memory\n");
+		return PTR_ERR(iproc_mbox->base);
+	}
+
+	return 0;
+}
+
+static struct platform_driver iproc_mbox_driver = {
+	.driver = {
+		.name = "brcm,iproc-mailbox",
+		.of_match_table = iproc_mbox_of_match,
+	},
+	.probe = iproc_mbox_probe,
+};
+
+static int __init iproc_mbox_init(void)
+{
+	return platform_driver_register(&iproc_mbox_driver);
+}
+arch_initcall(iproc_mbox_init);
+
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("Broadcom iProc Mailbox Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mailbox/bcm_iproc_mailbox.h b/include/linux/mailbox/bcm_iproc_mailbox.h
new file mode 100644
index 0000000..68f37e4
--- /dev/null
+++ b/include/linux/mailbox/bcm_iproc_mailbox.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2016 Broadcom.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef _BCM_IPROC_MAILBOX_H_
+#define _BCM_IPROC_MAILBOX_H_
+
+/*
+ * A message to send to the M0 processor.
+ * @cmd Command to send.
+ * @param Parameter corresponding to command.
+ * @wait_ack true if mbox_send_message() should wait for a reply from the M0,
+ *   false if the M0 doesn't reply. This depends on the message being sent.
+ * @reply_code The response code from the M0 for the command sent (wait_ack was
+ *   set to true).
+ */
+struct iproc_mbox_msg {
+	u32       cmd;
+	u32       param;
+	bool      wait_ack;
+	u32       reply_code;
+};
+
+#endif
-- 
1.9.1
