From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 11 Jun 2016 14:48:10 +0200
Subject: [PATCH 42/48] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <1465596231-21766-43-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1465596231-21766-43-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160611144810.4a1c61d3@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 11 Jun 2016 00:03:45 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Add a driver for the Atmel Timer Counter Blocks. This driver provides a
> clocksource and a clockevent device. The clockevent device is linked to the
> clocksource counter and so it will run at the same frequency.
> 
> This driver uses regmap and syscon to be able to probe early in the boot
> and avoid having to switch on the TCB clocksource later. Using regmap also
> means that unused TCB channels may be used by other drivers (PWM for
> example).

First of all, thanks for working on this
tcb/libtcb/tcb-clksource/tcb-pwm mess. It looks a lot cleaner after
your changes (both the DT representation and the code itself).

> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/clocksource/Kconfig                 |  13 ++
>  drivers/clocksource/Makefile                |   3 +-
>  drivers/clocksource/timer-atmel-tcbclksrc.c | 305 ++++++++++++++++++++++++++++
>  include/soc/at91/atmel_tcb.h                | 220 ++++++++++++++++++++

I think the creation of atmel_tcb.h should be done in a separate commit.

>  4 files changed, 540 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clocksource/timer-atmel-tcbclksrc.c
>  create mode 100644 include/soc/at91/atmel_tcb.h
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 47352d25c15e..ff7f4022c749 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -258,6 +258,19 @@ config ATMEL_ST
>  	select CLKSRC_OF
>  	select MFD_SYSCON
>  
> +config ATMEL_ARM_TCB_CLKSRC
> +	bool "TC Block Clocksource"
> +	select REGMAP_MMIO
> +	depends on GENERIC_CLOCKEVENTS
> +	depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
> +	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
> +	help
> +	  Select this to get a high precision clocksource based on a
> +	  TC block with a 5+ MHz base clock rate.
> +	  On platforms with 16-bit counters, two timer channels are combined
> +	  to make a single 32-bit timer.
> +	  It can also be used as a clock event device supporting oneshot mode.
> +
>  config CLKSRC_METAG_GENERIC
>  	def_bool y if METAG
>  	help
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 473974f9590a..988f33de5808 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -1,7 +1,8 @@
>  obj-$(CONFIG_CLKSRC_PROBE)	+= clksrc-probe.o
>  obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
>  obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
> -obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
> +obj-$(CONFIG_ATMEL_TCB_CLKSRC) += tcb_clksrc.o
> +obj-$(CONFIG_ATMEL_ARM_TCB_CLKSRC)	+= timer-atmel-tcbclksrc.o
>  obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
>  obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
>  obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
> diff --git a/drivers/clocksource/timer-atmel-tcbclksrc.c b/drivers/clocksource/timer-atmel-tcbclksrc.c
> new file mode 100644
> index 000000000000..af0b1aab7a98
> --- /dev/null
> +++ b/drivers/clocksource/timer-atmel-tcbclksrc.c
> @@ -0,0 +1,305 @@
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_irq.h>
> +#include <linux/regmap.h>
> +#include <linux/sched_clock.h>
> +#include <soc/at91/atmel_tcb.h>
> +
> +struct atmel_tcb_clksrc {
> +	struct clocksource clksrc;
> +	struct clock_event_device clkevt;
> +	struct regmap *regmap;
> +	struct clk *clk[2];
> +	int channels[2];
> +	u8 bits;
> +	unsigned int irq;
> +	bool registered;
> +	bool irq_requested;
> +};
> +
> +static struct atmel_tcb_clksrc tc = {
> +	.clksrc = {
> +		.name		= "tcb_clksrc",
> +		.rating		= 200,
> +		.mask		= CLOCKSOURCE_MASK(32),
> +		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,

			^ 2 tabs here

> +	},
> +	.clkevt	= {
> +		.name			= "tcb_clkevt",

			^ 3 here

Can you make that consistent?
Actually, I'm not a big fan of those tabs, but if you decide to use
tabs, use the same number of them everywhere.

> +		.features		= CLOCK_EVT_FEAT_ONESHOT,
> +		/* Should be lower than at91rm9200's system timer */
> +		.rating			= 125,
> +	},
> +};
> +

[...]

> +
> +static int tcb_clkevt_next_event(unsigned long delta,
> +				 struct clock_event_device *d)
> +{
> +	u32 val;
> +
> +	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &val);
> +	regmap_write(tc.regmap, ATMEL_TC_RC(tc.channels[0]), val + delta);
> +	regmap_write(tc.regmap, ATMEL_TC_IER(tc.channels[0]), ATMEL_TC_CPCS);

Hm, not sure this is 100% sure. What happens if by the time you write
TC_RC, the delta value has expired? This means you'll have to wait
another round before the TC engine generates the "RC reached" interrupt.

I know this is very unlikely, but should we take the risk?

The core seems to check the ->set_next_event() return value and tries to
adjust ->min_delta_ns if it returns an error, so maybe it's worth
testing if val + delta has already occurred just before enabling the
TC_CPCS interrupt, and if it's the case, return an -ETIME error.

Something like:

	u32 val[2], next;

	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &val[0]);
	next = (val[0] + delta) & GENMASK(tc.bits - 1, 0);
	regmap_write(tc.regmap, ATMEL_TC_RC(tc.channels[0]), next);
	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &val[1]);

	if ((next < val[0] && val[1] < val[0] && val[1] >= next) ||
	    (next > val[0] && (val[1] < val[0] || val[1] >= next))) {
		/*
		 * Clear the CPCS bit in the status register to avoid
		 * generating a spurious interrupt next time a valid
		 * timer event is configured.
		 * FIXME: not sure it's safe, since it also clears the
		 * overflow status, but it seems this flag is not used
		 * by the driver anyway.
		 */
		regmap_read(tc.regmap, ATMEL_TC_SR, &val[0]);
		return -ETIME;
	}

	
	regmap_write(tc.regmap, ATMEL_TC_IER(tc.channels[0]),
		     ATMEL_TC_CPCS);

Thomas, Daniel, what's your opinion? 

> +
> +	return 0;
> +}
> +


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
