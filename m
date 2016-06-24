From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 24 Jun 2016 12:07:01 +0200
Subject: [PATCH 42/48] clocksource/drivers: Add a new driver for the Atmel
 ARM TC blocks
In-Reply-To: <1465596231-21766-43-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1465596231-21766-43-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <576D0645.2070805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2016 12:03 AM, Alexandre Belloni wrote:
> Add a driver for the Atmel Timer Counter Blocks. This driver provides a
> clocksource and a clockevent device. The clockevent device is linked to the
> clocksource counter and so it will run at the same frequency.
>
> This driver uses regmap and syscon to be able to probe early in the boot
> and avoid having to switch on the TCB clocksource later. Using regmap also
> means that unused TCB channels may be used by other drivers (PWM for
> example).
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   drivers/clocksource/Kconfig                 |  13 ++
>   drivers/clocksource/Makefile                |   3 +-
>   drivers/clocksource/timer-atmel-tcbclksrc.c | 305 ++++++++++++++++++++++++++++
>   include/soc/at91/atmel_tcb.h                | 220 ++++++++++++++++++++
>   4 files changed, 540 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/clocksource/timer-atmel-tcbclksrc.c
>   create mode 100644 include/soc/at91/atmel_tcb.h
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 47352d25c15e..ff7f4022c749 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -258,6 +258,19 @@ config ATMEL_ST
>   	select CLKSRC_OF
>   	select MFD_SYSCON
>
> +config ATMEL_ARM_TCB_CLKSRC
> +	bool "TC Block Clocksource"

The Kconfig options are set now with the COMPILE_TEST option in order to 
increase the compilation test coverage.

Please, add bool "TC Block Clocksource" if COMPILE_TEST, ...

> +	select REGMAP_MMIO
> +	depends on GENERIC_CLOCKEVENTS
> +	depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
> +	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5

... remove these dependencies and let the SoC's Kconfig to select the 
timer like the other timers are.

> +	help
> +	  Select this to get a high precision clocksource based on a
> +	  TC block with a 5+ MHz base clock rate.
> +	  On platforms with 16-bit counters, two timer channels are combined
> +	  to make a single 32-bit timer.
> +	  It can also be used as a clock event device supporting oneshot mode.
> +
>   config CLKSRC_METAG_GENERIC
>   	def_bool y if METAG
>   	help
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 473974f9590a..988f33de5808 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -1,7 +1,8 @@
>   obj-$(CONFIG_CLKSRC_PROBE)	+= clksrc-probe.o
>   obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
>   obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
> -obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
> +obj-$(CONFIG_ATMEL_TCB_CLKSRC) += tcb_clksrc.o
> +obj-$(CONFIG_ATMEL_ARM_TCB_CLKSRC)	+= timer-atmel-tcbclksrc.o
>   obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
>   obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
>   obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
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

The test in the init function checks against < 0 but 'irq' is 'unsigned'

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
> +	},
> +	.clkevt	= {
> +		.name			= "tcb_clkevt",
> +		.features		= CLOCK_EVT_FEAT_ONESHOT,
> +		/* Should be lower than at91rm9200's system timer */
> +		.rating			= 125,
> +	},
> +};
> +
> +static cycle_t tc_get_cycles(struct clocksource *cs)
> +{
> +	unsigned long	flags;
> +	u32		lower, upper, tmp;
> +
> +	raw_local_irq_save(flags);
> +	do {
> +		regmap_read(tc.regmap, ATMEL_TC_CV(1), &upper);
> +		regmap_read(tc.regmap, ATMEL_TC_CV(0), &lower);
> +		regmap_read(tc.regmap, ATMEL_TC_CV(1), &tmp);
> +	} while (upper != tmp);
> +
> +	raw_local_irq_restore(flags);

Why is this lock needed ?

> +	return (upper << 16) | lower;
> +}
> +
> +static cycle_t tc_get_cycles32(struct clocksource *cs)
> +{
> +	u32 val;
> +
> +	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &val);
> +
> +	return val;
> +}
> +
> +static u64 tc_sched_clock_read(void)
> +{
> +	return tc_get_cycles(&tc.clksrc);
> +}
> +
> +static u64 tc_sched_clock_read32(void)
> +{
> +	return tc_get_cycles32(&tc.clksrc);
> +}

'notrace' should be added here to avoid recursion with ftrace.

> +static int tcb_clkevt_next_event(unsigned long delta,
> +				 struct clock_event_device *d)
> +{
> +	u32 val;
> +
> +	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &val);
> +	regmap_write(tc.regmap, ATMEL_TC_RC(tc.channels[0]), val + delta);
> +	regmap_write(tc.regmap, ATMEL_TC_IER(tc.channels[0]), ATMEL_TC_CPCS);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t tc_clkevt_irq(int irq, void *handle)
> +{
> +	unsigned int sr;
> +
> +	regmap_read(tc.regmap, ATMEL_TC_SR(tc.channels[0]), &sr);
> +	if (sr & ATMEL_TC_CPCS) {
> +		tc.clkevt.event_handler(&tc.clkevt);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int tcb_clkevt_oneshot(struct clock_event_device *dev)
> +{
> +	int ret;
> +
> +	if (tc.irq_requested)
> +		return 0;
> +
> +	ret = request_irq(tc.irq, tc_clkevt_irq, IRQF_TIMER | IRQF_SHARED,
> +			  "tcb_clkevt", &tc);
> +	if (!ret)
> +		tc.irq_requested = true;

The legacy driver checks clockevent_state_detached() and disables the clock.

Why is 'irq_requested' and request_irq/free_irq cleaner ?

Isn't there a configuration with the TCB register to disable the 
clockevent only ?

> +	return ret;
> +}
> +
> +static int tcb_clkevt_shutdown(struct clock_event_device *dev)
> +{
> +	regmap_write(tc.regmap, ATMEL_TC_IDR(tc.channels[0]), 0xff);
> +	if (tc.bits == 16)
> +		regmap_write(tc.regmap, ATMEL_TC_IDR(tc.channels[1]), 0xff);
> +
> +	if (tc.irq_requested) {
> +		free_irq(tc.irq, &tc);
> +		tc.irq_requested = false;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static void __init tcb_clksrc_init(struct device_node *node)
> +{
> +	const struct of_device_id *match;
> +	u32 rate, divided_rate = 0;
> +	int best_divisor_idx = -1;
> +	int i, err;
> +
> +	if (tc.registered)
> +		return;

That's getting annoying. It is not your fault but that's a repeating 
pattern when multiple nodes are defined for a timer. Someday we will 
have to sit down and think about that.

> +	tc.regmap = syscon_node_to_regmap(node->parent);
> +	if (IS_ERR(tc.regmap))
> +		return;
> +
> +	match = of_match_node(atmel_tcb_dt_ids, node->parent);
> +	tc.bits = (int)match->data;
> +
> +	err = of_property_read_u32_index(node, "reg", 0, &tc.channels[0]);
> +	if (err)
> +		return;
> +
> +	tc.channels[1] = -1;
> +
> +	if (tc.bits == 16) {
> +		of_property_read_u32_index(node, "reg", 1, &tc.channels[1]);
> +		if (tc.channels[1] == -1) {
> +			pr_err("%s: clocksource needs two channels\n",
> +			       node->parent->full_name);
> +		}
> +	}
> +
> +	tc.irq = tcb_irq_get(node, tc.channels[0]);
> +	if (tc.irq < 0)
> +		return;
> +
> +	tc.clk[0] = tcb_clk_get(node, tc.channels[0]);
> +	if (IS_ERR(tc.clk[0]))
> +		return;
> +	err = clk_prepare_enable(tc.clk[0]);
> +	if (err) {
> +		pr_debug("can't enable T0 clk\n");
> +		goto err_clk;
> +	}
> +
> +	if (tc.bits == 16) {
> +		tc.clk[1] = tcb_clk_get(node, tc.channels[1]);
> +		if (IS_ERR(tc.clk[1]))
> +			goto err_disable_t0;
> +	}
> +
> +	/* How fast will we be counting?  Pick something over 5 MHz.  */
> +	rate = (u32)clk_get_rate(tc.clk[0]);
> +	for (i = 0; i < 5; i++) {
> +		unsigned int divisor = atmel_tc_divisors[i];
> +		unsigned int tmp;
> +
> +		if (!divisor)
> +			continue;
> +
> +		tmp = rate / divisor;
> +		pr_debug("TC: %u / %-3u [%d] --> %u\n", rate, divisor, i, tmp);
> +		if (best_divisor_idx > 0) {
> +			if (tmp < 5 * 1000 * 1000)
> +				continue;
> +		}
> +		divided_rate = tmp;
> +		best_divisor_idx = i;
> +	}
> +
> +	pr_debug("%s: %s at %d.%03d MHz\n", tc.clksrc.name,
> +		 node->parent->full_name, divided_rate / 1000000,
> +		 ((divided_rate + 500000) % 1000000) / 1000);
> +
> +	if (tc.bits == 32) {
> +		tc.clksrc.read = tc_get_cycles32;
> +		tcb_setup_single_chan(&tc, best_divisor_idx);
> +	} else {
> +		err = clk_prepare_enable(tc.clk[1]);
> +		if (err) {
> +			pr_debug("can't enable T1 clk\n");
> +			goto err_clk1;
> +		}
> +		tc.clksrc.read = tc_get_cycles,
> +		tcb_setup_dual_chan(&tc, best_divisor_idx);
> +	}
> +
> +	err = clocksource_register_hz(&tc.clksrc, divided_rate);
> +	if (err)
> +		goto err_disable_t1;
> +
> +	if (tc.bits == 32)

Can't you can group the code under tc.bits == 16 and tc.bits == 32 
instead of multiple check against the reg width ?

> +		sched_clock_register(tc_sched_clock_read32, 32, divided_rate);
> +	else
> +		sched_clock_register(tc_sched_clock_read, 32, divided_rate);
> +
> +	tc.registered = true;
> +
> +	/* Set up and register clockevents */
> +	tc.clkevt.cpumask = cpumask_of(0);
> +	tc.clkevt.set_next_event = tcb_clkevt_next_event;
> +	tc.clkevt.set_state_oneshot = tcb_clkevt_oneshot;
> +	tc.clkevt.set_state_shutdown = tcb_clkevt_shutdown;
> +	if (tc.bits == 16)
> +		clockevents_config_and_register(&tc.clkevt, divided_rate, 1,
> +						0xffff);
> +	else
> +		clockevents_config_and_register(&tc.clkevt, divided_rate, 1,
> +						0xffffffff);
> +	return;

clockevents_config_and_register(&tc.clkevt, divided_rate, 1, 
BIT(tc.bits) - 1);

IIRC, there is a macro somewhere doing BIT(n) - 1. CLOCKSOURCE_MASK does 
it but it is weird to set a clockevent with a clocksource mask.

> +
> +err_disable_t1:
> +	if (tc.bits == 16)
> +		clk_disable_unprepare(tc.clk[1]);
> +
> +err_clk1:
> +	if (tc.bits == 16)
> +		clk_put(tc.clk[1]);
> +
> +err_disable_t0:
> +	clk_disable_unprepare(tc.clk[0]);
> +
> +err_clk:
> +	clk_put(tc.clk[0]);
> +
> +	pr_err("%s: unable to register clocksource/clockevent\n",
> +	       tc.clksrc.name);
> +}
> +CLOCKSOURCE_OF_DECLARE(atmel_tcb_clksrc, "atmel,tcb-clksrc",
> +		       tcb_clksrc_init);

[ ... ]


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
