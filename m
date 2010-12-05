From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 5 Dec 2010 16:21:51 +0000
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <19707.47304.977978.297596@pilspetsen.it.uu.se>
References: <19697.8378.717761.236202@pilspetsen.it.uu.se>
	<19707.34405.791777.298955@pilspetsen.it.uu.se>
	<20101205131702.GE9138@n2100.arm.linux.org.uk>
	<20101205141921.GF9138@n2100.arm.linux.org.uk>
	<19707.47304.977978.297596@pilspetsen.it.uu.se>
Message-ID: <20101205162151.GH9138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 05, 2010 at 05:07:36PM +0100, Mikael Pettersson wrote:
> I ran two tests on my iop32x machine:
> 
> 1. Made the above-mentioned assignment to rq->clock_task unconditional.
>    That cured the interactivity regressions.
> 
> 2. Restored the conditional assignment to rq->clock_task and disabled the
>    platform-specific sched_clock() so the kernel used the generic one.
>    That too cured the interactivity regressions.
> 
> I then repeated these tests on my ixp4xx machine, with the same results.
> 
> I'll try to come up with a fix for the ixp4xx and plat-iop 32-bit
> sched_clock()s.

I'm not sure that's the correct fix - it looks like sched_clock_cpu()
should already be preventing scheduler clock time going backwards.

Hmm. IOP32x seems to have a 32-bit timer clocked at 200MHz.  That means
it wraps once every 21s.  However, we have that converted to ns by an
unknown multiplier and shift.  It seems that those are chosen to
guarantee that we will cover only 4s without wrapping in the clocksource
conversion.  Maybe that's not sufficient?

Could you try looking into sched_clock_cpu(), sched_clock_local() and
sched_clock() to see whether anything odd stands out?
