From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun,  8 Jul 2018 22:56:55 +0800
Subject: [PATCH V4 3/5] mailbox: imx: add imx mu support
In-Reply-To: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used for i.MX multi core communication.
e.g. A core to SCU firmware(M core) on MX8.

Tx is using polling mode while Rx is interrupt driven and
schedule a hrtimer to receive remain words if have more than
4 words.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel at vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v3->v4:
 * New patch
   Old MU library dropped
---
 drivers/mailbox/Kconfig  |   8 ++
 drivers/mailbox/Makefile |   2 +
 drivers/mailbox/imx-mu.c | 341 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 351 insertions(+)
 create mode 100644 drivers/mailbox/imx-mu.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index a2bb274..4dd4823 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -124,6 +124,14 @@ config HI6220_MBOX
 	  between application processors and MCU. Say Y here if you want to
 	  build Hi6220 mailbox controller driver.
 
+config IMX_MU
+	tristate "IMX MU Mailbox"
+	depends on ARCH_MXC && OF
+	help
+	  An implementation of the i.MX MU Mailbox. It is used to send message
+	  between application processors and other processors/MCU/DSP. Select
+	  Y here if you want to use i.MX MU Mailbox controller.
+
 config MAILBOX_TEST
 	tristate "Mailbox Test Client"
 	depends on OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index cc23c3a..fa62f07 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -31,6 +31,8 @@ obj-$(CONFIG_HI3660_MBOX)	+= hi3660-mailbox.o
 
 obj-$(CONFIG_HI6220_MBOX)	+= hi6220-mailbox.o
 
+obj-$(CONFIG_IMX_MU)		+= imx-mu.o
+
 obj-$(CONFIG_BCM_PDC_MBOX)	+= bcm-pdc-mailbox.o
 
 obj-$(CONFIG_BCM_FLEXRM_MBOX)	+= bcm-flexrm-mailbox.o
diff --git a/drivers/mailbox/imx-mu.c b/drivers/mailbox/imx-mu.c
new file mode 100644
index 0000000..339dfa9
--- /dev/null
+++ b/drivers/mailbox/imx-mu.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP.
+ *
+ *  Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/hrtimer.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define MU_xTR0		0x0
+#define MU_xRR0		0x10
+#define MU_xSR		0x20
+#define MU_xCR		0x24
+
+#define MU_TR_COUNT		4
+#define MU_RR_COUNT		4
+
+#define MU_CR_GIEn_MASK		GENMASK(37, 28)
+#define MU_CR_RIEn_MASK		GENMASK(27, 24)
+#define MU_CR_TIEn_MASK		GENMASK(23, 20)
+#define MU_CR_GIRn_MASK		GENMASK(19, 16)
+#define MU_CR_NMI_MASK		BIT(3)
+#define MU_CR_Fn_MASK		GENMASK(2, 0)
+#define MU_CR_RIE0_SHIFT	27
+#define MU_CR_TIE0_SHIFT	23
+#define MU_CR_RIE0_MASK		BIT(27)
+#define MU_CR_GIE0_MASK		BIT(31)
+
+#define MU_SR_TE0_MASK		BIT(23)
+#define MU_SR_RF0_MASK		BIT(27)
+
+#define MU_SCU_MAX_MSG		8
+#define MU_DATA_TIME_OUT_US	(100 * USEC_PER_MSEC)
+
+struct imx_mu {
+	void __iomem *regs;
+	struct mbox_controller mbox;
+	struct mbox_chan chans;
+	struct hrtimer poll_hrt;
+	/* for runtime scu msg store */
+	u32 *msg;
+};
+
+/*
+ * Wait to receive message from the other core.
+ */
+static int imx_mu_receive_msg(struct mbox_chan *chan, u32 index, u32 *msg)
+{
+	struct imx_mu *mu = chan->con_priv;
+	u32 mask, sr;
+	int ret;
+
+	mask = MU_SR_RF0_MASK >> index;
+
+	/* Wait RX register to be full. */
+	ret = readl_poll_timeout_atomic(mu->regs + MU_xSR, sr, sr & mask,
+					0, MU_DATA_TIME_OUT_US);
+	if (ret) {
+		dev_err(chan->mbox->dev,
+			"Waiting MU receive register (%u) full timeout!\n",
+			index);
+		return ret;
+	}
+
+	*msg = readl(mu->regs + MU_xRR0 + (index * 4));
+
+	return 0;
+}
+
+/*
+ * Wait and send message to the other core.
+ */
+static int imx_mu_send_msg(struct mbox_chan *chan, u32 index, u32 msg)
+{
+	struct imx_mu *mu = chan->con_priv;
+	u32 mask, sr;
+	int ret;
+
+	mask = MU_SR_TE0_MASK >> index;
+
+	/* Wait TX register to be empty. */
+	ret = readl_poll_timeout_atomic(mu->regs + MU_xSR, sr, sr & mask,
+					0, MU_DATA_TIME_OUT_US);
+	if (ret) {
+		dev_err(chan->mbox->dev,
+			"Waiting MU transmit register (%u) empty timeout!\n",
+			index);
+		return ret;
+	}
+
+	writel(msg, mu->regs + MU_xTR0  + (index * 4));
+
+	return 0;
+}
+
+static enum hrtimer_restart imx_chan_recv_hrtimer(struct hrtimer *hrtimer)
+{
+	struct imx_mu *mu = container_of(hrtimer, struct imx_mu, poll_hrt);
+	u8 *raw_data = (u8 *)mu->msg;
+	int size;
+	int ret;
+	int i;
+
+	/* check msg size */
+	raw_data = (u8 *)mu->msg;
+	size = raw_data[1];
+
+	dev_dbg(mu->mbox.dev, "receive the remain %d words\n", size - 1);
+
+	for (i = 1; i < size; i++) {
+		ret = imx_mu_receive_msg(&mu->chans, i % 4, mu->msg + i);
+		if (ret)
+			break;
+	}
+
+	mbox_chan_received_data(&mu->chans, (void *)mu->msg);
+
+	return HRTIMER_NORESTART;
+}
+
+static irqreturn_t imx_channel_irq(int irq, void *data)
+{
+	struct imx_mu *mu = data;
+	u32 status, mask;
+	u8 *raw_data;
+	int size;
+	int i;
+
+	/* Only enabled RIE0 interrupt */
+	status = readl(mu->regs + MU_xSR);
+	if (!(status & MU_SR_RF0_MASK))
+		return IRQ_NONE;
+
+	/* Get the first data */
+	*mu->msg = readl(mu->regs + MU_xRR0);
+
+	/* check msg size */
+	raw_data = (u8 *)mu->msg;
+	size = raw_data[1];
+
+	dev_dbg(mu->mbox.dev, "receive data: head 0x%x\n", *mu->msg);
+
+	if (size > MU_SCU_MAX_MSG) {
+		dev_err(mu->mbox.dev,
+			"exceed the maximum scu msg size : %d\n", size);
+		return IRQ_HANDLED;
+
+	} else if (size > 1 && size <= 4) {
+		/* check remain data mask */
+		mask = GENMASK(MU_CR_RIE0_SHIFT	- 1, MU_CR_RIE0_SHIFT - size + 1);
+		status = readl(mu->regs + MU_xSR);
+
+		if ((status & mask) != mask) {
+			dev_dbg(mu->mbox.dev,
+				"start hrtimer to receive the remain %d words\n", size - 1);
+			hrtimer_start(&mu->poll_hrt, ktime_set(0, 0),
+				      HRTIMER_MODE_REL);
+			return IRQ_HANDLED;
+		}
+
+		dev_dbg(mu->mbox.dev,
+			"receive data: size %d mask 0x%x status 0x%x\n",
+			size, mask, status);
+
+		for (i = 1; i < size; i++)
+			mu->msg[i] = readl(mu->regs + MU_xRR0 + i * 4);
+
+	} else if (size > 4) {
+		dev_dbg(mu->mbox.dev,
+			"start hrtimer to receive the remain %d words\n", size - 1);
+		hrtimer_start(&mu->poll_hrt, ktime_set(0, 0),
+			      HRTIMER_MODE_REL);
+
+		return IRQ_HANDLED;
+	}
+
+	mbox_chan_received_data(&mu->chans, (void *)mu->msg);
+
+	return IRQ_HANDLED;
+}
+
+static int imx_mu_chan_send_data(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu *mu = chan->con_priv;
+	u8 *raw_data = data;
+	int i, ret;
+	int size;
+
+	if (!data)
+		return -EINVAL;
+
+	mu->msg = data;
+
+	/* SCU protocol size position is at the second u8 */
+	size = raw_data[1];
+
+	dev_dbg(mu->mbox.dev, "send data (size %d)\n", size);
+
+	for (i = 0; i < size; i++) {
+		ret = imx_mu_send_msg(chan, i % 4, *(mu->msg + i));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int imx_mu_chan_startup(struct mbox_chan *chan)
+{
+	struct imx_mu *mu = chan->con_priv;
+	u32 val;
+
+	/* Enable RIE0 interrupt */
+	val = readl(mu->regs + MU_xCR);
+	val |= MU_CR_RIE0_MASK;
+	writel(val, mu->regs + MU_xCR);
+
+	return 0;
+}
+
+static void imx_mu_chan_shutdown(struct mbox_chan *chan)
+{
+	struct imx_mu *mu = chan->con_priv;
+	u32 val;
+
+	/* Clear RIEn, TIEn, GIRn and ABFn. */
+	val = readl(mu->regs + MU_xCR);
+	val &= ~(MU_CR_RIEn_MASK | MU_CR_TIEn_MASK |
+		 MU_CR_GIRn_MASK | MU_CR_NMI_MASK | MU_CR_Fn_MASK);
+	writel(val, mu->regs + MU_xCR);
+}
+
+static struct mbox_chan_ops imx_mu_chan_ops = {
+	.send_data = imx_mu_chan_send_data,
+	.startup = imx_mu_chan_startup,
+	.shutdown = imx_mu_chan_shutdown,
+};
+
+static struct mbox_chan *imx_mu_index_xlate(struct mbox_controller *mbox,
+					    const struct of_phandle_args *sp)
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
+static int imx_mu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mbox_controller *mbox;
+	struct resource *res;
+	struct imx_mu *mu;
+	int irq, err;
+	u32 val;
+
+	mu = devm_kzalloc(&pdev->dev, sizeof(*mu), GFP_KERNEL);
+	if (!mu)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mu->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mu->regs))
+		return PTR_ERR(mu->regs);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "can't get irq number\n");
+		return irq;
+	}
+
+	err = devm_request_irq(dev, irq, imx_channel_irq, 0,
+			       dev_name(dev), mu);
+	if (err < 0) {
+		dev_err(dev, "Failed to request IRQ#%u: %d\n", irq, err);
+		return err;
+	}
+
+	hrtimer_init(&mu->poll_hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	mu->poll_hrt.function = imx_chan_recv_hrtimer;
+
+	platform_set_drvdata(pdev, mu);
+
+	mbox = &mu->mbox;
+	mbox->dev = dev;
+	mbox->num_chans = 1;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = false;
+	mbox->chans = &mu->chans;
+	mbox->ops = &imx_mu_chan_ops;
+	mbox->of_xlate = &imx_mu_index_xlate;
+	mu->chans.con_priv = mu;
+
+	/* Init MU */
+	val = readl(mu->regs + MU_xCR);
+	/* Clear GIEn, RIEn, TIEn, GIRn and ABFn. */
+	val &= ~(MU_CR_GIEn_MASK | MU_CR_RIEn_MASK | MU_CR_TIEn_MASK |
+		 MU_CR_GIRn_MASK | MU_CR_NMI_MASK | MU_CR_Fn_MASK);
+	writel(val, mu->regs + MU_xCR);
+
+	err = mbox_controller_register(mbox);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register mailbox: %d\n", err);
+		return err;
+	}
+
+	dev_info(dev, "registered mailbox\n");
+
+	return 0;
+}
+
+static const struct of_device_id imx_mu_match[] = {
+	{ .compatible = "fsl,imx8qxp-mu", },
+	{ /* Sentinel */ }
+};
+
+static struct platform_driver imx_mu_driver = {
+	.driver = {
+		.name = "imx-mu",
+		.of_match_table = imx_mu_match,
+	},
+	.probe = imx_mu_probe,
+};
+
+static int __init imx_mu_init(void)
+{
+	return platform_driver_register(&imx_mu_driver);
+}
+core_initcall(imx_mu_init);
-- 
2.7.4
