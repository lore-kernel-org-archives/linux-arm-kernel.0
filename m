From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Jan 2014 16:37:51 +0800
Subject: [PATCHv12] ARM: dts: Add support for the cpuimx35 board from
 Eukrea and its baseboard.
In-Reply-To: <1389803532-8516-1-git-send-email-denis@eukrea.com>
References: <1389803532-8516-1-git-send-email-denis@eukrea.com>
Message-ID: <20140128083746.GA20595@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 05:32:12PM +0100, Denis Carikli wrote:
> diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
> new file mode 100644
> index 0000000..303f789
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "imx35.dtsi"
> +
> +/ {
> +	model = "Eukrea CPUIMX35";
> +	compatible = "eukrea,cpuimx35", "fsl,imx35";
> +
> +	memory {
> +		reg = <0x80000000 0x8000000>; /* 128M */
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pcf8563 at 51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&iomuxc {
> +	imx35-eukrea {
> +		pinctrl_fec: fecgrp {
> +			fsl,pins = <MX35_FEC_PINGRP1>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <MX35_I2C1_PINGRP1>;
> +		};

You have these two pingrp in imx35-eukrea-cpuimx35.dtsi ...

> +	};
> +};
> +
> +&nfc {
> +	nand-bus-width = <8>;
> +	nand-ecc-mode = "hw";
> +	nand-on-flash-bbt;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
> new file mode 100644
> index 0000000..23f6fe1
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
> @@ -0,0 +1,137 @@
> +/*
> + * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "imx35-eukrea-cpuimx35.dtsi"

... imx35-eukrea-cpuimx35.dtsi is being included here ...

> +
> +/ {
> +	model = "Eukrea CPUIMX35";
> +	compatible = "eukrea,mbimxsd35-baseboard", "eukrea,cpuimx35", "fsl,imx35";
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_bp1>;
> +
> +		bp1 {
> +			label = "BP1";
> +			gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
> +			linux,code = <BTN_MISC>;
> +			gpio-key,wakeup;
> +			linux,input-type = <1>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led1>;
> +
> +		led1 {
> +			label = "led1";
> +			gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux>;
> +	status = "okay";
> +};
> +
> +&esdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_esdhc1>;
> +	cd-gpios = <&gpio3 24>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	tlv320aic23: codec at 1a {
> +		compatible = "ti,tlv320aic23";
> +		reg = <0x1a>;
> +	};
> +};
> +
> +&iomuxc {
> +	imx35-eukrea {
> +		pinctrl_audmux: audmuxgrp {
> +			fsl,pins = <MX35_AUDMUX_PINGRP1>;
> +		};
> +
> +		pinctrl_bp1: bp1grp {
> +			fsl,pins = <MX35_PAD_LD19__GPIO3_25  0x80000000>;
> +		};
> +
> +		pinctrl_esdhc1: esdhc1grp {
> +			fsl,pins = <
> +				  MX35_ESDHC1_PINGRP1
> +				  MX35_PAD_LD18__GPIO3_24  0x80000000 /* CD */
> +			>;
> +		};
> +
> +		pinctrl_fec: fecgrp {
> +			fsl,pins = <MX35_FEC_PINGRP1>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <MX35_I2C1_PINGRP1>;
> +		};

... why do you need to have them again?

I spotted this when rebasing this patch on pingrp removal series, and
just dropped them from imx35-eukrea-mbimxsd35-baseboard.dts.  Let me
know if I did get it right.

Shawn

> +
> +		pinctrl_led1: led1grp {
> +			fsl,pins = <MX35_PAD_LD23__GPIO3_29  0x80000000>;
> +		};
> +
> +		pinctrl_reg_lcd_3v3: reg-lcd-3v3 {
> +			fsl,pins = <MX35_PAD_D3_CLS__GPIO1_4 0x80000000>;
> +		};
> +
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX35_UART1_PINGRP1
> +				MX35_UART1_RTSCTS_PINGRP1
> +			>;
> +		};
> +
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <
> +				MX35_UART2_PINGRP1
> +				MX35_UART2_RTSCTS_PINGRP1
> +			>;
> +		};
> +	};
> +};
> +
> +&ssi1 {
> +	fsl,mode = "i2s-slave";
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
> -- 
> 1.7.9.5
> 
