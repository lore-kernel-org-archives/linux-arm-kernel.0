From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 2 May 2013 10:52:33 +0200
Subject: [PATCH V2 1/2] ARM/MVF600: add Vybrid Family platform support
In-Reply-To: <1367480285-26159-2-git-send-email-b35083@freescale.com>
References: <1367480285-26159-1-git-send-email-b35083@freescale.com>
 <1367480285-26159-2-git-send-email-b35083@freescale.com>
Message-ID: <20130502085233.GO32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 03:38:04PM +0800, Jingchang Lu wrote:
> This patch adds Freescale Vybrid Family platform core definitions,
> core drivers, including clock, period interrupt timer(PIT),
> and DTS based machine support with MVF600 Tower development board.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> V2:
>   Use CLOCKSOURCE_OF_DECLARE init timer
>   Add ONESHOT mode support
>   Add more clks definitions on MVF600 soc
> 
>  .../devicetree/bindings/clock/mvf600-clock.txt     | 180 +++++++++
>  arch/arm/mach-imx/Kconfig                          |  15 +
>  arch/arm/mach-imx/Makefile                         |   3 +
>  arch/arm/mach-imx/clk-mvf.c                        | 406 +++++++++++++++++++++
>  arch/arm/mach-imx/common.h                         |   1 +
>  arch/arm/mach-imx/mach-mvf600.c                    | 118 ++++++
>  arch/arm/mach-imx/pit.c                            | 244 +++++++++++++
>  7 files changed, 967 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mvf600-clock.txt
>  create mode 100644 arch/arm/mach-imx/clk-mvf.c
>  create mode 100644 arch/arm/mach-imx/mach-mvf600.c
>  create mode 100644 arch/arm/mach-imx/pit.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/mvf600-clock.txt b/Documentation/devicetree/bindings/clock/mvf600-clock.txt
> new file mode 100644
> index 0000000..9f8b20e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mvf600-clock.txt

[...]

> +	sys_bus_clk		36
> +	platform_bus_clk	37
> +	ipg_bus_clk		38
> +	uart0_clk		39
> +	uart1_clk		40
> +	uart2_clk		41
> +	uart3_clk		42
> +	uart4_clk		43
> +	uart5_clk		44

remove the _clk. The context makes it clear that it's a clock.

> +
> +#define CCM_CCGRx_CGn(n)		(n * 2)

Does CCM_CCGRx_CGn(1 + 1) give correct results? Always add braces to
the usage of macro arguments.

> +int __init mvf_clocks_init(void)
> +{
> +	struct device_node *np;
> +
> +	clk[dummy] = imx_clk_fixed("dummy", 0);
> +	clk[sirc_128k] = imx_clk_fixed("sirc_128k", 128000); /* slow internal IRC */
> +	clk[sirc_32k] = imx_clk_fixed("sirc_32k", 32000); /* slow internal IRC */
> +	clk[firc] = imx_clk_fixed("firc", 24000000); /* fast internal IRC */
> +	clk[sxosc] = imx_clk_fixed("sxosc", 32000); /* fixed 32k external osc */
> +
> +	for_each_compatible_node(np, NULL, "fixed-clock") {
> +		u32 rate;
> +
> +		if (of_property_read_u32(np, "clock-frequency", &rate))
> +			continue;
> +		else if (of_device_is_compatible(np, "fsl,mvf-osc"))
> +			clk[fxosc] = imx_clk_fixed("fxosc", rate);
> +		else if (of_device_is_compatible(np, "fsl,mvf-audio-ext-clk"))
> +			clk[audio_ext] = imx_clk_fixed("audio_ext", rate);
> +		else if (of_device_is_compatible(np, "fsl,mvf-enet-ext-clk"))
> +			clk[enet_ext] = imx_clk_fixed("enet_ext", rate);
> +	}

Please do the same as https://patchwork.kernel.org/patch/2476681/ does
for i.MX5.

> +
> +
> +void mvf_restart(char mode, const char *cmd)
> +{
> +	struct device_node *np;
> +	void __iomem *wdog_base;
> +	struct clk *wdog_clk;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-wdt");
> +	wdog_base = of_iomap(np, 0);
> +	if (!wdog_base)
> +		goto soft;
> +
> +	wdog_clk = of_clk_get_by_name(np, "wdog");

use of_clk_get.

> +
> +
> +static int __init pit_clocksource_init(struct clk *pit_clk)
> +{
> +	unsigned int c = clk_get_rate(pit_clk);
> +
> +	sched_clock_reg = clksrc_base + PITCVAL;
> +
> +	setup_sched_clock(mvf_read_sched_clock, 32, c);
> +	return clocksource_mmio_init(clksrc_base + PITCVAL, "pit", c, 300, 32,
> +			clocksource_mmio_readl_down);
> +}
> +
> +/* set clock event */
> +static int pit_set_next_event(unsigned long delta,
> +				struct clock_event_device *unused)
> +{
> +	pit_timer_disable();
> +	__raw_writel(delta - 1, clkevt_base + PITLDVAL);
> +	pit_irq_acknowledge();
> +	pit_timer_enable();

You disable/enable the timer each time here, is this necessary? You will
get a drift in the timer, that's really not nice.

> +
> +static void __init pit_timer_init(struct device_node *np)
> +{
> +	struct clk *pit_clk;
> +	void __iomem *timer_base;
> +	int irq;
> +
> +	if (!np) {
> +		pr_err("Failed to find pit DT node\n");
> +		BUG();
> +	}
> +
> +	timer_base = of_iomap(np, 0);
> +	WARN_ON(!timer_base);
> +
> +	/* chose PIT2 as clocksource, PIT3 as clockevent dev */
> +	clksrc_base = timer_base + PITOFFSETx(2);
> +	clkevt_base = timer_base + PITOFFSETx(3);
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +
> +	pit_clk = of_clk_get_by_name(np, "pit");

Use of_clk_get

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
