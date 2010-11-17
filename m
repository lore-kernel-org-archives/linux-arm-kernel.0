From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 17 Nov 2010 10:04:00 -0500 (EST)
Subject: [PATCH] nomadik: prevent sched_clock() wraparound
In-Reply-To: <AANLkTi=fespqykXjvgqGusp-4omT0sfUA8Aj4OnT-LNg@mail.gmail.com>
References: <1289898690-29910-1-git-send-email-linus.walleij@stericsson.com>
	<1289940829.3860.22.camel@localhost.localdomain>
	<AANLkTimvyo-2eHrvU=LNdBjrJfAxv9Jpza8Mh4iG4ts6@mail.gmail.com>
	<20101116223116.GG21926@n2100.arm.linux.org.uk>
	<AANLkTi=pa+oa3GXr5vfBtdrfnHpRc_2cwgBYQLJRvYXM@mail.gmail.com>
	<AANLkTi=fespqykXjvgqGusp-4omT0sfUA8Aj4OnT-LNg@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1011170957340.6448@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Nov 2010, Linus Walleij wrote:

> 2010/11/17 Linus Walleij <linus.ml.walleij@gmail.com>:
> 
> > Hm! Then in this code in plat-orion/timer.c:
> >
> > #define TCLK2NS_SCALE_FACTOR 8
> > static unsigned long tclk2ns_scale;
> >
> > unsigned long long sched_clock(void)
> > {
> > ? ? ? ?unsigned long long v = cnt32_to_63(0xffffffff - readl(TIMER0_VAL));
> > ? ? ? ?return (v * tclk2ns_scale) >> TCLK2NS_SCALE_FACTOR;
> > }
> 
> Looking at this again it seems the Orion is implicitly
> loosing bits - so this code will work and multiply out some of the
> 63 bits so it just wraps around earlier.

Exact.  And that's what the comment above it says:

 * Orion's sched_clock implementation. It has a resolution of
 * at least 7.5ns (133MHz TCLK) and a maximum value of 834 days.

The 834 days comes from the fact that the final shift preserves only 56 
bits from the result.

On PXA this is even worse:

 * This is PXA's sched_clock implementation. This has a resolution
 * of at least 308 ns and a maximum value of 208 days.

But again, in the context of sched_clock() this is fine.  We want 
sched_clock() to be fast, and having a glitch during that jiffy when the 
clock wraps back every 208 days is perfectly reasonable.

> Would be nice to have these kind of things explicit though,
> it's a bit hard to determine when this counter will wrap.

It is all commented, at least in those implementations I've written 
myself.


Nicolas
