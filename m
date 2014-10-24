From: lee@kernel.org (Lee Jones)
Date: Fri, 24 Oct 2014 16:51:17 +0100
Subject: [PATCH] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <1414156789-30188-1-git-send-email-lkundrak@v3.sk>
References: <1414156789-30188-1-git-send-email-lkundrak@v3.sk>
Message-ID: <20141024155115.GE10395@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Oct 2014, Lubomir Rintel wrote:

Thanks for sending this to list, as you are aware a lot of the other
platform drivers depend on this.

FYI: I don't know much about the Mailbox FW, so I'll leave the
functional review to the people who do.  This is going to be a coding
stylesque review instead. 

> Implement BCM2835 mailbox support as a device registered with the
> general purpose mailbox framework. Implementation based on commits by
> Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on which to base the
> implementation.
> 
> [1] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
> [2] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html
> 
> [lkundrak at v3.sk: Tidied up Squashed Craig's work for review, carried over
> to new version of Mailbox framework]
> 
> Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Did all of this people author this driver?  Did they also review the
final product and did they all sign it off?  This list insinuates that
Craig wrote the driver and was taken over by Suman etc, until it was
finally finished off and send upstream by you.  Is that really the
case?

> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org

As you're only sending a small patch-set, it's better to address the
emails to these guys directly, rather than doing so in here.  Cc's in
commit messages are good if there are only a few patches within a
large set to be sent to different addresses.

FWIW, you can drop Stephen and myself from Cc completely as we're both
subscribed to the RPi list and it's very low volume, thus we're not
likely to miss it.

> ---
>  .../bindings/mailbox/brcm,bcm2835-mbox.txt         |  18 ++

This should be a seperate patch and you should Cc the DT list on it.

See: Documentation/devicetree/bindings/submitting-patches.txt

>  drivers/mailbox/Kconfig                            |   9 +
>  drivers/mailbox/Makefile                           |   1 +
>  drivers/mailbox/bcm2835-mailbox.c                  | 291 +++++++++++++++++++++
>  4 files changed, 319 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
>  create mode 100644 drivers/mailbox/bcm2835-mailbox.c
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
> new file mode 100644
> index 0000000..68d761a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
> @@ -0,0 +1,18 @@
> +Broadcom BCM2835 VideoCore mailbox IPC
> +
> +Required properties:
> +
> +- compatible : should be "brcm,bcm2835-mbox"
> +- reg : Specifies base physical address and size of the registers.
> +- interrupts : the interrupt number. Must be <0 1>, the mailbox interrupt.
> +- #mbox-cells : Specifies the number of cells needed to encode a
> +  mailbox channel. The value shall be 1.

Either start the sentence with an uppercase letter, or don't.

Consistency aids in readability.

Links to where the generic properties are documented are helpful.

> +Example:
> +
> +mailbox: mailbox at 0x7e00b800 {

Drop the 0x

> +	compatible = "brcm,bcm2835-mbox";
> +	reg = <0x7e00b880 0x40>;
> +	interrupts = <0 1>;
> +	#mbox-cells = <1>;
> +};
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 9fd9c67..795d2fc 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -33,4 +33,13 @@ config OMAP_MBOX_KFIFO_SIZE
>  	  Specify the default size of mailbox's kfifo buffers (bytes).
>  	  This can also be changed at runtime (via the mbox_kfifo_size
>  	  module parameter).
> +
> +config BCM2835_MBOX
> +	tristate "BCM2835 Mailbox"
> +	depends on ARCH_BCM2835

depends on OF?

> +	help
> +	  An implementation of the BCM2385 Mailbox.  It is used to invoke
> +	  the services of the Videocore. Say Y here if you want to use the
> +	  BCM2835 Mailbox.
> +
>  endif
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 94ed7ce..e29e4d4 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_MAILBOX)		+= mailbox.o
>  obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
>  
>  obj-$(CONFIG_OMAP2PLUS_MBOX)	+= omap-mailbox.o
> +obj-$(CONFIG_BCM2835_MBOX)	+= bcm2835-mailbox.o
> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
> new file mode 100644
> index 0000000..5a37ac2
> --- /dev/null
> +++ b/drivers/mailbox/bcm2835-mailbox.c
> @@ -0,0 +1,291 @@
> +/*
> + *  Copyright (C) 2010 Broadcom
> + *  Copyright (C) 2013-2014 Lubomir Rintel
> + *  Copyright (C) 2013 Craig McGeachie

Better to put these in chronological order.

Does the Copyright really belong to you?

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This device provides a mechanism for writing to the mailboxes,
> + * that are shared between the ARM and the VideoCore processor
> + *
> + * Parts of the driver are based on:
> + *  - arch/arm/mach-bcm2708/vcio.c file written by Gray Girling that was

This doesn't seem very future-proof.

> + *    obtained from branch "rpi-3.6.y" of git://github.com/raspberrypi/
> + *    linux.git

Drop all this please.

> + *  - drivers/mailbox/bcm2835-ipc.c by Lubomir Rintel at
> + *    https://github.com/hackerspace/rpi-linux/blob/lr-raspberry-pi/drivers/
> + *    mailbox/bcm2835-ipc.c
> + *  - documentation available on the following web site:
> + *    https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface

And this.  Please don't put links to external Git repos in drivers.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/err.h>
> +#include <linux/spinlock.h>

Alphabetical.

> +/* Mailboxes */
> +#define ARM_0_MAIL0	0x00
> +#define ARM_0_MAIL1	0x20
> +
> +/* Mailbox registers. We basically only support mailbox 0 & 1. We deliver to
> + * the VC in mailbox 1, it delivers to us in mailbox 0. See BCM2835 ARM
> + * Peripherals section 1.3 for an explanation about the placement of memory
> + * barriers. */

Nonstandard multi-line comment.

Please see: Documentation/CodingStyle

> +#define MAIL0_RD	(ARM_0_MAIL0 + 0x00)
> +#define MAIL0_POL	(ARM_0_MAIL0 + 0x10)
> +#define MAIL0_STA	(ARM_0_MAIL0 + 0x18)
> +#define MAIL0_CNF	(ARM_0_MAIL0 + 0x1C)
> +#define MAIL1_WRT	(ARM_0_MAIL1 + 0x00)
> +
> +#define MBOX_CHAN_COUNT		16
> +
> +/* Status register: FIFO state. */
> +#define ARM_MS_FULL		0x80000000
> +#define ARM_MS_EMPTY		0x40000000
> +
> +/* Configuration register: Enable interrupts. */
> +#define ARM_MC_IHAVEDATAIRQEN	0x00000001
> +
> +#define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
> +#define MBOX_CHAN(msg)			((msg) & 0xf)
> +#define MBOX_DATA28(msg)		((msg) & ~0xf)
> +
> +struct bcm2835_mbox;
> +
> +struct bcm2835_channel {
> +	struct bcm2835_mbox *mbox;

Do you really want to put this in here?

Can't you use conatiner_of() instead?

> +	struct mbox_chan *link;
> +	u32 chan_num;
> +	bool started;
> +};
> +
> +struct bcm2835_mbox {
> +	struct platform_device *pdev;

What are you using this for?

It's not standard to save the platform_device.  Extract what you need
out of it in probe(), then let it die.

> +	struct device *dev;
> +	void __iomem *regs;
> +	spinlock_t lock;
> +	struct bcm2835_channel channel[MBOX_CHAN_COUNT];
> +	struct mbox_controller controller;
> +};
> +
> +#define to_channel(link) ((struct bcm2835_channel *)link->con_priv)
> +
> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
> +{
> +	struct bcm2835_mbox *mbox = (struct bcm2835_mbox *) dev_id;

No need to cast this.

> +	struct device *dev = mbox->dev;

Once the dev_dbg() has gone, you only use this once.  Better to save a
local variable and just use mbox->dev directly in dev_err().

> +	while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
> +		u32 msg = readl(mbox->regs + MAIL0_RD);
> +		unsigned int chan = MBOX_CHAN(msg);
> +
> +		if (!mbox->channel[chan].started) {
> +			dev_err(dev, "Reply on stopped channel %d\n", chan);
> +			continue;
> +		}
> +		dev_dbg(dev, "Reply 0x%08X\n", msg);

This file is riddled with dev_dbg() calls, which are great to have
during development, but are of very little use once in production.
They also make the place look untidy.  Please remove them.

> +		mbox_chan_received_data(mbox->channel[chan].link,
> +			(void *) MBOX_DATA28(msg));
> +	}
> +	rmb(); /* Finished last mailbox read. */
> +	return IRQ_HANDLED;
> +}
> +
> +static int bcm2835_send_data(struct mbox_chan *link, void *data)
> +{
> +	struct bcm2835_channel *chan = to_channel(link);
> +	struct bcm2835_mbox *mbox = chan->mbox;
> +	int ret = 0;
> +
> +	if (!chan->started)
> +		return -ENODEV;

Nice to put a '\n' here.

> +	spin_lock(&mbox->lock);
> +	if (readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL) {
> +		rmb(); /* Finished last mailbox read. */
> +		ret = -EBUSY;
> +		goto end;
> +	}
> +	wmb(); /* About to write to the mail box. */
> +	writel(MBOX_MSG(chan->chan_num, (u32) data), mbox->regs + MAIL1_WRT);
> +	dev_dbg(mbox->dev, "Request 0x%08X\n", MBOX_MSG(chan->chan_num,
> +		(u32) data));
> +end:
> +	spin_unlock(&mbox->lock);
> +	return ret;
> +}
> +
> +static int bcm2835_startup(struct mbox_chan *link)
> +{
> +	struct bcm2835_channel *chan = to_channel(link);
> +
> +	chan->started = true;
> +	return 0;
> +}
> +
> +static void bcm2835_shutdown(struct mbox_chan *link)
> +{
> +	struct bcm2835_channel *chan = to_channel(link);
> +
> +	chan->started = false;
> +}
> +
> +static bool bcm2835_last_tx_done(struct mbox_chan *link)
> +{
> +	struct bcm2835_channel *chan = to_channel(link);
> +	struct bcm2835_mbox *mbox = chan->mbox;
> +	bool ret;
> +
> +	if (!chan->started)
> +		return false;
> +	spin_lock(&mbox->lock);
> +	ret = !(readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL);
> +	rmb(); /* Finished last mailbox read. */
> +	spin_unlock(&mbox->lock);
> +	return ret;
> +}
> +
> +static struct mbox_chan_ops bcm2835_mbox_chan_ops = {
> +	.send_data	= bcm2835_send_data,
> +	.startup	= bcm2835_startup,
> +	.shutdown	= bcm2835_shutdown,
> +	.last_tx_done	= bcm2835_last_tx_done
> +};
> +
> +static int request_mailbox_iomem(struct bcm2835_mbox *mbox)
> +{

It would be better to pass pdev instead of mbox and use
platform_get_drvdata() here.

> +	struct platform_device *pdev = mbox->pdev;

... then you mitigate the requirement to save pdev in bcm2835_mbox.

> +	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	dev_dbg(&pdev->dev, "iomem 0x%08X-0x%08X\n", iomem->start, iomem->end);
> +	mbox->regs = devm_ioremap_resource(&pdev->dev, iomem);
> +	dev_dbg(&pdev->dev, "registers at [0x%p]\n", mbox->regs);

Remove all these, they're ugly!

> +	if (IS_ERR(mbox->regs)) {
> +		dev_err(&pdev->dev, "Failed to remap mailbox regs\n");

Doesn't devm_ioremap_resource() already issue an error?

> +		return PTR_ERR(mbox->regs);
> +	}
> +	dev_dbg(&pdev->dev, "iomem registered\n");
> +	return 0;
> +}
> +
> +static int request_mailbox_irq(struct bcm2835_mbox *mbox)
> +{
> +	int ret;
> +	struct device *dev = mbox->dev;
> +	struct device_node *np = dev->of_node;
> +	int irq = irq_of_parse_and_map(np, 0);

Separate the definition from the allocation here.

> +	if (irq <= 0) {

Then bring this line up so it's directly under irq_of_*.

> +		dev_err(dev, "Can't get IRQ number for mailbox\n");
> +		return -ENODEV;

Please return ret.

> +	}
> +	ret = devm_request_irq(dev, irq, bcm2835_mbox_irq, 0, dev_name(dev),
> +		mbox);
> +	if (ret) {
> +		dev_err(dev, "Failed to register a mailbox IRQ handler\n");
> +		return -ENODEV;

You should be returning ret here.

> +	}
> +	dev_dbg(dev, "Registered IRQ\n");

Blurh...

> +	return 0;
> +}
> +
> +static int bcm2835_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct bcm2835_mbox *mbox;
> +	int i;
> +	int ret = 0;

No need to pre-allocate here.

> +	dev_dbg(dev, "Probing\n");
> +	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +	if (mbox == NULL) {

if (!mbox)

> +		dev_err(dev, "Failed to allocate mailbox memory\n");

Remove all -ENOMEM prints please.

I think checkpatch warns against this.

> +		return -ENOMEM;
> +	}
> +	platform_set_drvdata(pdev, mbox);
> +	mbox->pdev = pdev;

Remove this.

> +	mbox->dev = dev;
> +	spin_lock_init(&mbox->lock);
> +
> +	dev_dbg(dev, "Requesting IRQ\n");
> +	ret = request_mailbox_irq(mbox);
> +	if (ret)
> +		return ret;

'\n'

> +	dev_dbg(dev, "Requesting iomem\n");
> +	ret = request_mailbox_iomem(mbox);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(dev, "Initializing mailbox controller\n");
> +	mbox->controller.txdone_poll = true;
> +	mbox->controller.txpoll_period = 5;
> +	mbox->controller.ops = &bcm2835_mbox_chan_ops;
> +	mbox->controller.dev = dev;
> +	mbox->controller.num_chans = MBOX_CHAN_COUNT;
> +	mbox->controller.chans = devm_kzalloc(dev,
> +		sizeof(struct mbox_chan) * MBOX_CHAN_COUNT,
> +		GFP_KERNEL);
> +	if (!mbox->controller.chans) {
> +		dev_err(dev, "Failed to alloc mbox_chans\n");

Remove the print.

> +		return -ENOMEM;
> +	}
> +
> +	dev_dbg(dev, "Initializing mailbox channels\n");
> +	for (i = 0; i != MBOX_CHAN_COUNT; ++i) {
> +		mbox->channel[i].mbox = mbox;
> +		mbox->channel[i].link = &mbox->controller.chans[i];
> +		mbox->channel[i].chan_num = i;
> +		mbox->controller.chans[i].con_priv =
> +			(void *)&mbox->channel[i];
> +	}
> +
> +	ret  = mbox_controller_register(&mbox->controller);

Does this provide it's own print on error?

> +	if (ret)
> +		return ret;
> +
> +	/* Enable the interrupt on data reception */
> +	writel(ARM_MC_IHAVEDATAIRQEN, mbox->regs + MAIL0_CNF);
> +	dev_info(dev, "mailbox enabled\n");
> +
> +	return ret;
> +}
> +
> +static int bcm2835_mbox_remove(struct platform_device *pdev)
> +{
> +	struct bcm2835_mbox *mbox = platform_get_drvdata(pdev);
> +
> +	mbox_controller_unregister(&mbox->controller);
> +	return 0;
> +}
> +
> +static const struct of_device_id bcm2835_mbox_of_match[] = {
> +	{ .compatible = "brcm,bcm2835-mbox", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bcm2835_mbox_of_match);

If you don't depend on OF, you need to protect this.

> +static struct platform_driver bcm2835_mbox_driver = {
> +	.driver = {
> +		.name = "bcm2835-mbox",
> +		.owner = THIS_MODULE,

Remove this, it's taken care of elsewhere.

> +		.of_match_table = bcm2835_mbox_of_match,

of_match_ptr()

> +	},
> +	.probe		= bcm2835_mbox_probe,
> +	.remove		= bcm2835_mbox_remove,
> +};
> +module_platform_driver(bcm2835_mbox_driver);
> +
> +MODULE_AUTHOR("Craig McGeachie");
> +MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
> +MODULE_DESCRIPTION("BCM2835 mailbox IPC driver");
> +MODULE_LICENSE("GPL v2");
