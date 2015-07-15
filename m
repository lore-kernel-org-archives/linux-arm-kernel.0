From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 14 Jul 2015 18:00:22 -0700
Subject: [PATCHv7 2/2] mailbox: Adding driver for Xilinx LogiCORE IP mailbox.
In-Reply-To: <1436922022-17564-1-git-send-email-moritz.fischer@ettus.com>
References: <1436922022-17564-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1436922022-17564-3-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Xilinx LogiCORE IP mailbox is a FPGA core that allows for
interprocessor communication via AXI4 memory mapped / AXI4 stream
interfaces.

It is single channel per core and allows for transmit and receive.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
 MAINTAINERS                      |   7 +
 drivers/mailbox/Kconfig          |   7 +
 drivers/mailbox/Makefile         |   2 +
 drivers/mailbox/mailbox-xilinx.c | 367 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 383 insertions(+)
 create mode 100644 drivers/mailbox/mailbox-xilinx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3d55c..bfe2b78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11320,6 +11320,13 @@ M:	John Linn <John.Linn@xilinx.com>
 S:	Maintained
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
+XILINX MAILBOX DRIVER
+M:	Moritz Fischer <moritz.fischer@ettus.com>
+L:	linux-kernel at vger.kernel.org
+S:	Maintained
+F:	drivers/mailbox/mailbox-xilinx.c
+F:	Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial at vger.kernel.org
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index e269f08..15b3ade 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -70,4 +70,11 @@ config BCM2835_MBOX
 	  the services of the Videocore. Say Y here if you want to use the
 	  BCM2835 Mailbox.
 
+config XILINX_MBOX
+	tristate "Xilinx Mailbox"
+	help
+	  An implementation of the Xilinx Mailbox soft core. It is used
+	  to send message between processors. Say Y here if you want to use the
+	  Xilinx mailbox support.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 8e6d822..1966e26 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -13,3 +13,5 @@ obj-$(CONFIG_PCC)		+= pcc.o
 obj-$(CONFIG_ALTERA_MBOX)	+= mailbox-altera.o
 
 obj-$(CONFIG_BCM2835_MBOX)	+= bcm2835-mailbox.o
+
+obj-$(CONFIG_XILINX_MBOX)	+= mailbox-xilinx.o
diff --git a/drivers/mailbox/mailbox-xilinx.c b/drivers/mailbox/mailbox-xilinx.c
new file mode 100644
index 0000000..27011e6
--- /dev/null
+++ b/drivers/mailbox/mailbox-xilinx.c
@@ -0,0 +1,367 @@
+/*
+ * Copyright (c) 2015, National Instruments Corp. All rights reserved.
+ *
+ * Driver for the Xilinx LogiCORE mailbox IP block
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+/* register offsets */
+#define MAILBOX_REG_WRDATA	0x00
+#define MAILBOX_REG_RDDATA	0x08
+#define MAILBOX_REG_STATUS	0x10
+#define MAILBOX_REG_ERROR	0x14
+#define MAILBOX_REG_SIT	0x18
+#define MAILBOX_REG_RIT	0x1c
+#define MAILBOX_REG_IS	0x20
+#define MAILBOX_REG_IE	0x24
+#define MAILBOX_REG_IP	0x28
+
+/* status register */
+#define STS_RTA	BIT(3)
+#define STS_STA	BIT(2)
+#define STS_FULL	BIT(1)
+#define STS_EMPTY	BIT(0)
+
+/* error register */
+#define ERR_FULL	BIT(1)
+#define ERR_EMPTY	BIT(0)
+
+/* mailbox interrupt status register */
+#define INT_STATUS_ERR	BIT(2)
+#define INT_STATUS_RTI	BIT(1)
+#define INT_STATUS_STI	BIT(0)
+
+/* mailbox interrupt enable register */
+#define INT_ENABLE_ERR	BIT(2)
+#define INT_ENABLE_RTI	BIT(1)
+#define INT_ENABLE_STI	BIT(0)
+
+#define MBOX_POLLING_MS		5	/* polling interval 5ms */
+
+struct xilinx_mbox {
+	int irq;
+	void __iomem *mbox_base;
+	struct clk *clk;
+	struct device *dev;
+	struct mbox_controller controller;
+	struct mbox_chan chan;
+
+	/* if the controller supports only RX polling mode */
+	struct timer_list rxpoll_timer;
+};
+
+static struct xilinx_mbox *mbox_chan_to_xilinx_mbox(struct mbox_chan *chan)
+{
+	return container_of(chan, struct xilinx_mbox, chan);
+}
+
+static inline bool xilinx_mbox_full(struct xilinx_mbox *mbox)
+{
+	u32 status;
+
+	status = readl_relaxed(mbox->mbox_base + MAILBOX_REG_STATUS);
+
+	return status & STS_FULL;
+}
+
+static inline bool xilinx_mbox_pending(struct xilinx_mbox *mbox)
+{
+	u32 status;
+
+	status = readl_relaxed(mbox->mbox_base + MAILBOX_REG_STATUS);
+
+	return !(status & STS_EMPTY);
+}
+
+static void xilinx_mbox_intmask(struct xilinx_mbox *mbox, u32 mask, bool enable)
+{
+	u32 mask_reg;
+
+	mask_reg = readl_relaxed(mbox->mbox_base + MAILBOX_REG_IE);
+	if (enable)
+		mask_reg |= mask;
+	else
+		mask_reg &= ~mask;
+
+	writel_relaxed(mask_reg, mbox->mbox_base + MAILBOX_REG_IE);
+}
+
+static inline void xilinx_mbox_rx_intmask(struct xilinx_mbox *mbox, bool enable)
+{
+	xilinx_mbox_intmask(mbox, INT_ENABLE_RTI, enable);
+}
+
+static inline void xilinx_mbox_tx_intmask(struct xilinx_mbox *mbox, bool enable)
+{
+	xilinx_mbox_intmask(mbox, INT_ENABLE_STI, enable);
+}
+
+static void xilinx_mbox_rx_data(struct mbox_chan *chan)
+{
+	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
+	u32 data;
+
+	if (xilinx_mbox_pending(mbox)) {
+		data = readl_relaxed(mbox->mbox_base + MAILBOX_REG_RDDATA);
+		mbox_chan_received_data(chan, (void *)data);
+	}
+}
+
+static void xilinx_mbox_poll_rx(unsigned long data)
+{
+	struct mbox_chan *chan = (struct mbox_chan *)data;
+	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
+
+	xilinx_mbox_rx_data(chan);
+
+	mod_timer(&mbox->rxpoll_timer,
+		  jiffies + msecs_to_jiffies(MBOX_POLLING_MS));
+}
+
+static irqreturn_t xilinx_mbox_interrupt(int irq, void *p)
+{
+	u32 mask;
+	struct mbox_chan *chan = (struct mbox_chan *)p;
+	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
+
+	mask = readl_relaxed(mbox->mbox_base + MAILBOX_REG_IS);
+	if (mask & INT_STATUS_RTI)
+		xilinx_mbox_rx_data(chan);
+
+	/* mask irqs *before* notifying done, require tx_block=true */
+	if (mask & INT_STATUS_STI) {
+		xilinx_mbox_tx_intmask(mbox, false);
+		mbox_chan_txdone(chan, 0);
+	}
+
+	writel_relaxed(mask, mbox->mbox_base + MAILBOX_REG_IS);
+
+	return IRQ_HANDLED;
+}
+
+static int xilinx_mbox_irq_startup(struct mbox_chan *chan)
+{
+	int ret;
+	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
+
+	ret = request_irq(mbox->irq, xilinx_mbox_interrupt, 0,
+			  dev_name(mbox->dev), chan);
+	if (unlikely(ret)) {
+		dev_err(mbox->dev,
+			"failed to register mailbox interrupt:%d\n",
+			ret);
+		return ret;
+	}
+
+	/* prep and enable the clock */
+	clk_prepare_enable(mbox->clk);
+
+	xilinx_mbox_rx_intmask(mbox, true);
+
+	/* if fifo was full already, we didn't get an interrupt */
+	while (xilinx_mbox_pending(mbox))
+		xilinx_mbox_rx_data(chan);
+
+	return 0;
+}
+
+static int xilinx_mbox_poll_startup(struct mbox_chan *chan)
+{
+	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
+
+	clk_prepare_enable(mbox->clk);
+
+	mod_timer(&mbox->rxpoll_timer,
+		  jiffies + msecs_to_jiffies(MBOX_POLLING_MS));
+
+	return 0;
+}
+
+static int xilinx_mbox_irq_send_data(struct mbox_chan *chan, void *data)
+{
+	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
+	u32 *udata = data;
+
+	if (xilinx_mbox_full(mbox))
+		return -EBUSY;
+
+	/* enable interrupt before send */
+	xilinx_mbox_tx_intmask(mbox, true);
+
+	writel_relaxed(*udata, mbox->mbox_base + MAILBOX_REG_WRDATA);
+
+	return 0;
+}
+
+static int xilinx_mbox_poll_send_data(struct mbox_chan *chan, void *data)
+{
+	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
+	u32 *udata = data;
+
+	if (!mbox || !data)
+		return -EINVAL;
+
+	if (xilinx_mbox_full(mbox))
+		return -EBUSY;
+
+	writel_relaxed(*udata, mbox->mbox_base + MAILBOX_REG_WRDATA);
+
+	return 0;
+}
+
+static bool xilinx_mbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
+
+	/* return false if mailbox is full */
+	return !xilinx_mbox_full(mbox);
+}
+
+static bool xilinx_mbox_peek_data(struct mbox_chan *chan)
+{
+	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
+
+	return xilinx_mbox_pending(mbox);
+}
+
+static void xilinx_mbox_irq_shutdown(struct mbox_chan *chan)
+{
+	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
+
+	/* mask all interrupts */
+	writel_relaxed(0, mbox->mbox_base + MAILBOX_REG_IE);
+
+	clk_disable_unprepare(mbox->clk);
+
+	free_irq(mbox->irq, chan);
+}
+
+static void xilinx_mbox_poll_shutdown(struct mbox_chan *chan)
+{
+	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
+
+	del_timer_sync(&mbox->rxpoll_timer);
+
+	clk_disable_unprepare(mbox->clk);
+}
+
+static const struct mbox_chan_ops xilinx_mbox_irq_ops = {
+	.send_data = xilinx_mbox_irq_send_data,
+	.startup = xilinx_mbox_irq_startup,
+	.shutdown = xilinx_mbox_irq_shutdown,
+	.last_tx_done = xilinx_mbox_last_tx_done,
+	.peek_data = xilinx_mbox_peek_data,
+};
+
+static const struct mbox_chan_ops xilinx_mbox_poll_ops = {
+	.send_data = xilinx_mbox_poll_send_data,
+	.startup = xilinx_mbox_poll_startup,
+	.shutdown = xilinx_mbox_poll_shutdown,
+	.last_tx_done = xilinx_mbox_last_tx_done,
+	.peek_data = xilinx_mbox_peek_data,
+};
+
+static int xilinx_mbox_probe(struct platform_device *pdev)
+{
+	struct xilinx_mbox *mbox;
+	struct resource	*regs;
+	int ret;
+
+	mbox = devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	/* get clk and enable */
+	mbox->clk = devm_clk_get(&pdev->dev, "mbox");
+	if (IS_ERR(mbox->clk)) {
+		dev_err(&pdev->dev, "Couldn't get clk.\n");
+		return PTR_ERR(mbox->clk);
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	mbox->mbox_base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(mbox->mbox_base))
+		return PTR_ERR(mbox->mbox_base);
+
+	mbox->irq = platform_get_irq(pdev, 0);
+	/* if irq is present, we can use it, otherwise, poll */
+	if (mbox->irq > 0) {
+		mbox->controller.txdone_irq = true;
+		mbox->controller.ops = &xilinx_mbox_irq_ops;
+	} else {
+		dev_info(&pdev->dev, "IRQ not found, fallback to polling.\n");
+		mbox->controller.txdone_poll = true;
+		mbox->controller.txpoll_period = MBOX_POLLING_MS;
+		mbox->controller.ops = &xilinx_mbox_poll_ops;
+
+		setup_timer(&mbox->rxpoll_timer, xilinx_mbox_poll_rx,
+			    (unsigned long)&mbox->chan);
+	}
+
+	mbox->dev = &pdev->dev;
+
+	/* hardware supports only one channel. */
+	mbox->controller.dev = mbox->dev;
+	mbox->controller.num_chans = 1;
+	mbox->controller.chans = &mbox->chan;
+
+	ret = mbox_controller_register(&mbox->controller);
+	if (ret) {
+		dev_err(&pdev->dev, "Register mailbox failed\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, mbox);
+
+	return 0;
+}
+
+static int xilinx_mbox_remove(struct platform_device *pdev)
+{
+	struct xilinx_mbox *mbox = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&mbox->controller);
+
+	return 0;
+}
+
+static const struct of_device_id xilinx_mbox_match[] = {
+	{ .compatible = "xlnx,mailbox-2.1" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, xilinx_mbox_match);
+
+static struct platform_driver xilinx_mbox_driver = {
+	.probe	= xilinx_mbox_probe,
+	.remove	= xilinx_mbox_remove,
+	.driver	= {
+		.name	= KBUILD_MODNAME,
+		.of_match_table	= xilinx_mbox_match,
+	},
+};
+
+module_platform_driver(xilinx_mbox_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Xilinx mailbox specific functions");
+MODULE_AUTHOR("Moritz Fischer <moritz.fischer@ettus.com>");
-- 
2.4.3
