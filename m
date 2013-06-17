From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Jun 2013 14:35:15 -0700
Subject: [PATCH v4 4/4] arm: add basic support for Rockchip RK3066a boards
In-Reply-To: <201306131702.13400.heiko@sntech.de>
References: <201306131658.36584.heiko@sntech.de>
 <201306131702.13400.heiko@sntech.de>
Message-ID: <20130617213515.GK28497@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just some small comments below. Once fixed:

Acked-by: Olof Johansson <olof@lixom.net>

On Thu, Jun 13, 2013 at 05:02:13PM +0200, Heiko St?bner wrote:

> +		dwmmc at 10214000 {
> +			compatible = "rockchip,rk2928-dw-mshc";

does it make sense to fall back and also specify "snps,dw-mshc"?

> diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
> new file mode 100644
> index 0000000..0933e17
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/rockchip.c
> @@ -0,0 +1,54 @@
> +/*
> + * Device Tree support for Rockchip SoCs
> + *
> + * Copyright (c) 2013 MundoReader S.L.
> + * Author: Heiko Stuebner <heiko@sntech.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +#include <linux/irqchip.h>
> +#include <linux/dw_apb_timer.h>
> +#include <linux/clk-provider.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/hardware/cache-l2x0.h>
> +
> +static void __init rockchip_timer_init(void)
> +{
> +	of_clk_init(NULL);
> +	clocksource_of_init();
> +}
> +
> +static void __init rockchip_dt_init(void)
> +{
> +#ifdef CONFIG_CACHE_L2X0
> +	l2x0_of_init(0, ~0UL);
> +#endif

No need to ifdef, there's a stub if CONFIG_CACHE_L2X0 isn't defined.

Side comment: I think it would be nice if the generic code did this
init if a l2x0 device node was in the device tree, since the only
reason to override init_machine is to do this call in addition to
of_platform_populate().

> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static const char * const rockchip_board_dt_compat[] = {
> +	"rockchip,rk2928",
> +	"rockchip,rk3066a",
> +	"rockchip,rk3066b",
> +	"rockchip,rk3188",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
> +	.init_machine	= rockchip_dt_init,
> +	.init_time	= rockchip_timer_init,
> +	.dt_compat	= rockchip_board_dt_compat,
> +MACHINE_END
