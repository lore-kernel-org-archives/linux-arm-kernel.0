From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 25 Aug 2011 01:15:25 +0200
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <20110823223518.GI2803@mtj.dyndns.org>
References: <20110823151936.GM9232@opensource.wolfsonmicro.com>
	<CAOS58YNtQEuke=Ko9J2oNGMECjabzxj=Nrg1o64X1JC3YRmJuw@mail.gmail.com>
	<20110823223518.GI2803@mtj.dyndns.org>
Message-ID: <201108250115.25987.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 24, 2011, Tejun Heo wrote:
> On Wed, Aug 24, 2011 at 12:17:03AM +0200, Tejun Heo wrote:
> > if (freezing() && IRQ disabled) {
> >       bust on IRQ;
> >       try_to_freeze();
> >       replug IRQ;
> > }
> > 
> > But, that can't be right. The current code isn't triggering warning
> > from scheduler code, right? If the above is the case, it should be
> > triggering that. What am I missing?
> 
> I think the refrigerator() code was actually doing that through
> spin_[un]lock_irq(), so it was accidentally masking the problem.  It
> definitely seems to need fixing.
> 
> Anyways, for now, we can do two things,
> 
> 1. if (freezing()) { irq_save; try_to_freeze(); irq_restore; } w/ BIG
>    FAT UGLY comment.
> 
> 2. Drop might_sleep() from try_to_freeze().  Moving it to
>    refrigerator() wouldn't help much.  It would just trigger more
>    sporadically during freeze, which is arguably worse than now.
> 
> I'd prefer #1 given that it documents the breakage while also
> restoring the IRQ state afterwards FWIW.

OK, I'm fine with 1.

Thanks,
Rafael
