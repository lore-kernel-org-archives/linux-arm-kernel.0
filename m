From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 14 Mar 2017 15:56:34 +0800
Subject: [PATCH] ARM: dts: imx7d-sdb: Add sht11 Click Board support
In-Reply-To: <1488997949-17160-1-git-send-email-marco.franchi@nxp.com>
References: <1488997949-17160-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <20170314075633.GM3618@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 03:32:29PM -0300, Marco Franchi wrote:
> The imx7d-sdb has a mickro bus connector that can be connected to a 
> Sensirion SHT11 click board (temperature and humidity sensor):
> 
> https://shop.mikroe.com/click/sensors/sht1x
> 
> Add a new device tree file to describe such hardware.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
> ---
>  arch/arm/boot/dts/Makefile            |  1 +
>  arch/arm/boot/dts/imx7d-sdb-sht11.dts | 74 +++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d-sdb-sht11.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0118084..7009856 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -458,6 +458,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-nitrogen7.dtb \
>  	imx7d-sbc-imx7.dtb \
>  	imx7d-sdb.dtb \
> +	imx7d-sdb-sht11.dtb \
>  	imx7s-colibri-eval-v3.dtb \
>  	imx7s-warp.dtb
>  dtb-$(CONFIG_SOC_LS1021A) += \
> diff --git a/arch/arm/boot/dts/imx7d-sdb-sht11.dts b/arch/arm/boot/dts/imx7d-sdb-sht11.dts
> new file mode 100644
> index 0000000..2f6f801
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-sdb-sht11.dts
> @@ -0,0 +1,74 @@
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include "imx7d-sdb.dts"
> +
> +/ {
> +	sensor {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sensor>;
> +		compatible = "sensirion,sht15";
> +		clk-gpios = <&gpio4 12 0>;
> +		data-gpios = <&gpio4 13 0>;
> +		vcc-supply = <&reg_sht15>;
> +	};
> +
> +	reg_sht15: reg-sht15 {

'regulator-sht15' should be the recommended name.

I fixed it up and applied the patch.

Shawn

> +		compatible = "regulator-fixed";
> +		regulator-name = "reg_sht15";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +};
> +
> +&i2c3 {
> +	status = "disabled";
> +};
> +
> +&iomuxc {
> +	pinctrl_sensor: sensorgrp {
> +		fsl,pins = <
> +			MX7D_PAD_I2C3_SDA__GPIO4_IO13	0x4000007f
> +			MX7D_PAD_I2C3_SCL__GPIO4_IO12	0x4000007f
> +		>;
> +	};
> +};
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
