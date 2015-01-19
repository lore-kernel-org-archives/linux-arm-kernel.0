From: vincent.yang.fujitsu@gmail.com (Vincent Yang)
Date: Mon, 19 Jan 2015 18:31:03 +0800
Subject: [PATCH v4 2/8] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <1421663016-1327-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1421663016-1327-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <1421663463-1426-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Add driver for the ARM Message-Handling-Unit (MHU).

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
---
 .../devicetree/bindings/mailbox/arm-mhu.txt        |  33 ++++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm_mhu.c                          | 211 +++++++++++++++++++++
 4 files changed, 253 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
 create mode 100644 drivers/mailbox/arm_mhu.c

diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
new file mode 100644
index 0000000..b1b9888
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
@@ -0,0 +1,33 @@
+ARM MHU Mailbox Driver
+======================
+
+The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
+3 independent channels/links to communicate with remote processor(s).
+ MHU links are hardwired on a platform. A link raises interrupt for any
+received data. However, there is no specified way of knowing if the sent
+data has been read by the remote. This driver assumes the sender polls
+STAT register and the remote clears it after having read the data.
+
+Mailbox Device Node:
+====================
+
+Required properties:
+--------------------
+- compatible:		Shall be "arm,mbox-mhu"
+- reg:			Contains the mailbox register address range (base
+			address and length)
+- #mbox-cells		Shall be 1
+- interrupts:		Contains the interrupt information corresponding to
+			each of the 3 links of MHU.
+
+Example:
+--------
+
+	mhu: mailbox at 2b1f0000 {
+		#mbox-cells = <1>;
+		compatible = "arm,mbox-mhu";
+		reg = <0 0x2b1f0000 0x1000>;
+		interrupts = <0 36 4>,
+			     <0 35 4>,
+			     <0 37 4>;
+	};
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c04fed9..9238440 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -6,6 +6,13 @@ menuconfig MAILBOX
 	  signals. Say Y if your platform supports hardware mailboxes.
 
 if MAILBOX
+
+config ARM_MHU
+	tristate "ARM MHU Mailbox"
+	depends on ARM
+	help
+	  Say Y here if you want to build the ARM MHU controller driver
+
 config PL320_MBOX
 	bool "ARM PL320 Mailbox"
 	depends on ARM_AMBA
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index dd412c2..c83791d 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -2,6 +2,8 @@
 
 obj-$(CONFIG_MAILBOX)		+= mailbox.o
 
+obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
+
 obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
 
 obj-$(CONFIG_OMAP2PLUS_MBOX)	+= omap-mailbox.o
diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
new file mode 100644
index 0000000..4f9d559
--- /dev/null
+++ b/drivers/mailbox/arm_mhu.c
@@ -0,0 +1,211 @@
+/*
+ * Copyright (C) 2013-2015 Fujitsu Semiconductor Ltd.
+ * Copyright (C) 2015 Linaro Ltd.
+ * Author: Jassi Brar <jaswinder.singh@linaro.org>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/mailbox_controller.h>
+#include <linux/platform_device.h>
+
+#define INTR_STAT_OFS	0x0
+#define INTR_SET_OFS	0x8
+#define INTR_CLR_OFS	0x10
+
+struct mhu_link {
+	unsigned irq;
+	void __iomem *tx_reg;
+	void __iomem *rx_reg;
+};
+
+struct arm_mhu {
+	void __iomem *base;
+	struct clk *clk;
+	struct mhu_link mlink[3];
+	struct mbox_chan chan[3];
+	struct mbox_controller mbox;
+};
+
+static irqreturn_t mhu_rx_interrupt(int irq, void *p)
+{
+	struct mbox_chan *chan = p;
+	struct mhu_link *mlink = chan->con_priv;
+	u32 val;
+
+	pr_debug("%s:%d\n", __func__, __LINE__);
+	val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
+	if (!val)
+		return IRQ_NONE;
+
+	mbox_chan_received_data(chan, (void *)val);
+
+	writel_relaxed(val, mlink->rx_reg + INTR_CLR_OFS);
+
+	return IRQ_HANDLED;
+}
+
+static bool mhu_last_tx_done(struct mbox_chan *chan)
+{
+	struct mhu_link *mlink = chan->con_priv;
+	u32 val;
+
+	pr_debug("%s:%d\n", __func__, __LINE__);
+	val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
+
+	return (val == 0);
+}
+
+static int mhu_send_data(struct mbox_chan *chan, void *data)
+{
+	struct mhu_link *mlink = chan->con_priv;
+
+	pr_debug("%s:%d\n", __func__, __LINE__);
+	if (!mhu_last_tx_done(chan)) {
+		dev_err(chan->mbox->dev, "Last TX(%d) pending!\n", mlink->irq);
+		return -EBUSY;
+	}
+
+	writel_relaxed((u32)data, mlink->tx_reg + INTR_SET_OFS);
+
+	return 0;
+}
+
+static int mhu_startup(struct mbox_chan *chan)
+{
+	struct mhu_link *mlink = chan->con_priv;
+	u32 val;
+	int ret;
+
+	pr_debug("%s:%d\n", __func__, __LINE__);
+	val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
+	writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
+
+	ret = request_irq(mlink->irq, mhu_rx_interrupt, 0, "mhu_link", chan);
+	if (ret) {
+		dev_err(chan->mbox->dev,
+			"Unable to aquire IRQ %d\n", mlink->irq);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mhu_shutdown(struct mbox_chan *chan)
+{
+	struct mhu_link *mlink = chan->con_priv;
+
+	pr_debug("%s:%d\n", __func__, __LINE__);
+	free_irq(mlink->irq, chan);
+}
+
+static struct mbox_chan_ops mhu_ops = {
+	.send_data = mhu_send_data,
+	.startup = mhu_startup,
+	.shutdown = mhu_shutdown,
+	.last_tx_done = mhu_last_tx_done,
+};
+
+static int arm_mhu_probe(struct platform_device *pdev)
+{
+	int i, err;
+	struct arm_mhu *mhu;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	int mhu_reg[3] = {0x0, 0x20, 0x200};
+
+	/* Allocate memory for device */
+	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
+	if (!mhu)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "No IOMEM found\n");
+		return -ENXIO;
+	}
+	mhu->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!mhu->base) {
+		dev_err(dev, "ioremap failed\n");
+		return -ENXIO;
+	}
+
+	for (i = 0; i < 3; i++) {
+		mhu->chan[i].con_priv = &mhu->mlink[i];
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
+		mhu->mlink[i].irq = res->start;
+		mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
+		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + 0x100;
+	}
+
+	mhu->mbox.dev = dev;
+	mhu->mbox.chans = &mhu->chan[0];
+	mhu->mbox.num_chans = 3;
+	mhu->mbox.ops = &mhu_ops;
+	mhu->mbox.txdone_irq = false;
+	mhu->mbox.txdone_poll = true;
+	mhu->mbox.txpoll_period = 10;
+
+	platform_set_drvdata(pdev, mhu);
+
+	err = mbox_controller_register(&mhu->mbox);
+	if (err) {
+		dev_err(dev, "Failed to register mailboxes %d\n", err);
+		return err;
+	}
+
+	mhu->clk = devm_clk_get(dev, "clk");
+	if (IS_ERR(mhu->clk))
+		dev_info(dev, "unable to init clock\n");
+	else
+		clk_prepare_enable(mhu->clk);
+
+	dev_info(dev, "ARM MHU Mailbox registered\n");
+	return 0;
+}
+
+static int arm_mhu_remove(struct platform_device *pdev)
+{
+	struct arm_mhu *mhu = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(mhu->clk);
+	mbox_controller_unregister(&mhu->mbox);
+
+	return 0;
+}
+
+static const struct of_device_id arm_mhu_dt_ids[] = {
+	{ .compatible = "arm,mbox-mhu" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, arm_mhu_dt_ids);
+
+static struct platform_driver arm_mhu_driver = {
+	.driver = {
+		.name = "arm_mhu",
+		.of_match_table = arm_mhu_dt_ids,
+	},
+	.probe = arm_mhu_probe,
+	.remove = arm_mhu_remove,
+};
+module_platform_driver(arm_mhu_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ARM MHU Driver");
+MODULE_AUTHOR("Jassi Brar <jassisinghbrar@gmail.com>");
-- 
1.9.0
