From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Aug 2013 11:46:35 +0100
Subject: [PATCH 06/10] ARM: clps711x: Add CLPS711X clocksource driver
In-Reply-To: <1374172501-26796-7-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-7-git-send-email-shc_work@mail.ru>
Message-ID: <20130802104635.GE2884@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 07:34:57PM +0100, Alexander Shiyan wrote:
> This adds the clocksource driver for Cirrus Logic CLPS711X series SoCs.
> Designed primarily for migration CLPS711X subarch for multiplatform & DT,
> for this as the "OF" and "not-OF" calls implemented.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---

[...]

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
> +
> +static struct {
> +	void __iomem	*tc1d;
> +	int		irq;
> +} *clps711x_clksrc;
> +
> +static u32 notrace clps711x_sched_clock_read(void)
> +{
> +	return ~readw(clps711x_clksrc->tc1d);
> +}
> +
> +static void clps711x_clockevent_set_mode(enum clock_event_mode mode,
> +					 struct clock_event_device *evt)
> +{
> +	disable_irq(clps711x_clksrc->irq);
> +
> +	switch (mode) {
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
> +
> +static struct clock_event_device clps711x_clockevent = {
> +	.name		= "clps711x-clockevent",
> +	.rating		= 300,
> +	.features	= CLOCK_EVT_FEAT_PERIODIC,
> +	.set_mode	= clps711x_clockevent_set_mode,
> +};

This seems to be a global clockevent, or a CPU0-only clockevent. Please
set the cpumask to clarify this, or core clockevent code will scream at
you (see clockevents_register_device).

I assume this doesn't stop in low power states (CLOCK_EVT_FEAT_C3STOP)?

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
> +	.handler	= clps711x_timer_interrupt,
> +};

Is there any reason you need to use irqaction and can't use
{request,free}_irq?

> +
> +static void __init _clps711x_clksrc_init(phys_addr_t phys_base, int irq,
> +					 struct clk *tc1, struct clk *tc2)
> +{
> +	unsigned long tc1_rate, tc2_rate;
> +	void __iomem *tc2d, *syscon1;
> +	u32 tmp;
> +
> +	BUG_ON(IS_ERR(tc1) || IS_ERR(tc2));

Is this the only timer possible in the SoCs it'll be used in? You might
not be capable of initialising this timer, but another timer may be able
to keep the system running...

I don't think the BUGs are necessary, and more robust failure handling
would be preferable.

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
> +
> +	tmp = readl(syscon1);
> +	/* TC1 in free running mode */
> +	tmp &= ~SYSCON1_TC1M;
> +	/* TC2 in prescale mode */
> +	tmp |= SYSCON1_TC2M;
> +	writel(tmp, syscon1);
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

I think the last two actions should be reordered, what if upon
registering the timer the clockevents layer decides to program the
timer? You don't have your interrupt set up, yet you'll try to disable
and enable it...

Thanks,
Mark.
