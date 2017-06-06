From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 6 Jun 2017 20:05:59 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20170606152104.GC2345@mai>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
 <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai>
Message-ID: <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2017 at 17:21:05 +0200, Daniel Lezcano wrote:
> On Tue, May 30, 2017 at 11:51:27PM +0200, Alexandre Belloni wrote:
> > Add a driver for the Atmel Timer Counter Blocks. This driver provides a
> > clocksource and a clockevent device. The clockevent device is linked to the
> > clocksource counter and so it will run at the same frequency.
> 
> Where is the clockevent in this driver?
> 

That's a leftover from v1, it seems I forgot to rework that commit
message.

> It seems the cutting out of this driver is a bit fuzzy and hard to follow.
> 
> Please re-org the changes in a logical manner when resubmitting.
> 

I can submit the whole driver as a single patch if that is easier for
you to review.

> > This driver uses regmap and syscon to be able to probe early in the boot
> > and avoid having to switch on the TCB clocksource later. Using regmap also
> > means that unused TCB channels may be used by other drivers (PWM for
> > example).
> 
> Can you give more details, I fail to understand how regmap and syscon help to
> probe sooner than timer_init()?
> 

Because before that, the tcb driver relied on atmel_tclib to share the
TCBs and it happened way too late, at arch_initcall() time.


> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  drivers/clocksource/Kconfig                 |  13 ++
> >  drivers/clocksource/Makefile                |   3 +-
> >  drivers/clocksource/timer-atmel-tcbclksrc.c | 252 ++++++++++++++++++++++++++++
> 
> As it is a clksrc + clkevt, please change the name to something more adequate:
> 
> eg. timer-tcb.c
> 
> >  3 files changed, 267 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/clocksource/timer-atmel-tcbclksrc.c
> > 
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 545d541ae20e..cbd710db3c09 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -418,6 +418,19 @@ config ATMEL_ST
> >  	help
> >  	  Support for the Atmel ST timer.
> >  
> > +config ATMEL_ARM_TCB_CLKSRC
> > +	bool "TC Block Clocksource"
> > +	select REGMAP_MMIO
> > +	depends on GENERIC_CLOCKEVENTS
> > +	depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5 || COMPILE_TEST
> > +	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
> > +	help
> > +	  Select this to get a high precision clocksource based on a
> > +	  TC block with a 5+ MHz base clock rate.
> > +	  On platforms with 16-bit counters, two timer channels are combined
> > +	  to make a single 32-bit timer.
> > +	  It can also be used as a clock event device supporting oneshot mode.
> > +
> >  config CLKSRC_METAG_GENERIC
> >  	def_bool y if METAG
> >  	help
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> > index 2b5b56a6f00f..53a0b40e0db2 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -2,7 +2,8 @@ obj-$(CONFIG_CLKSRC_PROBE)	+= clksrc-probe.o
> >  obj-$(CONFIG_CLKEVT_PROBE)	+= clkevt-probe.o
> >  obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
> >  obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
> > -obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
> > +obj-$(CONFIG_ATMEL_TCB_CLKSRC) += tcb_clksrc.o
> > +obj-$(CONFIG_ATMEL_ARM_TCB_CLKSRC)	+= timer-atmel-tcbclksrc.o
> >  obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
> >  obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
> >  obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
> > diff --git a/drivers/clocksource/timer-atmel-tcbclksrc.c b/drivers/clocksource/timer-atmel-tcbclksrc.c
> > new file mode 100644
> > index 000000000000..f18d177bfdea
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-atmel-tcbclksrc.c
> > @@ -0,0 +1,252 @@
> > +#include <linux/clk.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/regmap.h>
> > +#include <linux/sched_clock.h>
> > +#include <soc/at91/atmel_tcb.h>
> > +
> > +static struct atmel_tcb_clksrc {
> > +	char name[20];
> 
> 	^^^^^^^^^^^^^^
> This field is pointless.
> 

You mean you don't like how it is used? Or you don't think having the
timer full name is useful?

> > +	struct clocksource clksrc;
> 
> Why is this field defined and passed around to functions which do not use it?
> 
> Please consider using clocksource_mmio_init() and remove this field.
> 

Well, this doesn't work with a regmap so it doesn't fit.

> > +	struct regmap *regmap;
> > +	struct clk *clk[2];
> 
> Can you explain why we have two clocks here?
> 

Each channel have its clock, I can add a comment if you want.

> > +	int channels[2];
> 
> Instead of dealing with 2 channels and a costly bits shifting in the hot path,
> why not use a single channel with a different wrap up? IOW mask is 16 or 32.
> 
> The resulting code will be simpler, nicer and perhaps more efficient if you
> save the tc_get_cycles() loop?
> 

I think the rationale behind it is that 16 bits at 5MHz makes it
wrap every 13ms which is too fast to be useful.

> > +	int bits;
> 
> 	^^^^^^^^
> 
> This field is pointless.
> 
> > +	int irq;
> 
> irq belongs to clockevents changes.
> 
> > +	bool registered;
> 
> What is the purpose of this registered boolean?
> 

The main reason is that RobH doesn't want to have the use (clocksource
or clockevent) of the timer in the DT so when probing a timer, I need to
know whether I already have a clocksource to decide when it is time to
register a clockevent.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
