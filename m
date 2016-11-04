From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 4 Nov 2016 10:09:07 +0800
Subject: [PATCH 3/6] clk: rockchip: add clock controller for rk1108
In-Reply-To: <1478176713-12066-1-git-send-email-andy.yan@rock-chips.com>
References: <1478175975-11779-1-git-send-email-andy.yan@rock-chips.com>
 <1478176713-12066-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <f8b42f05-1f00-7f13-173c-4723752beece@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 2016/11/3 20:38, Andy Yan wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
>
> Add the clock tree definition and driver for rk1108 SoC.
>

We should spilt out another patch for adding clock/rst ID
as it should be in a shared branch. :)

You could respin it after Heiko reviews the other parts of
your patchset.

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
>
>  drivers/clk/rockchip/Makefile          |   1 +
>  drivers/clk/rockchip/clk-rk1108.c      | 463 +++++++++++++++++++++++++++++++++
>  drivers/clk/rockchip/clk.h             |  14 +
>  include/dt-bindings/clock/rk1108-cru.h | 308 ++++++++++++++++++++++
>  4 files changed, 786 insertions(+)
>  create mode 100644 drivers/clk/rockchip/clk-rk1108.c
>  create mode 100644 include/dt-bindings/clock/rk1108-cru.h
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
> diff --git a/drivers/clk/rockchip/clk-rk1108.c b/drivers/clk/rockchip/clk-rk1108.c
> new file mode 100644
> index 0000000..eafc623
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-rk1108.c
> @@ -0,0 +1,463 @@
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
> +static struct rockchip_cpuclk_rate_table rk1108_cpuclk_rates[] __initdata = {
> +	RK1108_CPUCLK_RATE(816000000, 4),
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
> +
> +PNAME(mux_ddrphy_p)		= { "dpll_ddr", "gpll_ddr", "apll_ddr" };
> +PNAME(mux_armclk_p)		= { "apll_core", "gpll_core", "dpll_core" };
> +PNAME(mux_pmu_1f)		= { "xin24m", "pmu_24m"};
> +PNAME(mux_usb480m_phy_p)	= { "usb480m_phy0", "usb480m_phy1" };
> +PNAME(mux_usb480m_p)		= { "usb480m_phy", "xin24m" };
> +PNAME(mux_hdmiphy_p)		= { "hdmiphy_phy", "pclk_top_pre", "xin24m" };
> +
> +PNAME(mux_pll_src_4plls_p)	= { "dpll", "hdmiphy", "gpll", "usb480m" };
> +PNAME(mux_pll_src_3plls_p)	= { "apll", "gpll", "dpll" };
> +PNAME(mux_pll_src_2plls_p)	= { "dpll", "gpll" };
> +
> +PNAME(mux_aclk_peri_src_p)	= { "aclk_peri_src_dpll", "aclk_peri_src_gpll" };
> +PNAME(mux_aclk_bus_src_p)	= { "aclk_bus_src_gpll", "aclk_bus_src_apll", "aclk_bus_src_dpll" };
> +
> +PNAME(mux_mmc_src_p)		= { "dpll", "gpll", "xin24m", "usb480m" };
> +PNAME(mux_pll_src_dpll_gpll_usb480m_p)	= { "dpll", "gpll", "usb480m" };
> +
> +
> +PNAME(mux_uart0_p)		= { "uart0_src", "uart0_frac", "xin24m" };
> +PNAME(mux_uart1_p)		= { "uart1_src", "uart1_frac", "xin24m" };
> +PNAME(mux_uart2_p)		= { "uart2_src", "uart2_frac", "xin24m" };
> +
> +
> +static struct rockchip_pll_clock rk1108_pll_clks[] __initdata = {
> +	[apll] = PLL(pll_rk3399, RK1108_APLL_ID, "apll", mux_pll_p, 0, RK1108_PLL_CON(0),
> +		     RK1108_PLL_CON(3), 8, 31, 0, rk1108_pll_rates),
> +	[dpll] = PLL(pll_rk3399, RK1108_DPLL_ID, "dpll", mux_pll_p, 0, RK1108_PLL_CON(8),
> +		     RK1108_PLL_CON(11), 8, 31, 0, NULL),
> +	[gpll] = PLL(pll_rk3399, RK1108_GPLL_ID, "gpll", mux_pll_p, 0, RK1108_PLL_CON(16),
> +		     RK1108_PLL_CON(19), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rk1108_pll_rates),
> +};
> +
> +#define MFLAGS CLK_MUX_HIWORD_MASK
> +#define DFLAGS CLK_DIVIDER_HIWORD_MASK
> +#define GFLAGS (CLK_GATE_HIWORD_MASK | CLK_GATE_SET_TO_DISABLE)
> +
> +
> +static struct rockchip_clk_branch rk1108_uart0_fracmux __initdata =
> +	MUX(SCLK_UART0, "sclk_uart0", mux_uart0_p, CLK_SET_RATE_PARENT,
> +			RK1108_CLKSEL_CON(13), 8, 2, MFLAGS);
> +
> +static struct rockchip_clk_branch rk1108_uart1_fracmux __initdata =
> +	MUX(SCLK_UART1, "sclk_uart1", mux_uart1_p, CLK_SET_RATE_PARENT,
> +			RK1108_CLKSEL_CON(14), 8, 2, MFLAGS);
> +
> +static struct rockchip_clk_branch rk1108_uart2_fracmux __initdata =
> +	MUX(SCLK_UART2, "sclk_uart2", mux_uart2_p, CLK_SET_RATE_PARENT,
> +			RK1108_CLKSEL_CON(15), 8, 2, MFLAGS);
> +
> +static struct rockchip_clk_branch rk1108_clk_branches[] __initdata = {
> +	/*
> +	 * Clock-Architecture Diagram 2
> +	 */
> +
> +	/* PD_CORE */
> +	GATE(0, "dpll_core", "dpll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(0), 1, GFLAGS),
> +	GATE(0, "apll_core", "apll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(0), 0, GFLAGS),
> +	GATE(0, "gpll_core", "gpll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(0), 2, GFLAGS),
> +	COMPOSITE_NOMUX(0, "pclken_dbg", "armclk", CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(1), 4, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
> +			RK1108_CLKGATE_CON(0), 5, GFLAGS),
> +	COMPOSITE_NOMUX(ACLK_ENMCORE, "aclkenm_core", "armclk", CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(1), 0, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
> +			RK1108_CLKGATE_CON(0), 4, GFLAGS),
> +	GATE(ACLK_CORE, "aclk_core", "aclkenm_core", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(11), 0, GFLAGS),
> +	GATE(0, "pclk_dbg", "pclken_dbg", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(11), 1, GFLAGS),
> +
> +	/* PD_RKVENC */
> +
> +	/* PD_RKVDEC */
> +
> +	/* PD_PMU_wrapper */
> +	COMPOSITE_NOMUX(0, "pmu_24m_ena", "gpll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(38), 0, 5, DFLAGS,
> +			RK1108_CLKGATE_CON(8), 12, GFLAGS),
> +	GATE(0, "pmu", "pmu_24m_ena", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(10), 0, GFLAGS),
> +	GATE(0, "intmem1", "pmu_24m_ena", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(10), 1, GFLAGS),
> +	GATE(0, "gpio0_pmu", "pmu_24m_ena", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(10), 2, GFLAGS),
> +	GATE(0, "pmugrf", "pmu_24m_ena", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(10), 3, GFLAGS),
> +	GATE(0, "pmu_noc", "pmu_24m_ena", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(10), 4, GFLAGS),
> +	GATE(0, "i2c0_pmu_pclk", "pmu_24m_ena", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(10), 5, GFLAGS),
> +	GATE(0, "pwm0_pmu_pclk", "pmu_24m_ena", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(10), 6, GFLAGS),
> +	COMPOSITE(0, "pwm0_pmu_clk", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(12), 7, 1, MFLAGS, 0, 7, DFLAGS,
> +			RK1108_CLKGATE_CON(8), 15, GFLAGS),
> +	COMPOSITE(0, "i2c0_pmu_clk", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(19), 7, 1, MFLAGS, 0, 7, DFLAGS,
> +			RK1108_CLKGATE_CON(8), 14, GFLAGS),
> +	GATE(0, "pvtm_pmu", "xin24m", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(8), 13, GFLAGS),
> +
> +
> +
> +	/*
> +	 * Clock-Architecture Diagram 4
> +	 */
> +	COMPOSITE(0, "aclk_vio0_2wrap_occ", mux_pll_src_4plls_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(28), 6, 2, MFLAGS, 0, 5, DFLAGS,
> +			RK1108_CLKGATE_CON(6), 0, GFLAGS),
> +	GATE(0, "aclk_vio0_pre", "aclk_vio0_2wrap_occ", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(17), 0, GFLAGS),
> +	COMPOSITE_NOMUX(0, "hclk_vio_pre", "aclk_vio0_pre", 0,
> +			RK1108_CLKSEL_CON(29), 0, 5, DFLAGS,
> +			RK1108_CLKGATE_CON(7), 2, GFLAGS),
> +	COMPOSITE_NOMUX(0, "pclk_vio_pre", "aclk_vio0_pre", 0,
> +			RK1108_CLKSEL_CON(29), 8, 5, DFLAGS,
> +			RK1108_CLKGATE_CON(7), 3, GFLAGS),
> +
> +
> +	/*
> +	 * Clock-Architecture Diagram 5
> +	 */
> +
> +	/* PD_BUS */
> +	GATE(0, "aclk_bus_src_gpll", "gpll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(1), 0, GFLAGS),
> +	GATE(0, "aclk_bus_src_apll", "apll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(1), 1, GFLAGS),
> +	GATE(0, "aclk_bus_src_dpll", "dpll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(1), 2, GFLAGS),
> +	COMPOSITE_NOGATE(ACLK_PRE, "aclk_bus_pre", mux_aclk_bus_src_p, 0,
> +			RK1108_CLKSEL_CON(2), 8, 2, MFLAGS, 0, 5, DFLAGS),
> +	COMPOSITE_NOMUX(0, "hclk_bus_pre", "aclk_bus_2wrap_occ", 0,
> +			RK1108_CLKSEL_CON(3), 0, 5, DFLAGS,
> +			RK1108_CLKGATE_CON(1), 4, GFLAGS),
> +	COMPOSITE_NOMUX(0, "pclken_bus", "aclk_bus_2wrap_occ", 0,
> +			RK1108_CLKSEL_CON(3), 8, 5, DFLAGS,
> +			RK1108_CLKGATE_CON(1), 5, GFLAGS),
> +	GATE(0, "pclk_bus_pre", "pclken_bus", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(1), 6, GFLAGS),
> +	GATE(0, "pclk_top_pre", "pclken_bus", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(1), 7, GFLAGS),
> +	GATE(0, "pclk_ddr_pre", "pclken_bus", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(1), 8, GFLAGS),
> +	GATE(0, "clk_timer0", "mux_pll_p", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(1), 9, GFLAGS),
> +	GATE(0, "clk_timer1", "mux_pll_p", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(1), 10, GFLAGS),
> +	GATE(0, "pclk_timer", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 4, GFLAGS),
> +
> +	COMPOSITE(0, "uart0_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(13), 12, 2, MFLAGS, 0, 7, DFLAGS,
> +			RK1108_CLKGATE_CON(3), 1, GFLAGS),
> +	COMPOSITE(0, "uart1_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(14), 12, 2, MFLAGS, 0, 7, DFLAGS,
> +			RK1108_CLKGATE_CON(3), 3, GFLAGS),
> +	COMPOSITE(0, "uart21_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(15), 12, 2, MFLAGS, 0, 7, DFLAGS,
> +			RK1108_CLKGATE_CON(3), 5, GFLAGS),
> +
> +	COMPOSITE_FRACMUX(0, "uart0_frac", "uart0_src", CLK_SET_RATE_PARENT,
> +			RK1108_CLKSEL_CON(16), 0,
> +			RK1108_CLKGATE_CON(3), 2, GFLAGS,
> +			&rk1108_uart0_fracmux),
> +	COMPOSITE_FRACMUX(0, "uart1_frac", "uart1_src", CLK_SET_RATE_PARENT,
> +			RK1108_CLKSEL_CON(17), 0,
> +			RK1108_CLKGATE_CON(3), 4, GFLAGS,
> +			&rk1108_uart1_fracmux),
> +	COMPOSITE_FRACMUX(0, "uart2_frac", "uart2_src", CLK_SET_RATE_PARENT,
> +			RK1108_CLKSEL_CON(18), 0,
> +			RK1108_CLKGATE_CON(3), 6, GFLAGS,
> +			&rk1108_uart2_fracmux),
> +	GATE(PCLK_UART0, "pclk_uart0", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 10, GFLAGS),
> +	GATE(PCLK_UART1, "pclk_uart1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 11, GFLAGS),
> +	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 12, GFLAGS),
> +
> +
> +	COMPOSITE(0, "clk_i2c1", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(19), 15, 2, MFLAGS, 8, 7, DFLAGS,
> +			RK1108_CLKGATE_CON(3), 7, GFLAGS),
> +	COMPOSITE(0, "clk_i2c2", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(20), 7, 2, MFLAGS, 0, 7, DFLAGS,
> +			RK1108_CLKGATE_CON(3), 8, GFLAGS),
> +	COMPOSITE(0, "clk_i2c3", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(20), 15, 2, MFLAGS, 8, 7, DFLAGS,
> +			RK1108_CLKGATE_CON(3), 9, GFLAGS),
> +	GATE(0, "pclk_i2c1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 0, GFLAGS),
> +	GATE(0, "pclk_i2c2", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 1, GFLAGS),
> +	GATE(0, "pclk_i2c3", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 2, GFLAGS),
> +	COMPOSITE(0, "clk_pwm1", mux_pll_src_2plls_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(12), 15, 2, MFLAGS, 8, 7, DFLAGS,
> +			RK1108_CLKGATE_CON(3), 10, GFLAGS),
> +	GATE(0, "pclk_pwm1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 6, GFLAGS),
> +	GATE(0, "pclk_wdt", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 3, GFLAGS),
> +	GATE(0, "pclk_gpio1", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 7, GFLAGS),
> +	GATE(0, "pclk_gpio2", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 8, GFLAGS),
> +	GATE(0, "pclk_gpio3", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(13), 9, GFLAGS),
> +
> +	GATE(0, "pclk_grf", "pclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(14), 0, GFLAGS),
> +
> +	GATE(ACLK_DMAC, "aclk_dmac", "aclk_bus_pre", 0,
> +	     RK1108_CLKGATE_CON(12), 2, GFLAGS),
> +	GATE(0, "hclk_rom", "hclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(12), 3, GFLAGS),
> +	GATE(0, "aclk_intmem", "aclk_bus_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(12), 1, GFLAGS),
> +
> +	/* PD_DDR */
> +	GATE(0, "apll_ddr", "apll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(0), 8, GFLAGS),
> +	GATE(0, "dpll_ddr", "dpll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(0), 9, GFLAGS),
> +	GATE(0, "gpll_ddr", "gpll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(0), 10, GFLAGS),
> +	COMPOSITE(0, "ddrphy4x", mux_ddrphy_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(4), 8, 2, MFLAGS, 0, 3, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
> +			RK1108_CLKGATE_CON(10), 9, GFLAGS),
> +	GATE(0, "ddrupctl", "ddrphy_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(12), 4, GFLAGS),
> +	GATE(0, "ddrc", "ddrphy", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(12), 5, GFLAGS),
> +	GATE(0, "ddrmon", "ddrphy_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(12), 6, GFLAGS),
> +	GATE(0, "timer_clk", "xin24m", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(0), 11, GFLAGS),
> +
> +	/*
> +	 * Clock-Architecture Diagram 6
> +	 */
> +
> +	/* PD_PERI */
> +	COMPOSITE_NOMUX(0, "pclk_periph_pre", "gpll", 0,
> +			RK1108_CLKSEL_CON(23), 10, 5, DFLAGS,
> +			RK1108_CLKGATE_CON(4), 5, GFLAGS),
> +	GATE(0, "pclk_periph", "pclk_periph_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(15), 13, GFLAGS),
> +	COMPOSITE_NOMUX(0, "hclk_periph_pre", "gpll", 0,
> +			RK1108_CLKSEL_CON(23), 5, 5, DFLAGS,
> +			RK1108_CLKGATE_CON(4), 4, GFLAGS),
> +	GATE(0, "hclk_periph", "hclk_periph_pre", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(15), 12, GFLAGS),
> +
> +	GATE(0, "aclk_peri_src_dpll", "dpll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(4), 1, GFLAGS),
> +	GATE(0, "aclk_peri_src_gpll", "gpll", CLK_IGNORE_UNUSED,
> +			RK1108_CLKGATE_CON(4), 2, GFLAGS),
> +	COMPOSITE(0, "aclk_periph", mux_aclk_peri_src_p, CLK_IGNORE_UNUSED,
> +			RK1108_CLKSEL_CON(23), 15, 2, MFLAGS, 0, 5, DFLAGS,
> +			RK1108_CLKGATE_CON(15), 11, GFLAGS),
> +
> +	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc0", mux_mmc_src_p, 0,
> +			RK1108_CLKSEL_CON(25), 8, 2, MFLAGS, 0, 8, DFLAGS,
> +			RK1108_CLKGATE_CON(5), 0, GFLAGS),
> +
> +	COMPOSITE_NODIV(0, "sclk_sdio_src", mux_mmc_src_p, 0,
> +			RK1108_CLKSEL_CON(25), 10, 2, MFLAGS,
> +			RK1108_CLKGATE_CON(5), 2, GFLAGS),
> +	DIV(SCLK_SDIO, "sclk_sdio", "sclk_sdio_src", 0,
> +			RK1108_CLKSEL_CON(26), 0, 8, DFLAGS),
> +
> +	COMPOSITE_NODIV(0, "sclk_emmc_src", mux_mmc_src_p, 0,
> +			RK1108_CLKSEL_CON(25), 12, 2, MFLAGS,
> +			RK1108_CLKGATE_CON(5), 1, GFLAGS),
> +	DIV(SCLK_EMMC, "sclk_emmc", "sclk_emmc_src", 0,
> +			RK2928_CLKSEL_CON(26), 8, 8, DFLAGS),
> +	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_periph", 0, RK1108_CLKGATE_CON(15), 0, GFLAGS),
> +	GATE(HCLK_SDIO, "hclk_sdio", "hclk_periph", 0, RK1108_CLKGATE_CON(15), 1, GFLAGS),
> +	GATE(HCLK_EMMC, "hclk_emmc", "hclk_periph", 0, RK1108_CLKGATE_CON(15), 2, GFLAGS),
> +
> +	COMPOSITE(SCLK_NANDC, "sclk_nandc", mux_pll_src_2plls_p, 0,
> +			RK1108_CLKSEL_CON(27), 14, 2, MFLAGS, 8, 5, DFLAGS,
> +			RK1108_CLKGATE_CON(5), 3, GFLAGS),
> +	GATE(HCLK_NANDC, "hclk_nandc", "hclk_periph", 0, RK1108_CLKGATE_CON(15), 3, GFLAGS),
> +
> +	COMPOSITE(SCLK_SFC, "sclk_sfc", mux_pll_src_2plls_p, 0,
> +			RK1108_CLKSEL_CON(27), 7, 2, MFLAGS, 0, 7, DFLAGS,
> +			RK1108_CLKGATE_CON(5), 4, GFLAGS),
> +	GATE(HCLK_SFC, "hclk_sfc", "hclk_periph", 0, RK1108_CLKGATE_CON(15), 10, GFLAGS),
> +	MMC(SCLK_SDMMC_DRV,    "sdmmc_drv",    "sclk_sdmmc", RK1108_SDMMC_CON0, 1),
> +	MMC(SCLK_SDMMC_SAMPLE, "sdmmc_sample", "sclk_sdmmc", RK1108_SDMMC_CON1, 1),
> +
> +	MMC(SCLK_SDIO_DRV,     "sdio_drv",     "sclk_sdio",  RK1108_SDIO_CON0,  1),
> +	MMC(SCLK_SDIO_SAMPLE,  "sdio_sample",  "sclk_sdio",  RK1108_SDIO_CON1,  1),
> +
> +	MMC(SCLK_EMMC_DRV,     "emmc_drv",     "sclk_emmc",  RK1108_EMMC_CON0,  1),
> +	MMC(SCLK_EMMC_SAMPLE,  "emmc_sample",  "sclk_emmc",  RK1108_EMMC_CON1,  1),
> +};
> +
> +static const char *const rk1108_critical_clocks[] __initconst = {
> +	"aclk_core",
> +	"aclk_bus_src_gpll",
> +	"aclk_periph",
> +	"hclk_periph",
> +	"pclk_periph",
> +};
> +
> +static void __init rk1108_clk_init(struct device_node *np)
> +{
> +	struct rockchip_clk_provider *ctx;
> +	void __iomem *reg_base;
> +
> +	reg_base = of_iomap(np, 0);
> +	if (!reg_base) {
> +		pr_err("%s: could not map cru region\n", __func__);
> +		return;
> +	}
> +
> +	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
> +	if (IS_ERR(ctx)) {
> +		pr_err("%s: rockchip clk init failed\n", __func__);
> +		iounmap(reg_base);
> +		return;
> +	}
> +
> +	rockchip_clk_register_plls(ctx, rk1108_pll_clks,
> +				   ARRAY_SIZE(rk1108_pll_clks),
> +				   RK1108_GRF_SOC_STATUS0);
> +	rockchip_clk_register_branches(ctx, rk1108_clk_branches,
> +				  ARRAY_SIZE(rk1108_clk_branches));
> +	rockchip_clk_protect_critical(rk1108_critical_clocks,
> +				      ARRAY_SIZE(rk1108_critical_clocks));
> +
> +	rockchip_clk_register_armclk(ctx, RK1108_ARMCLK, "armclk",
> +			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
> +			&rk1108_cpuclk_data, rk1108_cpuclk_rates,
> +			ARRAY_SIZE(rk1108_cpuclk_rates));
> +
> +	rockchip_register_softrst(np, 13, reg_base + RK1108_SOFTRST_CON(0),
> +				  ROCKCHIP_SOFTRST_HIWORD_MASK);
> +
> +	rockchip_register_restart_notifier(ctx, RK1108_GLB_SRST_FST, NULL);
> +
> +	rockchip_clk_of_add_provider(np, ctx);
> +}
> +CLK_OF_DECLARE(rk1108_cru, "rockchip,rk1108-cru", rk1108_clk_init);
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index 1653edd..90c580a 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -34,6 +34,20 @@ struct clk;
>  #define HIWORD_UPDATE(val, mask, shift) \
>  		((val) << (shift) | (mask) << ((shift) + 16))
>
> +/* register positions shared by RK1108, RK2928, RK3036, RK3066, RK3188 and RK3228 */
> +#define RK1108_PLL_CON(x)		((x) * 0x4)
> +#define RK1108_CLKSEL_CON(x)		((x) * 0x4 + 0x60)
> +#define RK1108_CLKGATE_CON(x)		((x) * 0x4 + 0x120)
> +#define RK1108_SOFTRST_CON(x)		((x) * 0x4 + 0x180)
> +#define RK1108_GLB_SRST_FST		0x1c0
> +#define RK1108_GLB_SRST_SND		0x1c4
> +#define RK1108_SDMMC_CON0		0x1d8
> +#define RK1108_SDMMC_CON1		0x1dc
> +#define RK1108_SDIO_CON0		0x1e0
> +#define RK1108_SDIO_CON1		0x1e4
> +#define RK1108_EMMC_CON0		0x1e8
> +#define RK1108_EMMC_CON1		0x1ec
> +
>  #define RK2928_PLL_CON(x)		((x) * 0x4)
>  #define RK2928_MODE_CON		0x40
>  #define RK2928_CLKSEL_CON(x)	((x) * 0x4 + 0x44)
> diff --git a/include/dt-bindings/clock/rk1108-cru.h b/include/dt-bindings/clock/rk1108-cru.h
> new file mode 100644
> index 0000000..e731cc8
> --- /dev/null
> +++ b/include/dt-bindings/clock/rk1108-cru.h
> @@ -0,0 +1,308 @@
> +/*
> + * Copyright (c) 2016 Rockchip Electronics Co. Ltd.
> + * Author:
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
> +#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK1108_H
> +#define _DT_BINDINGS_CLK_ROCKCHIP_RK1108_H
> +
> +/* pll id */
> +#define RK1108_APLL_ID			0
> +#define RK1108_DPLL_ID			1
> +#define RK1108_GPLL_ID			2
> +#define RK1108_ARMCLK			3
> +#define RK1108_END_PLL_ID		4
> +
> +/* sclk gates (special clocks) */
> +#define SCLK_SPI0			65
> +#define SCLK_NANDC			67
> +#define SCLK_SDMMC			68
> +#define SCLK_SDIO			69
> +#define SCLK_EMMC			71
> +#define SCLK_UART0			72
> +#define SCLK_UART1			73
> +#define SCLK_UART2			74
> +#define SCLK_I2S0			75
> +#define SCLK_I2S1			76
> +#define SCLK_I2S2			77
> +#define SCLK_TIMER0			78
> +#define SCLK_TIMER1			79
> +#define SCLK_SFC			80
> +#define SCLK_SDMMC_DRV			81
> +#define SCLK_SDIO_DRV			82
> +#define SCLK_EMMC_DRV			83
> +#define SCLK_SDMMC_SAMPLE		84
> +#define SCLK_SDIO_SAMPLE		85
> +#define SCLK_EMMC_SAMPLE		86
> +
> +/* aclk gates */
> +#define ACLK_DMAC			251
> +#define ACLK_PRE			252
> +#define ACLK_CORE			253
> +#define ACLK_ENMCORE			254
> +
> +/* pclk gates */
> +#define PCLK_GPIO1			321
> +#define PCLK_GPIO2			322
> +#define PCLK_GPIO3			323
> +#define PCLK_GRF			329
> +#define PCLK_I2C1			333
> +#define PCLK_I2C2			334
> +#define PCLK_I2C3			335
> +#define PCLK_SPI			338
> +#define PCLK_SFC			339
> +#define PCLK_UART0			341
> +#define PCLK_UART1			342
> +#define PCLK_UART2			343
> +#define PCLK_TSADC			344
> +#define PCLK_PWM			350
> +#define PCLK_TIMER			353
> +#define PCLK_PERI			363
> +
> +/* hclk gates */
> +#define HCLK_I2S0_8CH			442
> +#define HCLK_I2S1_8CH			443
> +#define HCLK_I2S2_2CH			444
> +#define HCLK_NANDC			453
> +#define HCLK_SDMMC			456
> +#define HCLK_SDIO			457
> +#define HCLK_EMMC			459
> +#define HCLK_PERI			478
> +#define HCLK_SFC			479
> +
> +#define CLK_NR_CLKS			(HCLK_SFC + 1)
> +
> +/* reset id */
> +#define SRST_CORE_PO_AD			0
> +#define SRST_CORE_AD			1
> +#define SRST_L2_AD			2
> +#define SRST_CPU_NIU_AD			3
> +#define SRST_CORE_PO			4
> +#define SRST_CORE			5
> +#define SRST_L2				6
> +#define RST_0RES7			7
> +#define SRST_CORE_DBG			8
> +#define PRST_DBG			9
> +#define RST_DAP				10
> +#define PRST_DBG_NIU			11
> +#define RST_0RES12			12
> +#define RST_0RES13			13
> +#define RST_0RES14			14
> +#define ARST_STRC_SYS_AD		15
> +
> +#define SRST_DDRPHY_CLKDIV		16
> +#define SRST_DDRPHY			17
> +#define PRST_DDRPHY			18
> +#define PRST_HDMIPHY			19
> +#define PRST_VDACPHY			20
> +#define PRST_VADCPHY			21
> +#define PRST_MIPI_CSI_PHY		22
> +#define PRST_MIPI_DSI_PHY		23
> +#define PRST_ACODEC			24
> +#define ARST_BUS_NIU			25
> +#define PRST_TOP_NIU			26
> +#define ARST_INTMEM			27
> +#define HRST_ROM			28
> +#define ARST_DMAC			29
> +#define SRST_MSCH_NIU			30
> +#define PRST_MSCH_NIU			31
> +
> +#define PRST_DDRUPCTL			32
> +#define NRST_DDRUPCTL			33
> +#define PRST_DDRMON			34
> +#define HRST_I2S0_8CH			35
> +#define MRST_I2S0_8CH			36
> +#define HRST_I2S1_2CH			37
> +#define MRST_IS21_2CH			38
> +#define HRST_I2S2_2CH			39
> +#define MRST_I2S2_2CH			40
> +#define HRST_CRYPTO			41
> +#define SRST_CRYPTO			42
> +#define PRST_SPI			43
> +#define SRST_SPI			44
> +#define PRST_UART0			45
> +#define PRST_UART1			46
> +#define PRST_UART2			47
> +
> +#define SRST_UART0			48
> +#define SRST_UART1			49
> +#define SRST_UART2			50
> +#define PRST_I2C1			51
> +#define PRST_I2C2			52
> +#define PRST_I2C3			53
> +#define SRST_I2C1			54
> +#define SRST_I2C2			55
> +#define SRST_I2C3			56
> +#define RST_3RES9			57
> +#define PRST_PWM1			58
> +#define RST_3RES11			59
> +#define SRST_PWM1			60
> +#define PRST_WDT			61
> +#define PRST_GPIO1			62
> +#define PRST_GPIO2			63
> +
> +#define PRST_GPIO3			64
> +#define PRST_GRF			65
> +#define PRST_EFUSE			66
> +#define PRST_EFUSE512			67
> +#define PRST_TIMER0			68
> +#define SRST_TIMER0			69
> +#define SRST_TIMER1			70
> +#define PRST_TSADC			71
> +#define SRST_TSADC			72
> +#define PRST_SARADC			73
> +#define SRST_SARADC			74
> +#define HRST_SYSBUS			75
> +#define PRST_USBGRF			76
> +#define RST_4RES13			77
> +#define RST_4RES14			78
> +#define RST_4RES15			79
> +
> +#define ARST_PERIPH_NIU			80
> +#define HRST_PERIPH_NIU			81
> +#define PRST_PERIPH_NIU			82
> +#define HRST_PERIPH			83
> +#define HRST_SDMMC			84
> +#define HRST_SDIO			85
> +#define HRST_EMMC			86
> +#define HRST_NANDC			87
> +#define NRST_NANDC			88
> +#define HRST_SFC			89
> +#define SRST_SFC			90
> +#define ARST_GMAC			91
> +#define HRST_OTG			92
> +#define SRST_OTG			93
> +#define SRST_OTG_ADP			94
> +#define HRST_HOST0			95
> +
> +#define HRST_HOST0_AUX			96
> +#define HRST_HOST0_ARB			97
> +#define SRST_HOST0_EHCIPHY		98
> +#define SRST_HOST0_UTMI			99
> +#define SRST_USBPOR			100
> +#define SRST_UTMI0			101
> +#define SRST_UTMI1			102
> +#define RST_6RES7			103
> +#define RST_6RES8			104
> +#define RST_6RES9			105
> +#define RST_6RES10			106
> +#define RST_6RES11			107
> +#define RST_6RES12			108
> +#define RST_6RES13			109
> +#define RST_6RES14			110
> +#define RST_6RES15			101
> +
> +#define ARST_VIO0_NIU			102
> +#define ARST_VIO1_NIU			103
> +#define HRST_VIO_NIU			104
> +#define PRST_VIO_NIU			105
> +#define ARST_VOP			106
> +#define HRST_VOP			107
> +#define DRST_VOP			108
> +#define ARST_IEP			109
> +#define HRST_IEP			110
> +#define ARST_RGA			111
> +#define HRST_RGA			112
> +#define SRST_RGA			113
> +#define PRST_CVBS			114
> +#define PRST_HDMI			115
> +#define SRST_HDMI			116
> +#define PRST_MIPI_DSI			117
> +
> +#define ARST_ISP_NIU			118
> +#define HRST_ISP_NIU			119
> +#define HRST_ISP			120
> +#define SRST_ISP			121
> +#define ARST_VIP0			122
> +#define HRST_VIP0			123
> +#define PRST_VIP0			124
> +#define ARST_VIP1			125
> +#define HRST_VIP1			126
> +#define PRST_VIP1			127
> +#define ARST_VIP2			128
> +#define HRST_VIP2			129
> +#define PRST_VIP2			120
> +#define ARST_VIP3			121
> +#define HRST_VIP3			122
> +#define PRST_VIP4			123
> +
> +#define PRST_CIF1TO4			124
> +#define SRST_CVBS_CLK			125
> +#define HRST_CVBS			126
> +#define RST_9RES3			127
> +#define RST_9RES4			128
> +#define RST_9RES5			129
> +#define RST_9RES6			130
> +#define RST_9RES7			131
> +#define RST_9RES8			132
> +#define RST_9RES9			133
> +#define RST_9RES10			134
> +#define RST_9RES11			134
> +#define RST_9RES12			136
> +#define RST_9RES13			137
> +#define RST_9RES14			138
> +#define RST_9RES15			139
> +
> +#define ARST_VPU_NIU			140
> +#define HRST_VPU_NIU			141
> +#define ARST_VPU			142
> +#define HRST_VPU			143
> +#define ARST_RKVDEC_NIU			144
> +#define HRST_RKVDEC_NIU			145
> +#define ARST_RKVDEC			146
> +#define HRST_RKVDEC			147
> +#define SRST_RKVDEC_CABAC		148
> +#define SRST_RKVDEC_CORE		149
> +#define ARST_RKVENC_NIU			150
> +#define HRST_RKVENC_NIU			151
> +#define ARST_RKVENC			152
> +#define HRST_RKVENC			153
> +#define SRST_RKVENC_CORE		154
> +#define RST_10RES15			155
> +
> +#define SRST_DSP_CORE			156
> +#define SRST_DSP_SYS			157
> +#define SRST_DSP_GLOBAL			158
> +#define SRST_DSP_OECM			159
> +#define PRST_DSP_IOP_NIU		160
> +#define ARST_DSP_EPP_NIU		161
> +#define ARST_DSP_EDP_NIU		162
> +#define PRST_DSP_DBG_NIU		163
> +#define PRST_DSP_CFG_NIU		164
> +#define PRST_DSP_GRF			165
> +#define PRST_DSP_MAILBOX		166
> +#define PRST_DSP_INTC			167
> +#define RST_11RES12			168
> +#define PRST_DSP_PFM_MON		169
> +#define SRST_DSP_PFM_MON		170
> +#define ARST_DSP_EDAP_NIU		171
> +
> +#define SRST_PMU			172
> +#define SRST_PMU_I2C0			173
> +#define PRST_PMU_I2C0			174
> +#define PRST_PMU_GPIO0			175
> +#define PRST_PMU_INTMEM			176
> +#define PRST_PMU_PWM0			177
> +#define SRST_PMU_PWM0			178
> +#define PRST_PMU_GRF			179
> +#define SRST_PMU_NIU			180
> +#define SRST_PMU_PVTM			181
> +#define RST_12RES10			182
> +#define RST_12RES11			183
> +#define ARST_DSP_EDP_PERF		184
> +#define ARST_DSP_EPP_PERF		185
> +#define RST_12RES114			186
> +#define RST_12RES15			187
> +
> +#endif /* _DT_BINDINGS_CLK_ROCKCHIP_RK1108_H */
> +
>


-- 
Best Regards
Shawn Lin
