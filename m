From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 25 Aug 2016 14:54:01 +0100
Subject: [RFC PATCH v3 6/7] arm64: irqflags: Use ICC sysregs to
 implement IRQ masking
In-Reply-To: <684c3744-6a36-be04-03aa-2b1fad692944@linaro.org>
References: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
 <1471623195-7829-7-git-send-email-daniel.thompson@linaro.org>
 <57BACFF6.6060807@arm.com>
 <5eb08d32-1223-55f9-24ac-c1909f62aea9@linaro.org>
 <57BB14FB.3090903@arm.com>
 <684c3744-6a36-be04-03aa-2b1fad692944@linaro.org>
Message-ID: <20160825145401.0576b262@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Aug 2016 14:23:42 +0100
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> On 22/08/16 16:06, Marc Zyngier wrote:
> >>>> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
> >>>> index fc2a0cb47b2c..a4ad69e2831b 100644
> >>>> --- a/arch/arm64/include/asm/arch_gicv3.h
> >>>> +++ b/arch/arm64/include/asm/arch_gicv3.h
> >>>> @@ -80,6 +80,9 @@
> >>>>  #include <linux/stringify.h>
> >>>>  #include <asm/barrier.h>
> >>>>
> >>>> +/* Our default, arbitrary priority value. Linux only uses one anyway. */
> >>>> +#define DEFAULT_PMR_VALUE	0xf0
> >>>> +
> >>>>  /*
> >>>>   * Low-level accessors
> >>>>   *
> >>>> @@ -102,9 +105,35 @@ static inline void gic_write_dir(u32 irq)
> >>>>  static inline u64 gic_read_iar_common(void)
> >>>>  {
> >>>>  	u64 irqstat;
> >>>> +	u64 __maybe_unused daif;
> >>>> +	u64 __maybe_unused pmr;
> >>>> +	u64 __maybe_unused default_pmr_value = DEFAULT_PMR_VALUE;
> >>>>
> >>>> +#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
> >>>>  	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
> >>>>  	dsb(sy);
> >>>> +#else
> >>>> +	/*
> >>>> +	 * The PMR may be configured to mask interrupts when this code is
> >>>> +	 * called, thus in order to acknowledge interrupts we must set the
> >>>> +	 * PMR to its default value before reading from the IAR.
> >>>> +	 *
> >>>> +	 * To do this without taking an interrupt we also ensure the I bit
> >>>> +	 * is set whilst we are interfering with the value of the PMR.
> >>>> +	 */
> >>>> +	asm volatile(
> >>>> +		"mrs	%1, daif\n\t"			     /* save I bit  */
> >>>> +		"msr	daifset, #2\n\t"		     /* set I bit   */
> >>>> +		"mrs_s  %2, " __stringify(ICC_PMR_EL1) "\n\t"/* save PMR    */
> >>>> +		"msr_s	" __stringify(ICC_PMR_EL1) ",%3\n\t" /* set PMR     */
> >>>> +		"mrs_s	%0, " __stringify(ICC_IAR1_EL1) "\n\t" /* ack int   */
> >>>> +		"msr_s  " __stringify(ICC_PMR_EL1) ",%2\n\t" /* restore PMR */
> >>>> +		"isb\n\t"
> >>>> +		"msr	daif, %1"			     /* restore I   */
> >>>> +		: "=r" (irqstat), "=&r" (daif), "=&r" (pmr)
> >>>> +		: "r" (default_pmr_value));  
> >>>
> >>> I'm a bit puzzled by this. Why would you have to mess with PMR or DAIF
> >>> at this stage? Why can't we just let the GIC priority mechanism do its
> >>> thing? I'd expect the initial setting of PMR (indicating whether or not
> >>> we have normal interrupts enabled or not) to be enough to perform the
> >>> filtering.
> >>>
> >>> You may get an NMI while you're already handling an interrupt, but
> >>> that's fair game, and that's not something we should prevent.
> >>>
> >>> What am I missing?  
> >>
> >> This code *always* executes with interrupts masked at the PMR and, when
> >> interrupts are masked in this way, they cannot be acknowledged.
> >>
> >> So to acknowledge the interrupt we must first modify the PMR to unmask
> >> it. If we did that without first ensuring the I-bit is masked we would
> >> end up constantly re-trapping.  
> >
> > Right, I see your problem now. I guess that I had a slightly different
> > view of how to implement it. My own take is that we'd be better off
> > leaving the I bit alone until we reach the point where we've accessed
> > the IAR register (hence making the interrupt active and this particular
> > priority unable to fire:
> >
> > 	irqstat = read_iar();
> > 	clear_i_bit();
> >
> > At that stage, the only interrupt that can fire is an NMI (or nothing at
> > all if we're already handling one). The I bit must also be set again on
> > priority drop (before writing to the EOI register).  
> 
> Relying on intack to raise the priority does sound a lot simpler.
> 
> The forceful mask of PMR inside kernel_entry was so we model, as closely 
> as possible. the way the I-bit is set by hardware when we take a trap.

I think we shouldn't confuse two things:
- an explicit call to local_irq_disable() which should translate in an
  increase of the priority to only allow NMIs,
- an exception taken by the CPU, which should mask interrupts
  completely until you're in a situation where you can safely clear the
  I bit.

> However the update of the PMR can easily be shifted into the enable_nmi 
> macro leaving the interrupt controller (which cannot enable_nmi before 
> calling the handler) to look after itself.
> 
> 
> > This will save you most, if not all, of the faffing with PMR (which
> > requires an ISB/DSB pair on each update to be guaranteed to have an
> > effect, and is a good way to kill your performance).  
> 
> Removing the code is a good thing although I thought the PMR was 
> self-synchronizing (the code used to have barriers all over the shop 
> until Dave Martin pointed that out).

The architecture document seems to suggest otherwise (8.1.6,
Observability of the effects of accesses to the GIC registers),
explicitly calling out that:

"- Architectural execution of a DSB instruction guarantees that
	- The last value written to ICC_PMR_EL1 or GICC_PMR is observed
	  by the associated Redistributor.
[...]
-- Note --
An ISB or other context synchronization operation must precede the DSB
to ensure visibility of System register writes.
----------"

> > Of course, the drawback is that we still cover a large section of code
> > using the I bit, but that'd be a good start.  
> 
> To be honest I think that is forced on us anyway. We cannot know if the 
> IRQ trap is a pseudo-NMI or an IRQ until we read the intack register.

Exactly. This is the only way you can be sure of what you're actually
dealing with (anything else is inherently racy).

> >> Note, we could probably avoid saving the DAIF bits and PMR since they
> >> both have a known state at this stage in gic_handle_irq(). However it
> >> would be such a nasty potential side-effect I think I'd have to refactor
> >> things a bit so the mask/unmask dance doesn't happen in the register
> >> access functions.  
> >
> > Yeah, there is clearly some redundancy here. And to be completely
> > honest, I think you should try to split this series in two parts:
> > - one that implements interrupt masking using PMR
> > - one that takes care of NMIs and possibly backtracing
> >
> > At the moment, things are a bit mixed and it is hard to pinpoint what is
> > really required for what.  
> 
> Well... the patches are already teased out just as you say but the 
> ordering *is* a bit weird now you mention it (patches 3, 4, 5 & 6 do the 
> interrupt masking, whilst 1, 2 and 7 do the NMI).
> 
> Do you think its acceptable to reorder the patch set and put a clear 
> description of the covering letter describing when the code related to 
> NMI starts? I find it hard to see the point of PMR masking without 
> example code to drive it.

I see it under a slightly different light. PMR usage as a replacement
for the I bit shouldn't introduce any change in behaviour, and I'm
eager to get that part right before we start introducing more features.

Of course, we should keep the NMI/backtracing goal in mind, but I'd
rather take one step at a time and plug the PMR infrastructure in place
first.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
