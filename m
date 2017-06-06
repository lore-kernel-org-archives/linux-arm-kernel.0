From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 6 Jun 2017 17:21:05 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
 <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
Message-ID: <20170606152104.GC2345@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 11:51:27PM +0200, Alexandre Belloni wrote:
> Add a driver for the Atmel Timer Counter Blocks. This driver provides a
> clocksource and a clockevent device. The clockevent device is linked to the
> clocksource counter and so it will run at the same frequency.

Where is the clockevent in this driver?

It seems the cutting out of this driver is a bit fuzzy and hard to follow.

Please re-org the changes in a logical manner when resubmitting.

> This driver uses regmap and syscon to be able to probe early in the boot
> and avoid having to switch on the TCB clocksource later. Using regmap also
> means that unused TCB channels may be used by other drivers (PWM for
> example).

Can you give more details, I fail to understand how regmap and syscon help to
probe sooner than timer_init()?

> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/clocksource/Kconfig                 |  13 ++
>  drivers/clocksource/Makefile                |   3 +-
>  drivers/clocksource/timer-atmel-tcbclksrc.c | 252 ++++++++++++++++++++++++++++

As it is a clksrc + clkevt, please change the name to something more adequate:

eg. timer-tcb.c

>  3 files changed, 267 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clocksource/timer-atmel-tcbclksrc.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 545d541ae20e..cbd710db3c09 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -418,6 +418,19 @@ config ATMEL_ST
>  	help
>  	  Support for the Atmel ST timer.
>  
> +config ATMEL_ARM_TCB_CLKSRC
> +	bool "TC Block Clocksource"
> +	select REGMAP_MMIO
> +	depends on GENERIC_CLOCKEVENTS
> +	depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5 || COMPILE_TEST
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
> index 2b5b56a6f00f..53a0b40e0db2 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -2,7 +2,8 @@ obj-$(CONFIG_CLKSRC_PROBE)	+= clksrc-probe.o
>  obj-$(CONFIG_CLKEVT_PROBE)	+= clkevt-probe.o
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
> index 000000000000..f18d177bfdea
> --- /dev/null
> +++ b/drivers/clocksource/timer-atmel-tcbclksrc.c
> @@ -0,0 +1,252 @@
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
> +static struct atmel_tcb_clksrc {
> +	char name[20];

	^^^^^^^^^^^^^^
This field is pointless.

> +	struct clocksource clksrc;

Why is this field defined and passed around to functions which do not use it?

Please consider using clocksource_mmio_init() and remove this field.

> +	struct regmap *regmap;
> +	struct clk *clk[2];

Can you explain why we have two clocks here?

> +	int channels[2];

Instead of dealing with 2 channels and a costly bits shifting in the hot path,
why not use a single channel with a different wrap up? IOW mask is 16 or 32.

The resulting code will be simpler, nicer and perhaps more efficient if you
save the tc_get_cycles() loop?

> +	int bits;

	^^^^^^^^

This field is pointless.

> +	int irq;

irq belongs to clockevents changes.

> +	bool registered;

What is the purpose of this registered boolean?

> +} tc = {
> +	.clksrc = {
> +		.rating		= 200,
> +		.mask		= CLOCKSOURCE_MASK(32),
> +		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	},
> +};
> +
> +static u64 tc_get_cycles(struct clocksource *cs)
> +{
> +	u32		lower, upper, tmp;

Fix these trailing spaces/tab.

> +
> +	do {
> +		regmap_read(tc.regmap, ATMEL_TC_CV(1), &upper);
> +		regmap_read(tc.regmap, ATMEL_TC_CV(0), &lower);
> +		regmap_read(tc.regmap, ATMEL_TC_CV(1), &tmp);
> +	} while (upper != tmp);
> +
> +	return (upper << 16) | lower;
> +}
> +
> +static u64 tc_get_cycles32(struct clocksource *cs)
> +{
> +	u32 val;
> +
> +	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &val);
> +
> +	return val;
> +}
> +
> +static u64 notrace tc_sched_clock_read(void)
> +{
> +	return tc_get_cycles(&tc.clksrc);
> +}
> +
> +static u64 notrace tc_sched_clock_read32(void)
> +{
> +	return tc_get_cycles32(&tc.clksrc);
> +}
> +
> +static void __init tcb_setup_dual_chan(struct atmel_tcb_clksrc *tc,
> +				       int mck_divisor_idx)
> +{
> +	/* first channel: waveform mode, input mclk/8, clock TIOA on overflow */
> +	regmap_write(tc->regmap, ATMEL_TC_CMR(tc->channels[0]),
> +		     mck_divisor_idx	/* likely divide-by-8 */
> +			| ATMEL_TC_CMR_WAVE
> +			| ATMEL_TC_CMR_WAVESEL_UP	/* free-run */
> +			| ATMEL_TC_CMR_ACPA(SET)	/* TIOA rises at 0 */
> +			| ATMEL_TC_CMR_ACPC(CLEAR));	/* (duty cycle 50%) */
> +	regmap_write(tc->regmap, ATMEL_TC_RA(tc->channels[0]), 0x0000);
> +	regmap_write(tc->regmap, ATMEL_TC_RC(tc->channels[0]), 0x8000);
> +	regmap_write(tc->regmap, ATMEL_TC_IDR(tc->channels[0]), 0xff);	/* no irqs */
> +	regmap_write(tc->regmap, ATMEL_TC_CCR(tc->channels[0]),
> +		     ATMEL_TC_CCR_CLKEN);
> +
> +	/* second channel: waveform mode, input TIOA */
> +	regmap_write(tc->regmap, ATMEL_TC_CMR(tc->channels[1]),
> +		     ATMEL_TC_CMR_XC(tc->channels[1])	/* input: TIOA */
> +		     | ATMEL_TC_CMR_WAVE
> +		     | ATMEL_TC_CMR_WAVESEL_UP);	/* free-run */
> +	regmap_write(tc->regmap, ATMEL_TC_IDR(tc->channels[1]), 0xff);	/* no irqs */
> +	regmap_write(tc->regmap, ATMEL_TC_CCR(tc->channels[1]),
> +		     ATMEL_TC_CCR_CLKEN);
> +
> +	/* chain both channel, we assume the previous channel */
> +	regmap_write(tc->regmap, ATMEL_TC_BMR,
> +		     ATMEL_TC_BMR_TCXC(1 + tc->channels[1], tc->channels[1]));
> +	/* then reset all the timers */
> +	regmap_write(tc->regmap, ATMEL_TC_BCR, ATMEL_TC_BCR_SYNC);
> +}
> +
> +static void __init tcb_setup_single_chan(struct atmel_tcb_clksrc *tc,
> +					 int mck_divisor_idx)
> +{
> +	/* channel 0:  waveform mode, input mclk/8 */
> +	regmap_write(tc->regmap, ATMEL_TC_CMR(tc->channels[0]),
> +		     mck_divisor_idx	/* likely divide-by-8 */
> +			| ATMEL_TC_CMR_WAVE
> +			| ATMEL_TC_CMR_WAVESEL_UP	/* free-run */
> +			);
> +	regmap_write(tc->regmap, ATMEL_TC_IDR(tc->channels[0]), 0xff);	/* no irqs */
> +	regmap_write(tc->regmap, ATMEL_TC_CCR(tc->channels[0]),
> +		     ATMEL_TC_CCR_CLKEN);
> +
> +	/* then reset all the timers */
> +	regmap_write(tc->regmap, ATMEL_TC_BCR, ATMEL_TC_BCR_SYNC);
> +}
> +
> +static int __init tcb_clksrc_register(struct device_node *node,
> +				      struct regmap *regmap, int channel,
> +				      int channel1, int irq, int bits)
> +{
> +	u32 rate, divided_rate = 0;
> +	int best_divisor_idx = -1;
> +	int i, err = -1;
> +	u64 (*tc_sched_clock)(void);
> +
> +	tc.regmap = regmap;
> +	tc.channels[0] = channel;
> +	tc.channels[1] = channel1;
> +	tc.irq = irq;
> +	tc.bits = bits;
> +
> +	tc.clk[0] = tcb_clk_get(node, tc.channels[0]);
> +	if (IS_ERR(tc.clk[0]))
> +		return PTR_ERR(tc.clk[0]);
> +	err = clk_prepare_enable(tc.clk[0]);
> +	if (err) {
> +		pr_debug("can't enable T0 clk\n");
> +		goto err_clk;
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
> +	if (tc.bits == 32) {
> +		tc.clksrc.read = tc_get_cycles32;
> +		tcb_setup_single_chan(&tc, best_divisor_idx);
> +		tc_sched_clock = tc_sched_clock_read32;
> +		snprintf(tc.name, sizeof(tc.name), "%s:%d",
> +			 kbasename(node->parent->full_name), tc.channels[0]);
> +	} else {
> +		tc.clk[1] = tcb_clk_get(node, tc.channels[1]);
> +		if (IS_ERR(tc.clk[1]))
> +			goto err_disable_t0;
> +
> +		err = clk_prepare_enable(tc.clk[1]);
> +		if (err) {
> +			pr_debug("can't enable T1 clk\n");
> +			goto err_clk1;
> +		}
> +		tc.clksrc.read = tc_get_cycles,
> +		tcb_setup_dual_chan(&tc, best_divisor_idx);
> +		tc_sched_clock = tc_sched_clock_read;
> +		snprintf(tc.name, sizeof(tc.name), "%s:%d,%d",
> +			 kbasename(node->parent->full_name), tc.channels[0],
> +			 tc.channels[1]);
> +	}
> +
> +	pr_debug("%s at %d.%03d MHz\n", tc.name,
> +		 divided_rate / 1000000,
> +		 ((divided_rate + 500000) % 1000000) / 1000);
> +
> +	tc.clksrc.name = tc.name;
> +
> +	err = clocksource_register_hz(&tc.clksrc, divided_rate);
> +	if (err)
> +		goto err_disable_t1;
> +
> +	sched_clock_register(tc_sched_clock, 32, divided_rate);
> +
> +	tc.registered = true;
> +
> +	return 0;
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
> +
> +	return err;
> +}
> +
> +static int __init tcb_clksrc_init(struct device_node *node)
> +{
> +	const struct of_device_id *match;
> +	const struct atmel_tcb_info *tcb_info;
> +	struct regmap *regmap;
> +	u32 channel;
> +	int bits, irq, err, chan1 = -1;
> +
> +	if (tc.registered)
> +		return -ENODEV;
> +
> +	regmap = syscon_node_to_regmap(node->parent);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	match = of_match_node(atmel_tcb_dt_ids, node->parent);
> +	tcb_info = match->data;
> +	bits = tcb_info->bits;
> +
> +	err = of_property_read_u32_index(node, "reg", 0, &channel);
> +	if (err)
> +		return err;
> +
> +	irq = tcb_irq_get(node, channel);
> +	if (irq < 0)
> +		return irq;
> +
> +	if (bits == 16) {
> +		of_property_read_u32_index(node, "reg", 1, &chan1);
> +		if (chan1 == -1) {
> +			pr_err("%s: clocksource needs two channels\n",
> +			       node->parent->full_name);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return tcb_clksrc_register(node, regmap, channel, chan1, irq, bits);
> +}
> +CLOCKSOURCE_OF_DECLARE(atmel_tcb_clksrc, "atmel,tcb-timer",
> +		       tcb_clksrc_init);
> -- 
> 2.11.0
> 

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
