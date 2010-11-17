From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 17 Nov 2010 10:26:53 +0100
Subject: [PATCH] nomadik: prevent sched_clock() wraparound
In-Reply-To: <AANLkTi=pa+oa3GXr5vfBtdrfnHpRc_2cwgBYQLJRvYXM@mail.gmail.com>
References: <1289898690-29910-1-git-send-email-linus.walleij@stericsson.com>
	<1289940829.3860.22.camel@localhost.localdomain>
	<AANLkTimvyo-2eHrvU=LNdBjrJfAxv9Jpza8Mh4iG4ts6@mail.gmail.com>
	<20101116223116.GG21926@n2100.arm.linux.org.uk>
	<AANLkTi=pa+oa3GXr5vfBtdrfnHpRc_2cwgBYQLJRvYXM@mail.gmail.com>
Message-ID: <AANLkTi=fespqykXjvgqGusp-4omT0sfUA8Aj4OnT-LNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/17 Linus Walleij <linus.ml.walleij@gmail.com>:

> Hm! Then in this code in plat-orion/timer.c:
>
> #define TCLK2NS_SCALE_FACTOR 8
> static unsigned long tclk2ns_scale;
>
> unsigned long long sched_clock(void)
> {
> ? ? ? ?unsigned long long v = cnt32_to_63(0xffffffff - readl(TIMER0_VAL));
> ? ? ? ?return (v * tclk2ns_scale) >> TCLK2NS_SCALE_FACTOR;
> }

Looking at this again it seems the Orion is implicitly
loosing bits - so this code will work and multiply out some of the
63 bits so it just wraps around earlier.

Would be nice to have these kind of things explicit though,
it's a bit hard to determine when this counter will wrap.

Linus Walleij
