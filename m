From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 1 Sep 2009 22:16:13 +0200
Subject: [RFC/RFT 1/3] iop: clocksource support
In-Reply-To: <63386a3d0908241607t4546b488oa19f43fbbef0ade5@mail.gmail.com>
References: <200908221204.n7MC4t2v029350@pilspetsen.it.uu.se>
	<63386a3d0908241607t4546b488oa19f43fbbef0ade5@mail.gmail.com>
Message-ID: <19101.33037.189854.375398@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij writes:
 > > +/*
 > > + * IOP clocksource (free-running timer 1).
 > > + */
 > > +static cycle_t iop_clocksource_read(struct clocksource *unused)
 > > +{
 > > + ? ? ? return 0xffffffffu - read_tcr1();
 > 
 > So tcr1 counts downwards and wraps around?

Yes. The timers are decrementers that when reaching zero either
halt or reload from another register and continue decrementing,
depending on settings in a mode register.

 > > +static struct clocksource iop_clocksource = {
 > > + ? ? ? .name ? ? ? ? ? = "iop_timer1",
 > > + ? ? ? .rating ? ? ? ? = 300,
 > > + ? ? ? .read ? ? ? ? ? = iop_clocksource_read,
 > > + ? ? ? .mask ? ? ? ? ? = CLOCKSOURCE_MASK(32),
 > > + ? ? ? .shift ? ? ? ? ?= 20, ? /* ??? crude guesstimate */
 > 
 > Calculate this using the algorithm in arch/mips/kernel/time.c
 > they have a dynamically changing clocksource...

Thanks, I've implemented that now. On my n2100 with its 198MHz
timer it computes shift = 29 and mult = 0xa19dbcc4.

The algorithm always computes the largest shift/mult pair that
solves the equation:

	// 0 <= shift && shift <= 32
	u64 mult = ((u64)1E9 << shift) / hz;
	(mult >> 32) == 0

Can I assume that this is to minimize precision loss?

/Mikael
