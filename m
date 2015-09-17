From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Sep 2015 11:47 +0200
Subject: [PATCH v2 3/9] clk: rockchip: add clock controller for rk3036
In-Reply-To: <1442478540-15068-4-git-send-email-zhengxing@rock-chips.com>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
 <1442478540-15068-4-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1775899.zcIuq65f1o@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Donnerstag, 17. September 2015, 16:28:54 schrieb Xing Zheng:
> Add the clock tree definition for the new rk3036 SoC.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

missing a dt-bindings document in a separate patch. See "dt-bindings: add 
documentation of rk3668 clock controller" 
(http://lists.infradead.org/pipermail/linux-rockchip/2015-July/003396.html) 
for comparison.


> ---
> 
> Changes in v2: None
> 
>  drivers/clk/rockchip/Makefile     |    1 +
>  drivers/clk/rockchip/clk-rk3036.c |  504
> +++++++++++++++++++++++++++++++++++++ drivers/clk/rockchip/clk.h        |  
> 30 +++
>  3 files changed, 535 insertions(+)
>  create mode 100644 drivers/clk/rockchip/clk-rk3036.c
> 
> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
> index b27edd6..d599829 100644
> --- a/drivers/clk/rockchip/Makefile
> +++ b/drivers/clk/rockchip/Makefile
> @@ -10,6 +10,7 @@ obj-y	+= clk-inverter.o
>  obj-y	+= clk-mmc-phase.o
>  obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
> 
> +obj-y	+= clk-rk3036.o
>  obj-y	+= clk-rk3188.o
>  obj-y	+= clk-rk3288.o
>  obj-y	+= clk-rk3368.o
> diff --git a/drivers/clk/rockchip/clk-rk3036.c
> b/drivers/clk/rockchip/clk-rk3036.c new file mode 100644
> index 0000000..724d467
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-rk3036.c
> @@ -0,0 +1,504 @@
> +/*
> + * Copyright (c) 2014 MundoReader S.L.
> + * Author: Heiko Stuebner <heiko@sntech.de>
> + *
> + * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
> + * Author: Xing Zheng <zhengxing@rock-chips.com>
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
> +#include <dt-bindings/clock/rk3036-cru.h>
> +#include "clk.h"
> +
> +enum rk3036_plls {
> +	apll, dpll, gpll,
> +};
> +
> +static struct rockchip_pll_rate_table rk3036_pll_rates[] = {
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
> +	RK3036_PLL_RATE(0, 1, 0, 1, 1, 1, 0),

you shouldn't need a "0" rate entry I guess


> +	{ /* sentinel */ },
> +};
> +
> +#define RK3036_DIV_CPU_MASK		0x1f
> +#define RK3036_DIV_CPU_SHIFT		8
> +
> +#define RK3036_DIV_PERI_MASK		0xf
> +#define RK3036_DIV_PERI_SHIFT		0
> +#define RK3036_DIV_ACLK_MASK		0x7
> +#define RK3036_DIV_ACLK_SHIFT		4
> +#define RK3036_DIV_HCLK_MASK		0x3
> +#define RK3036_DIV_HCLK_SHIFT		8
> +#define RK3036_DIV_PCLK_MASK		0x7
> +#define RK3036_DIV_PCLK_SHIFT		12
> +
> +#define RK3036_CLKSEL1(_core_periph_div)					\
> +	{									\
> +		.reg = RK2928_CLKSEL_CON(1),					\
> +		.val = HIWORD_UPDATE(_core_periph_div, RK3036_DIV_PERI_MASK,	\
> +				RK3036_DIV_PERI_SHIFT)				\
> +	}
> +
> +#define RK3036_CPUCLK_RATE(_prate, _core_periph_div)			\
> +	{								\
> +		.prate = _prate,					\
> +		.divs = {						\
> +			RK3036_CLKSEL1(_core_periph_div),		\
> +		},							\
> +	}
> +
> +static struct rockchip_cpuclk_rate_table rk3036_cpuclk_rates[] __initdata =
> { +	RK3036_CPUCLK_RATE(816000000, 4),
> +	RK3036_CPUCLK_RATE(600000000, 4),
> +	RK3036_CPUCLK_RATE(312000000, 4),
> +};
> +
> +static const struct rockchip_cpuclk_reg_data rk3036_cpuclk_data = {
> +	.core_reg = RK2928_CLKSEL_CON(0),
> +	.div_core_shift = 0,
> +	.div_core_mask = 0x1f,
> +	.mux_core_shift = 7,
> +};
> +
> +PNAME(mux_pll_p)		= { "xin24m", "xin24m" };

looks like you overlooked the divider? Like

DIV(0, "xin24m_plldiv", "xin24m", 0,
		RK2928_CLKSEL_CON(4), 8, 5, DFLAGS),

PNAME(mux_pll_p)		= { "xin24m_plldiv", "xin24m" };

> +
> +PNAME(mux_armclk_p)		= { "apll", "gpll_armclk" };
> +PNAME(mux_busclk_p)		= { "apll", "dpll_cpu", "gpll_cpu" };

[...]

> +	/*
> +	 * Clock-Architecture Diagram 3
> +	 */
> +
> +	/* aclk_cpu gates */
> +	GATE(0, "sclk_intmem", "aclk_cpu", CLK_IGNORE_UNUSED,
> RK2928_CLKGATE_CON(4), 12, GFLAGS), +	GATE(0, "aclk_strc_sys", "aclk_cpu",
> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 10, GFLAGS), +
> +	/* hclk_cpu gates */
> +	GATE(HCLK_ROM, "hclk_rom", "hclk_cpu", CLK_IGNORE_UNUSED,
> RK2928_CLKGATE_CON(5), 6, GFLAGS), +
> +	/* pclk_cpu gates */
> +	GATE(PCLK_GRF, "pclk_grf", "pclk_cpu", CLK_IGNORE_UNUSED,
> RK2928_CLKGATE_CON(5), 4, GFLAGS), +	GATE(PCLK_DDRUPCTL, "pclk_ddrupctl",
> "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 7, GFLAGS), +	GATE(ACLK_VCODEC,
> "pclk_acodec", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 14, GFLAGS),
> +	GATE(PCLK_HDMI, "pclk_hdmi", "pclk_cpu", 0, RK2928_CLKGATE_CON(3), 8,
> GFLAGS), +
> +	/* aclk_vio gates */
> +	GATE(ACLK_VIO, "aclk_vio", "aclk_disp1_pre", 0,
> +			RK2928_CLKGATE_CON(6), 13, GFLAGS),
> +	GATE(ACLK_LCDC, "aclk_lcdc", "aclk_disp1_pre", 0,
> +			RK2928_CLKGATE_CON(9), 6, GFLAGS),
> +
> +	GATE(HCLK_VIO_BUS, "hclk_vio_bus", "hclk_disp_pre", 0,
> +			RK2928_CLKGATE_CON(6), 12, GFLAGS),
> +	GATE(HCLK_LCDC, "hclk_lcdc", "hclk_disp_pre", 0,
> +			RK2928_CLKGATE_CON(9), 5, GFLAGS),
> +
> +	/* aclk_video gates */
> +	GATE(HCLK_LCDC, "hclk_vcodec", "hclk_disp_pre", 0,
> +			RK2928_CLKGATE_CON(3), 12, GFLAGS),

in big gate-block from diagram 3, please stick to the one-line format, like 
the rest of the gates here (diagram3 only)

> +
> +	/* xin24m gates */
> +	GATE(SCLK_PVTM_CORE, "sclk_pvtm_core", "xin24m", 0,
> RK2928_CLKGATE_CON(10), 0, GFLAGS), +	GATE(SCLK_PVTM_GPU, "sclk_pvtm_gpu",
> "xin24m", 0, RK2928_CLKGATE_CON(10), 1, GFLAGS), +
> +	/* aclk_peri gates */
> +	GATE(0, "aclk_peri_axi_matrix", "aclk_peri", CLK_IGNORE_UNUSED,
> RK2928_CLKGATE_CON(4), 3, GFLAGS), +	GATE(0, "aclk_cpu_peri", "aclk_peri",
> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 2, GFLAGS), +	GATE(ACLK_DMAC2,
> "aclk_dmac2", "aclk_peri", 0, RK2928_CLKGATE_CON(5), 1, GFLAGS), +	GATE(0,
> "aclk_peri_niu", "aclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 15,
> GFLAGS), +
> +	/* hclk_peri gates */
> +	GATE(0, "hclk_peri_matrix", "hclk_peri", CLK_IGNORE_UNUSED,
> RK2928_CLKGATE_CON(4), 0, GFLAGS), +	GATE(0, "hclk_usb_peri", "hclk_peri",
> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 13, GFLAGS), +	GATE(0,
> "hclk_peri_arbi", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9),
> 14, GFLAGS), +	GATE(HCLK_NANDC, "hclk_nandc", "hclk_peri", 0,
> RK2928_CLKGATE_CON(5), 9, GFLAGS), +	GATE(HCLK_SDMMC, "hclk_sdmmc",
> "hclk_peri", 0, RK2928_CLKGATE_CON(5), 10, GFLAGS), +	GATE(HCLK_SDIO,
> "hclk_sdio", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 11, GFLAGS),
> +	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 0,
> GFLAGS), +	GATE(HCLK_OTG0, "hclk_otg0", "hclk_peri", CLK_IGNORE_UNUSED,
> RK2928_CLKGATE_CON(5), 13, GFLAGS), +	GATE(HCLK_OTG1, "hclk_otg1",
> "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(7), 13, GFLAGS),
> +	GATE(HCLK_I2S, "hclk_i2s", "hclk_peri", CLK_IGNORE_UNUSED,
> RK2928_CLKGATE_CON(7), 2, GFLAGS), +	GATE(0, "hclk_sfc", "hclk_peri",
> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS), +	GATE(0,
> "hclk_mac", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 15,
> GFLAGS), +
> +	/* pclk_peri gates */
> +	GATE(0, "pclk_peri_matrix", "pclk_peri", CLK_IGNORE_UNUSED,
> RK2928_CLKGATE_CON(4), 1, GFLAGS), +	GATE(0, "pclk_efuse", "pclk_peri",
> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 2, GFLAGS), +	GATE(PCLK_TIMER,
> "pclk_timer0", "pclk_peri", 0, RK2928_CLKGATE_CON(7), 7, GFLAGS),
> +	GATE(PCLK_PWM, "pclk_pwm", "pclk_peri", 0, RK2928_CLKGATE_CON(7), 10,
> GFLAGS), +	GATE(PCLK_SPI, "pclk_spi", "pclk_peri", 0,
> RK2928_CLKGATE_CON(7), 12, GFLAGS), +	GATE(PCLK_WDT, "pclk_wdt",
> "pclk_peri", 0, RK2928_CLKGATE_CON(7), 15, GFLAGS), +	GATE(PCLK_UART0,
> "pclk_uart0", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 0, GFLAGS),
> +	GATE(PCLK_UART1, "pclk_uart1", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 1,
> GFLAGS), +	GATE(PCLK_UART2, "pclk_uart2", "pclk_peri", 0,
> RK2928_CLKGATE_CON(8), 2, GFLAGS), +	GATE(PCLK_I2C0, "pclk_i2c0",
> "pclk_peri", 0, RK2928_CLKGATE_CON(8), 4, GFLAGS), +	GATE(PCLK_I2C1,
> "pclk_i2c1", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 5, GFLAGS),
> +	GATE(PCLK_I2C2, "pclk_i2c2", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 6,
> GFLAGS), +	GATE(PCLK_GPIO0, "pclk_gpio0", "pclk_peri", 0,
> RK2928_CLKGATE_CON(8), 9, GFLAGS), +	GATE(PCLK_GPIO1, "pclk_gpio1",
> "pclk_peri", 0, RK2928_CLKGATE_CON(8), 10, GFLAGS), +	GATE(PCLK_GPIO2,
> "pclk_gpio2", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 11, GFLAGS), +};
> +
> +static const char *const rk3036_critical_clocks[] __initconst = {
> +	"aclk_cpu",
> +	"aclk_peri",
> +	"hclk_peri",
> +	"pclk_peri",
> +};
> +
> +static void __init rk3036_clk_init(struct device_node *np)
> +{
> +	void __iomem *reg_base;
> +	struct clk *clk;
> +
> +	reg_base = of_iomap(np, 0);
> +	if (!reg_base) {
> +		pr_err("%s: could not map cru region\n", __func__);
> +		return;
> +	}
> +
> +	rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
> +
> +	/* xin12m is created by an cru-internal divider */
> +	clk = clk_register_fixed_factor(NULL, "xin12m", "xin24m", 0, 1, 2);
> +	if (IS_ERR(clk))
> +		pr_warn("%s: could not register clock xin12m: %ld\n",
> +			__func__, PTR_ERR(clk));
> +
> +	clk = clk_register_fixed_factor(NULL, "usb480m", "xin24m", 0, 20, 1);
> +	if (IS_ERR(clk))
> +		pr_warn("%s: could not register clock usb480m: %ld\n",
> +			__func__, PTR_ERR(clk));
> +
> +	clk = clk_register_fixed_factor(NULL, "ddrphy", "ddrphy2x", 0, 1, 2);
> +	if (IS_ERR(clk))
> +		pr_warn("%s: could not register clock ddrphy: %ld\n",
> +			__func__, PTR_ERR(clk));
> +
> +	clk = clk_register_fixed_factor(NULL, "hclk_vcodec_pre",
> +					"aclk_vcodec", 0, 1, 4);
> +	if (IS_ERR(clk))
> +		pr_warn("%s: could not register clock hclk_vcodec_pre: %ld\n",
> +			__func__, PTR_ERR(clk));
> +
> +	clk = clk_register_fixed_factor(NULL, "sclk_macref_out",
> +					"hclk_peri_src", 0, 1, 2);
> +	if (IS_ERR(clk))
> +		pr_warn("%s: could not register clock sclk_macref_out: %ld\n",
> +			__func__, PTR_ERR(clk));
> +
> +	rockchip_clk_register_plls(rk3036_pll_clks,
> +				   ARRAY_SIZE(rk3036_pll_clks),
> +				   -1);
> +	rockchip_clk_register_branches(rk3036_clk_branches,
> +				  ARRAY_SIZE(rk3036_clk_branches));
> +	rockchip_clk_protect_critical(rk3036_critical_clocks,
> +				      ARRAY_SIZE(rk3036_critical_clocks));
> +
> +	rockchip_clk_register_armclk(ARMCLK, "armclk",
> +			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
> +			&rk3036_cpuclk_data, rk3036_cpuclk_rates,
> +			ARRAY_SIZE(rk3036_cpuclk_rates));
> +
> +	rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CON(0),
> +				  ROCKCHIP_SOFTRST_HIWORD_MASK);
> +
> +	rockchip_register_restart_notifier(RK2928_GLB_SRST_FST);
> +}
> +CLK_OF_DECLARE(rk3036_cru, "rockchip,rk3036-cru", rk3036_clk_init);
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index dc8ecb2..6603c07 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -2,6 +2,9 @@
>   * Copyright (c) 2014 MundoReader S.L.
>   * Author: Heiko Stuebner <heiko@sntech.de>
>   *
> + * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
> + * Author: Xing Zheng <zhengxing@rock-chips.com>
> + *
>   * based on
>   *
>   * samsung/clk.h
> @@ -40,6 +43,13 @@ struct clk;
>  #define RK2928_SOFTRST_CON(x)	((x) * 0x4 + 0x110)
>  #define RK2928_MISC_CON		0x134
> 
> +#define RK3036_SDMMC_CON0		0x144
> +#define RK3036_SDMMC_CON1		0x148
> +#define RK3036_SDIO_CON0		0x14c
> +#define RK3036_SDIO_CON1		0x150
> +#define RK3036_EMMC_CON0		0x154
> +#define RK3036_EMMC_CON1		0x158
> +
>  #define RK3288_PLL_CON(x)		RK2928_PLL_CON(x)
>  #define RK3288_MODE_CON			0x50
>  #define RK3288_CLKSEL_CON(x)		((x) * 0x4 + 0x60)
> @@ -75,6 +85,7 @@ struct clk;
> 
>  enum rockchip_pll_type {
>  	pll_rk3066,
> +	pll_rk3036,

this should be part of the addition of the pll type (your patch4, and should 
be reordered accordingly)

Also please all 3036 before the 3066 entry


>  };
> 
>  #define RK3066_PLL_RATE(_rate, _nr, _nf, _no)	\
> @@ -95,12 +106,31 @@ enum rockchip_pll_type {
>  	.nb = _nb,						\
>  }
> 
> +#define RK3036_PLL_RATE(_rate, _refdiv, _fbdiv, _postdiv1,	\
> +			_postdiv2, _dsmpd, _frac)		\
> +{								\
> +	.rate	= _rate##U,					\
> +	.fbdiv = _fbdiv,					\
> +	.postdiv1 = _postdiv1,					\
> +	.refdiv = _refdiv,					\
> +	.postdiv2 = _postdiv2,					\
> +	.dsmpd = _dsmpd,					\
> +	.frac = _frac,						\
> +}
> +
>  struct rockchip_pll_rate_table {
>  	unsigned long rate;
>  	unsigned int nr;
>  	unsigned int nf;
>  	unsigned int no;
>  	unsigned int nb;
> +	/* for RK3036 */
> +	unsigned int fbdiv;
> +	unsigned int postdiv1;
> +	unsigned int refdiv;
> +	unsigned int postdiv2;
> +	unsigned int dsmpd;
> +	unsigned int frac;

same for these 2 ... should be part of the pll addition itself

>  };
> 
>  /**
