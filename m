From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 04:15:46 +0200
Subject: [PATCH 10/10] arm: add basic support for Rockchip RK3066a boards
In-Reply-To: <201306030102.20890.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
 <201306030102.20890.heiko@sntech.de>
Message-ID: <5760087.7O4UgypAot@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013 01:02:20 Heiko St?bner wrote:
> index 0000000..094b37d
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rockchip.c

If all goes well, this file can be removed again in 3.11 since it's
all generic, but let's add it for now.

> +
> +static void __init rockchip_timer_init(void)
> +{
> +       rockchip_init_clocks();
> +       dw_apb_timer_init();
> +}

Can't you use 

	of_clk_init(NULL);
	clocksource_of_init();

here and change the two drivers to provide the respective macros?

> +
> +static void __init rockchip_dt_init(void)
> +{
> +#ifdef CONFIG_CACHE_L2X0
> +       l2x0_of_init(0, ~0UL);
> +#endif
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

We still need to find a common location to call l2x0_of_init.

> +
> +static const char * const rockchip_board_dt_compat[] = {
> +       "rockchip,rk2928", /* single core */
> +       "rockchip,rk30xx", /* dual cores */
> +       "rockchip,rk31xx", /* dual and quad cores */
> +       NULL,
> +};

Please use real numbers instead of wildcards: rockchip,rk3066
not rockchip,rk30xx.

> +DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
> +       .map_io         = debug_ll_io_init,
> +       .init_machine   = rockchip_dt_init,
> +       .init_time      = rockchip_timer_init,
> +       .dt_compat      = rockchip_board_dt_compat,
> +MACHINE_END

The map_io line can already get removed.

What about SMP support? Still working on it?

	Arnd
