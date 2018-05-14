From: hoeun.ryu@lge.com (Hoeun Ryu)
Date: Mon, 14 May 2018 11:26:30 +0900
Subject: [PATCH] armpmu: broadcast overflow irq on multi-core system
 having one muxed SPI for PMU.
In-Reply-To: <20180511103901.osi5lckq55jrms64@lakrids.cambridge.arm.com>
References: <1525941385-12766-1-git-send-email-hoeun.ryu@lge.com.com>
 <20180510102114.obmctt3nn7xakggi@lakrids.cambridge.arm.com>
 <010c01d3e8b5$8839a480$98aced80$@lge.com>
 <20180511103901.osi5lckq55jrms64@lakrids.cambridge.arm.com>
Message-ID: <014701d3eb2a$f8211db0$e8635910$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for the review.
I understand your NACK.

But I'd like to just fix the part of smp_call_function() in the next version.
You can simply ignore it.

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Friday, May 11, 2018 7:39 PM
> To: ????? <hoeun.ryu@lge.com>
> Cc: 'Hoeun Ryu' <hoeun.ryu@lge.com.com>; 'Will Deacon'
> <will.deacon@arm.com>; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH] armpmu: broadcast overflow irq on multi-core system
> having one muxed SPI for PMU.
> 
> On Fri, May 11, 2018 at 08:20:49AM +0900, ????? wrote:
> > Thank you for the reply.
> >
> > > -----Original Message-----
> > > From: Mark Rutland [mailto:mark.rutland at arm.com]
> > > Sent: Thursday, May 10, 2018 7:21 PM
> > > To: Hoeun Ryu <hoeun.ryu@lge.com.com>
> > > Cc: Will Deacon <will.deacon@arm.com>; Hoeun Ryu <hoeun.ryu@lge.com>;
> > > linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> > > Subject: Re: [PATCH] armpmu: broadcast overflow irq on multi-core
> system
> > > having one muxed SPI for PMU.
> 
> > > Muxing the PMU IRQs is a really broken system design, and there's no
> good
> > > way of supporting it.
> 
> > > What we should do for such systems is:
> > >
> > > * Add a flag to the DT to describe that the IRQs are muxed, as this
> > >   cannot be probed.
> > >
> > > * Add hrtimer code to periodically update the counters, to avoid
> > >   overflow (e.g. as we do in the l2x0 PMU).
> > >
> > > * Reject sampling for such systems, as this cannot be done reliably or
> > >   efficiently.
> > >
> > > NAK to broadcasting the IRQ -- there are a number of issues with the
> > > general approach.
> >
> > The second solution would be good if sampling is necessary even like
> those
> > systems.
> 
> Please note that I mean *all* of the above. There would be no sampling
> on systems with muxed PMU IRQs, since there's no correlation between
> overflow events and the hrtimer interrupts -- the results of sampling
> would be misleading.
> 
> > Actually I'm working on FIQ available ARM32 system and trying to enable
> the
> > hard lockup detector by routing the PMU IRQ to FIQ.
> > Because of that, I really need the interrupt event if it is a muxed SPI,
> > beside I also need to make an dedicated IPI FIQ to broadcast the IRQ in
> > this approach.
> > What would you do if you were in the same situation ?
> 
> I don't think that this can work with a muxed IRQ, sorry.
> 
> It would be better to use some kind of timer.
> 
> [...]
> 
> > > Futher, If you ever encounter a case where you need to avoid
> preemption
> > > across enabling IRQs, preemption must be disabled *before* enabling
> IRQs.
> >
> > Ah, OK.
> > Enabling IRQs can cause scheduling tasks in the end of exception or
> other
> > scheduling points, right ?
> 
> Yes. If an IRQ was taken *between* enabling IRQs and disabling
> preemption, preemption may occur as part of the exception return.
> 
> Thanks,
> Mark.
