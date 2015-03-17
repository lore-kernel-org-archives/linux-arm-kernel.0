From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Mar 2015 21:33:41 -0600
Subject: [PATCH 3/4 v4] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <1426213936-4139-3-git-send-email-eric@anholt.net>
References: <1426213936-4139-1-git-send-email-eric@anholt.net>
 <1426213936-4139-3-git-send-email-eric@anholt.net>
Message-ID: <5507A095.5090805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2015 08:32 PM, Eric Anholt wrote:
> From: Lubomir Rintel <lkundrak@v3.sk>
> 
> Implement BCM2835 mailbox support as a device registered with the
> general purpose mailbox framework. Implementation based on commits by
> Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on which to base the
> implementation.
> 
> [1] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
> [2] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Acks often don't carry over when there are significant changes.

> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c

> +#define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
> +#define MBOX_CHAN(msg)			((msg) & 0xf)
> +#define MBOX_DATA28(msg)		((msg) & ~0xf)

Even the concept of storing channel IDs in the LSBs feels like it might
be RPi-firmware-specific rather than HW-specific?

> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
> +{
> +	struct bcm2835_mbox *mbox = (struct bcm2835_mbox *) dev_id;
> +	struct device *dev = mbox->dev;
> +
> +	bcm2835_peripheral_read_workaround();
> +
> +	while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
> +		u32 msg = readl(mbox->regs + MAIL0_RD);
> +		unsigned int chan = MBOX_CHAN(msg);
> +		u32 data = MBOX_DATA28(msg);
> +
> +		if (!mbox->channel[chan].started) {
> +			dev_err(dev, "Reply on stopped channel %d\n", chan);
> +			continue;
> +		}
> +		dev_dbg(dev, "Reply 0x%08X\n", msg);

I think for complete safety, you'd need to put the peripheral workaround
call here too. Consider what happens if some module registers to receive
mailbox responses, then e.g. changes a GPIO right in the callback. Are
we going to add the workaround call to the bcm2835 GPIO, SDHCI, and USB
drivers too? If so, that might obviate the need to perform the
workaround here.

Either way though, wouldn't we need to at least move the workaround
that's already present in this function so that it happens before the
readl() inside the while() above every time, to handle the switch from
any HW access inside mbox_chan_received_data() to the HW access to the
mbox module here?

> +		mbox_chan_received_data(mbox->channel[chan].link, &data);
> +	}
> +	return IRQ_HANDLED;
> +}

> +static int bcm2835_mbox_probe(struct platform_device *pdev)
...
> +	/* Enable the interrupt on data reception */
> +	writel(ARM_MC_IHAVEDATAIRQEN, mbox->regs + MAIL0_CNF);

I think that bcm2835_mbox_remove() needs to undo that, so that it
guarantees the IRQ handler won't be called after the function returns,
but before the devm IRQ unregister occurs.
