From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 04 Nov 2016 08:32:15 +0100
Subject: [PATCH 3/6] clk: rockchip: add clock controller for rk1108
In-Reply-To: <1478176713-12066-1-git-send-email-andy.yan@rock-chips.com>
References: <1478175975-11779-1-git-send-email-andy.yan@rock-chips.com>
 <1478176713-12066-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <4415767.udKEaOCZjv@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Am Donnerstag, 3. November 2016, 20:38:33 CET schrieb Andy Yan:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Add the clock tree definition and driver for rk1108 SoC.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  drivers/clk/rockchip/Makefile          |   1 +
>  drivers/clk/rockchip/clk-rk1108.c      | 463
> +++++++++++++++++++++++++++++++++ drivers/clk/rockchip/clk.h             | 
> 14 +
>  include/dt-bindings/clock/rk1108-cru.h | 308 ++++++++++++++++++++++

Please split the rk1108-cru.h addition into a separate patch, so that I can 
put it into a shared branch for clock and dts branches.

Also it looks like you didn't provide a devicetree binding document (in a 
separate patch).

Clock-tree looks mostly good, just some small things below 


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
> diff --git a/drivers/clk/rockchip/clk-rk1108.c
> b/drivers/clk/rockchip/clk-rk1108.c new file mode 100644
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

double empty line. There are a lot more in this file, so please remove all of 
them. One line of space between blocks is enough :-) .

[...]

> diff --git a/include/dt-bindings/clock/rk1108-cru.h
> b/include/dt-bindings/clock/rk1108-cru.h new file mode 100644
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

what is this supposed to do. Looks like it should go away.

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

there is no need to document unused/reserved bits in the header,
so please drop all of them (more in the areas above here as well).


Heiko
