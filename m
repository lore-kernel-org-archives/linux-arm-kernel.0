From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 24 Jul 2018 07:14:21 +0200
Subject: [PATCH v6 5/5] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <1532366380.3163.109.camel@pengutronix.de>
References: <20180722063923.30222-1-o.rempel@pengutronix.de>
 <20180722063923.30222-6-o.rempel@pengutronix.de>
 <1532366380.3163.109.camel@pengutronix.de>
Message-ID: <eebba930-b3d7-3670-3d96-35cc6c2a6bcb@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

here is more detailed response:

On 23.07.2018 19:19, Lucas Stach wrote:
> Am Sonntag, den 22.07.2018, 08:39 +0200 schrieb Oleksij Rempel:
>> The Mailbox controller is able to send messages (up to 4 32 bit words)
>> between the endpoints.
>>
>> This driver was tested using the mailbox-test driver sending messages
>> between the Cortex-A7 and the Cortex-M4.
>>
>>> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>> ?drivers/mailbox/Kconfig???????|???6 +
>> ?drivers/mailbox/Makefile??????|???2 +
>> ?drivers/mailbox/imx-mailbox.c | 273 ++++++++++++++++++++++++++++++++++
>> ?3 files changed, 281 insertions(+)
>> ?create mode 100644 drivers/mailbox/imx-mailbox.c
>>
>> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
>> index a2bb27446dce..79060ddc380d 100644
>> --- a/drivers/mailbox/Kconfig
>> +++ b/drivers/mailbox/Kconfig
>> @@ -15,6 +15,12 @@ config ARM_MHU
>>> ?	??The controller has 3 mailbox channels, the last of which can be
>>> ?	??used in Secure mode only.
>> ?
>> +config IMX_MBOX
>>> +	tristate "i.MX Mailbox"
>>> +	depends on ARCH_MXC || COMPILE_TEST
>>> +	help
>>> +	??Mailbox implementation for i.MX Messaging Unit (MU).
>> +
>> ?config PLATFORM_MHU
>>> ?	tristate "Platform MHU Mailbox"
>>> ?	depends on OF
>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>> index cc23c3a43fcd..ba2fe1b6dd62 100644
>> --- a/drivers/mailbox/Makefile
>> +++ b/drivers/mailbox/Makefile
>>> @@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
>> ?
>>> ?obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
>> ?
>>> +obj-$(CONFIG_IMX_MBOX)	+= imx-mailbox.o
>> +
>>> ?obj-$(CONFIG_PLATFORM_MHU)	+= platform_mhu.o
>> ?
>>> ?obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
>> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
>> new file mode 100644
>> index 000000000000..29cf2876db01
>> --- /dev/null
>> +++ b/drivers/mailbox/imx-mailbox.c
>> @@ -0,0 +1,273 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mailbox_controller.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +
>> +/* Transmit Register */
>>> +#define IMX_MU_xTRn(x)		(0x00 + 4 * (x))
>> +/* Receive Register */
>>> +#define IMX_MU_xRRn(x)		(0x10 + 4 * (x))
>> +/* Status Register */
>>> +#define IMX_MU_xSR		0x20
>>> +#define IMX_MU_xSR_TEn(x)	BIT(20 + (3 - (x)))
>>> +#define IMX_MU_xSR_RFn(x)	BIT(24 + (3 - (x)))
>>> +#define IMX_MU_xSR_BRDIP	BIT(9)
>> +
>> +/* Control Register */
>>> +#define IMX_MU_xCR		0x24
>> +/* Transmit Interrupt Enable */
>>> +#define IMX_MU_xCR_TIEn(x)	BIT(20 + (3 - (x)))
>> +/* Receive Interrupt Enable */
>>> +#define IMX_MU_xCR_RIEn(x)	BIT(24 + (3 - (x)))
>> +
>>> +#define IMX_MU_CHANS	4u
>> +
>> +struct imx_mu_con_priv {
>>>> +	int			irq;
>>>> +	unsigned int		idx;
>>>> +	char			*irq_desc;
>> +};
>> +
>> +struct imx_mu_priv {
>>>> +	struct device		*dev;
>>>> +	void __iomem		*base;
>> +
>>>> +	struct mbox_controller	mbox;
>>>> +	struct mbox_chan	mbox_chans[IMX_MU_CHANS];
>> +
>>> +	struct imx_mu_con_priv??con_priv[IMX_MU_CHANS];
>>>> +	struct clk		*clk;
>> +
>>>> +	bool			side_b;
>> +};
>> +
>> +static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
>> +{
>>> +	return container_of(mbox, struct imx_mu_priv, mbox);
>> +}
>> +
>> +static void imx_mu_write(struct imx_mu_priv *priv, u32 val, u32 offs)
>> +{
>> +	iowrite32(val, priv->base + offs);
> 
> This driver is never going to be used on a device with port based IO,
> so iowrite doesn't make much sense here, just use writel. Same comment
> applies to the below read function.

As before I don't really understand the difference. I took some time for
learning and here are my findings:
- historical background of ioread/iowrite functions. What I can find is
this LWN article: https://lwn.net/Articles/102232/ . The main point
seems to be "The first of these is a new __iomem annotation used to mark
pointers to I/O memory" ... " As with __user, the __iomem marker serves
a documentation role in the kernel code;"

In modern kernel the difference between ioread32 and readl seems to be
completely disappeared.
with this LWN article (2016):
https://lwn.net/Articles/698014/
the readl and reade32 are always in the same group..

If there is some documentation which will say why I should use readl()
instead of ioread32() i would really love to read it.

> Also, given that those functions are not really shortening the code in
> the user they may also be removed completely IMHO.

Wrong assumption..  I use this functions for tracing. It is just to easy
to add two trace points...  From technical perspective I don't see any
advantage or disadvantage of having this functions.
If it is my personal preference, then I decide to keep it.

>> +}
>> +
>> +static u32 imx_mu_read(struct imx_mu_priv *priv, u32 offs)
>> +{
>>> +	return ioread32(priv->base + offs);
>> +}
>> +
>> +static u32 imx_mu_rmw(struct imx_mu_priv *priv, u32 offs, u32 set, u32 clr)
>> +{
>>> +	u32 val;
>> +
>>> +	val = imx_mu_read(priv, offs);
>>> +	val &= ~clr;
>>> +	val |= set;
>>> +	imx_mu_write(priv, val, offs);
>> +
>>> +	return val;
>> +}
>> +
>> +static irqreturn_t imx_mu_isr(int irq, void *p)
>> +{
>>> +	struct mbox_chan *chan = p;
>>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>>> +	u32 val, ctrl, dat;
>> +
>>> +	ctrl = imx_mu_read(priv, IMX_MU_xCR);
>>> +	val = imx_mu_read(priv, IMX_MU_xSR);
>>> +	val &= IMX_MU_xSR_TEn(cp->idx) | IMX_MU_xSR_RFn(cp->idx);
>>> +	val &= ctrl & (IMX_MU_xCR_TIEn(cp->idx) | IMX_MU_xCR_RIEn(cp->idx));
>>> +	if (!val)
>>> +		return IRQ_NONE;
>> +
>>> +	if (val & IMX_MU_xSR_TEn(cp->idx)) {
>>> +		imx_mu_rmw(priv, IMX_MU_xCR, 0, IMX_MU_xCR_TIEn(cp->idx));
>>> +		mbox_chan_txdone(chan, 0);
>>> +	}
>> +
>>> +	if (val & IMX_MU_xSR_RFn(cp->idx)) {
>>> +		dat = imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
>>> +		mbox_chan_received_data(chan, (void *)&dat);
>>> +	}
>> +
>>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static bool imx_mu_last_tx_done(struct mbox_chan *chan)
>> +{
>>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>>> +	u32 val;
>> +
>>> +	val = imx_mu_read(priv, IMX_MU_xSR);
>>> +	/* test if transmit register is empty */
>> +	return val & IMX_MU_xSR_TEn(cp->idx);
> 
> I guess
> "return imx_mu_read(priv, IMX_MU_xSR) & IMX_MU_xSR_TEn(cp->idx);" is
> shorter and equally well understood.

So, previous comment was saying, "those functions are not really
shortening the code"

I would apply same comment: "those .. are not really shortening the code".

Do we really need to make review of "personal coding style
preferences".. which are not against kernel coding style in 6. review
round...?!
For example:
kernel coding style is pink... in this case we are talking about
difference between lavender pink and carnation pink.


>> +}
>> +
>> +static int imx_mu_send_data(struct mbox_chan *chan, void *data)
>> +{
>>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>>> +	u32 *arg = data;
>> +
>>> +	if (!imx_mu_last_tx_done(chan))
>>> +		return -EBUSY;
>> +
>>> +	imx_mu_write(priv, *arg, IMX_MU_xTRn(cp->idx));
>> +	imx_mu_rmw(priv, IMX_MU_xCR, IMX_MU_xSR_TEn(cp->idx), 0);
> 
> In multi-channel mode this RMW cycle needs some kind of locking. As
> this register is also changed from the irq handler, this probably needs
> to be a irqsave spinlock.

Thank you, i need to fix it.

>> +
>>> +	return 0;
>> +}
>> +
>> +static int imx_mu_startup(struct mbox_chan *chan)
>> +{
>>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>>> +	int ret;
>> +
>>> +	cp->irq_desc = devm_kasprintf(priv->dev, GFP_KERNEL, "imx_mu_chan[%i]",
>>> +				??????cp->idx);
>>> +	if (!cp->irq_desc)
>>> +		return -ENOMEM;
>> +
>>> +	ret = devm_request_irq(priv->dev, cp->irq, imx_mu_isr,
>> +			???????IRQF_SHARED, cp->irq_desc, chan);
> 
> Using the devm_ variants of those functions doesn't make sense when the
> resources aren't tied to the device lifetime. As you are tearing them
> down manually in imx_mu_shutdown anyways, just use the raw variants of
> those functions.

I have nothing against it.

>> +	if (ret) {
>>> +		dev_err(priv->dev,
>>> +			"Unable to acquire IRQ %d\n", cp->irq);
>>> +		return ret;
>>> +	}
>> +
>>> +	imx_mu_rmw(priv, IMX_MU_xCR, IMX_MU_xCR_RIEn(cp->idx), 0);
>> +
>>> +	return 0;
>> +}
>> +
>> +static void imx_mu_shutdown(struct mbox_chan *chan)
>> +{
>>> +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>> +	struct imx_mu_con_priv *cp = chan->con_priv;
>> +
>>> +	imx_mu_rmw(priv, IMX_MU_xCR, 0,
>>> +		???IMX_MU_xCR_TIEn(cp->idx) | IMX_MU_xCR_RIEn(cp->idx));
>> +
>>> +	devm_free_irq(priv->dev, cp->irq, chan);
>>> +	devm_kfree(priv->dev, cp->irq_desc);
>> +}
>> +
>> +static const struct mbox_chan_ops imx_mu_ops = {
>>> +	.send_data = imx_mu_send_data,
>>> +	.startup = imx_mu_startup,
>>> +	.shutdown = imx_mu_shutdown,
>> +};
>> +
>> +static void imx_mu_init_generic(struct imx_mu_priv *priv)
>> +{
>>> +	if (priv->side_b)
>>> +		return;
>> +
>>> +	/* Set default MU configuration */
>>> +	imx_mu_write(priv, 0, IMX_MU_xCR);
>> +}
>> +
>> +static int imx_mu_probe(struct platform_device *pdev)
>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct device_node *np = dev->of_node;
>>> +	struct resource *iomem;
>>> +	struct imx_mu_priv *priv;
>>> +	unsigned int i;
>>> +	int irq, ret;
>> +
>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>> +
>>> +	priv->dev = dev;
>> +
>>> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	priv->base = devm_ioremap_resource(&pdev->dev, iomem);
>>> +	if (IS_ERR(priv->base))
>>> +		return PTR_ERR(priv->base);
>> +
>>> +	irq = platform_get_irq(pdev, 0);
>>> +	if (irq < 0)
>>> +		return irq;
>> +
>>> +	priv->clk = devm_clk_get(dev, NULL);
>>> +	if (IS_ERR(priv->clk)) {
>>> +		if (PTR_ERR(priv->clk) != -ENOENT)
>>> +			return PTR_ERR(priv->clk);
>> +
>>> +		priv->clk = NULL;
>>> +	}
>> +
>>> +	ret = clk_prepare_enable(priv->clk);
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to enable clock\n");
>>> +		return ret;
>>> +	}
>> +
>>> +	for (i = 0; i < IMX_MU_CHANS; i++) {
>>> +		struct imx_mu_con_priv *cp = &priv->con_priv[i];
>> +
>>> +		cp->idx = i;
>>> +		cp->irq = irq;
>>> +		priv->mbox_chans[i].con_priv = cp;
>>> +	}
>> +
>>> +	if (of_property_read_bool(np, "fsl,mu-side-b"))
>> +		priv->side_b = true;
> 
> No need for the if clause here. Just assign the return value from
> of_property_read_bool to priv->side_b.

ok.

Thank you for a review!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/8a7ff5f5/attachment-0001.sig>
