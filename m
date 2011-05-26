From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 26 May 2011 12:32:59 +0200
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
References: <1306260792.27474.133.camel@e102391-lin.cambridge.arm.com>
	<1306272750.2497.79.camel@laptop> <1306343335.21578.65.camel@twins>
	<1306358128.21578.107.camel@twins>
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
Message-ID: <1306405979.1200.63.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-26 at 15:29 +0800, Yong Zhang wrote:
> > Figuring out why the existing condition failed
> 
> Seems  'current' will change before/after switch_to since it's derived from
> sp register.
> So that means if interrupt come before we switch sp, 'p == current' will
> catch it, but if interrupt comes after we switch sp, we will lose a wake up.

Well, loosing a wakeup isn't the problem here (although it would be a
problem), the immediate problem is that we're getting stuck
(life-locked) in that while (p->on_cpu) loop.

But yes, I think that explains it, if the interrupts hits
context_switch() after current was changed but before clearing
p->on_cpu, we would life-lock in interrupt context.

Now we could of course go add in_interrupt() checks there, but that
would make this already fragile path more interesting, so I think I'll
stick with the proposed patch -- again provided it actually works.

Marc, any word on that?
