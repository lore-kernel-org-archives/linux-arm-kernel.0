From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Wed, 02 Oct 2013 21:51:17 +1300
Subject: [PATCH v3] irq: bmc2835: Re-implement the hardware IRQ handler.
In-Reply-To: <524B839D.7060908@wwwdotorg.org>
References: <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
 <1380275858-1289-1-git-send-email-slapdau@yahoo.com.au>
 <524B839D.7060908@wwwdotorg.org>
Message-ID: <524BDE85.6090807@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 03:23 PM, Stephen Warren wrote:
> On 09/27/2013 03:57 AM, Craig McGeachie wrote:

>> Actions taken by interrupt handlers could handle and
>> acknowledge multiple interrupts.  For example, the DMA controller has
>> it's own view of the interrupt status of all channels rather than just
>> the one that the interrupt was dispatched for.  The cost of re-reading
>> is small.  The cost of unnecessary dispatches is large.
>
> DMA is only one interrupt at the top-level, I believe; the multiple
> interrupt sources are sub-interrupts within the DMA controller. Naively,
> I'd expect it to be very unlikely that one top-level IRQ handler
> directly caused an unrelated top-level IRQ status to clear, although I'm
> sure someone can come up with some exceptions:-)

No.  It has 14 interrupts at the top level.  16..28,31 in the FIQ 
numbering scheme.  And <1 16> to <1 28>, <1 31> in the device tree 
numbering scheme.  Those 14 interrupts service 16 DMA channels.  Simon 
Arlott has identified a mapping of DMA channel to interrupt [1] which is 
surprising in that DMA channels 11 to 14 map onto interrupts <1 27> and 
<1 28> in a way which I can't see any obvious rationale for.

The iomem register 0x7E007fe0 is r/w for bits 15:0.  Each bit is the 
interrupt status for the corresponding DMA engine.  Bit 0 is DMA engine 
0, bit 15 is DMA engine, and so on. The way that I read this is that 
reading a set bit indicates a pending interrupt, and writing a clear bit 
acknowledges the interrupt, which should clear the appropriate pending 
status bit in interrupt controller.  The only example I know of that 
might provide some insight is the sdhci-bcm2708.c driver from
https://github.com/raspberrypi/linux.  I haven't read it yet.

Information on DMA channels and hardware interrupts is scarce.  Neither 
of two drivers at https://github.com/raspberrypi/linux offers any clues.

Given a DMA driver the works within the DMA engine framework, I can't 
see why the driver wouldn't read all the status bits from 0x7E007fe0 and 
simply handle all pending interrupts after being invoked to handle one.

>> Reorder the internal numbering of interrupt banks so that hardware IRQ
>> numbers range from 0 to 71, and match the natural numbering implied by
>> the FIQ source register.  This is in anticipation of being to implement
>> a viable mechanism for registering one of the available interrupts as a
>> fast interrupt.  Preferably based on device tree configuration.
>
> DT shouldn't specify whether an interrupt should be handled as
> FIQ-vs-non-FIQ, since that's a SW configuration issue, rather than a
> pure HW description.

Only one of the 72 interrupts could be FIQ.  I was about to write that I 
could not see a reasonable scheme for co-ordinating which one of these 
was mapped, but I might just have thought of something.  This is a rough 
idea, and hinges on more understanding of the flow of control for FIQ 
handling.

It would rely on using the translation table, even though I know you're 
not that taken with it.  Because the table runs up to 95, but has no 
valid mappings for 84 to 95, call init_FIQ() with 84 (I may be off by 
one or two here - I've not checked).  When configuring an FIQ, mask the 
normal IRQ bit, map 84 to the IRQ number, write the IRQ number to the 
FIQ selection register.  Reverse the steps to unconfigure.  The 
configuration could be dynamic and based on either module parameters or 
sysfs operations.

But this is a bit of a wild assed guess.  I don't know the processing 
flow for FIQ so I don't know how the hardware IRQ numbers are assigned, 
and if the flow of control passes a point where the mapping could be 
performed.

>> Enable device tree interrupt specifications to identify interrupts with
>> shortcut bits in the base register by either the shortcut bit, or the
>> canonical GPU register bit.   E.g. UART can be either <0, 19> or <2,
>> 25>.
>
> Hmmm. Is there a benefit to allowing that? One defined way feels better
> than multiple ways of specifying the same thing.

It's a reasonable question.  I thought so, but I couldn't defend that 
position.  My vague thought was that someone might find documentation 
about the interrupts from different sources. But given that anyone 
working in this area is going to need a minimum level of knowledge about 
interrupts, it's fair to expect them to work with a single canonical 
numbering. It was a natural fall out from using the translation table, 
which I liked and I don't think does any great harm.


Cheers,
Craig.

[1] 
https://github.com/lp0/linux/blob/rpi-dma-hack/arch/arm/boot/dts/bcm2835.dtsi
