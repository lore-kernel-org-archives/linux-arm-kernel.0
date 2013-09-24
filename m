From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Tue, 24 Sep 2013 20:09:01 +1200
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <52410949.8070403@wwwdotorg.org>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
 <52410949.8070403@wwwdotorg.org>
Message-ID: <5241489D.4000709@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


At the risk of being accused of top-posting, I'll just reply to this 
first in case you want to skip the rest.

On 09/24/2013 03:38 PM, Stephen Warren wrote:
 > Overall, I'm not sure what bug/issue in the original code this
 > patch is meant to solve, nor why the new IRQ ID scheme is better.
 > Sorry.

No apologies required.  I'm fairly thick skinned when it comes to 
criticism code I write.  I simply appreciate you taking to the time to 
review it.

Ultimately I was trying to achieve three things:
  * Restore the original order of interrupt dispatch, especially if new
    interrupts become pending.
  * Enable FIQ handling.
  * Clarify the processing and dispatch of interrupts, particularly in
    light of short cuts.

I wasn't too sure of the reasons for the ordering, and may have read too 
much into the comment "see SW-5809". But I was motivated by the Broadcom 
driver for the DMA controller that identified DMA 2 and 3 as "fast DMA" 
which correlates with the interrupts for those two channels being short 
cut.  Still, there is a strong element of cargo-cult programming here. 
Mea culpa.

The second point may be moot since I'm no longer sure if this is 
possible.  See below.

I'm in no position to judge the third point.  By the time I'd taken the 
trouble to understand the existing code, I understood both versions 
equally well.

All in all, I don't feel the need to be pushy about this and am happy to 
let it rest.  But if there are any ideas you'd like to salvage, I'd be 
happy to re-implement them from scatch and submit again.

On 09/24/2013 03:38 PM, Stephen Warren wrote:
> On 09/21/2013 03:18 AM, Craig McGeachie wrote:
>> The justification for doing this is:
>>   * Simplify the decode and dispatch logic to make it easier to under-
>>     stand and maintain.
>>   * Re-arrange the hardware IRQ numbers to match the numbering scheme of
>>     the FIQ register.
>
> What's the benefit of that change? The bank numbers in the existing
> driver match the register naming in the HW (base/pend1/pend2 for bank
> 0/1/2).

Not really. The different types registers from each bank have different 
bank orderings.  The pending registers go 
base=0x200/gpu0=0x204/gpu1=0x208.  The enable registers go 
gpu0=0x210/gpu1=0x214/base=0x218. The disable registers go 
gpu0=0x21C/gpu1=0x220/base=0x224.  The choice of bank numbering is 
arbitrary, but given that the pending registers require special handling 
anyway, I preferred that of the enable/disable registers. And it matches 
the implied order given the numbering in the FIQ control register.

As a side note, BCM2835_ARM_Peripherals.pdf doesn't number the base 
register but variously numbers the GPU registers as 0/1 or 1/2.  The 
document is inconsistent on this point.

> Further on, one of your added comments says "This is the same
> numbering scheme used in bits 0..6 of the FIQ register."; what about any
> other bits in the FIQ register - do they still not match the renumbered
> scheme, or are there just fewer bits in the FIQ register? Either way, I
> don't understand why it's useful for the internal IRQ IDs to match the
> FIQ register.

If you represent the UART interrupt as 57, then if you wish to treat the 
UART as a FIQ you simply write to the FIQ register like so:
   writel_relaxed((BIT(7) | 57), ctrlr.iobase + 0x0C)
and write the appropriate bit to the disable registers.  Any other 
numbering scheme for hardware IRQs requires translation to 57 first so 
that you can write the correct 7 bit unsigned integer to bits 6:0.

However, this might all be pointless. Only one interrupt can be flagged 
as fast at any given time.  After the first driver registers for a fast 
interrupt, the best that I would be able to do is effectively mark all 
fast interrupts as unavailable until the first one is released.

>
> I guess the table of interrupt IDs in BCM2835_ARM_Peripherals.pdf
>
>>   * Restore the flow of control that re-reads the base pending register
>>     after handling any interrupt. The current version handles all
>>     interrupts found in a GPU pending register before re-reading the
>>     base pending register. In the original Broadcom assembly code, there
>>     appear to be defect tracking numbers next to code inserted to create
>>     this behaviour.
>
> I assume you mean the assembly in BCM2835_ARM_Peripherals.pdf? I'm not
> really sure that code implies that SW must work the way you've modified
> it to work, although there's probably no harm making this change.
>
> The "defect tracking numbers" in that code simply make sure that when
> reading PEND1, any status bits there that also have shortcut bits in the
> base pending register aren't handled. Presumably this is simply to avoid
> having two IRQ numbers for the same physical IRQ, since any table
> lookups for an IRQ handler would fail if using an IRQ ID derived from
> PEND1 bank/bit ID rather than base bank/bit ID.

Now that you describe it like that, I think you're right.

> IIRC, the existing Linux
> driver already does this (ignores the bits in PEND1 that are
> duplicates).

I don't think it does. If it doesn't find any other interrupts in the 
base pending register it handles the first bank:
		} else if (stat & BANK1_HWIRQ) {
			armctrl_handle_bank(1, regs);

Then it reads the bits in tight loop handling all that it finds.
	while ((stat = readl_relaxed(intc.pending[bank]))) {
		irq = MAKE_HWIRQ(bank, ffs(stat) - 1);
		handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
	}

So long as new interrupts come in on this register, the base pending 
register will never be re-read.  Still, there could be memory access 
ordering and caching behaviour that I'm completely ignorant of, so I 
could be completely wrong. And it's probably unlikely that interrupts 
come in that fast.

> This logic doesn't imply that one can't loop reading the
> PEND1 register.

No. I just felt that always reading the base pending register and 
processing the short cut interrupts there lent itself to a natural 
interrupt prioritisation.

>
>
>> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
>
>>    * GNU General Public License for more details.
>> - *
>> - * Quirk 1: Shortcut interrupts don't set the bank 1/2 register pending bits
>> - *
>> - * If an interrupt fires on bank 1 that isn't in the shortcuts list, bit 8
> ...
>> - * otherwise both handlers will fire at the same time!
>>    */
>
> That removes a bunch of useful description of the HW. I don't think it's
> a good idea to remove it.

I didn't find it any more helpful than the BCM2835_ARM_Peripherals.pdf. 
  Not that the PDF was very easy to follow either.  I also thought that 
comparing what was going on to a "proper cascaded interrupt controller" 
distracting. There is no cascade.  I don't think there's meant to be. 
Just a simple bit of combinational digital circuitry on top of the 
interrupt lines. But this is purely a personal opinion.

And now a few snips, simply because you're correct and I have nothing to 
add.

 >...cut...<
> I'm not sure why a hwirq_xlat table lookup is needed; why not just
> return the HW IRQ number directly like the existing code?

Have I managed to cover this elsewhere?

>...cut...<
>> +static struct irq_chip bmc2835_chip = {
>> +	.name = "bmc2835-level",
>> +	.irq_mask = bmc2835_mask_irq,
>> +	.irq_unmask = bmc2835_unmask_irq,
>> +	.irq_ack =  bmc2835_mask_irq,
>> +};
>
> Why should an IRQ be masked by the ack operation?

To be honest, I don't know for sure.  I took my cue from 
Documentation/arm/Interrupts.

ack    - required.  May be the same function as mask for IRQs
          handled by do_level_IRQ.

Some other irq_chips are set up the same way and I can't see any other 
way of implementing an acknowledgement function.  And my experience with 
a never ending flow of interrupts while writing the mailbox driver made 
me think it might be good idea for the BMC2835 as well.

>
>> +/**
>> + * bmc2835_dispatch_irq() - translate bank/bit to kernel IRQ and dispatch
>> + * @bank:	Register bank (BASE, GPU1, or GPU2).
>> + * @bits:	Pending interrupt status bits.
>> + * @regs:	register pointer passed on to the handler.
>> + *
>> + * The bits passed are the full set of bits read from register.  Only the lowest
>> + * order bit is translated and dispatched. Dispatching the other IRQs requires
>> + * re-reading the register and calling this function again.
>
> I'm not actually sure that's a good change. If we read e.g. PEND1 and
> saw 4 bits asserted, why wouldn't we optimize by handling each of those
> 4 bits. Re-reading the PEND1 register for each bit, and presumably
> seeing the exact same set of remaining bits still set (or even more),
> just seems like a waste. We know we're going to have to process all the
> interrupts, so why not just process them?

Again, simply from the point of prioritising interrupts.  It's not just 
re-reading the current pending register. As to whether a full review of 
pending interrupts was appropriate, I don't really know. Thats the flow 
that arch/arm/include/asm/entry-macro-multi.S implements.  Find the 
first known interrupt.  Handle it. Find the first known interrupt again 
without any context from previous search.  There might perhaps have been 
a touch of cargo-cult going on again.

>
>> +static int __init bmc2835_of_init(struct device_node *node,
>
>> +	for (i = 0; i != NR_CHIP_IRQS; i++) {
>> +		int irq;
>> +		BUG_ON((irq = irq_create_mapping(ctrlr.domain, i)) <= 0);
>
> I rather dislike statements with assignment side-effects. That was a
> separate assignment and test statement in the original code, which seems
> much clearer.

Um, I generally don't like assignment expressions either.  I have no 
idea why I did this.

Cheers,
Craig.
