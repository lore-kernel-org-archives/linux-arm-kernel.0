From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 18 Jun 2013 00:26:25 +0200
Subject: [PATCH v4 4/4] arm: add basic support for Rockchip RK3066a boards
In-Reply-To: <20130617213515.GK28497@quad.lixom.net>
References: <201306131658.36584.heiko@sntech.de>
 <201306131702.13400.heiko@sntech.de> <20130617213515.GK28497@quad.lixom.net>
Message-ID: <201306180026.25973.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 17. Juni 2013, 23:35:15 schrieb Olof Johansson:
> Hi,
> 
> Just some small comments below. Once fixed:
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> On Thu, Jun 13, 2013 at 05:02:13PM +0200, Heiko St?bner wrote:
> > +		dwmmc at 10214000 {
> > +			compatible = "rockchip,rk2928-dw-mshc";
> 
> does it make sense to fall back and also specify "snps,dw-mshc"?

nope, the rockchip-variant is necessary, with the regular dw-mshc it doesn't 
work at all.


> > diff --git a/arch/arm/mach-rockchip/rockchip.c
> > b/arch/arm/mach-rockchip/rockchip.c new file mode 100644
> > index 0000000..0933e17
> > --- /dev/null
> > +++ b/arch/arm/mach-rockchip/rockchip.c
> > @@ -0,0 +1,54 @@
> > +/*
> > + * Device Tree support for Rockchip SoCs
> > + *
> > + * Copyright (c) 2013 MundoReader S.L.
> > + * Author: Heiko Stuebner <heiko@sntech.de>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/dw_apb_timer.h>
> > +#include <linux/clk-provider.h>
> > +#include <asm/mach/arch.h>
> > +#include <asm/mach/map.h>
> > +#include <asm/hardware/cache-l2x0.h>
> > +
> > +static void __init rockchip_timer_init(void)
> > +{
> > +	of_clk_init(NULL);
> > +	clocksource_of_init();
> > +}
> > +
> > +static void __init rockchip_dt_init(void)
> > +{
> > +#ifdef CONFIG_CACHE_L2X0
> > +	l2x0_of_init(0, ~0UL);
> > +#endif
> 
> No need to ifdef, there's a stub if CONFIG_CACHE_L2X0 isn't defined.

ok


> Side comment: I think it would be nice if the generic code did this
> init if a l2x0 device node was in the device tree, since the only
> reason to override init_machine is to do this call in addition to
> of_platform_populate().

Arnd said similar things in the initial version :-).

Currently I'm wondering if it wouldn't be enough to call always l2x0_of_init 
somewhere, because it does the checking for the dt nodes itself already.

The only obstacle would be platforms having the need to use special aux-values 
or which are currently calling the function from some other parts of the boot 
process (tegra inits the cache in its tegra_init_early function for example).


> > +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +}
> > +
> > +static const char * const rockchip_board_dt_compat[] = {
> > +	"rockchip,rk2928",
> > +	"rockchip,rk3066a",
> > +	"rockchip,rk3066b",
> > +	"rockchip,rk3188",
> > +	NULL,
> > +};
> > +
> > +DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
> > +	.init_machine	= rockchip_dt_init,
> > +	.init_time	= rockchip_timer_init,
> > +	.dt_compat	= rockchip_board_dt_compat,
> > +MACHINE_END
