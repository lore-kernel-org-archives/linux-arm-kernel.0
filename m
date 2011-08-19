From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Aug 2011 16:11:35 +0200
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <20110818154048.GD21865@n2100.arm.linux.org.uk>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<201108181734.25397.arnd@arndb.de>
	<20110818154048.GD21865@n2100.arm.linux.org.uk>
Message-ID: <201108191611.36147.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 August 2011, Russell King - ARM Linux wrote:
> On Thu, Aug 18, 2011 at 05:34:25PM +0200, Arnd Bergmann wrote:
> > On Tuesday 16 August 2011, Rob Herring wrote:
> > > +static void __init highbank_timer_init(void)
> > > +{
> > > +   int irq;
> > > +   struct device_node *np;
> > > +   void __iomem *timer_base;
> > > +
> > > +   /* Map system registers */
> > > +   np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
> > > +   sregs_base = of_iomap(np, 0);
> > > +
> > > +   np = of_find_compatible_node(NULL, NULL, "arm,sp804");
> > > +   timer_base = of_iomap(np, 0);
> > > +   irq = irq_of_parse_and_map(np, 0);
> > > +
> > > +   highbank_clocks_init();
> > > +
> > > +   sp804_clocksource_init(timer_base + 0x20, "timer1");
> > > +   sp804_clockevents_init(timer_base, irq, "timer0");
> > > +}
> > 
> > How about moving the sp804 initialization from device tree into the
> > arch/arm/common/timer-sp.c file?
> > 
> > Why do you initialize sregs_base from timer_init?
> 
> That'd create special cases - ARM platforms need registers twiddled to
> change the clock rate for the timers from 32kHz to a more sensible 1MHz.

Is that a bad thing? Platforms that don't need the special case can
simply call sp804_clocksource_init_dt() which scans the device tree,
while other platforms do whatever is necessary to the registers
and then call the existing sp804_clockevents_init.

> > > diff --git a/arch/arm/mach-highbank/include/mach/timex.h b/arch/arm/mach-highbank/include/mach/timex.h
> > > new file mode 100644
> > > index 0000000..88dac7a
> > > --- /dev/null
> > > +++ b/arch/arm/mach-highbank/include/mach/timex.h
> > > @@ -0,0 +1,6 @@
> > > +#ifndef __MACH_TIMEX_H
> > > +#define __MACH_TIMEX_H
> > > +
> > > +#define CLOCK_TICK_RATE            1000000
> > > +
> > > +#endif
> > 
> > In 3.2, we shouldn't need this any more. We'll have to come up with a
> > way to remember removing the new definitions that come in in parallel
> > to the patch that removes the old ones.
> 
> Has anyone really properly evaluated the CLOCK_TICK_RATE issues on things
> like NTP etc?  I have problems with kernels on OMAP4 constantly jumping
> forwards/back by .5sec when NTP is running which suggests that there's
> something not quite right _somewhere_.
> 
> Given that OMAP uses an untrue value for this, and the platforms I have
> which do behave properly when running NTP have correct values, I still
> remain entirely unconvinced about the claims surrounding CLOCK_TICK_RATE
> not mattering.

(Taking John, Deepak an Thomas on Cc, they have all worked on this
in the past)

The argument why it is assumed to be safe is that almost all machines
today use a totally bogus CLOCK_TICK_RATE. This includes most x86
machines (which don't use PIT for periodic ticks any more), all sparc,
powerpc, s390, parisc and mips machines that have never used the PIT
time base but define CLOCK_TICK_RATE to 1193180 or 1193182 anyway.

The only explanation I have for these working correctly is that
the effect of the ACTHZ macro is not what it was meant to be
and that it should better be removed.

> Has anyone managed to run NTP on OMAP4 and had it sync successfully over
> a few days?

Omap is weird in many ways here. They define CLOCK_TICK_RATE to be
equal to HZ, which in turn is a power-of-two value, typically 128.
I have verified that the strange CLOCK_TICK_RATE won't cause problems
in the kernel (in theory), but I could well imagine that the problems
of OMAP are stemming from rounding problems when converting between
kernel ticks (128 Hz) to user ticks (100 Hz) in kernel/time.c, or perhaps
from the omap read_persistent_clock() function not being SMP safe.

	Arnd
