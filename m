From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Nov 2015 14:40:04 +0100
Subject: [RFC PATCH 02/10] clockevents/drivers: add MPS2 Timer driver
In-Reply-To: <1448447621-17900-3-git-send-email-vladimir.murzin@arm.com>
References: <1448447621-17900-1-git-send-email-vladimir.murzin@arm.com>
 <1448447621-17900-3-git-send-email-vladimir.murzin@arm.com>
Message-ID: <5655BA34.9040207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2015 11:33 AM, Vladimir Murzin wrote:
> MPS2 platform has simple 32 bits general purpose countdown timers.
>
> The driver uses the first detected timer as a clocksource and the rest
> of the timers as a clockevent
>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>   drivers/clocksource/Kconfig      |    5 +
>   drivers/clocksource/Makefile     |    1 +
>   drivers/clocksource/mps2-timer.c |  280 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 286 insertions(+)
>   create mode 100644 drivers/clocksource/mps2-timer.c
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 71cfdf7..552ab54 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -136,6 +136,11 @@ config CLKSRC_STM32
>   	depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
>   	select CLKSRC_MMIO
>
> +config CLKSRC_MPS2
> +	bool "Clocksource for MPS2 SoCs"
> +	depends on OF && (ARM || COMPILE_TEST)

bool "Clocksource for MPS2 SoCs" if COMPILE_TEST
depends on OF && ARM

> +	select CLKSRC_MMIO
> +
>   config ARM_ARCH_TIMER
>   	bool
>   	select CLKSRC_OF if OF
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 56bd16e..7033b9c 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_CLKSRC_EFM32)	+= time-efm32.o
>   obj-$(CONFIG_CLKSRC_STM32)	+= timer-stm32.o
>   obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
>   obj-$(CONFIG_CLKSRC_LPC32XX)	+= time-lpc32xx.o
> +obj-$(CONFIG_CLKSRC_MPS2)	+= mps2-timer.o
>   obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
>   obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
>   obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
> diff --git a/drivers/clocksource/mps2-timer.c b/drivers/clocksource/mps2-timer.c
> new file mode 100644
> index 0000000..77befe2
> --- /dev/null
> +++ b/drivers/clocksource/mps2-timer.c
> @@ -0,0 +1,280 @@
> +/*
> + * Copyright (C) 2015 ARM Limited
> + *
> + * Author: Vladimir Murzin <vladimir.murzin@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/of_address.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/sched_clock.h>
> +#include <linux/slab.h>
> +
> +#define TIMER_CTRL		0x0
> +#define TIMER_CTRL_ENABLE	BIT(0)
> +#define TIMER_CTRL_IE		BIT(3)
> +
> +#define TIMER_VALUE		0x4
> +#define TIMER_RELOAD		0x8
> +#define TIMER_INT		0xc
> +
> +struct clockevent_mps2 {
> +	void __iomem *reg;
> +	u32 clock_count_per_tick;
> +	struct clock_event_device clkevt;
> +};
> +
> +static void __iomem *sched_clock_base;
> +
> +static u64 notrace mps2_sched_read(void)
> +{
> +        return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
> +}
> +
> +

extra line.

> +static inline struct clockevent_mps2 *to_mps2_clkevt(struct clock_event_device *c)
> +{
> +	return container_of(c, struct clockevent_mps2, clkevt);
> +}
> +
> +static void clockevent_mps2_writel(u32 val, struct clock_event_device *c, u32 offset)
> +{
> +	writel(val, to_mps2_clkevt(c)->reg + offset);
> +}
> +
> +static int mps2_timer_shutdown(struct clock_event_device *ce)
> +{
> +	clockevent_mps2_writel(0, ce, TIMER_RELOAD);
> +	clockevent_mps2_writel(0, ce, TIMER_CTRL);
> +
> +	return 0;
> +}
> +
> +static int mps2_timer_set_next_event(unsigned long next, struct clock_event_device *ce)
> +{
> +	clockevent_mps2_writel(next, ce, TIMER_VALUE);
> +	clockevent_mps2_writel(TIMER_CTRL_IE | TIMER_CTRL_ENABLE, ce, TIMER_CTRL);
> +
> +	return 0;
> +}
> +
> +static int mps2_timer_set_periodic(struct clock_event_device *ce)
> +{
> +	u32 clock_count_per_tick = to_mps2_clkevt(ce)->clock_count_per_tick;
> +
> +	clockevent_mps2_writel(clock_count_per_tick, ce, TIMER_RELOAD);
> +	clockevent_mps2_writel(clock_count_per_tick, ce, TIMER_VALUE);
> +	clockevent_mps2_writel(TIMER_CTRL_IE | TIMER_CTRL_ENABLE, ce, TIMER_CTRL);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t mps2_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clockevent_mps2 *ce = dev_id;
> +	u32 status = readl(ce->reg + TIMER_INT);
> +
> +	if (!status)
> +		return IRQ_NONE;

Why that could happen ? Add a comment.

> +
> +	writel(1, ce->reg + TIMER_INT);
> +
> +	ce->clkevt.event_handler(&ce->clkevt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init mps2_clockevents_init(struct device_node *np)
> +{
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct irqaction *ia;
> +	struct clockevent_mps2 *ce;
> +	u32 rate;
> +	int irq, ret;
> +	const char *name = "mps2-clkevt";
> +
> +	ret = of_property_read_u32(np, "clock-frequency", &rate);
> +

extra line.

> +	if (ret) {
> +		clk = of_clk_get(np, 0);
> +		if (IS_ERR(clk)) {
> +			ret = PTR_ERR(clk);
> +			pr_err("failed to get clock for clockevent: %d\n", ret);
> +			goto err_clk_get;
> +		}
> +
> +		ret = clk_prepare_enable(clk);
> +		if (ret) {
> +			pr_err("failed to enable clock for clockevent: %d\n", ret);
> +			clk_put(clk);
> +			goto err_clk_enable;
> +		}
> +
> +		rate = clk_get_rate(clk);
> +	}
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		ret = -EADDRNOTAVAIL;
> +		pr_err("failed to map register for clockevent: %d\n", ret);
> +		goto err_iomap;
> +	}
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (!irq) {
> +		ret = -ENOENT;
> +		pr_err("failed to get irq for clockevent: %d\n", ret);
> +		goto err_get_irq;
> +	}
> +
> +	ce = kzalloc(sizeof(struct clockevent_mps2), GFP_KERNEL);
> +	if (!ce) {
> +		ret = -ENOMEM;
> +		pr_err("failed to allocate clockevent: %d\n", ret);
> +		goto err_ce_alloc;
> +	}
> +
> +	ce->reg = base;
> +	ce->clock_count_per_tick = DIV_ROUND_CLOSEST(rate, HZ);
> +	ce->clkevt.irq = irq;
> +	ce->clkevt.name = name;
> +	ce->clkevt.rating = 200;
> +	ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> +	ce->clkevt.cpumask = cpu_possible_mask;
> +	ce->clkevt.set_state_shutdown	= mps2_timer_shutdown,
> +	ce->clkevt.set_state_periodic	= mps2_timer_set_periodic,
> +	ce->clkevt.set_state_oneshot	= mps2_timer_shutdown,
> +	ce->clkevt.set_next_event	= mps2_timer_set_next_event;
> +
> +	ia = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
> +	if (!ia) {
> +		ret = -ENOMEM;
> +		pr_err("failed to allocate irqaction: %d\n", ret);
> +		goto err_ia_alloc;
> +	}
> +
> +	ia->name = name;
> +	ia->flags = IRQF_TIMER;
> +	ia->handler = mps2_timer_interrupt;
> +	ia->dev_id = ce;
> +
> +	writel(0, base + TIMER_CTRL);
> +
> +	ret = setup_irq(irq, ia);

Use request_irq here, that will save some extra code in this driver.

> +	if (ret) {
> +		pr_err("failed to setup irq: %d\n", ret);
> +		goto err_setup_irq;
> +	}
> +
> +	clockevents_config_and_register(&ce->clkevt, rate, 0xf, 0xffffffff);
> +
> +	return 0;
> +
> +err_setup_irq:
> +	kfree(ia);
> +err_ia_alloc:
> +	kfree(ce);
> +err_ce_alloc:
> +err_get_irq:
> +	iounmap(base);
> +err_iomap:
> +	clk_disable_unprepare(clk);
> +err_clk_enable:
> +	clk_put(clk);
> +err_clk_get:
> +	return ret;
> +}
> +
> +static int mps2_clocksource_init(struct device_node *np)

__init annotation.

> +{
> +	void __iomem *base;
> +	struct clk *clk;
> +	u32 rate;
> +	int ret;
> +	const char *name = "mps2-clksrc";
> +
> +	ret = of_property_read_u32(np, "clock-frequency", &rate);
> +

extra line.

> +	if (ret) {
> +		clk = of_clk_get(np, 0);
> +		if (IS_ERR(clk)) {
> +			ret = PTR_ERR(clk);
> +			pr_err("failed to get clock for clocksource: %d\n", ret);
> +			goto err_clk_get;
> +		}
> +
> +		ret = clk_prepare_enable(clk);
> +		if (ret) {
> +			pr_err("failed to enable clock for clocksource: %d\n", ret);
> +			clk_put(clk);
> +			goto err_clk_enable;
> +		}
> +
> +		rate = clk_get_rate(clk);
> +	}
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		ret = -EADDRNOTAVAIL;
> +		pr_err("failed to map register for clocksource: %d\n", ret);
> +		goto err_iomap;
> +	}
> +
> +	writel(0, base + TIMER_CTRL);
> +
> +	writel(0xffffffff, base + TIMER_VALUE);
> +	writel(0xffffffff, base + TIMER_RELOAD);
> +
> +	writel(TIMER_CTRL_ENABLE, base + TIMER_CTRL);

A comment would help to understand the above 4 lines.

> +	ret = clocksource_mmio_init(base + TIMER_VALUE, name,
> +				    rate, 200, 32,
> +				    clocksource_mmio_readl_down);
> +	if (ret) {
> +		pr_err("failed to init clocksource: %d\n", ret);
> +		goto err_clocksource_init;
> +	}
> +
> +	sched_clock_base = base;
> +	sched_clock_register(mps2_sched_read, 32, rate);
> +
> +	return 0;
> +
> +err_clocksource_init:
> +	iounmap(base);
> +err_iomap:
> +	clk_disable_unprepare(clk);
> +err_clk_enable:
> +	clk_put(clk);
> +err_clk_get:
> +	return ret;
> +

extra line.

> +}
> +
> +static void __init mps2_timer_init(struct device_node *np)
> +{
> +	static int clksrc;
> +
> +	if (!clksrc && !mps2_clocksource_init(np))
> +		clksrc = 1;
> +	else
> +		mps2_clockevents_init(np);

That assumes the clocksource is defined before the clockevents in the 
DT. If it is not the case, the mps2_clocksource_init will fail (and spit 
errors) and mps2_clockevents_init() won't be called.

> +}
> +
> +CLOCKSOURCE_OF_DECLARE(mps2_timer, "arm,mps2-timer", mps2_timer_init);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
