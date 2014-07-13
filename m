From: mollie.wu@linaro.org (Mollie Wu)
Date: Sun, 13 Jul 2014 14:32:08 +0800
Subject: [PATCH 7/8] mailbox: f_mhu: add driver for Fujitsu MHU controller
In-Reply-To: <message-id-of-cover-letter>
References: <message-id-of-cover-letter>
Message-ID: <1405233128-4799-1-git-send-email-mollie.wu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver for the proprietary Mailbox controller (f_mhu) in MB86S7x.
It has three channels - LowPri-NonSecure, HighPri-NonSecure and Secure.
The MB86S7x communicates over the HighPri-NonSecure channel.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>
Signed-off-by: Mollie Wu <mollie.wu@linaro.org>
---
 drivers/mailbox/Kconfig  |   7 ++
 drivers/mailbox/Makefile |   2 +
 drivers/mailbox/f_mhu.c  | 227 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 drivers/mailbox/f_mhu.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c8b5c13..681aac2 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -6,6 +6,13 @@ menuconfig MAILBOX
 	  signals. Say Y if your platform supports hardware mailboxes.
 
 if MAILBOX
+
+config MBOX_F_MHU
+	bool
+	depends on ARCH_MB86S7X
+	help
+	  Say Y here if you want to use the F_MHU IPCM support.
+
 config PL320_MBOX
 	bool "ARM PL320 Mailbox"
 	depends on ARM_AMBA
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 2fa343a..3707e93 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -2,6 +2,8 @@
 
 obj-$(CONFIG_MAILBOX)		+= mailbox.o
 
+obj-$(CONFIG_MBOX_F_MHU)	+= f_mhu.o
+
 obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
 
 obj-$(CONFIG_OMAP_MBOX)		+= omap-mailbox.o
diff --git a/drivers/mailbox/f_mhu.c b/drivers/mailbox/f_mhu.c
new file mode 100644
index 0000000..cf5d3cd
--- /dev/null
+++ b/drivers/mailbox/f_mhu.c
@@ -0,0 +1,227 @@
+/*
+ * Copyright (C) 2013-2014 Fujitsu Semiconductor Ltd.
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
+#define MHU_SCFG	0x400
+
+struct mhu_link {
+	unsigned irq;
+	spinlock_t lock; /* channel regs */
+	void __iomem *tx_reg;
+	void __iomem *rx_reg;
+};
+
+struct f_mhu {
+	void __iomem *base;
+	struct clk *clk;
+	struct mhu_link mlink[3];
+	struct mbox_chan chan[3];
+	struct mbox_controller mbox;
+};
+
+static irqreturn_t mhu_rx_interrupt(int irq, void *p)
+{
+	struct mbox_chan *chan = (struct mbox_chan *)p;
+	struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
+	u32 val;
+
+	pr_debug("%s:%d\n", __func__, __LINE__);
+	/* See NOTE_RX_DONE */
+	val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
+	mbox_chan_received_data(chan, (void *)val);
+
+	/*
+	 * It is agreed with the remote firmware that the receiver
+	 * will clear the STAT register indicating it is ready to
+	 * receive next data - NOTE_RX_DONE
+	 */
+	writel_relaxed(val, mlink->rx_reg + INTR_CLR_OFS);
+
+	return IRQ_HANDLED;
+}
+
+static bool mhu_last_tx_done(struct mbox_chan *chan)
+{
+	struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
+	unsigned long flags;
+	u32 val;
+
+	pr_debug("%s:%d\n", __func__, __LINE__);
+	spin_lock_irqsave(&mlink->lock, flags);
+	/* See NOTE_RX_DONE */
+	val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
+	spin_unlock_irqrestore(&mlink->lock, flags);
+
+	return (val == 0);
+}
+
+static int mhu_send_data(struct mbox_chan *chan, void *data)
+{
+	struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
+	unsigned long flags;
+
+	pr_debug("%s:%d\n", __func__, __LINE__);
+	if (!mhu_last_tx_done(chan)) {
+		pr_err("%s:%d Shouldn't have seen the day!\n",
+		       __func__, __LINE__);
+		return -EBUSY;
+	}
+
+	spin_lock_irqsave(&mlink->lock, flags);
+	writel_relaxed((u32)data, mlink->tx_reg + INTR_SET_OFS);
+	spin_unlock_irqrestore(&mlink->lock, flags);
+
+	return 0;
+}
+
+static int mhu_startup(struct mbox_chan *chan)
+{
+	struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
+	unsigned long flags;
+	u32 val;
+	int ret;
+
+	pr_debug("%s:%d\n", __func__, __LINE__);
+	spin_lock_irqsave(&mlink->lock, flags);
+	val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
+	writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
+	spin_unlock_irqrestore(&mlink->lock, flags);
+
+	ret = request_irq(mlink->irq, mhu_rx_interrupt,
+			  IRQF_SHARED, "mhu_link", chan);
+	if (unlikely(ret)) {
+		pr_err("Unable to aquire IRQ\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mhu_shutdown(struct mbox_chan *chan)
+{
+	struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
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
+static int f_mhu_probe(struct platform_device *pdev)
+{
+	int i, err;
+	struct f_mhu *mhu;
+	struct resource *res;
+	int mhu_reg[3] = {0x0, 0x20, 0x200};
+
+	/* Allocate memory for device */
+	mhu = kzalloc(sizeof(*mhu), GFP_KERNEL);
+	if (!mhu) {
+		dev_err(&pdev->dev, "failed to allocate memory.\n");
+		return -EBUSY;
+	}
+
+	mhu->clk = clk_get(&pdev->dev, "clk");
+	if (unlikely(IS_ERR(mhu->clk))) {
+		dev_err(&pdev->dev, "unable to init clock\n");
+		kfree(mhu);
+		return -EINVAL;
+	}
+	clk_prepare_enable(mhu->clk);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mhu->base = ioremap(res->start, resource_size(res));
+	if (!mhu->base) {
+		dev_err(&pdev->dev, "ioremap failed.\n");
+		kfree(mhu);
+		return -EBUSY;
+	}
+
+	/* Let UnTrustedOS's access violations don't bother us */
+	writel_relaxed(0, mhu->base + MHU_SCFG);
+
+	for (i = 0; i < 3; i++) {
+		mhu->chan[i].con_priv = &mhu->mlink[i];
+		spin_lock_init(&mhu->mlink[i].lock);
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
+		mhu->mlink[i].irq = res->start;
+		mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
+		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + 0x100;
+	}
+
+	mhu->mbox.dev = &pdev->dev;
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
+		dev_err(&pdev->dev, "Failed to register mailboxes %d\n", err);
+		iounmap(mhu->base);
+		kfree(mhu);
+	} else {
+		dev_info(&pdev->dev, "Fujitsu MHU Mailbox registered\n");
+	}
+
+	return 0;
+}
+
+static const struct of_device_id f_mhu_dt_ids[] = {
+	{ .compatible = "fujitsu,mhu" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, f_mhu_dt_ids);
+
+static struct platform_driver f_mhu_driver = {
+	.driver		= {
+		.name	= "f_mhu",
+		.owner = THIS_MODULE,
+		.of_match_table = f_mhu_dt_ids,
+	},
+	.probe		= f_mhu_probe,
+};
+
+static int __init f_mhu_init(void)
+{
+	return platform_driver_register(&f_mhu_driver);
+}
+module_init(f_mhu_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Fujitsu MHU Driver");
+MODULE_AUTHOR("Jassi Brar <jaswinder.singh@linaro.org>");
-- 
1.8.1.2
