From: vincent.cw.yang@gmail.com (Vincent Yang)
Date: Wed,  4 Mar 2015 19:01:24 +0800
Subject: [PATCH v7 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
Message-ID: <1425466884-30648-1-git-send-email-vincent.yang@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Add driver for the ARM Primecell Message-Handling-Unit(MHU) controller.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Vincent Yang <vincent.yang@socionext.com>
Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@socionext.com>
---
 .../devicetree/bindings/mailbox/arm-mhu.txt        |  43 +++++
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm_mhu.c                          | 195 +++++++++++++++++++++
 4 files changed, 249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
 create mode 100644 drivers/mailbox/arm_mhu.c

diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
new file mode 100644
index 0000000..4971f03
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
@@ -0,0 +1,43 @@
+ARM MHU Mailbox Driver
+======================
+
+The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
+3 independent channels/links to communicate with remote processor(s).
+ MHU links are hardwired on a platform. A link raises interrupt for any
+received data. However, there is no specified way of knowing if the sent
+data has been read by the remote. This driver assumes the sender polls
+STAT register and the remote clears it after having read the data.
+The last channel is specified to be a 'Secure' resource, hence can't be
+used by Linux running NS.
+
+Mailbox Device Node:
+====================
+
+Required properties:
+--------------------
+- compatible:		Shall be "arm,mhu" & "arm,primecell"
+- reg:			Contains the mailbox register address range (base
+			address and length)
+- #mbox-cells		Shall be 1 - the index of the channel needed.
+- interrupts:		Contains the interrupt information corresponding to
+			each of the 3 links of MHU.
+
+Example:
+--------
+
+	mhu: mailbox at 2b1f0000 {
+		#mbox-cells = <1>;
+		compatible = "arm,mhu", "arm,primecell";
+		reg = <0 0x2b1f0000 0x1000>;
+		interrupts = <0 36 4>, /* LP-NonSecure */
+			     <0 35 4>, /* HP-NonSecure */
+			     <0 37 4>; /* Secure */
+		clocks = <&clock 0 2 1>;
+		clock-names = "apb_pclk";
+	};
+
+	mhu_client: scb at 2e000000 {
+		compatible = "fujitsu,mb86s70-scb-1.0";
+		reg = <0 0x2e000000 0x4000>;
+		mboxes = <&mhu 1>; /* HP-NonSecure */
+	};
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 84325f2..84b0a2d 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -6,6 +6,15 @@ menuconfig MAILBOX
 	  signals. Say Y if your platform supports hardware mailboxes.
 
 if MAILBOX
+
+config ARM_MHU
+	tristate "ARM MHU Mailbox"
+	depends on ARM_AMBA
+	help
+	  Say Y here if you want to build the ARM MHU controller driver.
+	  The controller has 3 mailbox channels, the last of which can be
+	  used in Secure mode only.
+
 config PL320_MBOX
 	bool "ARM PL320 Mailbox"
 	depends on ARM_AMBA
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 2e79231..b18201e 100644
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
index 0000000..ac693c6
--- /dev/null
+++ b/drivers/mailbox/arm_mhu.c
@@ -0,0 +1,195 @@
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
+#include <linux/module.h>
+#include <linux/amba/bus.h>
+#include <linux/mailbox_controller.h>
+
+#define INTR_STAT_OFS	0x0
+#define INTR_SET_OFS	0x8
+#define INTR_CLR_OFS	0x10
+
+#define MHU_LP_OFFSET	0x0
+#define MHU_HP_OFFSET	0x20
+#define MHU_SEC_OFFSET	0x200
+#define TX_REG_OFFSET	0x100
+
+#define MHU_CHANS	3
+
+struct mhu_link {
+	unsigned irq;
+	void __iomem *tx_reg;
+	void __iomem *rx_reg;
+};
+
+struct arm_mhu {
+	void __iomem *base;
+	struct mhu_link mlink[MHU_CHANS];
+	struct mbox_chan chan[MHU_CHANS];
+	struct mbox_controller mbox;
+};
+
+static irqreturn_t mhu_rx_interrupt(int irq, void *p)
+{
+	struct mbox_chan *chan = p;
+	struct mhu_link *mlink = chan->con_priv;
+	u32 val;
+
+	val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
+	if (!val)
+		return IRQ_NONE;
+
+	mbox_chan_received_data(chan, (void *)&val);
+
+	writel_relaxed(val, mlink->rx_reg + INTR_CLR_OFS);
+
+	return IRQ_HANDLED;
+}
+
+static bool mhu_last_tx_done(struct mbox_chan *chan)
+{
+	struct mhu_link *mlink = chan->con_priv;
+	u32 val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
+
+	return (val == 0);
+}
+
+static int mhu_send_data(struct mbox_chan *chan, void *data)
+{
+	struct mhu_link *mlink = chan->con_priv;
+	u32 *arg = data;
+
+	writel_relaxed(*arg, mlink->tx_reg + INTR_SET_OFS);
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
+	val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
+	writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
+
+	ret = request_irq(mlink->irq, mhu_rx_interrupt,
+			  IRQF_SHARED, "mhu_link", chan);
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
+static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	int i, err;
+	struct arm_mhu *mhu;
+	struct device *dev = &adev->dev;
+	int mhu_reg[MHU_CHANS] = {MHU_LP_OFFSET, MHU_HP_OFFSET, MHU_SEC_OFFSET};
+
+	/* Allocate memory for device */
+	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
+	if (!mhu)
+		return -ENOMEM;
+
+	mhu->base = devm_ioremap_resource(dev, &adev->res);
+	if (IS_ERR(mhu->base)) {
+		dev_err(dev, "ioremap failed\n");
+		return PTR_ERR(mhu->base);
+	}
+
+	for (i = 0; i < MHU_CHANS; i++) {
+		mhu->chan[i].con_priv = &mhu->mlink[i];
+		mhu->mlink[i].irq = adev->irq[i];
+		mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
+		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
+	}
+
+	mhu->mbox.dev = dev;
+	mhu->mbox.chans = &mhu->chan[0];
+	mhu->mbox.num_chans = MHU_CHANS;
+	mhu->mbox.ops = &mhu_ops;
+	mhu->mbox.txdone_irq = false;
+	mhu->mbox.txdone_poll = true;
+	mhu->mbox.txpoll_period = 10;
+
+	amba_set_drvdata(adev, mhu);
+
+	err = mbox_controller_register(&mhu->mbox);
+	if (err) {
+		dev_err(dev, "Failed to register mailboxes %d\n", err);
+		return err;
+	}
+
+	dev_info(dev, "ARM MHU Mailbox registered\n");
+	return 0;
+}
+
+static int mhu_remove(struct amba_device *adev)
+{
+	struct arm_mhu *mhu = amba_get_drvdata(adev);
+
+	mbox_controller_unregister(&mhu->mbox);
+
+	return 0;
+}
+
+static struct amba_id mhu_ids[] = {
+	{
+		.id	= 0x1bb098,
+		.mask	= 0xffffff,
+	},
+	{ 0, 0 },
+};
+MODULE_DEVICE_TABLE(amba, mhu_ids);
+
+static struct amba_driver arm_mhu_driver = {
+	.drv = {
+		.name	= "mhu",
+	},
+	.id_table	= mhu_ids,
+	.probe		= mhu_probe,
+	.remove		= mhu_remove,
+};
+module_amba_driver(arm_mhu_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ARM MHU Driver");
+MODULE_AUTHOR("Jassi Brar <jassisinghbrar@gmail.com>");
-- 
1.9.0
