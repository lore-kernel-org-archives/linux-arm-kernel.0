From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Thu, 26 May 2011 12:02:39 +0100
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <1306405979.1200.63.camel@twins>
References: <1306260792.27474.133.camel@e102391-lin.cambridge.arm.com>
	<1306272750.2497.79.camel@laptop> <1306343335.21578.65.camel@twins>
	<1306358128.21578.107.camel@twins>
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
Message-ID: <1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-26 at 12:32 +0200, Peter Zijlstra wrote:
> On Thu, 2011-05-26 at 15:29 +0800, Yong Zhang wrote:
> > > Figuring out why the existing condition failed
> > 
> > Seems  'current' will change before/after switch_to since it's derived from
> > sp register.
> > So that means if interrupt come before we switch sp, 'p == current' will
> > catch it, but if interrupt comes after we switch sp, we will lose a wake up.
> 
> Well, loosing a wakeup isn't the problem here (although it would be a
> problem), the immediate problem is that we're getting stuck
> (life-locked) in that while (p->on_cpu) loop.
> 
> But yes, I think that explains it, if the interrupts hits
> context_switch() after current was changed but before clearing
> p->on_cpu, we would life-lock in interrupt context.
> 
> Now we could of course go add in_interrupt() checks there, but that
> would make this already fragile path more interesting, so I think I'll
> stick with the proposed patch -- again provided it actually works.
> 
> Marc, any word on that?

The box is currently building kernels in a loop (using -j64...). So far,
so good. Oh, and that fixed the load-average thing as well.

Oh wait (my turn...):
INFO: task gcc:10030 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.

One of my ssh sessions is locking up periodically, and it generally
feels a bit sluggish.

	M.
-- 
Reality is an implementation detail.
