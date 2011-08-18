From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Aug 2011 16:40:48 +0100
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <201108181734.25397.arnd@arndb.de>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
	<201108181734.25397.arnd@arndb.de>
Message-ID: <20110818154048.GD21865@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2011 at 05:34:25PM +0200, Arnd Bergmann wrote:
> On Tuesday 16 August 2011, Rob Herring wrote:
> > +static void __init highbank_timer_init(void)
> > +{
> > +	int irq;
> > +	struct device_node *np;
> > +	void __iomem *timer_base;
> > +
> > +	/* Map system registers */
> > +	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
> > +	sregs_base = of_iomap(np, 0);
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "arm,sp804");
> > +	timer_base = of_iomap(np, 0);
> > +	irq = irq_of_parse_and_map(np, 0);
> > +
> > +	highbank_clocks_init();
> > +
> > +	sp804_clocksource_init(timer_base + 0x20, "timer1");
> > +	sp804_clockevents_init(timer_base, irq, "timer0");
> > +}
> 
> How about moving the sp804 initialization from device tree into the
> arch/arm/common/timer-sp.c file?
> 
> Why do you initialize sregs_base from timer_init?

That'd create special cases - ARM platforms need registers twiddled to
change the clock rate for the timers from 32kHz to a more sensible 1MHz.

> > diff --git a/arch/arm/mach-highbank/include/mach/timex.h b/arch/arm/mach-highbank/include/mach/timex.h
> > new file mode 100644
> > index 0000000..88dac7a
> > --- /dev/null
> > +++ b/arch/arm/mach-highbank/include/mach/timex.h
> > @@ -0,0 +1,6 @@
> > +#ifndef __MACH_TIMEX_H
> > +#define __MACH_TIMEX_H
> > +
> > +#define CLOCK_TICK_RATE		1000000
> > +
> > +#endif
> 
> In 3.2, we shouldn't need this any more. We'll have to come up with a
> way to remember removing the new definitions that come in in parallel
> to the patch that removes the old ones.

Has anyone really properly evaluated the CLOCK_TICK_RATE issues on things
like NTP etc?  I have problems with kernels on OMAP4 constantly jumping
forwards/back by .5sec when NTP is running which suggests that there's
something not quite right _somewhere_.

Given that OMAP uses an untrue value for this, and the platforms I have
which _do_ behave properly when running NTP have correct values, I _still_
remain entirely unconvinced about the claims surrounding CLOCK_TICK_RATE
not mattering.

Has anyone managed to run NTP on OMAP4 and had it sync successfully over
a few days?
