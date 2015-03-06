From: eric@anholt.net (Eric Anholt)
Date: Fri, 06 Mar 2015 12:00:06 -0800
Subject: [PATCH 02/10] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <54F932FD.5040207@wwwdotorg.org>
References: <1425329684-23968-1-git-send-email-eric@anholt.net>
 <1425329684-23968-3-git-send-email-eric@anholt.net>
 <54F675F1.60205@wwwdotorg.org> <87a8zs8vzo.fsf@eliezer.anholt.net>
 <54F932FD.5040207@wwwdotorg.org>
Message-ID: <87bnk5lwvt.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 03/04/2015 11:20 AM, Eric Anholt wrote:
>> Stephen Warren <swarren@wwwdotorg.org> writes:
>> 
>>> On 03/02/2015 01:54 PM, Eric Anholt wrote:
>>>> From: Lubomir Rintel <lkundrak@v3.sk>
>>>> 
>>>> Implement BCM2835 mailbox support as a device registered with
>>>> the general purpose mailbox framework. Implementation based on
>>>> commits by Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on
>>>> which to base the implementation.
>>> 
>>>> diff --git a/drivers/mailbox/bcm2835-mailbox.c
>>>> b/drivers/mailbox/bcm2835-mailbox.c
>
>>>> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id) +{ 
>>>> +	struct bcm2835_mbox *mbox = (struct bcm2835_mbox *) dev_id; +
>>>> struct device *dev = mbox->dev; + +	while (!(readl(mbox->regs +
>>>> MAIL0_STA) & ARM_MS_EMPTY)) { +		u32 msg = readl(mbox->regs +
>>>> MAIL0_RD); +		unsigned int chan = MBOX_CHAN(msg); + +		if
>>>> (!mbox->channel[chan].started) { +			dev_err(dev, "Reply on
>>>> stopped channel %d\n", chan); +			continue; +		} +
>>>> dev_dbg(dev, "Reply 0x%08X\n", msg); +
>>>> mbox_chan_received_data(mbox->channel[chan].link, +			(void *)
>>>> MBOX_DATA28(msg)); +	} +	rmb(); /* Finished last mailbox read.
>>>> */
>>> 
>>> I know the PDF mentioned in the comment earlier in the patch says
>>> to put in barriers between accesses to different peripherals,
>>> which this seems compliant with, but I don't see quite what this
>>> barrier achieves. I think the PDF is talking generalities, not
>>> imposing a rule that must be blindly followed. Besides, if
>>> there's a context-switch you can't actually implement the rules
>>> the PDF suggests. What read operation is this barrier attempting
>>> to ensure happens after reading all mailbox messages and any
>>> associated DRAM buffer?
>> 
>> Looking at this bit of code in particular:
>> 
>> "As interrupts can appear anywhere in the code so you should
>> safeguard those. If an interrupt routine reads from a peripheral
>> the routine should start with a memory read barrier. If an
>> interrupt routine writes to a peripheral the routine should end
>> with a memory write barrier."
>
> I can see that doing that would be safe, but I don't think following
> those rules is actually necessary in the general case. Following those
> rules would cause lots of unnecessary barriers in code.
>
> Barriers shouldn't be used arbitrarily at the start/end of ISRs, but
> rather at specific chosen locations in the code that actually need to
> enforce some kind of memory ordering.

According to the architecture docs, if you don't RMB at the start of
your ISR, then the following timeline could get the wrong values:

some other device driver               our isr
------------------------               -------
rmb()
read from device
                                       read from device
                                       examine value read
                                       exit isr
examine value raed.

The ISR could get the device driver's value.  This is made explicit in
footnote 2 on page 7.

>> So it seems like the IRQ handler at least wants:
>> 
>> diff --git a/drivers/mailbox/bcm2835-mailbox.c
>> b/drivers/mailbox/bcm2835-mailbox.c index 604beb7..7e528f6 100644 
>> --- a/drivers/mailbox/bcm2835-mailbox.c +++
>> b/drivers/mailbox/bcm2835-mailbox.c @@ -88,6 +88,13 @@ static
>> irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id) struct
>> bcm2835_mbox *mbox = (struct bcm2835_mbox *) dev_id; struct device
>> *dev = mbox->dev;
>> 
>> +	/* +	 * BCM2835-ARM-Peripherals.pdf says "If an interrupt
>> routine +	 * reads from a peripheral the routine should start with
>> a +	 * memory read barrier." +	 */ +	rmb(); + while
>> (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) { u32 msg =
>> readl(mbox->regs + MAIL0_RD); unsigned int chan = MBOX_CHAN(msg); 
>> @@ -100,7 +107,6 @@ static irqreturn_t bcm2835_mbox_irq(int irq,
>> void *dev_id) mbox_chan_received_data(mbox->channel[chan].link, 
>> (void *) MBOX_DATA28(msg)); } -	rmb(); /* Finished last mailbox
>> read. */ return IRQ_HANDLED; }
>
> In this case, I don't think neither the original barrier is needed,
> nor the extra one you added.

Your formatting got completely destroyed here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150306/6a66dddf/attachment.sig>
