From: johnstul@us.ibm.com (john stultz)
Date: Wed, 08 Dec 2010 12:42:21 -0800
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1291819459.28378.64.camel@laptop>
References: <19697.8378.717761.236202@pilspetsen.it.uu.se>
	<19707.34405.791777.298955@pilspetsen.it.uu.se>
	<20101205131702.GE9138@n2100.arm.linux.org.uk>
	<20101205141921.GF9138@n2100.arm.linux.org.uk>
	<19707.47304.977978.297596@pilspetsen.it.uu.se>
	<20101205162151.GH9138@n2100.arm.linux.org.uk>
	<1291812015.28378.24.camel@laptop>
	<20101208125548.GA9777@n2100.arm.linux.org.uk>
	<1291817076.28378.28.camel@laptop>
	<20101208142814.GE9777@n2100.arm.linux.org.uk>
	<1291819459.28378.64.camel@laptop>
Message-ID: <1291840941.2909.40.camel@work-vm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-12-08 at 15:44 +0100, Peter Zijlstra wrote:
> On Wed, 2010-12-08 at 14:28 +0000, Russell King - ARM Linux wrote:
> > So, what I'm saying is that if wrapping in 4 seconds is a problem,
> > then maybe we shouldn't be providing sched_clock() at all.
> 
> 4 seconds should be perfectly fine, we call it at least every scheduler
> tick (HZ) and NO_HZ will either have to limit the max sleep period or
> provide its own sleep duration (using a more expensive clock) so we can
> recover (much like GTOD already requires).
> 
> > Also, if wrapping below 64-bits is also a problem, again, maybe we
> > shouldn't be providing it there either.  Eg:
> 
> That's mostly due to hysterical raisins and we should just fix that, the
> simplest way is to use something like kernel/sched_clock.c to use
> sched_clock() deltas to make a running u64 value.
> 
> Like said, John Stultz was already looking at doing something like that
> because there's a number of architectures suffering this same problem
> and they're all already using part of the clocksource infrastructure to
> implement the sched_clock() interface simply because they only have a
> single hardware resource.

I'm not actively working on it right now, but trying to rework the
sched_clock code so its more like the generic timekeeping code is on my
list (I'm Looking to see if I can bump it up to the front in the near
future).

thanks
-john
