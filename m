From: hoeun.ryu@lge.com (=?ks_c_5601-1987?B?t/nIo8C6?=)
Date: Fri, 11 May 2018 08:20:49 +0900
Subject: [PATCH] armpmu: broadcast overflow irq on multi-core system
 having one muxed SPI for PMU.
In-Reply-To: <20180510102114.obmctt3nn7xakggi@lakrids.cambridge.arm.com>
References: <1525941385-12766-1-git-send-email-hoeun.ryu@lge.com.com>
 <20180510102114.obmctt3nn7xakggi@lakrids.cambridge.arm.com>
Message-ID: <010c01d3e8b5$8839a480$98aced80$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for the reply.

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Thursday, May 10, 2018 7:21 PM
> To: Hoeun Ryu <hoeun.ryu@lge.com.com>
> Cc: Will Deacon <will.deacon@arm.com>; Hoeun Ryu <hoeun.ryu@lge.com>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH] armpmu: broadcast overflow irq on multi-core system
> having one muxed SPI for PMU.
> 
> Hi,
> On Thu, May 10, 2018 at 05:36:17PM +0900, Hoeun Ryu wrote:
> > From: Hoeun Ryu <hoeun.ryu@lge.com>
> >
> >  On some SoCs like i.MX6DL/QL have only one muxed SPI for multi-core
> system.
> > On the systems, a CPU can be interrupted by overflow irq but it is
> > possible that the overflow actually occurs on another CPU.
> 
> Muxing the PMU IRQs is a really broken system design, and there's no good
> way of supporting it.

Yes. I agree with that. I scratched my head when I found the system has one
muxed SPI.

> 
> What we should do for such systems is:
> 
> * Add a flag to the DT to describe that the IRQs are muxed, as this
>   cannot be probed.
> 
> * Add hrtimer code to periodically update the counters, to avoid
>   overflow (e.g. as we do in the l2x0 PMU).
> 
> * Reject sampling for such systems, as this cannot be done reliably or
>   efficiently.
> 
> NAK to broadcasting the IRQ -- there are a number of issues with the
> general approach.
> 

The second solution would be good if sampling is necessary even like those
systems.

Actually I'm working on FIQ available ARM32 system and trying to enable the
hard lockup detector by routing the PMU IRQ to FIQ.
Because of that, I really need the interrupt event if it is a muxed SPI,
beside I also need to make an dedicated IPI FIQ to broadcast the IRQ in
this approach.
What would you do if you were in the same situation ?

> We should update the PMU probing code to warn when we have fewer IRQs than
> CPUs, and fail gracefully to the above.
> 
> [...]
> 
> >  static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)  {
> 
> > +			/* smp_call_function cannot be called with irq
> disabled */
> > +			local_irq_enable();
> > +			preempt_disable();
> > +			smp_call_function_many(&mask, __armpmu_handle_irq,
dev,
> 0);
> > +			preempt_enable();
> > +			local_irq_disable();
> 
> For many reasons, this sequence is not safe.
> 
> It is not safe to enable IRQs in irq handlers. Please never do this.

I was not sure it was safe to enable IRQs in irq handlers.
Thank you for pointing that.

> 
> Thus it's also never safe to call smp_call_function*() in IRQ handlers.

Yes. I found out that it is due to csd lock.

> 
> Futher, If you ever encounter a case where you need to avoid preemption
> across enabling IRQs, preemption must be disabled *before* enabling IRQs.

Ah, OK.
Enabling IRQs can cause scheduling tasks in the end of exception or other
scheduling points, right ?

> 
> Thanks,
> Mark.
