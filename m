From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Wed, 02 Oct 2013 20:25:03 +1300
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <524B7F2C.9080105@wwwdotorg.org>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
 <52410949.8070403@wwwdotorg.org> <52427C15.6010204@yahoo.com.au>
 <524B7F2C.9080105@wwwdotorg.org>
Message-ID: <524BCA4F.1070201@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 03:04 PM, Stephen Warren wrote:
> On 09/25/2013 12:00 AM, Craig McGeachie wrote:
>> On 09/24/2013 03:38 PM, Stephen Warren wrote:
>>>> +#define BAD_IRQ_NUM    -1
>>>
>>> That should be 0; Using -1 for invalid IRQ is deprecated.
>>
>> Could you please point me to something that describes this? I can't find
>> anything that limits the internal representations used by the driver for
>> an interrupt controller.  That, and the design of
>> include/linux/irqdomain.h and kernel/irq/irqdomain.c implies that a
>> 0-based hwirq numbering scheme is the natural order of things.
>
> I suppose there isn't any limitation on the driver-internal
> representation, so this is OK from that perspective. I'd still prefer if
> this constant simply weren't needed, just like it isn't in the current
> code, simply because the entire range of hwirq numbers is valid, so
> there's no need for a sparse lookup table, and hence no concept of an
> invalid ID. The only exception would be if you're trying to align the
> hwirq numbers with that FIQ register, and there truly are some invalid
> values in the FIQ numbering scheme?

No, the FIQ numbering scheme has no invalid values in the range 0 to 71. 
  The field id 7 bits, but the invalid values that you must not write 
are 72 to 127.

The BAD_IRQ_NUM constant and the translation array really came about 
because I was looking for a single mechanism for all special case 
handling.  Together they replace:
  * A special check for the limited number of bits in the base pending
    register.
  * bank_irqs[], which is used only during initialisation.
  * The two different functions, armctrl_handle_shortcut() and
    armctrl_handle_bank() for handling interrupts from the GPU banks.
  * The separation of base pending into three different masks
    (BANK0_HWIRQ_MASK, SHORTCUT1_MASK, SHORTCUT2_MASK)
  * The SHORTCUT_SHIFT required to get a sensible number from the
    shortcut bits in base pending.

Bits 10 to 20 of base pending have no simple relationship to the 
corresponding bits in the GPU pending registers.  The mapping could be 
implemented a piecewise function with a sequence of if statements.  But 
since the domain is small and discrete, a straight forward one to one 
mapping seems easier.  Since the mapping had to be implemented anyway I 
decided to extend it to cover all 32 bits of the 3 registers.  That 
removed the need to have a different range check for the banks when 
reading a DT value.  It removed the need to treat different ranges of 
the base pending bits differently with an if-else statement. It gave the 
free benefit of allowing the DT value for a shortcut to be represented 
by either the GPU bit or the base shortcut bit.

The introduction of the constant just followed on from that. It marks 
which values, in a simple bank_nr * 32  + bit_nr, are invalid.  I chose 
used signed integers for the array, and chose -1, as being a marker 
value that could never be a valid hardware IRQ, since hardware IRQ 
numbers are unsigned int.

Annnd then ... I messed it up entirely.  Quite badly in fact.

In bmc2835_dispatch_irq()
   unsigned int irq = ctrlr.hwirq_xlat[MAKE_HWIRQ(bank, ffs(bits) - 1)];
   if (irq == BAD_IRQ_NUM) {

And in bmc2835_domain_xlate()
   unsigned int bank, hwirq;
   hwirq = ctrlr.hwirq_xlat[MAKE_HWIRQ(bank, intspec[1])];
   if (WARN_ON(hwirq == BAD_IRQ_NUM))

A rather bad mixing up of signed and unsigned.  I had it in my mind that 
I was being very careful about the conversion from signed to unsigned. 
Presumably my fingers didn't get the memo. Amazing what you find when 
checking that you really implemented what you're about to claim ... .

Cheers,
Craig.
