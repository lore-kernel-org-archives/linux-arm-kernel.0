From: ralf@linux-mips.org (Ralf Baechle)
Date: Wed, 2 Sep 2009 16:15:37 +0100
Subject: [RFC/RFT 1/3] iop: clocksource support
In-Reply-To: <63386a3d0909011448k6f221118k81cc7d993c65ac20@mail.gmail.com>
References: <200908221204.n7MC4t2v029350@pilspetsen.it.uu.se>
	<63386a3d0908241607t4546b488oa19f43fbbef0ade5@mail.gmail.com>
	<19101.33037.189854.375398@pilspetsen.it.uu.se>
	<63386a3d0909011448k6f221118k81cc7d993c65ac20@mail.gmail.com>
Message-ID: <20090902151537.GA12951@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 01, 2009 at 11:48:57PM +0200, Linus Walleij wrote:

> > ?> Calculate this using the algorithm in arch/mips/kernel/time.c
> > ?> they have a dynamically changing clocksource...
> >
> > The algorithm always computes the largest shift/mult pair that
> > solves the equation:
> >
> > ? ? ? ?// 0 <= shift && shift <= 32
> > ? ? ? ?u64 mult = ((u64)1E9 << shift) / hz;
> > ? ? ? ?(mult >> 32) == 0
> >
> > Can I assume that this is to minimize precision loss?
> 
> So I think, I asked the question of how to calculate div but noone
> answered IIRC, then I found the MIPS code and it contained this
> clue. Ralf Baechle from the MIPS camp wrote this code so lets
> ask him.

The code you're talking about is in arch/mips/kernel/time.c:

[...]
void __init clocksource_set_clock(struct clocksource *cs, unsigned int clock)
{
	u64 temp;
	u32 shift;

	/* Find a shift value */
	for (shift = 32; shift > 0; shift--) {
		temp = (u64) NSEC_PER_SEC << shift;
		do_div(temp, clock);
		if ((temp >> 32) == 0)
			break;
	}
	cs->shift = shift;
	cs->mult = (u32) temp;
}

void __cpuinit clockevent_set_clock(struct clock_event_device *cd,
	unsigned int clock)
{
	u64 temp;
	u32 shift;

	/* Find a shift value */
	for (shift = 32; shift > 0; shift--) {
		temp = (u64) clock << shift;
		do_div(temp, NSEC_PER_SEC);
		if ((temp >> 32) == 0)
			break;
	}
	cd->shift = shift;
	cd->mult = (u32) temp;
}
[...]

The algorithm tries to minimize the loss of precision.  Like two years ago
I had already agreed with Thomas Gleixner to move this function into
generic code but somehow that never happened.

  Ralf
