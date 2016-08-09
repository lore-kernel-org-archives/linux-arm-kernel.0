From: andre.przywara@arm.com (Andre Przywara)
Date: Tue,  9 Aug 2016 12:52:59 +0100
Subject: [RFC PATCH 1/5] mailbox: introduce ARM SMC based mailbox
In-Reply-To: <20160809115303.17032-1-andre.przywara@arm.com>
References: <20160809115303.17032-1-andre.przywara@arm.com>
Message-ID: <20160809115303.17032-2-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This mailbox driver implements a mailbox which signals transmitted data
via an ARM smc (secure monitor call) instruction. The mailbox receiver
is implemented in firmware and can synchronously return data when it
returns execution to the non-secure OS again.
An asynchronous receive path is not implemented.
This allows the usage of a mailbox to trigger firmware actions on SoCs
which either don't have a separate management processor or on which such
a core is not available. A user of this mailbox could be the SCP
interface.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mailbox/Kconfig       |   8 +++
 drivers/mailbox/Makefile      |   2 +
 drivers/mailbox/smc-mailbox.c | 135 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 drivers/mailbox/smc-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 97c3729..7ffaef6 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -132,4 +132,12 @@ config BCM_PDC_MBOX
 	  Mailbox implementation for the Broadcom PDC ring manager,
 	  which provides access to various offload engines on Broadcom
 	  SoCs. Say Y here if you want to use the Broadcom PDC.
+
+config SMC_MBOX
+	tristate "Generic ARM SMC mailbox"
+	depends on HAVE_ARM_SMCCC
+	depends on OF
+	help
+	  Generic mailbox driver which uses ARM smc calls to call into
+	  firmware for triggering mailboxes.
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 66c38e3..8488afd 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -27,3 +27,5 @@ obj-$(CONFIG_XGENE_SLIMPRO_MBOX) += mailbox-xgene-slimpro.o
 obj-$(CONFIG_HI6220_MBOX)	+= hi6220-mailbox.o
 
 obj-$(CONFIG_BCM_PDC_MBOX)	+= bcm-pdc-mailbox.o
+
+obj-$(CONFIG_SMC_MBOX)		+= smc-mailbox.o
diff --git a/drivers/mailbox/smc-mailbox.c b/drivers/mailbox/smc-mailbox.c
new file mode 100644
index 0000000..63f09bd
--- /dev/null
+++ b/drivers/mailbox/smc-mailbox.c
@@ -0,0 +1,135 @@
+/*
+ *  Copyright (C) 2016 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This device provides a mechanism for emulating a mailbox by using
+ * smc calls, allowing a "mailbox" consumer to sit in firmware running
+ * on the same core.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/arm-smccc.h>
+
+static int smc_send_data(struct mbox_chan *link, void *data)
+{
+	u32 function_id = (unsigned long)link->con_priv;
+	u32 msg = *(u32 *)data;
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(function_id, msg, 0, 0, 0, 0, 0, 0, &res);
+
+	mbox_chan_received_data(link, (void *)res.a0);
+
+	return 0;
+}
+
+static int smc_startup(struct mbox_chan *link)
+{
+	return 0;
+}
+
+static void smc_shutdown(struct mbox_chan *link)
+{
+}
+
+/* This mailbox is synchronous, so we are always done. */
+static bool smc_last_tx_done(struct mbox_chan *link)
+{
+	return true;
+}
+
+static const struct mbox_chan_ops smc_mbox_chan_ops = {
+	.send_data	= smc_send_data,
+	.startup	= smc_startup,
+	.shutdown	= smc_shutdown,
+	.last_tx_done	= smc_last_tx_done
+};
+
+static int smc_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mbox_controller *mbox;
+	int ret = 0;
+	int i;
+
+	ret = of_property_count_elems_of_size(dev->of_node, "identifiers",
+					      sizeof(u32));
+	if (ret < 0)
+		return ret;
+
+	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (mbox == NULL)
+		return -ENOMEM;
+
+	mbox->num_chans = ret;
+	mbox->chans = devm_kmalloc_array(dev, mbox->num_chans,
+					 sizeof(*mbox->chans),
+					 GFP_KERNEL | __GFP_ZERO);
+	if (!mbox->chans)
+		return -ENOMEM;
+
+	for (i = 0; i < mbox->num_chans; i++) {
+		u32 function_id;
+
+		ret = of_property_read_u32_index(dev->of_node, "identifiers", i,
+						 &function_id);
+		if (ret)
+			return ret;
+		mbox->chans[i].con_priv = (void *)(unsigned long)function_id;
+	}
+
+	mbox->txdone_poll = true;
+	mbox->txdone_irq = false;
+	mbox->txpoll_period = 1;
+	mbox->ops = &smc_mbox_chan_ops;
+	mbox->dev = dev;
+
+	ret = mbox_controller_register(mbox);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, mbox);
+	dev_info(dev, "ARM SMC mailbox enabled with %d chans.\n",
+		 mbox->num_chans);
+
+	return ret;
+}
+
+static int smc_mbox_remove(struct platform_device *pdev)
+{
+	struct mbox_controller *mbox = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(mbox);
+	return 0;
+}
+
+static const struct of_device_id smc_mbox_of_match[] = {
+	{ .compatible = "arm,smc-mbox", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, smc_mbox_of_match);
+
+static struct platform_driver smc_mbox_driver = {
+	.driver = {
+		.name = "smc-mbox",
+		.of_match_table = smc_mbox_of_match,
+	},
+	.probe		= smc_mbox_probe,
+	.remove		= smc_mbox_remove,
+};
+module_platform_driver(smc_mbox_driver);
+
+MODULE_AUTHOR("Andre Przywara <andre.przywara@arm.com>");
+MODULE_DESCRIPTION("Generic ARM smc mailbox driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.0
