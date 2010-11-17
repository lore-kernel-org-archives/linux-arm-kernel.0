From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 17 Nov 2010 09:34:56 +0100
Subject: [PATCH] nomadik: prevent sched_clock() wraparound
In-Reply-To: <20101116223116.GG21926@n2100.arm.linux.org.uk>
References: <1289898690-29910-1-git-send-email-linus.walleij@stericsson.com>
	<1289940829.3860.22.camel@localhost.localdomain>
	<AANLkTimvyo-2eHrvU=LNdBjrJfAxv9Jpza8Mh4iG4ts6@mail.gmail.com>
	<20101116223116.GG21926@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=pa+oa3GXr5vfBtdrfnHpRc_2cwgBYQLJRvYXM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/16 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Nov 16, 2010 at 11:15:02PM +0100, Linus Walleij wrote:

>> + ? ? /* The highest bit is not valid */
>> + ? ? v &= 0x7FFFFFFFFFFFFFFFLLU;
>> + ? ? return clocksource_cyc2ns(v, nmdk_clksrc.mult, nmdk_clksrc.shift);
>
> v is 63-bit. ?Any multiply greater than two will result in an overflow,
> which means the best you can achieve with this is basically a divide by
> a power of two. ?So you've lost accuracy in the factor conversion.

Hm! Then in this code in plat-orion/timer.c:

#define TCLK2NS_SCALE_FACTOR 8
static unsigned long tclk2ns_scale;

unsigned long long sched_clock(void)
{
        unsigned long long v = cnt32_to_63(0xffffffff - readl(TIMER0_VAL));
        return (v * tclk2ns_scale) >> TCLK2NS_SCALE_FACTOR;
}

This is some basic mult and shift with new names. But tclk2ns_scale
cannot be greater than 2, still it's calculated like this:

unsigned long long v;
unsigned long data;

v = NSEC_PER_SEC;
v <<= TCLK2NS_SCALE_FACTOR;
v += tclk/2;
do_div(v, tclk);
/*
 * We want an even value to automatically clear the top bit
 * returned by cnt32_to_63() without an additional run time
 * instruction. So if the LSB is 1 then round it up.
 */
if (v & 1)
        v++;
tclk2ns_scale = v;

Seems like it will never fly for long, the long long will overflow
pretty soon, though later than@th 32bit boundary.

And the Tegra code in mach-tegra/timer.c:

static cycle_t tegra_clocksource_read(struct clocksource *cs)
{
        return cnt32_to_63(timer_readl(TIMERUS_CNTR_1US));
}

This just won't fly for long either, the mult for the clocksource is
usually something in the order of 20.

The right way is likely to shift *first* and *then* multiply to get
the proper lossy conversion.

> I think you have a trade-off to make here, between time between wraps
> and conversion accuracy.

Yeah I'll make a try. Looking at the above code it seems we have
some cleanup to do once I settle on something.

Linus Walleij
