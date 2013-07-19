From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 19 Jul 2013 16:38:54 +0200
Subject: [PATCH 06/10] ARM: clps711x: Add CLPS711X clocksource driver
In-Reply-To: <1374172501-26796-7-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-7-git-send-email-shc_work@mail.ru>
Message-ID: <51E94F7E.4030404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

(Added Thomas and John in Cc in case they want to review the patch).

On 07/18/2013 08:34 PM, Alexander Shiyan wrote:
> This adds the clocksource driver for Cirrus Logic CLPS711X series SoCs.
> Designed primarily for migration CLPS711X subarch for multiplatform & DT,
> for this as the "OF" and "not-OF" calls implemented.

When a new driver is submitted, I ask for a more detailed changelog
about the driver itself: how it works, any specificities, etc ...

That will help people to understand the code better at least for the review.

> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/Kconfig                      |   2 -
>  drivers/clocksource/Kconfig           |   6 ++
>  drivers/clocksource/Makefile          |   1 +
>  drivers/clocksource/clps711x-clksrc.c | 151 ++++++++++++++++++++++++++++++++++
>  4 files changed, 158 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clocksource/clps711x-clksrc.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index dfb1e7f..5c60cb7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -370,10 +370,8 @@ config ARCH_CLPS711X
>  	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
>  	select ARCH_REQUIRE_GPIOLIB
>  	select AUTO_ZRELADDR
> -	select CLKSRC_MMIO
>  	select COMMON_CLK
>  	select CPU_ARM720T
> -	select GENERIC_CLOCKEVENTS
>  	select MFD_SYSCON
>  	select MULTI_IRQ_HANDLER
>  	select SPARSE_IRQ
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index b7b9b04..bd6dc82 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -41,6 +41,12 @@ config VT8500_TIMER
>  config CADENCE_TTC_TIMER
>  	bool
>  
> +config CLKSRC_CLPS711X
> +	def_bool y if ARCH_CLPS711X
> +	select CLKSRC_MMIO
> +	select CLKSRC_OF if OF
> +	select GENERIC_CLOCKEVENTS
> +
>  config CLKSRC_NOMADIK_MTU
>  	bool
>  	depends on (ARCH_NOMADIK || ARCH_U8500)
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 8b00c5c..da6c102 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
>  obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
>  obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
>  obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
> +obj-$(CONFIG_CLKSRC_CLPS711X)	+= clps711x-clksrc.o
>  obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
>  obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
>  obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
> diff --git a/drivers/clocksource/clps711x-clksrc.c b/drivers/clocksource/clps711x-clksrc.c
> new file mode 100644
> index 0000000..1749b0b
> --- /dev/null
> +++ b/drivers/clocksource/clps711x-clksrc.c
> @@ -0,0 +1,151 @@
> +/*
> + *  CLPS711X clocksource driver
> + *
> + *  Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/sched_clock.h>
> +#include <linux/slab.h>
> +
> +#include <linux/mfd/syscon/clps711x.h>
> +
> +#define CLPS711X_SYSCON1	(0x0100)
> +#define CLPS711X_TC1D		(0x0300)
> +#define CLPS711X_TC2D		(0x0340)

Alignment.

> +
> +static struct {
> +	void __iomem	*tc1d;
> +	int		irq;
> +} *clps711x_clksrc;

You don't need to define this structure, the struct clock_event_device
already contains a field with irq.

> +static u32 notrace clps711x_sched_clock_read(void)
> +{
> +	return ~readw(clps711x_clksrc->tc1d);
> +}
> +
> +static void clps711x_clockevent_set_mode(enum clock_event_mode mode,
> +					 struct clock_event_device *evt)
> +{
> +	disable_irq(clps711x_clksrc->irq);

Do you really need to disable the interrupt to re-enable it right after ?

> +> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		enable_irq(clps711x_clksrc->irq);
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		/* Not supported */
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_RESUME:
> +		/* Left event sources disabled, no more interrupts appear */
> +		break;
> +	}
> +}

I am not expert in interrupts, but it is possible this interrupt could
be shared ?

There isn't a register to enable/disable the timer ?

> +
> +static struct clock_event_device clps711x_clockevent = {
> +	.name		= "clps711x-clockevent",
> +	.rating		= 300,
> +	.features	= CLOCK_EVT_FEAT_PERIODIC,
> +	.set_mode	= clps711x_clockevent_set_mode,
> +};
> +
> +static irqreturn_t clps711x_timer_interrupt(int irq, void *dev_id)
> +{
> +	clps711x_clockevent.event_handler(&clps711x_clockevent);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction clps711x_timer_irq = {
> +	.name		= "clps711x-timer",
> +	.flags		= IRQF_TIMER | IRQF_IRQPOLL,

Why do you need IRQF_IRQPOOL ?

> +	.handler	= clps711x_timer_interrupt,
> +};
> +
> +static void __init _clps711x_clksrc_init(phys_addr_t phys_base, int irq,
> +					 struct clk *tc1, struct clk *tc2)
> +{
> +	unsigned long tc1_rate, tc2_rate;
> +	void __iomem *tc2d, *syscon1;
> +	u32 tmp;
> +
> +	BUG_ON(IS_ERR(tc1) || IS_ERR(tc2));
> +
> +	BUG_ON(!request_mem_region(phys_base + CLPS711X_TC1D, SZ_2, NULL));
> +	BUG_ON(!request_mem_region(phys_base + CLPS711X_TC2D, SZ_2, NULL));
> +
> +	clps711x_clksrc = kzalloc(sizeof(*clps711x_clksrc), GFP_KERNEL);
> +	BUG_ON(!clps711x_clksrc);
> +
> +	clps711x_clksrc->tc1d = ioremap(phys_base + CLPS711X_TC1D, SZ_2);
> +	BUG_ON(!clps711x_clksrc->tc1d);
> +
> +	tc2d = ioremap(phys_base + CLPS711X_TC2D, SZ_2);
> +	BUG_ON(!tc2d);
> +
> +	syscon1 = ioremap(phys_base + CLPS711X_SYSCON1, SZ_4);
> +	BUG_ON(!syscon1);
> +
> +	clps711x_clksrc->irq = irq;

	clps711x_clockevent.irq = irq;

	clps711x_clockevent.cpumask = ?

> +	tmp = readl(syscon1);
> +	/* TC1 in free running mode */
> +	tmp &= ~SYSCON1_TC1M;
> +	/* TC2 in prescale mode */
> +	tmp |= SYSCON1_TC2M;
> +	writel(tmp, syscon1);

Could you encapsulate these calls inside a static inline function with a
more detailed comment please ?

> +
> +	tc1_rate = clk_get_rate(tc1);
> +	tc2_rate = clk_get_rate(tc2);
> +
> +	clocksource_mmio_init(clps711x_clksrc->tc1d, "clps711x-clocksource",
> +			      tc1_rate, 300, 16, clocksource_mmio_readw_down);
> +
> +	setup_sched_clock(clps711x_sched_clock_read, 16, tc1_rate);
> +
> +	/* Set Timer prescaler */
> +	writew(DIV_ROUND_CLOSEST(tc2_rate, HZ), tc2d);
> +
> +	clockevents_config_and_register(&clps711x_clockevent, tc2_rate, 0, 0);
> +
> +	BUG_ON(setup_irq(clps711x_clksrc->irq, &clps711x_timer_irq));
> +}
> +
> +void __init clps711x_clksrc_init(phys_addr_t phys_base, int irq)

Is this function called somewhere ? I don't see the function definition ?

> +{
> +	struct clk *tc1 = clk_get(NULL, "tc1");
> +	struct clk *tc2 = clk_get(NULL, "tc2");
> +
> +	_clps711x_clksrc_init(phys_base, irq, tc1, tc2);
> +}
> +
> +#ifdef CONFIG_CLKSRC_OF
> +static void __init clps711x_clksrc_init_dt(struct device_node *np)
> +{
> +	struct clk *tc1 = of_clk_get_by_name(np, "tc1");
> +	struct clk *tc2 = of_clk_get_by_name(np, "tc2");
> +	struct resource res_io, res_irq;
> +
> +	BUG_ON(!of_address_to_resource(np, 0, &res_io));
> +
> +	BUG_ON(!of_irq_to_resource(np, 0, &res_irq));
> +
> +	_clps711x_clksrc_init(res_io.start, res_irq.start, tc1, tc2);
> +}
> +CLOCKSOURCE_OF_DECLARE(clps711x, "cirrus,clps711x-clocksource",
> +		       clps711x_clksrc_init_dt);
> +#endif
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
