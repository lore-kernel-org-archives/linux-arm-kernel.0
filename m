From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Dec 2010 14:28:14 +0000
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1291817076.28378.28.camel@laptop>
References: <19697.8378.717761.236202@pilspetsen.it.uu.se>
	<19707.34405.791777.298955@pilspetsen.it.uu.se>
	<20101205131702.GE9138@n2100.arm.linux.org.uk>
	<20101205141921.GF9138@n2100.arm.linux.org.uk>
	<19707.47304.977978.297596@pilspetsen.it.uu.se>
	<20101205162151.GH9138@n2100.arm.linux.org.uk>
	<1291812015.28378.24.camel@laptop>
	<20101208125548.GA9777@n2100.arm.linux.org.uk>
	<1291817076.28378.28.camel@laptop>
Message-ID: <20101208142814.GE9777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 03:04:36PM +0100, Peter Zijlstra wrote:
> On Wed, 2010-12-08 at 12:55 +0000, Russell King - ARM Linux wrote:
> > Hmm, you're right.  In which case it's purely down to sched_clock()
> > only being able to cover 4s - which seems to be far too small a gap.
> > 
> > I'm not sure that the unstable sched clock stuff makes much sense to
> > be enabled - we don't have an unstable clock, we just don't have the
> > required number of bits for the scheduler to work correctly.
> 
> We can perhaps make part of the HAVE_UNSTABLE_SCHED_CLOCK depend on SMP
> and only deal with the short wraps (and maybe monotonicity) on UP.
> 
> > Nevertheless, this provides a good way to find this kind of wrap bug.
> > Even with cnt_32_to_63, we still don't get a 64-bit sched_clock(), so
> > this bug will still be there.  Even with a 64-bit clock, the bug will
> > still be there.  It's basically crap code.
> 
> You're referring to the clock_task bit from Venki? Yes that needs
> fixing.

Indeed.

> > Maybe it's better that on ARM, we just don't implement sched_clock()
> > at all?
> 
> If you have a high res clock source that's cheap to read it would be
> better if we can simply fix the infrastructure such that we can make use
> of it.

This is the point.  We don't have high res clock sources that run for
millenium before wrapping.  What we have depends on the platform, and
as this example has found, some platforms have high-res clock sources
but they wrap in as little as 4 seconds.  Other platforms will have
slower clock sources which'll run for longer before wrapping.

Essentially, clock sources on ARM so far have been a 32-bit counter
(if you're lucky) clocked at some rate.

So, what I'm saying is that if wrapping in 4 seconds is a problem,
then maybe we shouldn't be providing sched_clock() at all.

Also, if wrapping below 64-bits is also a problem, again, maybe we
shouldn't be providing it there either.  Eg:

#define TCR2NS_SCALE_FACTOR     10

unsigned long long sched_clock(void)
{
        unsigned long long v = cnt32_to_63(timer_read());
        return (v * tcr2ns_scale) >> TCR2NS_SCALE_FACTOR;
}

has a maximum of 54 bits - and this seems to be the most we can sanely
get from a 32-bit counter.
