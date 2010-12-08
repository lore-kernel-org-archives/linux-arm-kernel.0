From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Dec 2010 15:05:17 +0000
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1291819459.28378.64.camel@laptop>
References: <19707.34405.791777.298955@pilspetsen.it.uu.se>
	<20101205131702.GE9138@n2100.arm.linux.org.uk>
	<20101205141921.GF9138@n2100.arm.linux.org.uk>
	<19707.47304.977978.297596@pilspetsen.it.uu.se>
	<20101205162151.GH9138@n2100.arm.linux.org.uk>
	<1291812015.28378.24.camel@laptop>
	<20101208125548.GA9777@n2100.arm.linux.org.uk>
	<1291817076.28378.28.camel@laptop>
	<20101208142814.GE9777@n2100.arm.linux.org.uk>
	<1291819459.28378.64.camel@laptop>
Message-ID: <20101208150517.GF9777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 03:44:19PM +0100, Peter Zijlstra wrote:
> One of the problems is I think the cycles2ns multiplication of the raw
> clock, that makes dealing with wrap-around lots harder, so I guess we
> should deal with the wrap on the raw clock values and then apply
> cycles2ns on the delta or somesuch. But I expect the clocksource
> infrastructure already has something like that, John?

I've thought about that, but it becomes slightly problematical, as
was shown in one of the examples I provided.  If you do scale by
doing a 64-bit multiply and shift, you're always going to end up
with less than a 64-bit result.

I think your idea makes sense though, but I think for it to be able
to cover the full 64-bit range, we need to do the wraparound handling
after scaling.  So maybe something like the following:

static unsigned long long last_ns, cur_ns;
static unsigned long long max = (max_read_clock() * mult) >> shift;

unsigned long long sched_clock(void)
{
	unsigned long long cyc = read_clock();
	unsigned long long ns = (cyc * mult) >> shift;
	unsigned long long delta;

	spin_lock(&sched_clock_lock);
	delta = last_ns - ns;
	if (ns < last_ns)
		delta += max;

	last_ns = ns;
	ns = cur_ns += delta;
	spin_unlock(&sched_clock_lock);

	return ns;
}
