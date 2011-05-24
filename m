From: mingo@elte.hu (Ingo Molnar)
Date: Tue, 24 May 2011 23:39:24 +0200
Subject: [BUG]  "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <1306272750.2497.79.camel@laptop>
References: <1306260792.27474.133.camel@e102391-lin.cambridge.arm.com>
	<1306272750.2497.79.camel@laptop>
Message-ID: <20110524213924.GO27634@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Tue, 2011-05-24 at 19:13 +0100, Marc Zyngier wrote:
> > Peter,
> > 
> > I've experienced all kind of lock-ups on ARM SMP platforms recently, and
> > finally tracked it down to the following patch:
> > 
> > e4a52bcb9a18142d79e231b6733cabdbf2e67c1f [sched: Remove rq->lock from the first half of ttwu()].
> > 
> > Even on moderate load, the machine locks up, often silently, and
> > sometimes with a few messages like:
> > INFO: rcu_preempt_state detected stalls on CPUs/tasks: { 0} (detected by 1, t=12002 jiffies)
> > 
> > Another side effect of this patch is that the load average is always 0,
> > whatever load I throw at the system.
> > 
> > Reverting the sched changes up to that patch (included) gives me a
> > working system again, which happily survives parallel kernel
> > compilations without complaining.
> > 
> > My knowledge of the scheduler being rather limited, I haven't been able
> > to pinpoint the exact problem (though it probably have something to do
> > with __ARCH_WANT_INTERRUPTS_ON_CTXSW being defined on ARM). The enclosed
> > patch somehow papers over the load average problem, but the system ends
> > up locking up anyway:
> 
> Hurm.. I'll try and make x86 use __ARCH_WANT_INTERRUPTS_ON_CTXSW, IIRC
> Ingo once said that that is possible and try to see if I can reproduce.
> No clear ideas atm.

Yes, should be possible to just disable it on x86 - no further tricks needed. 
It's been a long time since i tested that though.

Thanks,

	Ingo
