From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 6 Jun 2011 12:29:06 +0200
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <20110527120629.GA32617@elte.hu>
References: <BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526122623.GA11875@elte.hu>
	<20110526123137.GG24876@n2100.arm.linux.org.uk>
	<20110526125007.GA27083@elte.hu>
	<BANLkTinUZ7EwN_nBCi_RQ9u8-LBcr_A74g@mail.gmail.com>
	<20110527120629.GA32617@elte.hu>
Message-ID: <20110606102905.GB5820@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> The expectations are to have irqs off (we are holding the runqueue 
> lock if !__ARCH_WANT_INTERRUPTS_ON_CTXSW), so that's not workable i 
> suspect.
> 
> But in theory we could drop the rq lock and restart the scheduler 
> task-pick and balancing sequence when the ARM TLB tag rolls over. So 
> instead of this fragile and assymetric method we'd have a 
> straightforward retry-in-rare-cases method.
> 
> That means some modifications to switch_mm() but should be solvable.
> 
> That would make ARM special only in so far that it's one of the few 
> architectures that signal 'retry task pickup' via switch_mm() - it 
> would use the stock scheduler otherwise and we could remove 
> __ARCH_WANT_INTERRUPTS_ON_CTXSW and perhaps even 
> __ARCH_WANT_UNLOCKED_CTXSW altogether.
> 
> I'd suggest doing this once modern ARM chips get so widespread that 
> you can realistically induce a ~700 usecs irqs-off delays on old, 
> virtual-cache ARM chips. Old chips would likely use old kernels 
> anyway, right?

Not really. Equivalent machines (400g) with new chips do not exist, so
many people are stuck with Sharp Zaurus, and track latest kernels,
because support is actually improving there.

(And yes, I'd like to keep using bluetooth CF card with 16550-style
chip.)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
