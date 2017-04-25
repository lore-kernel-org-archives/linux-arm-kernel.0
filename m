From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 25 Apr 2017 11:49:27 +0200
Subject: [PATCH V9 1/3] irq: Allow to pass the IRQF_TIMER flag with
 percpu irq request
In-Reply-To: <f840e9d2-8aac-dc1d-6468-44f7658b55b1@arm.com>
References: <1493042494-14057-1-git-send-email-daniel.lezcano@linaro.org>
 <398f3f3d-c567-0f1f-1a43-9b8d5805d5fd@arm.com>
 <20170424185909.GD2137@mai>
 <92e2a022-93d4-d4f3-78af-c9b5d51bb867@arm.com>
 <20170424195948.GE2137@mai>
 <16042494-2e67-e1a5-b9f6-af57e349d8a7@arm.com>
 <20170425083451.GA16888@mai>
 <f840e9d2-8aac-dc1d-6468-44f7658b55b1@arm.com>
Message-ID: <20170425094927.GB16888@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 10:10:12AM +0100, Marc Zyngier wrote:

[?... ]

> >>>> Maybe you could explain why you think this interrupt is relevant to what
> >>>> you're trying to achieve?
> >>>
> >>> If this interrupt does not happen on the host, we don't care.
> >>
> >> All interrupts happen on the host. There is no such thing as a HW 
> >> interrupt being directly delivered to a guest (at least so far). The 
> >> timer is under control of the guest, which uses as it sees fit. When 
> >> the HW timer expires, the interrupt fires on the host, which re-inject 
> >> the interrupt in the guest.
> > 
> > Ah, thanks for the clarification. Interesting.
> > 
> > How can the host know which guest to re-inject the interrupt?
> 
> The timer can only fire when the vcpu is running. If it is not running,
> a software timer is queued, with a pointer to the vcpu struct.

I see, thanks.

> >>> The flag IRQF_TIMER is used by the spurious irq handler in the try_one_irq()
> >>> function. However the per cpu timer interrupt will be discarded in the function
> >>> before because it is per cpu.
> >>
> >> Right. That's not because this is a timer, but because it is per-cpu. 
> >> So why do we need this IRQF_TIMER flag, instead of fixing try_one_irq()?
> > 
> > When a timer is not per cpu, (eg. request_irq), we need this flag, no?
> 
> Sure, but in this series, they all seem to be per-cpu.

I think I was unclear. We need to tag an interrupt with IRQS_TIMINGS to record
their occurences but discarding the timers interrupt. That is done by checking
against IRQF_TIMER when setting up an interrupt.

request_irq() has a flag parameter which has IRQF_TIMER set in case of the
timers. request_percpu_irq has no flag parameter, so it is not possible to
discard these interrupts as the IRQS_TIMINGS will be set.

I don't understand how this is related to the the try_one_irq() fix you are
proposing. Am I missing something?

Regarding your description below, the host has no control at all on the virtual
timer and is not able to know the next expiration time, so I don't see the
point to add the IRQF_TIMER flag to the virtual timer.

I will resend a new version without this change on the virtual timer.

> >>> IMO, for consistency reason, adding the IRQF_TIMER makes sense. Other than
> >>> that, as the interrupt is not happening on the host, this flag won't be used.
> >>>
> >>> Do you want to drop this change?
> >>
> >> No, I'd like to understand the above. Why isn't the following patch 
> >> doing the right thing?
> > 
> > Actually, the explanation is in the next patch of the series (2/3)
> > 
> > [ ... ]
> > 
> > +static inline void setup_timings(struct irq_desc *desc, struct irqaction *act)
> > +{
> > +	/*
> > +	 * We don't need the measurement because the idle code already
> > +	 * knows the next expiry event.
> > +	 */
> > +	if (act->flags & __IRQF_TIMER)
> > +		return;
> 
> And that's where this is really wrong for the KVM guest timer. As I
> said, this timer is under complete control of the guest, and the rest of
> the system doesn't know about it. KVM itself will only find out when the
> vcpu does a VM exit for a reason or another, and will just save/restore
> the state in order to be able to give the timer to another guest.
> 
> The idle code is very much *not* aware of anything concerning that guest
> timer.

Just for my own curiosity, if there are two VM (VM1 and VM2). VM1 sets a timer1
at <time> and exits, VM2 runs and sets a timer2 at <time+delta>.

The timer1 for VM1 is supposed to expire while VM2 is running. IIUC the virtual
timer is under control of VM2 and will expire at <time+delta>.

Is the host wake up with the SW timer and switch in VM1 which in turn restores
the timer and jump in the virtual timer irq handler?
 
> > +
> > +	desc->istate |= IRQS_TIMINGS;
> > +}
> > 
> > [ ... ]
> > 
> > +/*
> > + * The function record_irq_time is only called in one place in the
> > + * interrupts handler. We want this function always inline so the code
> > + * inside is embedded in the function and the static key branching
> > + * code can act at the higher level. Without the explicit
> > + * __always_inline we can end up with a function call and a small
> > + * overhead in the hotpath for nothing.
> > + */
> > +static __always_inline void record_irq_time(struct irq_desc *desc)
> > +{
> > +	if (!static_branch_likely(&irq_timing_enabled))
> > +		return;
> > +
> > +	if (desc->istate & IRQS_TIMINGS) {
> > +		struct irq_timings *timings = this_cpu_ptr(&irq_timings);
> > +
> > +		timings->values[timings->count & IRQ_TIMINGS_MASK] =
> > +			irq_timing_encode(local_clock(),
> > +					  irq_desc_get_irq(desc));
> > +
> > +		timings->count++;
> > +	}
> > +}
> > 
> > [ ... ]
> > 
> > The purpose is to predict the next event interrupts on the system which are
> > source of wake up. For now, this patchset is focused on interrupts (discarding
> > timer interrupts).
> > 
> > The following article gives more details: https://lwn.net/Articles/673641/
> > 
> > When the interrupt is setup, we tag it except if it is a timer. So with this
> > patch there is another usage of the IRQF_TIMER where we will be ignoring
> > interrupt coming from a timer.
> > 
> > As the timer interrupt is delivered to the host, we should not measure it as it
> > is a timer and set this flag.
> > 
> > The needed information is: "what is the earliest VM timer?". If this
> > information is already available then there is nothing more to do, otherwise we
> > should add it in the future.
> 
> This information is not readily available. You can only find it when it
> is too late (timer has already fired) or when it is not relevant anymore
> (guest is sleeping and we've queued a SW timer for it).
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
