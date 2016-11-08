From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 8 Nov 2016 03:44:02 +0000
Subject: [PATCH 1/3] ARM: imx6u: add imx6ull support
In-Reply-To: <20161105085951.GG5597@dragon>
References: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
 <1477969343-19887-2-git-send-email-peter.chen@nxp.com>
 <20161105085951.GG5597@dragon>
Message-ID: <HE1PR04MB1450E18DBDFB1EEB51B7A3ED8BA60@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

Thanks, Shawn. All comments will be adopted in v2.

Peter

>>
>> In this patch, it moves common dts between imx6ul* and imx6ull* as new
>> files named imx6u*, and the specific part for imx6ul and imx6ull are
>> individual file.
>
>No.  That only helps churn the tree and git history.  Please keep using imx6ul.dtsi and
>simply have it be included by imx6ull.dtsi.
>
>>
>> Signed-off-by: Peter Chen <peter.chen@nxp.com>
>> ---
>>  arch/arm/boot/dts/Makefile              |   3 +-
>>  arch/arm/boot/dts/imx6u-14x14-evk.dts   | 475 ++++++++++++++++
>>  arch/arm/boot/dts/imx6u-14x14-evk.dtsi  | 487 +++++++++++++++++
>>  arch/arm/boot/dts/imx6u.dtsi            | 942
>++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/imx6ul-14x14-evk.dts  | 479 +---------------
>>  arch/arm/boot/dts/imx6ul.dtsi           | 936 +------------------------------
>>  arch/arm/boot/dts/imx6ull-14x14-evk.dts |  17 +
>>  arch/arm/boot/dts/imx6ull-pinfunc.h     |  57 ++
>>  arch/arm/boot/dts/imx6ull.dtsi          |  10 +
>>  9 files changed, 1993 insertions(+), 1413 deletions(-)  create mode
>> 100644 arch/arm/boot/dts/imx6u-14x14-evk.dts
>>  create mode 100644 arch/arm/boot/dts/imx6u-14x14-evk.dtsi
>>  create mode 100644 arch/arm/boot/dts/imx6u.dtsi  create mode 100644
>> arch/arm/boot/dts/imx6ull-14x14-evk.dts
>>  create mode 100644 arch/arm/boot/dts/imx6ull-pinfunc.h
>>  create mode 100644 arch/arm/boot/dts/imx6ull.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index befcd26..3d6e199 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -423,7 +423,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>>  	imx6ul-pico-hobbit.dtb \
>>  	imx6ul-tx6ul-0010.dtb \
>>  	imx6ul-tx6ul-0011.dtb \
>> -	imx6ul-tx6ul-mainboard.dtb
>> +	imx6ul-tx6ul-mainboard.dtb \
>> +	imx6ull-14x14-evk.dtb
>>  dtb-$(CONFIG_SOC_IMX7D) += \
>>  	imx7d-cl-som-imx7.dtb \
>>  	imx7d-colibri-eval-v3.dtb \
>> diff --git a/arch/arm/boot/dts/imx6u-14x14-evk.dts
>> b/arch/arm/boot/dts/imx6u-14x14-evk.dts
>> new file mode 100644
>> index 0000000..ba8614c
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6u-14x14-evk.dts
>> @@ -0,0 +1,475 @@
>> +/*
>> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> +modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>
>For new DT files, please consider to use GPL/X11 dual license.  You should be able
>to find a lot of examples in arch/arm/boot/dts.
>
><snip>
>
>> diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h
>> b/arch/arm/boot/dts/imx6ull-pinfunc.h
>> new file mode 100644
>> index 0000000..fca0036
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
>> @@ -0,0 +1,57 @@
>> +/*
>> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> +modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __DTS_IMX6ULL_PINFUNC_H
>> +#define __DTS_IMX6ULL_PINFUNC_H
>> +
>> +#include "imx6ul-pinfunc.h"
>> +/*
>> + * The pin function ID is a tuple of
>> + * <mux_reg conf_reg input_reg mux_mode input_val>  */
>> +#define MX6UL_PAD_ENET2_RX_DATA0__EPDC_SDDO08
>0x00E4 0x0370 0x0000 0x9 0x0
>
>Can we name these imx6ull specific defines MX6ULL_xxx, so that we know they
>should only be used in imx6ull specific dts?
>
>> +#define MX6UL_PAD_ENET2_RX_DATA1__EPDC_SDDO09
>0x00E8 0x0374 0x0000 0x9 0x0
>> +#define MX6UL_PAD_ENET2_RX_EN__EPDC_SDDO10                       0x00EC
>0x0378 0x0000 0x9 0x0
>> +#define MX6UL_PAD_ENET2_TX_DATA0__EPDC_SDDO11
>0x00F0 0x037C 0x0000 0x9 0x0
>> +#define MX6UL_PAD_ENET2_TX_DATA1__EPDC_SDDO12
>0x00F4 0x0380 0x0000 0x9 0x0
>> +#define MX6UL_PAD_ENET2_TX_EN__EPDC_SDDO13                       0x00F8
>0x0384 0x0000 0x9 0x0
>> +#define MX6UL_PAD_ENET2_TX_CLK__EPDC_SDDO14                      0x00FC
>0x0388 0x0000 0x9 0x0
>> +#define MX6UL_PAD_ENET2_RX_ER__EPDC_SDDO15                       0x0100
>0x038C 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_CLK__EPDC_SDCLK                            0x0104
>0x0390 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_ENABLE__EPDC_SDLE                          0x0108
>0x0394 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_HSYNC__EPDC_SDOE                           0x010C
>0x0398 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_VSYNC__EPDC_SDCE0                          0x0110
>0x039C 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_RESET__EPDC_GDOE                           0x0114
>0x03A0 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA00__EPDC_SDDO00                        0x0118
>0x03A4 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA01__EPDC_SDDO01                        0x011C
>0x03A8 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA02__EPDC_SDDO02                        0x0120
>0x03AC 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA03__EPDC_SDDO03                        0x0124
>0x03B0 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA04__EPDC_SDDO04                        0x0128
>0x03B4 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA05__EPDC_SDDO05                        0x012C
>0x03B8 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA06__EPDC_SDDO06                        0x0130
>0x03BC 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA07__EPDC_SDDO07                        0x0134
>0x03C0 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA14__EPDC_SDSHR                         0x0150
>0x03DC 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA15__EPDC_GDRL                          0x0154
>0x03E0 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA16__EPDC_GDCLK                         0x0158
>0x03E4 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA17__EPDC_GDSP                          0x015C
>0x03E8 0x0000 0x9 0x0
>> +#define MX6UL_PAD_LCD_DATA21__EPDC_SDCE1                         0x016C
>0x03F8 0x0000 0x9 0x0
>> +
>
>Why this new line?
>
>Shawn
>
