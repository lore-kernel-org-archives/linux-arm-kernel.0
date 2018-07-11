From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 12 Jul 2018 00:32:39 +0800
Subject: [RFC PATCH v6 2/2] mailbox: imx-mailbox: add scu protocol support
In-Reply-To: <1531326759-20556-1-git-send-email-aisheng.dong@nxp.com>
References: <1531326759-20556-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1531326759-20556-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SCU protocol support in the generic mailbox driver.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mailbox/Kconfig       |   6 +-
 drivers/mailbox/imx-mailbox.c | 252 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 223 insertions(+), 35 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 91dd507..40b8736 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -17,9 +17,11 @@ config ARM_MHU
 
 config IMX_MBOX
 	tristate "iMX Mailbox"
-	depends on SOC_IMX7D || COMPILE_TEST
+	depends on ARCH_MXC || COMPILE_TEST
 	help
-	  Mailbox implementation for iMX7D Messaging Unit (MU).
+	  An implementation of the i.MX MU Mailbox. It is used to send message
+	  between application processors and other processors/MCU/DSP. Select
+	  Y here if you want to use i.MX MU Mailbox controller.
 
 config PLATFORM_MHU
 	tristate "Platform MHU Mailbox"
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 5f925dc..2931d57 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@xxxxxxxxxxxxxx>
+ * Copyright 2018 NXP, Dong Aisheng <aisheng.dong@nxp.com>
  */
 
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
@@ -23,6 +25,12 @@
 
 /* Control Register */
 #define IMX_MU_xCR		0x24
+#define IMX_MU_xCR_GIEn_MASK	GENMASK(37, 28)
+#define IMX_MU_xCR_RIEn_MASK	GENMASK(27, 24)
+#define IMX_MU_xCR_TIEn_MASK	GENMASK(23, 20)
+#define IMX_MU_xCR_GIRn_MASK	GENMASK(19, 16)
+#define IMX_MU_xCR_Fn_MASK	GENMASK(2, 0)
+
 /* Transmit Interrupt Enable */
 #define IMX_MU_xCR_TIEn(x)	BIT(20 + (x))
 /* Receive Interrupt Enable */
@@ -30,6 +38,8 @@
 
 #define IMX_MU_MAX_CHANS	4u
 
+#define MU_DATA_TIME_OUT_US	(100 * USEC_PER_MSEC)
+
 struct imx_mu_priv;
 
 struct imx_mu_cfg {
@@ -38,7 +48,6 @@ struct imx_mu_cfg {
 };
 
 struct imx_mu_con_priv {
-	int			irq;
 	unsigned int		bidx;
 	unsigned int		idx;
 };
@@ -53,6 +62,11 @@ struct imx_mu_priv {
 
 	struct imx_mu_con_priv  con_priv[IMX_MU_MAX_CHANS];
 	struct clk		*clk;
+	int			irq;
+
+	bool			is_scu_pro;
+	/* for runtime scu msg store */
+	u32 *msg;
 };
 
 static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
@@ -82,6 +96,161 @@ static u32 imx_mu_rmw(struct imx_mu_priv *priv, u32 offs, u32 set, u32 clr)
 	return val;
 }
 
+static struct mbox_chan *imx_mu_scu_index_xlate(struct mbox_controller *mbox,
+						const struct of_phandle_args *sp)
+{
+	if (sp->args_count != 0) {
+		dev_err(mbox->dev,
+			"incorrect mu channel specified in devicetree\n");
+		return NULL;
+	}
+
+	return &mbox->chans[0];
+}
+
+/*
+ * Wait to receive message from the other core.
+ */
+static int imx_mu_scu_receive_msg(struct mbox_chan *chan, u32 index, u32 *msg)
+{
+	struct imx_mu_priv *priv = chan->con_priv;
+	u32 mask, sr;
+	int ret;
+
+	mask = IMX_MU_xSR_RFn(3 - index);
+
+	/* Wait RX register to be full. */
+	ret = readl_poll_timeout_atomic(priv->base + IMX_MU_xSR, sr, sr & mask,
+					0, MU_DATA_TIME_OUT_US);
+	if (ret) {
+		dev_err(chan->mbox->dev,
+			"Waiting MU receive register (%u) full timeout!\n",
+			index);
+		return ret;
+	}
+
+	*msg = imx_mu_read(priv, IMX_MU_xRRn(index));
+
+	return 0;
+}
+
+static bool imx_mu_scu_peek_data(struct mbox_chan *chan)
+{
+	struct imx_mu_priv *priv = chan->con_priv;
+	u8 *raw_data;
+	int i, size;
+	int ret;
+
+	ret = imx_mu_scu_receive_msg(chan, 0, priv->msg);
+	if (ret)
+		return false;
+
+	raw_data = (u8 *)priv->msg;
+	size = raw_data[1];
+
+	dev_dbg(chan->mbox->dev, "receive data: hdr 0x%x size %d\n",
+		*priv->msg, size);
+
+	for (i = 1; i < size; i++) {
+		ret = imx_mu_scu_receive_msg(chan, i % 4, priv->msg + i);
+		if (ret)
+			return false;
+	}
+
+	mbox_chan_received_data(chan, (void *)priv->msg);
+
+	return true;
+}
+
+
+/*
+ * Wait and send message to the other core.
+ */
+static int imx_mu_scu_send_msg(struct mbox_chan *chan, u32 index, u32 msg)
+{
+	struct imx_mu_priv *priv = chan->con_priv;
+	u32 mask, sr;
+	int ret;
+
+	mask = IMX_MU_xSR_TEn(3 - index);
+
+	/* Wait TX register to be empty. */
+	ret = readl_poll_timeout_atomic(priv->base + IMX_MU_xSR, sr, sr & mask,
+					0, MU_DATA_TIME_OUT_US);
+	if (ret) {
+		dev_err(chan->mbox->dev,
+			"Waiting MU transmit register (%u) empty timeout!\n",
+			index);
+		return ret;
+	}
+
+	imx_mu_write(priv, msg, IMX_MU_xTRn(index));
+
+	return 0;
+}
+
+static int imx_mu_scu_send_data(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu_priv *priv = chan->con_priv;
+	u8 *raw_data = data;
+	int i, ret;
+	int size;
+
+	if (!data)
+		return -EINVAL;
+
+	priv->msg = data;
+
+	/* SCU protocol size position is at the second u8 */
+	size = raw_data[1];
+
+	dev_dbg(chan->mbox->dev, "send data (size %d)\n", size);
+
+	for (i = 0; i < size; i++) {
+		ret = imx_mu_scu_send_msg(chan, i % 4, *(priv->msg + i));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int imx_mu_scu_startup(struct mbox_chan *chan)
+{
+	struct imx_mu_priv *priv = chan->con_priv;
+	u32 val;
+
+	/* Init MU */
+	val = imx_mu_read(priv, IMX_MU_xCR);
+	/* Clear GIEn, RIEn, TIEn, GIRn and ABFn. */
+	val &= ~(IMX_MU_xCR_GIEn_MASK | IMX_MU_xCR_RIEn_MASK |
+		 IMX_MU_xCR_TIEn_MASK | IMX_MU_xCR_GIRn_MASK |
+		 IMX_MU_xCR_Fn_MASK);
+	imx_mu_write(priv, val, IMX_MU_xCR);
+
+	return 0;
+}
+
+static const struct mbox_chan_ops imx_mu_scu_ops = {
+	.startup = imx_mu_scu_startup,
+	.send_data = imx_mu_scu_send_data,
+	.peek_data = imx_mu_scu_peek_data,
+};
+
+int imx_mu_scu_init(struct imx_mu_priv *priv)
+{
+	priv->mbox.dev = priv->dev;
+	priv->mbox.ops = &imx_mu_scu_ops;
+	priv->mbox.chans = &priv->mbox_chans[0];
+	priv->mbox.num_chans = 1;
+	priv->mbox.txdone_irq = false;
+	priv->mbox.txdone_poll = false;
+	priv->mbox.of_xlate = &imx_mu_scu_index_xlate;
+	priv->mbox.chans->con_priv = priv;
+
+	return 0;
+}
+
 static irqreturn_t imx_mu_isr(int irq, void *p)
 {
 	struct mbox_chan *chan = p;
@@ -140,11 +309,11 @@ static int imx_mu_startup(struct mbox_chan *chan)
 	struct imx_mu_con_priv *cp = chan->con_priv;
 	int ret;
 
-	ret = request_irq(cp->irq, imx_mu_isr,
+	ret = request_irq(priv->irq, imx_mu_isr,
 			  IRQF_SHARED, "imx_mu_chan", chan);
 	if (ret) {
 		dev_err(chan->mbox->dev,
-			"Unable to acquire IRQ %d\n", cp->irq);
+			"Unable to acquire IRQ %d\n", priv->irq);
 		return ret;
 	}
 
@@ -161,7 +330,7 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 	imx_mu_rmw(priv, IMX_MU_xCR, 0,
 		   IMX_MU_xCR_TIEn(cp->bidx) | IMX_MU_xCR_RIEn(cp->bidx));
 
-	free_irq(cp->irq, chan);
+	free_irq(priv->irq, chan);
 }
 
 static const struct mbox_chan_ops imx_mu_ops = {
@@ -170,24 +339,47 @@ static const struct mbox_chan_ops imx_mu_ops = {
 	.shutdown = imx_mu_shutdown,
 };
 
+int imx_mu_init(struct imx_mu_priv *priv)
+{
+	unsigned int chans;
+	int i;
+
+	priv->dcfg = of_device_get_match_data(priv->dev);
+	if (!priv->dcfg)
+		return -EINVAL;
+
+	chans = min(priv->dcfg->chans, IMX_MU_MAX_CHANS);
+	/* Initialize channel identifiers */
+	for (i = 0; i < chans; i++) {
+		struct imx_mu_con_priv *cp = &priv->con_priv[i];
+
+		cp->bidx = 3 - i;
+		cp->idx = i;
+		priv->mbox_chans[i].con_priv = cp;
+	}
+
+	priv->mbox.dev = priv->dev;
+	priv->mbox.ops = &imx_mu_ops;
+	priv->mbox.chans = priv->mbox_chans;
+	priv->mbox.num_chans = chans;
+	priv->mbox.txdone_irq = true;
+
+	if (priv->dcfg->init_hw)
+		priv->dcfg->init_hw(priv);
+}
+
 static int imx_mu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *iomem;
 	struct imx_mu_priv *priv;
-	const struct imx_mu_cfg *dcfg;
-	unsigned int i, chans;
-	int irq, ret;
+	u32 val = 0;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	dcfg = of_device_get_match_data(dev);
-	if (!dcfg)
-		return -EINVAL;
-
-	priv->dcfg = dcfg;
 	priv->dev = dev;
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -195,9 +387,9 @@ static int imx_mu_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return irq < 0 ? irq : -EINVAL;
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq <= 0)
+		return priv->irq < 0 ? priv->irq : -EINVAL;
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
@@ -215,28 +407,21 @@ static int imx_mu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	chans = min(dcfg->chans, IMX_MU_MAX_CHANS);
-	/* Initialize channel identifiers */
-	for (i = 0; i < chans; i++) {
-		struct imx_mu_con_priv *cp = &priv->con_priv[i];
+	ret = of_property_read_u32(dev->of_node, "#mbox-cells", &val);
+	if (ret)
+		return ret;
 
-		cp->bidx = 3 - i;
-		cp->idx = i;
-		cp->irq = irq;
-		priv->mbox_chans[i].con_priv = cp;
-	}
+	priv->is_scu_pro = !val;
+	if (priv->is_scu_pro)
+		ret = imx_mu_scu_init(priv);
+	else
+		ret = imx_mu_init(priv);
 
-	priv->mbox.dev = dev;
-	priv->mbox.ops = &imx_mu_ops;
-	priv->mbox.chans = priv->mbox_chans;
-	priv->mbox.num_chans = chans;
-	priv->mbox.txdone_irq = true;
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, priv);
 
-	if (priv->dcfg->init_hw)
-		priv->dcfg->init_hw(priv);
-
 	return mbox_controller_register(&priv->mbox);
 }
 
@@ -250,7 +435,6 @@ static int imx_mu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-
 static void imx_mu_init_imx7d_a(struct imx_mu_priv *priv)
 {
 	/* Set default config */
@@ -269,6 +453,7 @@ static const struct imx_mu_cfg imx_mu_cfg_imx7d_b = {
 static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx7s-mu-a", .data = &imx_mu_cfg_imx7d_a },
 	{ .compatible = "fsl,imx7s-mu-b", .data = &imx_mu_cfg_imx7d_b },
+	{ .compatible = "fsl,imx8qxp-mu", NULL },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
@@ -284,5 +469,6 @@ static struct platform_driver imx_mu_driver = {
 module_platform_driver(imx_mu_driver);
 
 MODULE_AUTHOR("Oleksij Rempel <o.rempel@xxxxxxxxxxxxxx>");
+MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("Message Unit driver for i.MX");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4
