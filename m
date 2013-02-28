From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Feb 2013 11:04:13 +0000
Subject: [PATCH 3/7] ARM: hs: add board support with device tree
In-Reply-To: <1362035966-17628-3-git-send-email-haojian.zhuang@linaro.org>
References: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
 <1362035966-17628-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <201302281104.13885.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 February 2013, Haojian Zhuang wrote:
> Add board support with device tree for Hisilicon Hi36xx/Hi37xx platform.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Ah, nice and small ;-)

>  arch/arm/Kconfig          |    2 ++
>  arch/arm/Makefile         |    1 +
>  arch/arm/mach-hs/Kconfig  |   23 +++++++++++++
>  arch/arm/mach-hs/Makefile |    5 +++
>  arch/arm/mach-hs/hs-dt.c  |   83 +++++++++++++++++++++++++++++++++++++++++++++

Regarding the naming, I wonder if "hs" is unique enough for a platform name.
AFAIK, HiSilicon has a couple of independently developed SoC families,
so we might want to be a bit more specific here, e.g. mach-hi3xxx.

Regarding the file name, I think the "-dt" postfix is redundant, when we
only support booting using DT. I would call this one the same thing as the
platform name, whichever we go with.

> +config MACH_HS_DT
> +	bool "Hisilicon Development Board"
> +	default y
> +	help
> +	  Say 'Y' here if you want to support the Hisilicon Development
> +	  Board. 
> +
> +endif

I don't think we need this option. Let's just always build the file
when the platform is enabled, and build all .dtb files as well.

> +static struct clk_lookup sp804_lookup = {
> +	.dev_id	= "sp804",
> +	.clk	= NULL,
> +};

(adding Mike to Cc)

Shouldn't the clk_lookup be automatic with a fully DT enabled platform now?

> +extern void __init hs_init_clocks(void);
> +static void __init hs_timer_init(void)
> +{
> +	struct device_node *node = NULL;
> +	void __iomem *base;
> +	int irq;
> +
> +	hs_init_clocks();
> +
> +	node = of_find_matching_node(NULL, hs_timer_match);
> +	WARN_ON(!node);
> +	if (!node) {
> +		pr_err("Failed to find sp804 timer\n");
> +		return;
> +	}
> +	base = of_iomap(node, 0);
> +	WARN_ON(!base);
> +
> +	/* timer0 is used as clock event, and timer1 is clock source. */
> +	irq = irq_of_parse_and_map(node, 0);
> +	WARN_ON(!irq);
> +
> +	sp804_lookup.clk = of_clk_get(node, 0);
> +	clkdev_add(&sp804_lookup);
> +
> +	sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE, "timer1");
> +	sp804_clockevents_init(base, irq, "timer0");
> +}

I think for the clocksource/clockevents driver, we should move
arch/arm/common/timer-sp.c to drivers/clocksource now and integrate
it into the automatic probing through clocksource_of_init().

> +static void __init hs_init(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static const char *hs_compat[] __initdata = {
> +	"hisilicon,hi3620-hi4511",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(HS_DT, "Hisilicon Hi36xx/Hi37xx (Flattened Device Tree)")
> +	/* Maintainer: Haojian Zhuang <haojian.zhuang@linaro.org> */
> +	.map_io		= debug_ll_io_init,
> +	.init_irq	= irqchip_init,
> +	.init_time	= hs_timer_init,
> +	.init_machine	= hs_init,
> +	.dt_compat	= hs_compat,
> +MACHINE_END

This looks right at the moment, but I also have a patch to make it possible to drop the
irqchip_init, clocksource_of_init and hs_init() calls here, as they are all the
defaults. At that point, the platform would be essentially empty except for the
debug_ll_io_init part that is inherently platform specific. 

	Arnd
