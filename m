From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Feb 2017 17:47:45 +0100
Subject: [PATCH v3 04/25] clocksource: Add Owl timer
In-Reply-To: <20170228063535.32069-5-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
 <20170228063535.32069-5-afaerber@suse.de>
Message-ID: <20170228164745.GC30601@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 07:35:14AM +0100, Andreas F?rber wrote:
> The Actions Semi S500 SoC provides four timers, 2Hz0/1 and 32-bit TIMER0/1.
> 
> Use TIMER0 as clocksource and TIMER1 as clockevents.
> 
> Based on LeMaker linux-actions tree.
> 
> An S500 datasheet can be found on the LeMaker Guitar pages:
> http://www.lemaker.org/product-guitar-download-29.html
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2 -> v3:
>  * Cleared interrupt pending flag for Timer1
>  * Adopted named interrupts for Timer1
>  * Extended commit message (Daniel)
>  * Adopted BIT() macros (Daniel)
>  * Adopted PTR_ERR() (Daniel)
>  * Adopted request_irq() (Daniel)
>  * Factored timer reset out (Daniel)
>  * Adopted CLOCK_EVT_FEAT_DYNIRQ (Daniel)
>  * Adopted clk input for rate (Daniel)
>  * Prepared for S900, adopting S500 DT compatible
>  
>  v2: new
>  
>  drivers/clocksource/Kconfig     |   7 ++
>  drivers/clocksource/Makefile    |   1 +
>  drivers/clocksource/owl-timer.c | 193 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 drivers/clocksource/owl-timer.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 3356ab8..2551365 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -107,6 +107,13 @@ config ORION_TIMER
>  	help
>  	  Enables the support for the Orion timer driver
>  
> +config OWL_TIMER
> +	bool "Owl timer driver" if COMPILE_TEST
> +	depends on GENERIC_CLOCKEVENTS
> +	select CLKSRC_MMIO
> +	help
> +	  Enables the support for the Actions Semi Owl timer driver.
> +
>  config SUN4I_TIMER
>  	bool "Sun4i timer driver" if COMPILE_TEST
>  	depends on GENERIC_CLOCKEVENTS
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index d227d13..801b65a 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
>  obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
>  obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
>  obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
> +obj-$(CONFIG_OWL_TIMER)		+= owl-timer.o
>  
>  obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
>  obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
> diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
> new file mode 100644
> index 0000000..1b1e26d
> --- /dev/null
> +++ b/drivers/clocksource/owl-timer.c
> @@ -0,0 +1,193 @@
> +/*
> + * Actions Semi Owl timer
> + *
> + * Copyright 2012 Actions Semi Inc.
> + * Author: Actions Semi, Inc.
> + *
> + * Copyright (c) 2017 SUSE Linux GmbH
> + * Author: Andreas F?rber
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqreturn.h>
> +#include <linux/sched_clock.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#define OWL_Tx_CTL		0x0
> +#define OWL_Tx_CMP		0x4
> +#define OWL_Tx_VAL		0x8
> +
> +#define OWL_Tx_CTL_PD		BIT(0)
> +#define OWL_Tx_CTL_INTEN	BIT(1)
> +#define OWL_Tx_CTL_EN		BIT(2)
> +
> +#define OWL_MAX_Tx 2
> +
> +struct owl_timer_info {
> +	int timer_offset[OWL_MAX_Tx];
> +};
> +
> +static const struct owl_timer_info *owl_timer_info;
> +
> +static void __iomem *owl_timer_base;
> +
> +static inline void __iomem *owl_timer_get_base(unsigned timer_nr)
> +{
> +	if (timer_nr >= OWL_MAX_Tx)
> +		return NULL;

The driver is supposed to know what is doing. owl_timer_get_base won't be
called with an invalid index. This test will have a cost as it is called from
owl_timer_sched_read.

> +
> +	return owl_timer_base + owl_timer_info->timer_offset[timer_nr];

Actually, you just need a clkevt base @ and a clocksource base @.

Instead of computing again and again the base, why not just precompute:

	owl_clksrc_base = owl_timer_base + owl_timer_info->timer_offset[OWL_TIMER0]
	owl_clkevt_base = owl_timer_base + owl_timer_info->timer_offset[OWL_TIMER1]

  at init time.

And use these variables directly in the functions.

> +}
> +
> +static inline void owl_timer_reset(unsigned index)
> +{
> +	void __iomem *base;
> +
> +	base = owl_timer_get_base(index);
> +	if (!base)
> +		return;

Same here, this test is pointless.

> +	writel(0, base + OWL_Tx_CTL);
> +	writel(0, base + OWL_Tx_VAL);
> +	writel(0, base + OWL_Tx_CMP);
> +}

I suggest:

static inline void owl_timer_reset(void __iomem *addr)
{
	writel(0, addr + OWL_Tx_CTL);
	writel(0, addr + OWL_Tx_VAL);
	writel(0, addr + OWL_Tx_CMP);
}

> +
> +static u64 notrace owl_timer_sched_read(void)
> +{
> +	return (u64)readl(owl_timer_get_base(0) + OWL_Tx_VAL);

	return (u64)readl(owl_clksrc_base + OWL_Tx_VAL);

> +}
> +

static inline int owl_timer_set_state_disable(struct clock_event_device *evt)
{
	return writel(0, owl_clkevt_base + OWL_Tx_CTL);
}


> +static int owl_timer_set_state_shutdown(struct clock_event_device *evt)
> +{
> +	writel(0, owl_timer_get_base(0) + OWL_Tx_CTL);

	return owl_timer_set_state_disable(evt);

> +
> +	return 0;
> +}
> +
> +static int owl_timer_set_state_oneshot(struct clock_event_device *evt)
> +{
> +	owl_timer_reset(1);

Do you really need to do reset here ? Why not just owl_timer_set_state_disable(evt) ?

> +	return 0;
> +}
> +
> +static int owl_timer_tick_resume(struct clock_event_device *evt)
> +{
> +	return 0;
> +}
> +
> +static int owl_timer_set_next_event(unsigned long evt,
> +				    struct clock_event_device *ev)
> +{
> +	void __iomem *base = owl_timer_get_base(1);
> +
> +	writel(0, base + OWL_Tx_CTL);
> +
> +	writel(0, base + OWL_Tx_VAL);

> +	writel(evt, base + OWL_Tx_CMP);
> +
> +	writel(OWL_Tx_CTL_EN | OWL_Tx_CTL_INTEN, base + OWL_Tx_CTL);
> +
> +	return 0;
> +}
> +
> +static struct clock_event_device owl_clockevent = {
> +	.name			= "owl_tick",
> +	.rating			= 200,
> +	.features		= CLOCK_EVT_FEAT_ONESHOT |
> +				  CLOCK_EVT_FEAT_DYNIRQ,
> +	.set_state_shutdown	= owl_timer_set_state_shutdown,
> +	.set_state_oneshot	= owl_timer_set_state_oneshot,
> +	.tick_resume		= owl_timer_tick_resume,
> +	.set_next_event		= owl_timer_set_next_event,
> +};
> +
> +static irqreturn_t owl_timer1_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> +
> +	writel(OWL_Tx_CTL_PD, owl_timer_get_base(1) + OWL_Tx_CTL);
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct owl_timer_info s500_timer_info = {
> +	.timer_offset[0] = 0x08,
> +	.timer_offset[1] = 0x14,
> +};
> +
> +static const struct of_device_id owl_timer_of_matches[] = {
> +	{ .compatible = "actions,s500-timer", .data = &s500_timer_info },
> +	{ }
> +};
> +
> +static int __init owl_timer_init(struct device_node *node)
> +{
> +	const struct of_device_id *match;
> +	struct clk *clk;
> +	unsigned long rate;
> +	int timer1_irq, i, ret;
> +
> +	match = of_match_node(owl_timer_of_matches, node);
> +	if (!match || !match->data) {
> +		pr_err("Unknown compatible");
> +		return -EINVAL;
> +	}
> +
> +	owl_timer_info = match->data;
> +
> +	owl_timer_base = of_io_request_and_map(node, 0, "owl-timer");
> +	if (IS_ERR(owl_timer_base)) {
> +		pr_err("Can't map timer registers");
> +		return PTR_ERR(owl_timer_base);
> +	}
> +
> +	timer1_irq = of_irq_get_byname(node, "Timer1");
> +	if (timer1_irq <= 0) {
> +		pr_err("Can't parse Timer1 IRQ");
> +		return -EINVAL;
> +	}
> +
> +	clk = of_clk_get(node, 0);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	rate = clk_get_rate(clk);
> +
> +	for (i = 0; i < OWL_MAX_Tx; i++)
> +		owl_timer_reset(i);
> +
> +	writel(OWL_Tx_CTL_EN, owl_timer_get_base(0) + OWL_Tx_CTL);
> +
> +	sched_clock_register(owl_timer_sched_read, 32, rate);
> +	clocksource_mmio_init(owl_timer_get_base(0) + OWL_Tx_VAL, node->name,
> +			      rate, 200, 32, clocksource_mmio_readl_up);
> +
> +	ret = request_irq(timer1_irq, owl_timer1_interrupt, IRQF_TIMER,
> +			  "owl-timer", &owl_clockevent);
> +	if (ret) {
> +		pr_err("failed to request irq %d\n", timer1_irq);
> +		return ret;
> +	}
> +
> +	owl_clockevent.cpumask = cpumask_of(0);
> +	owl_clockevent.irq = timer1_irq;
> +
> +	clockevents_config_and_register(&owl_clockevent, rate,
> +					0xf, 0xffffffff);
> +
> +	return 0;
> +}
> +CLOCKSOURCE_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
> -- 
> 2.10.2
> 

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
