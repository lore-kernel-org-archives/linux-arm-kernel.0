From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 Nov 2016 11:32:32 +0100
Subject: [PATCH v2 04/10] clk: rockchip: add clock controller for rk1108
In-Reply-To: <1479125262-24294-1-git-send-email-andy.yan@rock-chips.com>
References: <1479124550-24037-1-git-send-email-andy.yan@rock-chips.com>
 <1479125262-24294-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <2185081.FigXhudOUe@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 14. November 2016, 20:07:42 CET schrieb Andy Yan:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Add the clock tree definition and driver for rk1108 SoC.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Jacob Chen <jacob2.chen@rock-chips.com>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
> Changes in v2:
> - fix some CodingStyle issues
> 
>  drivers/clk/rockchip/Makefile     |   1 +
>  drivers/clk/rockchip/clk-rk1108.c | 451
> ++++++++++++++++++++++++++++++++++++++ drivers/clk/rockchip/clk.h        | 
> 14 ++
>  3 files changed, 466 insertions(+)
>  create mode 100644 drivers/clk/rockchip/clk-rk1108.c
> 
> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
> index b5f2c8e..16e098c 100644
> --- a/drivers/clk/rockchip/Makefile
> +++ b/drivers/clk/rockchip/Makefile
> @@ -11,6 +11,7 @@ obj-y	+= clk-mmc-phase.o
>  obj-y	+= clk-ddr.o
>  obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
> 
> +obj-y	+= clk-rk1108.o
>  obj-y	+= clk-rk3036.o
>  obj-y	+= clk-rk3188.o
>  obj-y	+= clk-rk3228.o
> diff --git a/drivers/clk/rockchip/clk-rk1108.c
> b/drivers/clk/rockchip/clk-rk1108.c new file mode 100644
> index 0000000..e3a4f74
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-rk1108.c
> @@ -0,0 +1,451 @@
> +/*
> + * Copyright (c) 2016 Rockchip Electronics Co. Ltd.
> + * Author: Shawn Lin <shawn.lin@rock-chips.com>
> + *         Andy Yan <andy.yan@rock-chips.com>
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
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/syscore_ops.h>
> +#include <dt-bindings/clock/rk1108-cru.h>
> +#include "clk.h"
> +
> +#define RK1108_GRF_SOC_STATUS0	0x480
> +
> +enum rk1108_plls {
> +	apll, dpll, gpll,
> +};
> +
> +static struct rockchip_pll_rate_table rk1108_pll_rates[] = {
> +	/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
> +	RK3036_PLL_RATE(1608000000, 1, 67, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1584000000, 1, 66, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1560000000, 1, 65, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1536000000, 1, 64, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1512000000, 1, 63, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1488000000, 1, 62, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1464000000, 1, 61, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1440000000, 1, 60, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1416000000, 1, 59, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1392000000, 1, 58, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1368000000, 1, 57, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1344000000, 1, 56, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1320000000, 1, 55, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1296000000, 1, 54, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1272000000, 1, 53, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1248000000, 1, 52, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1200000000, 1, 50, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1188000000, 2, 99, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1104000000, 1, 46, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1100000000, 12, 550, 1, 1, 1, 0),
> +	RK3036_PLL_RATE(1008000000, 1, 84, 2, 1, 1, 0),
> +	RK3036_PLL_RATE(1000000000, 6, 500, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 984000000, 1, 82, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 960000000, 1, 80, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 936000000, 1, 78, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 912000000, 1, 76, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 900000000, 4, 300, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 888000000, 1, 74, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 864000000, 1, 72, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 840000000, 1, 70, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 816000000, 1, 68, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 800000000, 6, 400, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 700000000, 6, 350, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 696000000, 1, 58, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 600000000, 1, 75, 3, 1, 1, 0),
> +	RK3036_PLL_RATE( 594000000, 2, 99, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 504000000, 1, 63, 3, 1, 1, 0),
> +	RK3036_PLL_RATE( 500000000, 6, 250, 2, 1, 1, 0),
> +	RK3036_PLL_RATE( 408000000, 1, 68, 2, 2, 1, 0),
> +	RK3036_PLL_RATE( 312000000, 1, 52, 2, 2, 1, 0),
> +	RK3036_PLL_RATE( 216000000, 1, 72, 4, 2, 1, 0),
> +	RK3036_PLL_RATE(  96000000, 1, 64, 4, 4, 1, 0),
> +	{ /* sentinel */ },
> +};
> +
> +#define RK1108_DIV_CORE_MASK		0xf
> +#define RK1108_DIV_CORE_SHIFT		4
> +
> +#define RK1108_CLKSEL0(_core_peri_div)					\
> +	{									\
> +		.reg = RK1108_CLKSEL_CON(1),					\
> +		.val = HIWORD_UPDATE(_core_peri_div, RK1108_DIV_CORE_MASK,	\
> +				RK1108_DIV_CORE_SHIFT)				\
> +	}
> +
> +#define RK1108_CPUCLK_RATE(_prate, _core_peri_div)			\
> +	{								\
> +		.prate = _prate,					\
> +		.divs = {						\
> +			RK1108_CLKSEL0(_core_peri_div),		\
> +		},							\
> +	}
> +
> +static struct rockchip_cpuclk_rate_table rk1108_cpuclk_rates[] __initdata =
> { +	RK1108_CPUCLK_RATE(816000000, 4),
> +	RK1108_CPUCLK_RATE(600000000, 4),
> +	RK1108_CPUCLK_RATE(312000000, 4),
> +};
> +
> +static const struct rockchip_cpuclk_reg_data rk1108_cpuclk_data = {
> +	.core_reg = RK1108_CLKSEL_CON(0),
> +	.div_core_shift = 0,
> +	.div_core_mask = 0x1f,
> +	.mux_core_alt = 1,
> +	.mux_core_main = 0,
> +	.mux_core_shift = 8,
> +	.mux_core_mask = 0x1,
> +};
> +
> +PNAME(mux_pll_p)		= { "xin24m", "xin24m"};
> +PNAME(mux_ddrphy_p)		= { "dpll_ddr", "gpll_ddr", "apll_ddr" };
> +PNAME(mux_armclk_p)		= { "apll_core", "gpll_core", "dpll_core" };
> +PNAME(mux_pmu_1f)		= { "xin24m", "pmu_24m"};
> +PNAME(mux_usb480m_phy_p)	= { "usb480m_phy0", "usb480m_phy1" };
> +PNAME(mux_usb480m_p)		= { "usb480m_phy", "xin24m" };
> +PNAME(mux_hdmiphy_p)		= { "hdmiphy_phy", "pclk_top_pre", "xin24m" };

pmu_1f, usbphy and hdmiphy do not seem to be used in this driver, while they 
are specified in the clock documentation.

Also there is a discrepancy between your pmu_24m and pmu_24m_ena below I 
think.


The rest looks sane but I didn't check every register offset :-) .


Heiko
