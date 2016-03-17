From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 17 Mar 2016 17:13:44 +0100
Subject: [PATCH 04/17] clocksource: Add PLX Technology RPS Timer
In-Reply-To: <1457005210-18485-5-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-5-git-send-email-narmstrong@baylibre.com>
Message-ID: <56EAD7B8.3030004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On 03/03/2016 12:39 PM, Neil Armstrong wrote:
> Add clocksource and clockevent driver from dual RPS timer.

please elaborate the log: describe the timer, how it works, is there a 
pointer to doc, freq, etc ...

> CC: Ma Haijun <mahaijuns@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/clocksource/Kconfig     |   6 +
>   drivers/clocksource/Makefile    |   1 +
>   drivers/clocksource/timer-rps.c | 249 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 256 insertions(+)
>   create mode 100644 drivers/clocksource/timer-rps.c
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 33db740..f79bc0f 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -276,6 +276,12 @@ config VF_PIT_TIMER
>   	help
>   	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
>
> +config CLKSRC_RPS_TIMER
> +	bool
> +	select CLKSRC_MMIO
> +	help
> +	  This enables support for the PLX Tech OXNAS RPS timers.
> +

Please check DIGICOLOR_TIMER or DW_APB_TIMER or ROCKCHIP_TIMER or 
ARMADA_370_XP_TIMER or ... config section and try to stick to the same 
pattern.

>   config SYS_SUPPORTS_SH_CMT
>           bool
>
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index dc2b899..120bc09 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
>   obj-$(CONFIG_MTK_TIMER)		+= mtk_timer.o
>   obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
>   obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
> +obj-$(CONFIG_CLKSRC_RPS_TIMER)	+= timer-rps.o
>
>   obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
>   obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
> diff --git a/drivers/clocksource/timer-rps.c b/drivers/clocksource/timer-rps.c
> new file mode 100644
> index 0000000..79621b8
> --- /dev/null
> +++ b/drivers/clocksource/timer-rps.c
> @@ -0,0 +1,249 @@
> +/*
> + * drivers/clocksource/timer-rps.c
> + *
> + * Copyright (C) 2009 Oxford Semiconductor Ltd
> + * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
> + * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/clockchips.h>
> +#include <linux/clk.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/sched_clock.h>
> +
> +/* TIMER1 as tick
> + * TIMER2 as clocksource
> + */

Comment format:

/*
  * TIMER1 used as tick
  * TIMER2 used as clocksource
  */

> +enum {
> +	TIMER_LOAD = 0,
> +	TIMER_CURR = 4,
> +	TIMER_CTRL = 8,
> +	TIMER_CLRINT = 0xC,
> +
> +	TIMER_BITS = 24,
> +
> +	TIMER_MAX_VAL = (1 << TIMER_BITS) - 1,
> +
> +	TIMER_PERIODIC = (1 << 6),
> +	TIMER_ENABLE = (1 << 7),
> +
> +	TIMER_DIV1  = (0 << 2),
> +	TIMER_DIV16  = (1 << 2),
> +	TIMER_DIV256  = (2 << 2),
> +
> +	TIMER1_OFFSET = 0,
> +	TIMER2_OFFSET = 0x20,
> +};

What is the point of having this unorganized enum with duplicate values 
? and why TIMER_DIV1 = (0 << 2) ?

Replace by #define.

> +/* Clockevent */
> +
> +static unsigned long timer_period = HZ;
> +static unsigned timer_prescaler = 1;
> +static void __iomem *timer_base;

Encapsulate these variables into a structure and use container_of.

> +
> +static irqreturn_t rps_timer_irq(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = dev_id;
> +
> +	iowrite32(0, timer_base + TIMER_CLRINT);
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void rps_timer_config(unsigned long period, unsigned periodic)
> +{
> +	uint32_t cfg = 0;
> +
> +	if (period)
> +		cfg |= TIMER_ENABLE;
> +
> +	if (periodic)
> +		cfg |= TIMER_PERIODIC;
> +
> +	switch (timer_prescaler) {
> +	case 1:
> +		cfg |= TIMER_DIV1;
> +		break;
> +	case 16:
> +		cfg |= TIMER_DIV16;
> +		break;
> +	case 256:
> +		cfg |= TIMER_DIV256;
> +		break;
> +	}

No direct value (1, 16, 256) but macros please.

> +	iowrite32(period, timer_base + TIMER_LOAD);
> +	iowrite32(cfg, timer_base + TIMER_CTRL);
> +}
> +
> +static int rps_timer_shutdown(struct clock_event_device *evt)
> +{
> +	if (!clockevent_state_periodic(evt))
> +		return 0;
> +
> +	rps_timer_config(0, 0);
> +
> +	return 0;
> +}
> +
> +static int rps_timer_set_periodic(struct clock_event_device *evt)
> +{
> +	rps_timer_config(timer_period, 1);
> +
> +	return 0;
> +}
> +
> +static int rps_timer_set_oneshot(struct clock_event_device *evt)
> +{
> +	rps_timer_config(timer_period, 0);
> +
> +	return 0;
> +}
> +
> +static int rps_timer_next_event(unsigned long delta,
> +				struct clock_event_device *evt)
> +{
> +	rps_timer_config(delta, 0);
> +
> +	return 0;
> +}
> +
> +static struct clock_event_device rps_clockevent = {
> +	.name = "rps",
> +	.features = CLOCK_EVT_FEAT_PERIODIC |
> +		    CLOCK_EVT_FEAT_ONESHOT,
> +	.tick_resume = rps_timer_shutdown,
> +	.set_state_shutdown = rps_timer_shutdown,
> +	.set_state_periodic = rps_timer_set_periodic,
> +	.set_state_oneshot = rps_timer_set_oneshot,
> +	.set_next_event = rps_timer_next_event,
> +	.rating = 200,
> +};
> +
> +static void __init rps_clockevent_init(void __iomem *base, ulong ref_rate,
> +				       int irq)
> +{
> +	timer_base = base;
> +
> +	/* Start with prescaler 1 */
> +	timer_prescaler = 1;
> +	timer_period = DIV_ROUND_UP(ref_rate, HZ);
> +
> +	if (timer_period > TIMER_MAX_VAL) {
> +		timer_prescaler = 16;
> +		timer_period = DIV_ROUND_UP(ref_rate / timer_prescaler, HZ);

Using macro and bit shifting will be nicer.

> +	}
> +	if (timer_period > TIMER_MAX_VAL) {
> +		timer_prescaler = 256;
> +		timer_period = DIV_ROUND_UP(ref_rate / timer_prescaler, HZ);
> +	}
> +	rps_clockevent.cpumask = cpu_possible_mask;
> +	rps_clockevent.irq = irq;

So if you are using such cpumask, I suggest you have a look at the 
DYNIRQ flag.

> +	clockevents_config_and_register(&rps_clockevent,
> +					ref_rate / timer_prescaler,
> +					1,
> +					TIMER_MAX_VAL);
> +
> +	pr_info("rps: Registered clock event rate %luHz prescaler %d period %lu\n",
> +			ref_rate,
> +			timer_prescaler,
> +			timer_period);
> +}
> +
> +/* Clocksource */
> +
> +static void __iomem *timer_curr;
> +
> +static u64 notrace rps_read_sched_clock(void)
> +{
> +	return ~readl_relaxed(timer_curr);
> +}
> +
> +static void __init rps_clocksource_init(void __iomem *base, ulong ref_rate)
> +{
> +	int ret;
> +	ulong clock_rate;
> +	/* use prescale 16 */
> +	clock_rate = ref_rate / 16;
> +
> +	iowrite32(TIMER_MAX_VAL, base + TIMER_LOAD);
> +	iowrite32(TIMER_PERIODIC | TIMER_ENABLE | TIMER_DIV16,
> +			base + TIMER_CTRL);
> +
> +	timer_curr = base + TIMER_CURR;
> +	sched_clock_register(rps_read_sched_clock, TIMER_BITS, clock_rate);
> +	ret = clocksource_mmio_init(base + TIMER_CURR, "rps_clocksource_timer",
> +					clock_rate, 250, TIMER_BITS,
> +					clocksource_mmio_readl_down);
> +	if (ret)
> +		panic("can't register clocksource\n");

No panic, just an error.

> +	pr_info("rps: Registered clocksource rate %luHz\n", clock_rate);
> +}
> +
> +static struct irqaction rps_timer_irqaction = {
> +	.name		= "rps_timer",
> +	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
> +	.handler	= rps_timer_irq,
> +	.dev_id		= &rps_clockevent,
> +};
> +
> +static void __init rps_timer_init(struct device_node *np)
> +{
> +	struct clk *refclk;
> +	unsigned long ref_rate;
> +	void __iomem *base;
> +	int irq, ret;
> +
> +	refclk = of_clk_get(np, 0);
> +
> +	if (IS_ERR(refclk) || clk_prepare_enable(refclk))
> +		panic("rps_timer_init: failed to get refclk\n");

no panic.

> +	ref_rate = clk_get_rate(refclk);
> +
> +	base = of_iomap(np, 0);
> +	if (!base)
> +		panic("rps_timer_init: failed to map io\n");
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (irq < 0)
> +		panic("rps_timer_init: failed to parse IRQ\n");

if (!irq)
	no panic.

> +
> +	/* Disable timers */
> +	iowrite32(0, base + TIMER1_OFFSET + TIMER_CTRL);
> +	iowrite32(0, base + TIMER2_OFFSET + TIMER_CTRL);
> +	iowrite32(0, base + TIMER1_OFFSET + TIMER_LOAD);
> +	iowrite32(0, base + TIMER2_OFFSET + TIMER_LOAD);
> +	iowrite32(0, base + TIMER1_OFFSET + TIMER_CLRINT);
> +	iowrite32(0, base + TIMER2_OFFSET + TIMER_CLRINT);
> +
> +	rps_clocksource_init(base + TIMER2_OFFSET, ref_rate);
> +	rps_clockevent_init(base + TIMER1_OFFSET, ref_rate, irq);
> +
> +	ret = setup_irq(irq, &rps_timer_irqaction);

Replace setup_irq by request_irq.

> +	if (ret)
> +		panic("rps_timer_init: failed to request irq\n");
> +}
> +
> +CLOCKSOURCE_OF_DECLARE(nas782x, "plxtech,nas782x-rps-timer", rps_timer_init);


Thanks !

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
