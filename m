From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 2 Jul 2018 09:35:45 +0200
Subject: [PATCH v2 4/4] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <AM0PR04MB4211ED5BDFC0105477AD4F8B80490@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180615095107.24610-1-o.rempel@pengutronix.de>
 <20180615095107.24610-5-o.rempel@pengutronix.de>
 <AM0PR04MB4211BBB72255BDA36C5AFF9880490@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <66bc8ac0-913a-f444-e554-ade4df1306b6@pengutronix.de>
 <AM0PR04MB4211ED5BDFC0105477AD4F8B80490@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <b67fc42f-5cf8-70ac-e291-eb62ca2e7cb7@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26.06.2018 14:07, A.s. Dong wrote:
>> -----Original Message-----
>> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
>> Sent: Tuesday, June 26, 2018 6:56 PM
>> To: A.s. Dong <aisheng.dong@nxp.com>; Shawn Guo
>> <shawnguo@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
>> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; linux-
>> arm-kernel at lists.infradead.org; kernel at pengutronix.de; linux-
>> clk at vger.kernel.org
>> Subject: Re: [PATCH v2 4/4] mailbox: Add support for i.MX7D messaging unit
>>
>>
>>
>> On 26.06.2018 12:09, A.s. Dong wrote:
>>>> -----Original Message-----
>>>> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
>>>> Sent: Friday, June 15, 2018 5:51 PM
>>>> To: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
>>>> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
>>>> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>
>>>> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
>>>> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
>>>> linux- clk at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
>>>> Subject: [PATCH v2 4/4] mailbox: Add support for i.MX7D messaging
>>>> unit
>>>>
>>>> The Mailbox controller is able to send messages (up to 4 32 bit
>>>> words) between the endpoints.
>>>>
>>>> This driver was tested using the mailbox-test driver sending messages
>>>> between the Cortex-A7 and the Cortex-M4.
>>>>
>>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>>> ---
>>>>  drivers/mailbox/Kconfig       |   6 +
>>>>  drivers/mailbox/Makefile      |   2 +
>>>>  drivers/mailbox/imx-mailbox.c | 288
>>>> ++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 296 insertions(+)
>>>>  create mode 100644 drivers/mailbox/imx-mailbox.c
>>>>
>>>> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig index
>>>> a2bb27446dce..e1d2738a2e4c 100644
>>>> --- a/drivers/mailbox/Kconfig
>>>> +++ b/drivers/mailbox/Kconfig
>>>> @@ -15,6 +15,12 @@ config ARM_MHU
>>>>  	  The controller has 3 mailbox channels, the last of which can be
>>>>  	  used in Secure mode only.
>>>>
>>>> +config IMX_MBOX
>>>> +	tristate "iMX Mailbox"
>>>> +	depends on SOC_IMX7D || COMPILE_TEST
>>>> +	help
>>>> +	  Mailbox implementation for iMX7D Messaging Unit (MU).
>>>> +
>>>>  config PLATFORM_MHU
>>>>  	tristate "Platform MHU Mailbox"
>>>>  	depends on OF
>>>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>>>> index
>>>> cc23c3a43fcd..ba2fe1b6dd62 100644
>>>> --- a/drivers/mailbox/Makefile
>>>> +++ b/drivers/mailbox/Makefile
>>>> @@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
>>>>
>>>>  obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
>>>>
>>>> +obj-$(CONFIG_IMX_MBOX)	+= imx-mailbox.o
>>>> +
>>>>  obj-$(CONFIG_PLATFORM_MHU)	+= platform_mhu.o
>>>>
>>>>  obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
>>>> diff --git a/drivers/mailbox/imx-mailbox.c
>>>> b/drivers/mailbox/imx-mailbox.c new file mode 100644 index
>>>> 000000000000..e3f621cb1d30
>>>> --- /dev/null
>>>> +++ b/drivers/mailbox/imx-mailbox.c
>>>> @@ -0,0 +1,288 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (c) 2018 Pengutronix, Oleksij Rempel
>>>> +<o.rempel@pengutronix.de>  */
>>>> +
>>>> +#include <linux/clk.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/mailbox_controller.h> #include <linux/module.h>
>>>> +#include <linux/of_device.h>
>>>> +
>>>> +/* Transmit Register */
>>>> +#define IMX_MU_xTRn(x)		(0x00 + 4 * (x))
>>>> +/* Receive Register */
>>>> +#define IMX_MU_xRRn(x)		(0x10 + 4 * (x))
>>>> +/* Status Register */
>>>> +#define IMX_MU_xSR		0x20
>>>> +#define IMX_MU_xSR_TEn(x)	BIT(20 + (x))
>>>> +#define IMX_MU_xSR_RFn(x)	BIT(24 + (x))
>>>> +#define IMX_MU_xSR_BRDIP	BIT(9)
>>>> +
>>>> +/* Control Register */
>>>> +#define IMX_MU_xCR		0x24
>>>> +/* Transmit Interrupt Enable */
>>>> +#define IMX_MU_xCR_TIEn(x)	BIT(20 + (x))
>>>> +/* Receive Interrupt Enable */
>>>> +#define IMX_MU_xCR_RIEn(x)	BIT(24 + (x))
>>>> +
>>>> +#define IMX_MU_MAX_CHANS	4u
>>>> +
>>>> +struct imx_mu_priv;
>>>> +
>>>> +struct imx_mu_cfg {
>>>> +	unsigned int		chans;
>>>> +	void (*init_hw)(struct imx_mu_priv *priv); };
>>>> +
>>>> +struct imx_mu_con_priv {
>>>> +	int			irq;
>>>> +	unsigned int		bidx;
>>>> +	unsigned int		idx;
>>>> +};
>>>> +
>>>> +struct imx_mu_priv {
>>>> +	struct device		*dev;
>>>> +	const struct imx_mu_cfg	*dcfg;
>>>> +	void __iomem		*base;
>>>> +
>>>> +	struct mbox_controller	mbox;
>>>> +	struct mbox_chan	mbox_chans[IMX_MU_MAX_CHANS];
>>>> +
>>>> +	struct imx_mu_con_priv  con_priv[IMX_MU_MAX_CHANS];
>>>> +	struct clk		*clk;
>>>> +};
>>>> +
>>>> +static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller
>>>> +*mbox) {
>>>> +	return container_of(mbox, struct imx_mu_priv, mbox); }
>>>> +
>>>> +static void imx_mu_write(struct imx_mu_priv *priv, u32 val, u32 offs) {
>>>> +	iowrite32(val, priv->base + offs);
>>>> +}
>>>> +
>>>> +static u32 imx_mu_read(struct imx_mu_priv *priv, u32 offs) {
>>>> +	return ioread32(priv->base + offs); }
>>>> +
>>>> +static u32 imx_mu_rmw(struct imx_mu_priv *priv, u32 offs, u32 set,
>>>> +u32
>>>> +clr) {
>>>> +	u32 val;
>>>> +
>>>> +	val = imx_mu_read(priv, offs);
>>>> +	val &= ~clr;
>>>> +	val |= set;
>>>> +	imx_mu_write(priv, val, offs);
>>>> +
>>>> +	return val;
>>>> +}
>>>> +
>>>> +static irqreturn_t imx_mu_isr(int irq, void *p) {
>>>> +	struct mbox_chan *chan = p;
>>>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>>>> +
>>>> +	u32 val, dat;
>>>> +
>>>> +	val = imx_mu_read(priv, IMX_MU_xSR);
>>>> +	val &= IMX_MU_xSR_TEn(cp->bidx) | IMX_MU_xSR_RFn(cp->bidx);
>>>> +	if (!val)
>>>> +		return IRQ_NONE;
>>>> +
>>>> +	if (val & IMX_MU_xSR_TEn(cp->bidx)) {
>>>
>>> I'm wondering whether this can work properly for multi consumers at
>>> the same time.
>>> Because xSR_TEn is 1 by default and four virtual channels actually are
>>> using the same interrupt. That means channel 1 interrupt may cause
>>> channel 2 believe it's txdone.
>>> Have we tested such using?
>>
>> see imx_mu_send_data()
>> ..... imx_mu_rmw(priv, IMX_MU_xCR, IMX_MU_xSR_TEn(cp->bidx), 0);
>>
>>>
>>>> +		imx_mu_rmw(priv, IMX_MU_xCR, 0, IMX_MU_xCR_TIEn(cp-
>>>>> bidx));
>>
>> and here ^^^
>> TX status is enabled only for send and disabled as soon at transfer is done.
>>
> 
> That controls the interrupt enable signal, I'm not sure if the status bit
> Won't be set if not enable interrupt. I've not tested it.
> 
> Have you double checked it?
> 
> For n = {0, 1, 2, 3} Processor A Transmit Register n Empty. (Read-only)
> ? The TEn bit is set to ?1? after the BRRn register is read on the Processor B-side.
> ? After the TEn bit is set to ?1?, the TEn bit signals the Processor A-side that the ATRn register is
> ready to be written on the Processor A-side, and a Transmit n interrupt is issued on the Processor
> A-side (if the TEn bit in the ACR register is set to ?1?).

You are right.
> mdw phys 0x30aa0024 # read control register
0x30aa0024: 08000000  # onyl RIE for channel 0 is enabled
> mdw phys 0x30aa0020 # read status register
0x30aa0020: 00f00200  # all TE are 1

So i need to compare Control with Status regs to see if we expect an
Interrupt on for the TX.

> 
>>>> +		mbox_chan_txdone(chan, 0);
>>>> +	}
>>>> +
>>>> +	if (val & IMX_MU_xSR_RFn(cp->bidx)) {
>>>> +		dat = imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
>>>> +		mbox_chan_received_data(chan, (void *)&dat);
>>>> +	}
>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static bool imx_mu_last_tx_done(struct mbox_chan *chan) {
>>>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>>>> +	u32 val;
>>>> +
>>>> +	val = imx_mu_read(priv, IMX_MU_xSR);
>>>> +	/* test if transmit register is empty */
>>>> +	return (!!(val & IMX_MU_xSR_TEn(cp->bidx))); }
>>>> +
>>>> +static int imx_mu_send_data(struct mbox_chan *chan, void *data) {
>>>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>>>> +	u32 *arg = data;
>>>> +
>>>> +	if (!imx_mu_last_tx_done(chan))
>>>> +		return -EBUSY;
>>>> +
>>>> +	imx_mu_write(priv, *arg, IMX_MU_xTRn(cp->idx));
>>>> +	imx_mu_rmw(priv, IMX_MU_xCR, IMX_MU_xSR_TEn(cp->bidx), 0);
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>>> Since Sascha is requesting to write a generic MU mailbox driver for
>>> both SCU MU and M4 case, the current way using virtual channels in
>>> this patch only send one word a time obviously can't fit for SCU MU clients
>> well.
>>> Do you think if we can refer to TI case to design a generic data
>>> transfer protocol to allow send multi words which is more close to SCU?
>>
>> According to your code, you are able to send 1 word message. It means, your
>> SCU is configured to trigger an interrupt or status update if REG0 was written.
>> The same is true for 2, 3, 4 and 5 word messages.
>>
> 
> SCU is interrupt driven already for the first word.
> We do can send word one by one but the performance would be terrible
> comparing to write 4 a time.
> 
>> If the MU configuration would look like you it described, you would be forced
>> to write always 4 words, even for 1 word message.
>>
>>> include/linux/soc/ti/ti-msgmgr.h
>>> struct ti_msgmgr_message {
>>>         size_t len;
>>>         u8 *buf;
>>> };
>>>
>>> Or we try to support both type transfer protocols in this driver?
>>
>> Sure. ti-msgmgr.c is a good example. You will probably need reduced variant
>> of it. It is generic enough to make it useful not only for SCU.
>>
> 
> Sascha needs a common design for both M4 and SCU.If decide to do that,
> you probably need update this patch as well.
> 
> But even doing like TI style, it still need hack for SCU as the data size offset
> Is different. However, that would be a much smaller hack than doing based
> On this driver.
> 
>>> That may introduce much complexities, personally I'm not quite like
>>> that.
>>
>> I expect 50-150 lines of extra code.
>>
> 
> Hope that could be true.
> Do you have suggestion on how to keep two type protocol co-exist
> If you thought that would work without two much extra complexity?
> Have you tried it already based this driver?
> 
> Regards
> Dong Aisheng
> 
>>> Regards
>>> Dong Aisheng
>>>
>>>> +
>>>> +static int imx_mu_startup(struct mbox_chan *chan) {
>>>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>>>> +	int ret;
>>>> +
>>>> +	ret = request_irq(cp->irq, imx_mu_isr,
>>>> +			  IRQF_SHARED, "imx_mu_chan", chan);
>>>> +	if (ret) {
>>>> +		dev_err(chan->mbox->dev,
>>>> +			"Unable to acquire IRQ %d\n", cp->irq);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	imx_mu_rmw(priv, IMX_MU_xCR, IMX_MU_xCR_RIEn(cp->bidx), 0);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void imx_mu_shutdown(struct mbox_chan *chan) {
>>>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>>>> +
>>>> +	imx_mu_rmw(priv, IMX_MU_xCR, 0,
>>>> +		   IMX_MU_xCR_TIEn(cp->bidx) | IMX_MU_xCR_RIEn(cp-
>>>>> bidx));
>>>> +
>>>> +	free_irq(cp->irq, chan);
>>>> +}
>>>> +
>>>> +static const struct mbox_chan_ops imx_mu_ops = {
>>>> +	.send_data = imx_mu_send_data,
>>>> +	.startup = imx_mu_startup,
>>>> +	.shutdown = imx_mu_shutdown,
>>>> +};
>>>> +
>>>> +static int imx_mu_probe(struct platform_device *pdev) {
>>>> +	struct device *dev = &pdev->dev;
>>>> +	struct resource *iomem;
>>>> +	struct imx_mu_priv *priv;
>>>> +	const struct imx_mu_cfg *dcfg;
>>>> +	unsigned int i, chans;
>>>> +	int irq, ret;
>>>> +
>>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>> +	if (!priv)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	dcfg = of_device_get_match_data(dev);
>>>> +	if (!dcfg)
>>>> +		return -EINVAL;
>>>> +
>>>> +	priv->dcfg = dcfg;
>>>> +	priv->dev = dev;
>>>> +
>>>> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +	priv->base = devm_ioremap_resource(&pdev->dev, iomem);
>>>> +	if (IS_ERR(priv->base))
>>>> +		return PTR_ERR(priv->base);
>>>> +
>>>> +	irq = platform_get_irq(pdev, 0);
>>>> +	if (irq <= 0)
>>>> +		return irq < 0 ? irq : -EINVAL;
>>>> +
>>>> +	priv->clk = devm_clk_get(dev, NULL);
>>>> +	if (IS_ERR(priv->clk)) {
>>>> +		if (PTR_ERR(priv->clk) == -ENOENT) {
>>>> +			priv->clk = NULL;
>>>> +		} else {
>>>> +			dev_err(dev, "Failed to get clock\n");
>>>> +			return PTR_ERR(priv->clk);
>>>> +		}
>>>> +	}
>>>> +
>>>> +	ret = clk_prepare_enable(priv->clk);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Failed to enable clock\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	chans = min(dcfg->chans, IMX_MU_MAX_CHANS);
>>>> +	/* Initialize channel identifiers */
>>>> +	for (i = 0; i < chans; i++) {
>>>> +		struct imx_mu_con_priv *cp = &priv->con_priv[i];
>>>> +
>>>> +		cp->bidx = 3 - i;
>>>> +		cp->idx = i;
>>>> +		cp->irq = irq;
>>>> +		priv->mbox_chans[i].con_priv = cp;
>>>> +	}
>>>> +
>>>> +	priv->mbox.dev = dev;
>>>> +	priv->mbox.ops = &imx_mu_ops;
>>>> +	priv->mbox.chans = priv->mbox_chans;
>>>> +	priv->mbox.num_chans = chans;
>>>> +	priv->mbox.txdone_irq = true;
>>>> +
>>>> +	platform_set_drvdata(pdev, priv);
>>>> +
>>>> +	if (priv->dcfg->init_hw)
>>>> +		priv->dcfg->init_hw(priv);
>>>> +
>>>> +	return mbox_controller_register(&priv->mbox);
>>>> +}
>>>> +
>>>> +static int imx_mu_remove(struct platform_device *pdev) {
>>>> +	struct imx_mu_priv *priv = platform_get_drvdata(pdev);
>>>> +
>>>> +	mbox_controller_unregister(&priv->mbox);
>>>> +	clk_disable_unprepare(priv->clk);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +
>>>> +static void imx_mu_init_imx7d_a(struct imx_mu_priv *priv) {
>>>> +	/* Set default config */
>>>> +	imx_mu_write(priv, 0, IMX_MU_xCR);
>>>> +}
>>>> +
>>>> +static const struct imx_mu_cfg imx_mu_cfg_imx7d_a = {
>>>> +	.chans = IMX_MU_MAX_CHANS,
>>>> +	.init_hw = imx_mu_init_imx7d_a,
>>>> +};
>>>> +
>>>> +static const struct imx_mu_cfg imx_mu_cfg_imx7d_b = {
>>>> +	.chans = IMX_MU_MAX_CHANS,
>>>> +};
>>>> +
>>>> +static const struct of_device_id imx_mu_dt_ids[] = {
>>>> +	{ .compatible = "fsl,imx7s-mu-a", .data = &imx_mu_cfg_imx7d_a },
>>>> +	{ .compatible = "fsl,imx7s-mu-b", .data = &imx_mu_cfg_imx7d_b },
>>>> +	{ },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
>>>> +
>>>> +static struct platform_driver imx_mu_driver = {
>>>> +	.probe		= imx_mu_probe,
>>>> +	.remove		= imx_mu_remove,
>>>> +	.driver = {
>>>> +		.name	= "imx_mu",
>>>> +		.of_match_table = imx_mu_dt_ids,
>>>> +	},
>>>> +};
>>>> +module_platform_driver(imx_mu_driver);
>>>> +
>>>> +MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
>>>> +MODULE_DESCRIPTION("Message Unit driver for i.MX");
>>>> MODULE_LICENSE("GPL
>>>> +v2");
>>>> --
>>>> 2.17.1
>>>
>>>
>>>
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/404ad71c/attachment-0001.sig>
