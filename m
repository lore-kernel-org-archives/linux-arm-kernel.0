From: mingo@elte.hu (Ingo Molnar)
Date: Fri, 27 May 2011 14:06:29 +0200
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <BANLkTinUZ7EwN_nBCi_RQ9u8-LBcr_A74g@mail.gmail.com>
References: <1306358128.21578.107.camel@twins>
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526122623.GA11875@elte.hu>
	<20110526123137.GG24876@n2100.arm.linux.org.uk>
	<20110526125007.GA27083@elte.hu>
	<BANLkTinUZ7EwN_nBCi_RQ9u8-LBcr_A74g@mail.gmail.com>
Message-ID: <20110527120629.GA32617@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Catalin Marinas <catalin.marinas@arm.com> wrote:

> > How much time does that take on contemporary ARM hardware, 
> > typically (and worst-case)?
> 
> On newer ARMv6 and ARMv7 hardware, we no longer flush the caches at 
> context switch as we got VIPT (or PIPT-like) caches.
> 
> But modern ARM processors use something called ASID to tag the TLB 
> entries and we are limited to 256. The switch_mm() code checks for 
> whether we ran out of them to restart the counting. This ASID 
> roll-over event needs to be broadcast to the other CPUs and issuing 
> IPIs with the IRQs disabled isn't always safe. Of course, we could 
> briefly re-enable them at the ASID roll-over time but I'm not sure 
> what the expectations of the code calling switch_mm() are.

The expectations are to have irqs off (we are holding the runqueue 
lock if !__ARCH_WANT_INTERRUPTS_ON_CTXSW), so that's not workable i 
suspect.

But in theory we could drop the rq lock and restart the scheduler 
task-pick and balancing sequence when the ARM TLB tag rolls over. So 
instead of this fragile and assymetric method we'd have a 
straightforward retry-in-rare-cases method.

That means some modifications to switch_mm() but should be solvable.

That would make ARM special only in so far that it's one of the few 
architectures that signal 'retry task pickup' via switch_mm() - it 
would use the stock scheduler otherwise and we could remove 
__ARCH_WANT_INTERRUPTS_ON_CTXSW and perhaps even 
__ARCH_WANT_UNLOCKED_CTXSW altogether.

I'd suggest doing this once modern ARM chips get so widespread that 
you can realistically induce a ~700 usecs irqs-off delays on old, 
virtual-cache ARM chips. Old chips would likely use old kernels 
anyway, right?

Thanks,

	Ingo
