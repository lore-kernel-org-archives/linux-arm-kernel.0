From: eric@anholt.net (Eric Anholt)
Date: Wed, 04 Mar 2015 10:20:59 -0800
Subject: [PATCH 02/10] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <54F675F1.60205@wwwdotorg.org>
References: <1425329684-23968-1-git-send-email-eric@anholt.net>
 <1425329684-23968-3-git-send-email-eric@anholt.net>
 <54F675F1.60205@wwwdotorg.org>
Message-ID: <87a8zs8vzo.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 03/02/2015 01:54 PM, Eric Anholt wrote:
>> From: Lubomir Rintel <lkundrak@v3.sk>
>> 
>> Implement BCM2835 mailbox support as a device registered with the
>> general purpose mailbox framework. Implementation based on commits by
>> Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on which to base the
>> implementation.
>
>> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
>
>> +/* Mailboxes */
>> +#define ARM_0_MAIL0	0x00
>> +#define ARM_0_MAIL1	0x20
>> +
>> +/*
>> + * Mailbox registers. We basically only support mailbox 0 & 1. We
>> + * deliver to the VC in mailbox 1, it delivers to us in mailbox 0. See
>> + * BCM2835-ARM-Peripherals.pdf section 1.3 for an explanation about
>> + * the placement of memory barriers.
>> + */
>> +#define MAIL0_RD	(ARM_0_MAIL0 + 0x00)
>> +#define MAIL0_POL	(ARM_0_MAIL0 + 0x10)
>> +#define MAIL0_STA	(ARM_0_MAIL0 + 0x18)
>> +#define MAIL0_CNF	(ARM_0_MAIL0 + 0x1C)
>> +#define MAIL1_WRT	(ARM_0_MAIL1 + 0x00)
>
> That implies there are more mailboxes. I wonder if we should
> parameterize which to use via some DT properties? I guess we can defer
> that though; we can default to the current values and add properties
> later if we want to use something else.

Yeah, until there's something to talk to in another mailbox, this seems
fine.

>> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
>> +{
>> +	struct bcm2835_mbox *mbox = (struct bcm2835_mbox *) dev_id;
>> +	struct device *dev = mbox->dev;
>> +
>> +	while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
>> +		u32 msg = readl(mbox->regs + MAIL0_RD);
>> +		unsigned int chan = MBOX_CHAN(msg);
>> +
>> +		if (!mbox->channel[chan].started) {
>> +			dev_err(dev, "Reply on stopped channel %d\n", chan);
>> +			continue;
>> +		}
>> +		dev_dbg(dev, "Reply 0x%08X\n", msg);
>> +		mbox_chan_received_data(mbox->channel[chan].link,
>> +			(void *) MBOX_DATA28(msg));
>> +	}
>> +	rmb(); /* Finished last mailbox read. */
>
> I know the PDF mentioned in the comment earlier in the patch says to put
> in barriers between accesses to different peripherals, which this seems
> compliant with, but I don't see quite what this barrier achieves. I
> think the PDF is talking generalities, not imposing a rule that must be
> blindly followed. Besides, if there's a context-switch you can't
> actually implement the rules the PDF suggests. What read operation is
> this barrier attempting to ensure happens after reading all mailbox
> messages and any associated DRAM buffer?

Looking at this bit of code in particular:

"As interrupts can appear anywhere in the code so you should safeguard
those. If an interrupt routine reads from a peripheral the routine
should start with a memory read barrier. If an interrupt routine writes
to a peripheral the routine should end with a memory write barrier."

So it seems like the IRQ handler at least wants:

diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
index 604beb7..7e528f6 100644
--- a/drivers/mailbox/bcm2835-mailbox.c
+++ b/drivers/mailbox/bcm2835-mailbox.c
@@ -88,6 +88,13 @@ static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
 	struct bcm2835_mbox *mbox = (struct bcm2835_mbox *) dev_id;
 	struct device *dev = mbox->dev;
 
+	/*
+	 * BCM2835-ARM-Peripherals.pdf says "If an interrupt routine
+	 * reads from a peripheral the routine should start with a
+	 * memory read barrier."
+	 */
+	rmb();
+
 	while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
 		u32 msg = readl(mbox->regs + MAIL0_RD);
 		unsigned int chan = MBOX_CHAN(msg);
@@ -100,7 +107,6 @@ static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
 		mbox_chan_received_data(mbox->channel[chan].link,
 			(void *) MBOX_DATA28(msg));
 	}
-	rmb(); /* Finished last mailbox read. */
 	return IRQ_HANDLED;
 }
 
-- 

> If any barrier is needed, shouldn't it be between the mailbox read and
> the processing of that message (which could at least in some cases read
> an SDRAM buffer). So, the producer would do roughly:
>
> p1) Fill in DRAM buffer
> p2) Write memory barrier so the MBOX write happens after the above
> p3) Send mbox message to tell the consumer to process the buffer
>
> ... and the consumer:
>
> c1) Read MBOX register to know which DRAM buffer to handle
> c2) rmb() to make sure we read from the DRAM buffer after the MBOX read
> c3) Read the DRAM buffer
>
> Even then, since (c3) is data-dependent on (c1), I don't think the rmb()
> in (c2) there actually does anything useful.

I'm not sure if this is already covered by "The GPU has special logic to
cope with data arriving out-of-order", but I think I agree we should
probably do it for safety.

>> +static int bcm2835_send_data(struct mbox_chan *link, void *data)
>> +{
>> +	struct bcm2835_channel *chan = to_channel(link);
>> +	struct bcm2835_mbox *mbox = chan->mbox;
>> +	int ret = 0;
>> +
>> +	if (!chan->started)
>> +		return -ENODEV;
>> +	spin_lock(&mbox->lock);
>
> Is it safe to read chan->started without the channel lock held?

The channel's lock is held by our caller (msg_submit() of mailbox.c).

>> +	if (readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL) {
>> +		rmb(); /* Finished last mailbox read. */
>
> This also doesn't seem useful?

This (and the next one) seems to fall under:

"You should place:
? A memory write barrier before the first write to a peripheral.
? A memory read barrier after the last read of a peripheral.

It is not required to put a memory barrier instruction after each read
or write access. Only at those places in the code where it is possible
that a peripheral read or write may be followed by a read or write of a
different peripheral. This is normally at the entry and exit points of
the peripheral service code."

>> +static int bcm2835_startup(struct mbox_chan *link)
>> +{
>> +	struct bcm2835_channel *chan = to_channel(link);
>> +
>> +	chan->started = true;
>> +	return 0;
>> +}
>> +
>> +static void bcm2835_shutdown(struct mbox_chan *link)
>> +{
>> +	struct bcm2835_channel *chan = to_channel(link);
>> +
>> +	chan->started = false;
>> +}
>
> Don't we need to hold chan->lock when adjusting chan->started? Or is
> start/stop intended to be asynchronous to any operations currently in
> progress on the channel?

Only one client can be on a channel at a time, which is controlled by
con_mutex at channel request time, and these hooks are when the client
appears/disappears.

The started check in the irq handler is necessary so that we drop any
stray mbox messages instead of NULL dereffing in
mbox_chan_received_data().  I think the check in bcm2846_send_data()
could just be dropped (we know we have a client if a client is trying to
send a message).  I haven't followed quite what bcm2835_last_tx_done()
is doing.

>> +static bool bcm2835_last_tx_done(struct mbox_chan *link)
>> +{
>> +	struct bcm2835_channel *chan = to_channel(link);
>> +	struct bcm2835_mbox *mbox = chan->mbox;
>> +	bool ret;
>> +
>> +	if (!chan->started)
>> +		return false;
>> +	spin_lock(&mbox->lock);
>> +	ret = !(readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL);
>> +	rmb(); /* Finished last mailbox read. */
>
> That barrier doesn't seem useful?

Same barrier comment.

> What are the semantics of "tx done"? This seems to be testing that the
> TX mailbox isn't completely full, which is more about whether the
> consumer side is backed up rather than whether our producer-side TX
> operations are done.

Take a look at poll_txdone() -- it does look like we're doing the right
thing here, just that the method would be better named as
"ready_to_send" or something.

>> +static int request_mailbox_irq(struct bcm2835_mbox *mbox)
>
>> +	if (irq <= 0) {
>> +		dev_err(dev, "Can't get IRQ number for mailbox\n");
>> +		return -ENODEV;
>> +	}
>
> I expect devm_request_irq() checkes that condition.

Chasing things down, it looks like you'd get a silent error, but then
we've already got a whine if devm_request_irq fails anyway.

>> +	ret = devm_request_irq(dev, irq, bcm2835_mbox_irq, 0, dev_name(dev),
>> +		mbox);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register a mailbox IRQ handler\n");
>
> Printing ret might be useful to know why.

Yeah.

> Are you sure devm_request_irq() is appropriate? The IRQ handler will be
> unregistered *after* bcm2835_mbox_remove() is called, and I think
> without any guarantee re: the order that other devm_ allocations are
> cleaned up. If bcm2835_mbox_remove() can't guarantee that no IRQ will
> fire after it exits, then bcm2835_mbox_irq() might just get called after
> some allocations are torn down, thus causing the IRQ handler to touch
> free'd memory.

It looks like we should

writel(0, mbox->regs + MAIL0_CNF);

in the unload.

> Both request_mailbox_iomem and request_mailbox_irq are small enough
> they're typically written inline into the main probe() function.

Sounds good.

>> +static int bcm2835_mbox_probe(struct platform_device *pdev)
>
>> +	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
>> +	if (mbox == NULL) {
>> +		dev_err(dev, "Failed to allocate mailbox memory\n");
>
> devm_kzalloc() already prints an error, so no need to add another here,
> even if it does nicely document the fact that you remembered error
> messages:-)

Wait, it does?  I couldn't find where it would, when I was looking into
the checkpatch warnings.

>> +	mbox->controller.txdone_poll = true;
>> +	mbox->controller.txpoll_period = 5;
>> +	mbox->controller.ops = &bcm2835_mbox_chan_ops;
>> +	mbox->controller.dev = dev;
>> +	mbox->controller.num_chans = MBOX_CHAN_COUNT;
>> +	mbox->controller.chans = devm_kzalloc(dev,
>> +		sizeof(struct mbox_chan) * MBOX_CHAN_COUNT,
>> +		GFP_KERNEL);
>
> It'd be common to say "sizeof(*mbox->controller.chans) so the type can't
> mismatch what's being assigned to.

Agreed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150304/55955f1c/attachment.sig>
