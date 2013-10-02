From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 20:01:52 -0600
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <5241489D.4000709@yahoo.com.au>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
 <52410949.8070403@wwwdotorg.org> <5241489D.4000709@yahoo.com.au>
Message-ID: <524B7E90.30000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2013 02:09 AM, Craig McGeachie wrote:
...
> On 09/24/2013 03:38 PM, Stephen Warren wrote:
>> On 09/21/2013 03:18 AM, Craig McGeachie wrote:
>>> The justification for doing this is:
>>>   * Simplify the decode and dispatch logic to make it easier to under-
>>>     stand and maintain.
>>>   * Re-arrange the hardware IRQ numbers to match the numbering scheme of
>>>     the FIQ register.
>>
>> What's the benefit of that change? The bank numbers in the existing
>> driver match the register naming in the HW (base/pend1/pend2 for bank
>> 0/1/2).
> 
> Not really. The different types registers from each bank have different
> bank orderings.  The pending registers go
> base=0x200/gpu0=0x204/gpu1=0x208.  The enable registers go
> gpu0=0x210/gpu1=0x214/base=0x218. The disable registers go
> gpu0=0x21C/gpu1=0x220/base=0x224.  The choice of bank numbering is
> arbitrary, but given that the pending registers require special handling
> anyway, I preferred that of the enable/disable registers. And it matches
> the implied order given the numbering in the FIQ control register.

Ah yes, I guess the enable/status registers are indeed in a different order.

I think this highlights part of why I preferred some aspects of the
original code; it used a set of lookup tables to map from the SW bank
number to the register addresses. There were no complicated calculations
here; just a simple table lookup. It would be possible to re-order the
banks without changing this.

>> Further on, one of your added comments says "This is the same
>> numbering scheme used in bits 0..6 of the FIQ register."; what about any
>> other bits in the FIQ register - do they still not match the renumbered
>> scheme, or are there just fewer bits in the FIQ register? Either way, I
>> don't understand why it's useful for the internal IRQ IDs to match the
>> FIQ register.
> 
> If you represent the UART interrupt as 57, then if you wish to treat the
> UART as a FIQ you simply write to the FIQ register like so:
>   writel_relaxed((BIT(7) | 57), ctrlr.iobase + 0x0C)
> and write the appropriate bit to the disable registers.  Any other
> numbering scheme for hardware IRQs requires translation to 57 first so
> that you can write the correct 7 bit unsigned integer to bits 6:0.

Ah right, I see. Renumbering the banks internally may make sense then.
You'd still end up needing to translate between the DT bank IDs and
internal bank IDs though, so I don't know how useful this would be.

>> I guess the table of interrupt IDs in BCM2835_ARM_Peripherals.pdf
>>
>>>   * Restore the flow of control that re-reads the base pending register
>>>     after handling any interrupt. The current version handles all
>>>     interrupts found in a GPU pending register before re-reading the
>>>     base pending register. In the original Broadcom assembly code, there
>>>     appear to be defect tracking numbers next to code inserted to create
>>>     this behaviour.

BTW, you mentioned "restore" above; while your patch did align the
upstream Linux driver more closely with the sample code in the PDF, I'm
not sure that any Linux port actually previously followed that example,
did it? I'm nit-picking about the semantics of the word "restore" here:-)

>> IIRC, the existing Linux
>> driver already does this (ignores the bits in PEND1 that are
>> duplicates).
> 
> I don't think it does. If it doesn't find any other interrupts in the
> base pending register it handles the first bank:
>
>         } else if (stat & BANK1_HWIRQ) {
>             armctrl_handle_bank(1, regs);
> 
> Then it reads the bits in tight loop handling all that it finds.
>     while ((stat = readl_relaxed(intc.pending[bank]))) {
>         irq = MAKE_HWIRQ(bank, ffs(stat) - 1);
>         handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
>     }

Oh yes, the bug is indeed present. That should indeed be fixed.

> So long as new interrupts come in on this register, the base pending
> register will never be re-read.  Still, there could be memory access
> ordering and caching behaviour that I'm completely ignorant of, so I
> could be completely wrong. And it's probably unlikely that interrupts
> come in that fast.
> 
>> This logic doesn't imply that one can't loop reading the
>> PEND1 register.
> 
> No. I just felt that always reading the base pending register and
> processing the short cut interrupts there lent itself to a natural
> interrupt prioritisation.

True. I suppose the shortcuts are indeed there because they're
theoretically higher priority .

>> I'm not sure why a hwirq_xlat table lookup is needed; why not just
>> return the HW IRQ number directly like the existing code?
> 
> Have I managed to cover this elsewhere?

Well, the existing code manages without any kind of lookup table, since
it numbers the banks in the same order as the enable/disable registers,
and hard-codes the bank ID parameter to MAKE_HWIRQ() when handling IRQs.
To my mind, this makes the code a lot simpler...

>>> +static struct irq_chip bmc2835_chip = {
>>> +    .name = "bmc2835-level",
>>> +    .irq_mask = bmc2835_mask_irq,
>>> +    .irq_unmask = bmc2835_unmask_irq,
>>> +    .irq_ack =  bmc2835_mask_irq,
>>> +};
>>
>> Why should an IRQ be masked by the ack operation?
> 
> To be honest, I don't know for sure.  I took my cue from
> Documentation/arm/Interrupts.
> 
> ack    - required.  May be the same function as mask for IRQs
>          handled by do_level_IRQ.
> 
> Some other irq_chips are set up the same way and I can't see any other
> way of implementing an acknowledgement function.  And my experience with
> a never ending flow of interrupts while writing the mailbox driver made
> me think it might be good idea for the BMC2835 as well.

OK, it makes sense to implement that.
