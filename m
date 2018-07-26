From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 26 Jul 2018 08:53:31 +0200
Subject: [PATCH v7 6/6] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <20180726065331.6186-1-o.rempel@pengutronix.de>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
Message-ID: <20180726065331.6186-7-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Mailbox controller is able to send messages (up to 4 32 bit words)
between the endpoints.

This driver was tested using the mailbox-test driver sending messages
between the Cortex-A7 and the Cortex-M4.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/mailbox/Kconfig       |   6 +
 drivers/mailbox/Makefile      |   2 +
 drivers/mailbox/imx-mailbox.c | 276 ++++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 drivers/mailbox/imx-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index a2bb27446dce..79060ddc380d 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -15,6 +15,12 @@ config ARM_MHU
 	  The controller has 3 mailbox channels, the last of which can be
 	  used in Secure mode only.
 
+config IMX_MBOX
+	tristate "i.MX Mailbox"
+	depends on ARCH_MXC || COMPILE_TEST
+	help
+	  Mailbox implementation for i.MX Messaging Unit (MU).
+
 config PLATFORM_MHU
 	tristate "Platform MHU Mailbox"
 	depends on OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index cc23c3a43fcd..ba2fe1b6dd62 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
 
 obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
 
+obj-$(CONFIG_IMX_MBOX)	+= imx-mailbox.o
+
 obj-$(CONFIG_PLATFORM_MHU)	+= platform_mhu.o
 
 obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
new file mode 100644
index 000000000000..ecfddca5e31c
--- /dev/null
+++ b/drivers/mailbox/imx-mailbox.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+
+/* Transmit Register */
+#define IMX_MU_xTRn(x)		(0x00 + 4 * (x))
+/* Receive Register */
+#define IMX_MU_xRRn(x)		(0x10 + 4 * (x))
+/* Status Register */
+#define IMX_MU_xSR		0x20
+#define IMX_MU_xSR_TEn(x)	BIT(20 + (3 - (x)))
+#define IMX_MU_xSR_RFn(x)	BIT(24 + (3 - (x)))
+#define IMX_MU_xSR_BRDIP	BIT(9)
+
+/* Control Register */
+#define IMX_MU_xCR		0x24
+/* Transmit Interrupt Enable */
+#define IMX_MU_xCR_TIEn(x)	BIT(20 + (3 - (x)))
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(x)	BIT(24 + (3 - (x)))
+
+#define IMX_MU_CHANS	4u
+
+struct imx_mu_con_priv {
+	int			irq;
+	unsigned int		idx;
+	char			*irq_desc;
+};
+
+struct imx_mu_priv {
+	struct device		*dev;
+	void __iomem		*base;
+	spinlock_t		xcr_lock; /* control register lock */
+
+	struct mbox_controller	mbox;
+	struct mbox_chan	mbox_chans[IMX_MU_CHANS];
+
+	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
+	struct clk		*clk;
+
+	bool			side_b;
+};
+
+static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
+{
+	return container_of(mbox, struct imx_mu_priv, mbox);
+}
+
+static void imx_mu_write(struct imx_mu_priv *priv, u32 val, u32 offs)
+{
+	iowrite32(val, priv->base + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu_priv *priv, u32 offs)
+{
+	return ioread32(priv->base + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu_priv *priv, u32 set, u32 clr)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&priv->xcr_lock, flags);
+	val = imx_mu_read(priv, IMX_MU_xCR);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(priv, val, IMX_MU_xCR);
+	spin_unlock_irqrestore(&priv->xcr_lock, flags);
+
+	return val;
+}
+
+static irqreturn_t imx_mu_isr(int irq, void *p)
+{
+	struct mbox_chan *chan = p;
+	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	u32 val, ctrl, dat;
+
+	ctrl = imx_mu_read(priv, IMX_MU_xCR);
+	val = imx_mu_read(priv, IMX_MU_xSR);
+	val &= IMX_MU_xSR_TEn(cp->idx) | IMX_MU_xSR_RFn(cp->idx);
+	val &= ctrl & (IMX_MU_xCR_TIEn(cp->idx) | IMX_MU_xCR_RIEn(cp->idx));
+	if (!val)
+		return IRQ_NONE;
+
+	if (val & IMX_MU_xSR_TEn(cp->idx)) {
+		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
+		mbox_chan_txdone(chan, 0);
+	}
+
+	if (val & IMX_MU_xSR_RFn(cp->idx)) {
+		dat = imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
+		mbox_chan_received_data(chan, (void *)&dat);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static bool imx_mu_last_tx_done(struct mbox_chan *chan)
+{
+	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	/* test if transmit register is empty */
+	return imx_mu_read(priv, IMX_MU_xSR) & IMX_MU_xSR_TEn(cp->idx);
+}
+
+static int imx_mu_send_data(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	u32 *arg = data;
+
+	if (!imx_mu_last_tx_done(chan))
+		return -EBUSY;
+
+	imx_mu_write(priv, *arg, IMX_MU_xTRn(cp->idx));
+	imx_mu_xcr_rmw(priv, IMX_MU_xSR_TEn(cp->idx), 0);
+
+	return 0;
+}
+
+static int imx_mu_startup(struct mbox_chan *chan)
+{
+	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	int ret;
+
+	cp->irq_desc = kasprintf(GFP_KERNEL, "imx_mu_chan[%i]", cp->idx);
+	if (!cp->irq_desc)
+		return -ENOMEM;
+
+	ret = request_irq(cp->irq, imx_mu_isr, IRQF_SHARED, cp->irq_desc,
+			  chan);
+	if (ret) {
+		dev_err(priv->dev,
+			"Unable to acquire IRQ %d\n", cp->irq);
+		return ret;
+	}
+
+	imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(cp->idx), 0);
+
+	return 0;
+}
+
+static void imx_mu_shutdown(struct mbox_chan *chan)
+{
+	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	imx_mu_xcr_rmw(priv, 0,
+		   IMX_MU_xCR_TIEn(cp->idx) | IMX_MU_xCR_RIEn(cp->idx));
+
+	free_irq(cp->irq, chan);
+	kfree(cp->irq_desc);
+}
+
+static const struct mbox_chan_ops imx_mu_ops = {
+	.send_data = imx_mu_send_data,
+	.startup = imx_mu_startup,
+	.shutdown = imx_mu_shutdown,
+};
+
+static void imx_mu_init_generic(struct imx_mu_priv *priv)
+{
+	if (priv->side_b)
+		return;
+
+	/* Set default MU configuration */
+	imx_mu_write(priv, 0, IMX_MU_xCR);
+}
+
+static int imx_mu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct resource *iomem;
+	struct imx_mu_priv *priv;
+	unsigned int i;
+	int irq, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(&pdev->dev, iomem);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		if (PTR_ERR(priv->clk) != -ENOENT)
+			return PTR_ERR(priv->clk);
+
+		priv->clk = NULL;
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock\n");
+		return ret;
+	}
+
+	for (i = 0; i < IMX_MU_CHANS; i++) {
+		struct imx_mu_con_priv *cp = &priv->con_priv[i];
+
+		cp->idx = i;
+		cp->irq = irq;
+		priv->mbox_chans[i].con_priv = cp;
+	}
+
+	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
+
+	spin_lock_init(&priv->xcr_lock);
+
+	priv->mbox.dev = dev;
+	priv->mbox.ops = &imx_mu_ops;
+	priv->mbox.chans = priv->mbox_chans;
+	priv->mbox.num_chans = IMX_MU_CHANS;
+	priv->mbox.txdone_irq = true;
+
+	platform_set_drvdata(pdev, priv);
+
+	imx_mu_init_generic(priv);
+
+	return mbox_controller_register(&priv->mbox);
+}
+
+static int imx_mu_remove(struct platform_device *pdev)
+{
+	struct imx_mu_priv *priv = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&priv->mbox);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static const struct of_device_id imx_mu_dt_ids[] = {
+	{ .compatible = "fsl,imx6sx-mu" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
+
+static struct platform_driver imx_mu_driver = {
+	.probe		= imx_mu_probe,
+	.remove		= imx_mu_remove,
+	.driver = {
+		.name	= "imx_mu",
+		.of_match_table = imx_mu_dt_ids,
+	},
+};
+module_platform_driver(imx_mu_driver);
+
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_DESCRIPTION("Message Unit driver for i.MX");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0
