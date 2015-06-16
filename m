From: joshc@ni.com (Josh Cartwright)
Date: Tue, 16 Jun 2015 13:44:24 -0500
Subject: [PATCHv4 2/2] mailbox: Adding driver for Xilinx LogiCORE IP
 mailbox.
In-Reply-To: <1433175507-3833-3-git-send-email-moritz.fischer@ettus.com>
References: <1433175507-3833-1-git-send-email-moritz.fischer@ettus.com>
 <1433175507-3833-3-git-send-email-moritz.fischer@ettus.com>
Message-ID: <20150616184424.GT633@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Moritz-

A few comments below:

On Mon, Jun 01, 2015 at 09:18:27AM -0700, Moritz Fischer wrote:
[..]
> +++ b/drivers/mailbox/mailbox-xilinx.c
> @@ -0,0 +1,352 @@
> +/*
> + * Copyright (c) 2015, National Instruments Corp. All rights reserved.
> + *
> + * Driver for the Xilinx LogiCORE mailbox IP block
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#define DRIVER_NAME "xilinx-mailbox"

Does KBUILD_MODNAME already give you what you need?

> +
> +/* register offsets */
> +#define MAILBOX_REG_WRDATA	0x00
> +#define MAILBOX_REG_RDDATA	0x08
> +#define MAILBOX_REG_STATUS	0x10
> +#define MAILBOX_REG_ERROR	0x14
> +#define MAILBOX_REG_SIT	0x18
> +#define MAILBOX_REG_RIT	0x1c
> +#define MAILBOX_REG_IS	0x20
> +#define MAILBOX_REG_IE	0x24
> +#define MAILBOX_REG_IP	0x28
> +
> +/* status register */
> +#define STS_RTA	BIT(3)
> +#define STS_STA	BIT(2)
> +#define STS_FULL	BIT(1)
> +#define STS_EMPTY	BIT(0)
> +
> +/* error register */
> +#define ERR_FULL	BIT(1)
> +#define ERR_EMPTY	BIT(0)
> +
> +/* mailbox interrupt status register */
> +#define INT_STATUS_ERR	BIT(2)
> +#define INT_STATUS_RTI	BIT(1)
> +#define INT_STATUS_STI	BIT(0)
> +
> +/* mailbox interrupt enable register */
> +#define INT_ENABLE_ERR	BIT(2)
> +#define INT_ENABLE_RTI	BIT(1)
> +#define INT_ENABLE_STI	BIT(0)
> +
> +#define MBOX_POLLING_MS		5	/* polling interval 5ms */
> +
> +struct xilinx_mbox {
> +	int irq;
> +	void __iomem *mbox_base;
> +	struct clk *clk;
> +	struct device *dev;
> +	struct mbox_controller controller;
> +
> +	/* if the controller supports only RX polling mode */
> +	struct timer_list rxpoll_timer;
> +};
> +
> +static struct xilinx_mbox *mbox_chan_to_xilinx_mbox(struct mbox_chan *chan)
> +{
> +	if (!chan || !chan->con_priv)

The chan->con_priv check is unnecessary.

> +		return NULL;
> +
> +	return (struct xilinx_mbox *)chan->con_priv;

Nit: Unnecessary cast.

[..]
> +static int xilinx_mbox_startup(struct mbox_chan *chan)
> +{
> +	int ret;
> +	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +
> +	if (mbox->irq > 0) {
> +		ret = request_irq(mbox->irq, xilinx_mbox_interrupt, 0,
> +				  dev_name(mbox->dev), chan);
> +		if (unlikely(ret)) {
> +			dev_err(mbox->dev,
> +				"failed to register mailbox interrupt:%d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		xilinx_mbox_rx_intmask(mbox, true);
> +
> +		/* if fifo was full already, we didn't get an interrupt */
> +		while (xilinx_mbox_pending(mbox))
> +			xilinx_mbox_rx_data(chan);
> +
> +		return 0;
> +	}
> +
> +	/* setup polling timer */
> +	setup_timer(&mbox->rxpoll_timer, xilinx_mbox_poll_rx,
> +		    (unsigned long)chan);
> +	mod_timer(&mbox->rxpoll_timer,
> +		  jiffies + msecs_to_jiffies(MBOX_POLLING_MS));
> +
> +	return 0;
> +}
> +
> +static int xilinx_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +	u32 *udata = (u32 *)data;

Nit: Unnecessary cast.

> +
> +	if (!mbox || !data)
> +		return -EINVAL;
> +
> +	if (xilinx_mbox_full(mbox))
> +		return -EBUSY;
> +
> +	/* enable interrupt before send */
> +	if (mbox->irq >= 0)

You seem to be inconsistent in checking mbox->irq >=0 (here) vs. >0 (in
probe).

> +		xilinx_mbox_tx_intmask(mbox, true);
> +
> +	writel_relaxed(*udata, mbox->mbox_base + MAILBOX_REG_WRDATA);
> +
> +	return 0;
> +}
> +
> +static bool xilinx_mbox_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +
> +	/* return false if mailbox is full */
> +	return !xilinx_mbox_full(mbox);
> +}
> +
> +static bool xilinx_mbox_peek_data(struct mbox_chan *chan)
> +{
> +	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +
> +	return xilinx_mbox_pending(mbox);

> +
> +static void xilinx_mbox_shutdown(struct mbox_chan *chan)
> +{
> +	struct xilinx_mbox *mbox = mbox_chan_to_xilinx_mbox(chan);
> +
> +	if (mbox->irq > 0) {
> +		/* mask all interrupts */
> +		writel_relaxed(0, mbox->mbox_base + MAILBOX_REG_IE);
> +		free_irq(mbox->irq, chan);
> +	} else {
> +		del_timer_sync(&mbox->rxpoll_timer);
> +	}
> +}
> +
> +static struct mbox_chan_ops xilinx_mbox_ops = {

const?

I'm also wondering if it's a bit cleaner to define two mbox_ops, one for
polling and one for when the device is interrupt driven.

> +	.send_data = xilinx_mbox_send_data,
> +	.startup = xilinx_mbox_startup,
> +	.shutdown = xilinx_mbox_shutdown,
> +	.last_tx_done = xilinx_mbox_last_tx_done,
> +	.peek_data = xilinx_mbox_peek_data,
> +};
> +
> +static int xilinx_mbox_probe(struct platform_device *pdev)
> +{
> +	struct xilinx_mbox *mbox;
> +	struct resource	*regs;
> +	struct mbox_chan *chans;
> +	int ret;
> +
> +	mbox = devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +
> +	/* get clk and enable */
> +	mbox->clk = devm_clk_get(&pdev->dev, "mbox");
> +	if (IS_ERR(mbox->clk)) {
> +		dev_err(&pdev->dev, "Couldn't get clk.\n");
> +		return PTR_ERR(mbox->clk);
> +	}
> +
> +	/* allocated one channel */
> +	chans = devm_kzalloc(&pdev->dev, sizeof(*chans), GFP_KERNEL);
> +	if (!chans)
> +		return -ENOMEM;

You know statically the number of channels (one), so why not just
include the struct mbox_chan in struct xilinx_mbox (admittedly, I'm not
too familiar with the mailbox subsystem's lifetime guarantees).

> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	mbox->mbox_base = devm_ioremap_resource(&pdev->dev, regs);
> +	if (IS_ERR(mbox->mbox_base))
> +		return PTR_ERR(mbox->mbox_base);
> +
> +	mbox->irq = platform_get_irq(pdev, 0);
> +	/* if irq is present, we can use it, otherwise, poll */
> +	if (mbox->irq > 0) {
> +		mbox->controller.txdone_irq = true;
> +	} else {
> +		dev_info(&pdev->dev, "IRQ not found, fallback to polling.\n");
> +		mbox->controller.txdone_poll = true;
> +		mbox->controller.txpoll_period = MBOX_POLLING_MS;
> +	}
> +
> +	mbox->dev = &pdev->dev;
> +
> +	/* hardware supports only one channel. */
> +	chans[0].con_priv = mbox;
> +	mbox->controller.dev = mbox->dev;
> +	mbox->controller.num_chans = 1;
> +	mbox->controller.chans = chans;
> +	mbox->controller.ops = &xilinx_mbox_ops;
> +
> +	/* prep and enable the clock */
> +	clk_prepare_enable(mbox->clk);

I know you've already moved where clock management has been done once,
but I'm wondering if clock management be done in startup/shutdown
instead of in probe()?

> +	ret = mbox_controller_register(&mbox->controller);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Register mailbox failed\n");
> +		clk_disable_unprepare(mbox->clk);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, mbox);
> +
> +	return 0;
> +}
> +
> +static int xilinx_mbox_remove(struct platform_device *pdev)
> +{
> +	struct xilinx_mbox *mbox = platform_get_drvdata(pdev);
> +
> +	if (!mbox)

How could this happen?

> +		return -EINVAL;
> +
> +	mbox_controller_unregister(&mbox->controller);
> +
> +	clk_disable_unprepare(mbox->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id xilinx_mbox_match[] = {
> +	{ .compatible = "xlnx,mailbox-2.1" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, xilinx_mbox_match);
> +
> +static struct platform_driver xilinx_mbox_driver = {
> +	.probe	= xilinx_mbox_probe,
> +	.remove	= xilinx_mbox_remove,
> +	.driver	= {
> +		.name	= DRIVER_NAME,
> +		.of_match_table	= xilinx_mbox_match,
> +	},
> +};
> +
> +module_platform_driver(xilinx_mbox_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Xilinx mailbox specific functions");
> +MODULE_AUTHOR("Moritz Fischer <moritz.fischer@ettus.com>");
> +MODULE_ALIAS("platform:xilinx-mailbox");
> -- 
> 2.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150616/0c89ccea/attachment-0001.sig>
