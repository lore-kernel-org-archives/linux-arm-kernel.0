From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 17 Jul 2018 06:21:32 +0000
Subject: [PATCH v3 3/3] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <20180716114209.25242-4-o.rempel@pengutronix.de>
References: <20180716114209.25242-1-o.rempel@pengutronix.de>
 <20180716114209.25242-4-o.rempel@pengutronix.de>
Message-ID: <AM0PR04MB42117528ACC1D9572C4D5C8A805C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> Sent: Monday, July 16, 2018 7:42 PM
> To: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; dl-linux-
> imx <linux-imx@nxp.com>
> Subject: [PATCH v3 3/3] mailbox: Add support for i.MX7D messaging unit
> 
> The Mailbox controller is able to send messages (up to 4 32 bit words)
> between the endpoints.
> 
> This driver was tested using the mailbox-test driver sending messages
> between the Cortex-A7 and the Cortex-M4.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/mailbox/Kconfig       |   6 +
>  drivers/mailbox/Makefile      |   2 +
>  drivers/mailbox/imx-mailbox.c | 294
> ++++++++++++++++++++++++++++++++++
>  3 files changed, 302 insertions(+)
>  create mode 100644 drivers/mailbox/imx-mailbox.c
> 

Generally it looks good to me, a few minor comments:

> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig index
> a2bb27446dce..79060ddc380d 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -15,6 +15,12 @@ config ARM_MHU
>  	  The controller has 3 mailbox channels, the last of which can be
>  	  used in Secure mode only.
> 
> +config IMX_MBOX
> +	tristate "i.MX Mailbox"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	help
> +	  Mailbox implementation for i.MX Messaging Unit (MU).
> +
>  config PLATFORM_MHU
>  	tristate "Platform MHU Mailbox"
>  	depends on OF
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile index
> cc23c3a43fcd..ba2fe1b6dd62 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
> 
>  obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
> 
> +obj-$(CONFIG_IMX_MBOX)	+= imx-mailbox.o
> +
>  obj-$(CONFIG_PLATFORM_MHU)	+= platform_mhu.o
> 
>  obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> new file mode 100644 index 000000000000..31353366a007
> --- /dev/null
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Pengutronix, Oleksij Rempel
> +<o.rempel@pengutronix.de>  */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +/* Transmit Register */
> +#define IMX_MU_xTRn(x)		(0x00 + 4 * (x))
> +/* Receive Register */
> +#define IMX_MU_xRRn(x)		(0x10 + 4 * (x))
> +/* Status Register */
> +#define IMX_MU_xSR		0x20
> +#define IMX_MU_xSR_TEn(x)	BIT(20 + (3 - (x)))
> +#define IMX_MU_xSR_RFn(x)	BIT(24 + (3 - (x)))
> +#define IMX_MU_xSR_BRDIP	BIT(9)
> +
> +/* Control Register */
> +#define IMX_MU_xCR		0x24
> +/* Transmit Interrupt Enable */
> +#define IMX_MU_xCR_TIEn(x)	BIT(20 + (3 - (x)))
> +/* Receive Interrupt Enable */
> +#define IMX_MU_xCR_RIEn(x)	BIT(24 + (3 - (x)))
> +
> +#define IMX_MU_MAX_CHANS	4u
> +
> +struct imx_mu_priv;
> +
> +struct imx_mu_cfg {
> +	unsigned int		chans;
> +	void (*init_hw)(struct imx_mu_priv *priv); };
> +
> +struct imx_mu_con_priv {
> +	int			irq;
> +	unsigned int		idx;
> +};
> +
> +struct imx_mu_priv {
> +	struct device		*dev;
> +	const struct imx_mu_cfg	*dcfg;
> +	void __iomem		*base;
> +
> +	struct mbox_controller	mbox;
> +	struct mbox_chan	mbox_chans[IMX_MU_MAX_CHANS];
> +
> +	struct imx_mu_con_priv  con_priv[IMX_MU_MAX_CHANS];
> +	struct clk		*clk;
> +
> +	bool			side_a;
> +};
> +
> +static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
> +{
> +	return container_of(mbox, struct imx_mu_priv, mbox); }
> +
> +static void imx_mu_write(struct imx_mu_priv *priv, u32 val, u32 offs) {
> +	iowrite32(val, priv->base + offs);
> +}
> +
> +static u32 imx_mu_read(struct imx_mu_priv *priv, u32 offs) {
> +	return ioread32(priv->base + offs);
> +}
> +
> +static u32 imx_mu_rmw(struct imx_mu_priv *priv, u32 offs, u32 set, u32
> +clr) {
> +	u32 val;
> +
> +	val = imx_mu_read(priv, offs);
> +	val &= ~clr;
> +	val |= set;
> +	imx_mu_write(priv, val, offs);
> +
> +	return val;
> +}
> +
> +static irqreturn_t imx_mu_isr(int irq, void *p) {
> +	struct mbox_chan *chan = p;

Better re-order from long to short.

> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> +	struct imx_mu_con_priv *cp = chan->con_priv;
> +

Unnecessary blank line?

> +	u32 val, ctrl, dat;
> +
> +	ctrl = imx_mu_read(priv, IMX_MU_xCR);
> +	val = imx_mu_read(priv, IMX_MU_xSR);
> +	val &= IMX_MU_xSR_TEn(cp->idx) | IMX_MU_xSR_RFn(cp->idx);
> +	val &= ctrl & (IMX_MU_xCR_TIEn(cp->idx) | IMX_MU_xCR_RIEn(cp-
> >idx));
> +	if (!val)
> +		return IRQ_NONE;
> +
> +	if (val & IMX_MU_xSR_TEn(cp->idx)) {
> +		imx_mu_rmw(priv, IMX_MU_xCR, 0, IMX_MU_xCR_TIEn(cp-
> >idx));
> +		mbox_chan_txdone(chan, 0);
> +	}
> +
> +	if (val & IMX_MU_xSR_RFn(cp->idx)) {
> +		dat = imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
> +		mbox_chan_received_data(chan, (void *)&dat);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static bool imx_mu_last_tx_done(struct mbox_chan *chan) {
> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> +	struct imx_mu_con_priv *cp = chan->con_priv;
> +	u32 val;
> +
> +	val = imx_mu_read(priv, IMX_MU_xSR);
> +	/* test if transmit register is empty */
> +	return (!!(val & IMX_MU_xSR_TEn(cp->idx))); }
> +
> +static int imx_mu_send_data(struct mbox_chan *chan, void *data) {
> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> +	struct imx_mu_con_priv *cp = chan->con_priv;
> +	u32 *arg = data;
> +
> +	if (!imx_mu_last_tx_done(chan))
> +		return -EBUSY;
> +
> +	imx_mu_write(priv, *arg, IMX_MU_xTRn(cp->idx));
> +	imx_mu_rmw(priv, IMX_MU_xCR, IMX_MU_xSR_TEn(cp->idx), 0);
> +
> +	return 0;
> +}
> +
> +static int imx_mu_startup(struct mbox_chan *chan) {
> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> +	struct imx_mu_con_priv *cp = chan->con_priv;
> +	char *irq_desc;
> +	int ret;
> +
> +	irq_desc = devm_kasprintf(priv->dev, GFP_KERNEL,
> "imx_mu_chan[%i]",
> +				  cp->idx);

I like the name differentiation, just wondering whether this could
cause memory leak if users repeatly open/close MU channels due to
I see no free.

> +	if (!irq_desc)
> +		return -ENOMEM;
> +
> +	ret = devm_request_irq(priv->dev, cp->irq, imx_mu_isr,
> +			       IRQF_SHARED, irq_desc, chan);
> +	if (ret) {
> +		dev_err(priv->dev,
> +			"Unable to acquire IRQ %d\n", cp->irq);
> +		return ret;
> +	}
> +
> +	imx_mu_rmw(priv, IMX_MU_xCR, IMX_MU_xCR_RIEn(cp->idx), 0);
> +
> +	return 0;
> +}
> +
> +static void imx_mu_shutdown(struct mbox_chan *chan) {
> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> +	struct imx_mu_con_priv *cp = chan->con_priv;
> +
> +	imx_mu_rmw(priv, IMX_MU_xCR, 0,
> +		   IMX_MU_xCR_TIEn(cp->idx) | IMX_MU_xCR_RIEn(cp-
> >idx));
> +
> +	devm_free_irq(priv->dev, cp->irq, chan); }
> +
> +static const struct mbox_chan_ops imx_mu_ops = {
> +	.send_data = imx_mu_send_data,
> +	.startup = imx_mu_startup,
> +	.shutdown = imx_mu_shutdown,
> +};
> +
> +static int imx_mu_probe(struct platform_device *pdev) {
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct resource *iomem;
> +	struct imx_mu_priv *priv;
> +	const struct imx_mu_cfg *dcfg;
> +	unsigned int i, chans;
> +	int irq, ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dcfg = of_device_get_match_data(dev);
> +	if (!dcfg)
> +		return -EINVAL;
> +
> +	priv->dcfg = dcfg;
> +	priv->dev = dev;
> +
> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(&pdev->dev, iomem);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0)
> +		return irq < 0 ? irq : -EINVAL;
> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		if (PTR_ERR(priv->clk) != -ENOENT)
> +			return PTR_ERR(priv->clk);
> +
> +		priv->clk = NULL;
> +	}
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	chans = min(dcfg->chans, IMX_MU_MAX_CHANS);
> +	/* Initialize channel identifiers */
> +	for (i = 0; i < chans; i++) {
> +		struct imx_mu_con_priv *cp = &priv->con_priv[i];
> +
> +		cp->idx = i;
> +		cp->irq = irq;
> +		priv->mbox_chans[i].con_priv = cp;
> +	}
> +
> +	if (of_property_read_bool(np, "fsl,mu-side-a"))
> +		priv->side_a = true;

See property comments in former emails.

> +
> +	priv->mbox.dev = dev;
> +	priv->mbox.ops = &imx_mu_ops;
> +	priv->mbox.chans = priv->mbox_chans;
> +	priv->mbox.num_chans = chans;
> +	priv->mbox.txdone_irq = true;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	if (priv->dcfg->init_hw)
> +		priv->dcfg->init_hw(priv);
> +
> +	return mbox_controller_register(&priv->mbox);
> +}
> +
> +static int imx_mu_remove(struct platform_device *pdev) {
> +	struct imx_mu_priv *priv = platform_get_drvdata(pdev);
> +
> +	mbox_controller_unregister(&priv->mbox);
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +
> +static void imx_mu_init_imx7d(struct imx_mu_priv *priv) {

I guess we could remove the soc postfix now.

> +	/* Set default config */
> +	if (priv->side_a)
> +		imx_mu_write(priv, 0, IMX_MU_xCR);
> +}
> +
> +static const struct imx_mu_cfg imx_mu_cfg_imx7d = {
> +	.chans = IMX_MU_MAX_CHANS,

What's point of another chans here?
This can also be controlled by IMX_MU_MAX_CHANS.

> +	.init_hw = imx_mu_init_imx7d,

Can we imagine a diferent .init_hw callback for another SoC?
If no, how about make it default as I see the implementation
is quite simple and seems not SoC specific. Then we probably
can totally remove struct imx_mu_cfg.

> +};
> +
> +static const struct of_device_id imx_mu_dt_ids[] = {
> +	{ .compatible = "fsl,imx7s-mu", .data = &imx_mu_cfg_imx7d },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
> +
> +static struct platform_driver imx_mu_driver = {
> +	.probe		= imx_mu_probe,
> +	.remove		= imx_mu_remove,
> +	.driver = {
> +		.name	= "imx_mu",
> +		.of_match_table = imx_mu_dt_ids,
> +	},
> +};
> +module_platform_driver(imx_mu_driver);

Do you think if we can escalated it a bit earlier as it's used by SCU?
e.g. core_initcall ?

Regards
Dong Aisheng

> +
> +MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
> +MODULE_DESCRIPTION("Message Unit driver for i.MX");
> MODULE_LICENSE("GPL
> +v2");
> --
> 2.18.0
