From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Wed, 08 Dec 2010 13:40:15 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <20101205162151.GH9138@n2100.arm.linux.org.uk>
References: <19697.8378.717761.236202@pilspetsen.it.uu.se>
	<19707.34405.791777.298955@pilspetsen.it.uu.se>
	<20101205131702.GE9138@n2100.arm.linux.org.uk>
	<20101205141921.GF9138@n2100.arm.linux.org.uk>
	<19707.47304.977978.297596@pilspetsen.it.uu.se>
	<20101205162151.GH9138@n2100.arm.linux.org.uk>
Message-ID: <1291812015.28378.24.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-12-05 at 16:21 +0000, Russell King - ARM Linux wrote:

> I'm not sure that's the correct fix - it looks like sched_clock_cpu()
> should already be preventing scheduler clock time going backwards.
> 
> Hmm. IOP32x seems to have a 32-bit timer clocked at 200MHz.  That means
> it wraps once every 21s.  However, we have that converted to ns by an
> unknown multiplier and shift.  It seems that those are chosen to
> guarantee that we will cover only 4s without wrapping in the clocksource
> conversion.  Maybe that's not sufficient?
> 
> Could you try looking into sched_clock_cpu(), sched_clock_local() and
> sched_clock() to see whether anything odd stands out?

# git grep HAVE_UNSTABLE_SCHED_CLOCK arch/arm | wc -l
0

That code won't help if you don't enable it ;-)

John Stultz was also looking into making the kernel/sched_clock.c code
deal with short clocks.
