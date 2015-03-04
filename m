From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Mar 2015 20:03:13 -0700
Subject: [PATCH 02/10] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <1425329684-23968-3-git-send-email-eric@anholt.net>
References: <1425329684-23968-1-git-send-email-eric@anholt.net>
 <1425329684-23968-3-git-send-email-eric@anholt.net>
Message-ID: <54F675F1.60205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2015 01:54 PM, Eric Anholt wrote:
> From: Lubomir Rintel <lkundrak@v3.sk>
> 
> Implement BCM2835 mailbox support as a device registered with the
> general purpose mailbox framework. Implementation based on commits by
> Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on which to base the
> implementation.

> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c

> +/* Mailboxes */
> +#define ARM_0_MAIL0	0x00
> +#define ARM_0_MAIL1	0x20
> +
> +/*
> + * Mailbox registers. We basically only support mailbox 0 & 1. We
> + * deliver to the VC in mailbox 1, it delivers to us in mailbox 0. See
> + * BCM2835-ARM-Peripherals.pdf section 1.3 for an explanation about
> + * the placement of memory barriers.
> + */
> +#define MAIL0_RD	(ARM_0_MAIL0 + 0x00)
> +#define MAIL0_POL	(ARM_0_MAIL0 + 0x10)
> +#define MAIL0_STA	(ARM_0_MAIL0 + 0x18)
> +#define MAIL0_CNF	(ARM_0_MAIL0 + 0x1C)
> +#define MAIL1_WRT	(ARM_0_MAIL1 + 0x00)

That implies there are more mailboxes. I wonder if we should
parameterize which to use via some DT properties? I guess we can defer
that though; we can default to the current values and add properties
later if we want to use something else.

> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
> +{
> +	struct bcm2835_mbox *mbox = (struct bcm2835_mbox *) dev_id;
> +	struct device *dev = mbox->dev;
> +
> +	while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
> +		u32 msg = readl(mbox->regs + MAIL0_RD);
> +		unsigned int chan = MBOX_CHAN(msg);
> +
> +		if (!mbox->channel[chan].started) {
> +			dev_err(dev, "Reply on stopped channel %d\n", chan);
> +			continue;
> +		}
> +		dev_dbg(dev, "Reply 0x%08X\n", msg);
> +		mbox_chan_received_data(mbox->channel[chan].link,
> +			(void *) MBOX_DATA28(msg));
> +	}
> +	rmb(); /* Finished last mailbox read. */

I know the PDF mentioned in the comment earlier in the patch says to put
in barriers between accesses to different peripherals, which this seems
compliant with, but I don't see quite what this barrier achieves. I
think the PDF is talking generalities, not imposing a rule that must be
blindly followed. Besides, if there's a context-switch you can't
actually implement the rules the PDF suggests. What read operation is
this barrier attempting to ensure happens after reading all mailbox
messages and any associated DRAM buffer?

If any barrier is needed, shouldn't it be between the mailbox read and
the processing of that message (which could at least in some cases read
an SDRAM buffer). So, the producer would do roughly:

p1) Fill in DRAM buffer
p2) Write memory barrier so the MBOX write happens after the above
p3) Send mbox message to tell the consumer to process the buffer

... and the consumer:

c1) Read MBOX register to know which DRAM buffer to handle
c2) rmb() to make sure we read from the DRAM buffer after the MBOX read
c3) Read the DRAM buffer

Even then, since (c3) is data-dependent on (c1), I don't think the rmb()
in (c2) there actually does anything useful.

> +static int bcm2835_send_data(struct mbox_chan *link, void *data)
> +{
> +	struct bcm2835_channel *chan = to_channel(link);
> +	struct bcm2835_mbox *mbox = chan->mbox;
> +	int ret = 0;
> +
> +	if (!chan->started)
> +		return -ENODEV;
> +	spin_lock(&mbox->lock);

Is it safe to read chan->started without the channel lock held?

> +	if (readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL) {
> +		rmb(); /* Finished last mailbox read. */

This also doesn't seem useful?

> +		ret = -EBUSY;
> +		goto end;
> +	}
> +	wmb(); /* About to write to the mail box. */
> +	writel(MBOX_MSG(chan->chan_num, (u32) data), mbox->regs + MAIL1_WRT);

This one I agree with, at least if MBOX messages contain pointers to
DRAM buffers.

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

Don't we need to hold chan->lock when adjusting chan->started? Or is
start/stop intended to be asynchronous to any operations currently in
progress on the channel?

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

That barrier doesn't seem useful?

What are the semantics of "tx done"? This seems to be testing that the
TX mailbox isn't completely full, which is more about whether the
consumer side is backed up rather than whether our producer-side TX
operations are done.

If the idea is to wait for the consumer to have consumed everything in
our TX direction, shouldn't this check for empty not !full?

> +static int request_mailbox_irq(struct bcm2835_mbox *mbox)

> +	if (irq <= 0) {
> +		dev_err(dev, "Can't get IRQ number for mailbox\n");
> +		return -ENODEV;
> +	}

I expect devm_request_irq() checkes that condition.

> +	ret = devm_request_irq(dev, irq, bcm2835_mbox_irq, 0, dev_name(dev),
> +		mbox);
> +	if (ret) {
> +		dev_err(dev, "Failed to register a mailbox IRQ handler\n");

Printing ret might be useful to know why.

Are you sure devm_request_irq() is appropriate? The IRQ handler will be
unregistered *after* bcm2835_mbox_remove() is called, and I think
without any guarantee re: the order that other devm_ allocations are
cleaned up. If bcm2835_mbox_remove() can't guarantee that no IRQ will
fire after it exits, then bcm2835_mbox_irq() might just get called after
some allocations are torn down, thus causing the IRQ handler to touch
free'd memory.

Both request_mailbox_iomem and request_mailbox_irq are small enough
they're typically written inline into the main probe() function.

> +static int bcm2835_mbox_probe(struct platform_device *pdev)

> +	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +	if (mbox == NULL) {
> +		dev_err(dev, "Failed to allocate mailbox memory\n");

devm_kzalloc() already prints an error, so no need to add another here,
even if it does nicely document the fact that you remembered error
messages:-)

> +	mbox->controller.txdone_poll = true;
> +	mbox->controller.txpoll_period = 5;
> +	mbox->controller.ops = &bcm2835_mbox_chan_ops;
> +	mbox->controller.dev = dev;
> +	mbox->controller.num_chans = MBOX_CHAN_COUNT;
> +	mbox->controller.chans = devm_kzalloc(dev,
> +		sizeof(struct mbox_chan) * MBOX_CHAN_COUNT,
> +		GFP_KERNEL);

It'd be common to say "sizeof(*mbox->controller.chans) so the type can't
mismatch what's being assigned to.

> +	if (!mbox->controller.chans) {
> +		dev_err(dev, "Failed to alloc mbox_chans\n");

Same comment about error messages here.

> +	/* Enable the interrupt on data reception */
> +	writel(ARM_MC_IHAVEDATAIRQEN, mbox->regs + MAIL0_CNF);
> +	dev_info(dev, "mailbox enabled\n");

There's no interrupt for "TX space available"? Oh well. I guess that's
why mbox->controller.txdone_poll = true.
