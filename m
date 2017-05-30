From: icenowy@aosc.io (icenowy at aosc.io)
Date: Wed, 31 May 2017 03:09:22 +0800
Subject: [PATCH 1/2] arm64: allwinner: h5: Add initial NanoPi NEO2 support
In-Reply-To: <1496166170-6593-1-git-send-email-jagan@openedev.com>
References: <1496166170-6593-1-git-send-email-jagan@openedev.com>
Message-ID: <0ac7e4973794e99d75001dd6b1adc822@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-05-31 01:42?Jagan Teki ???
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> NanoPi M1 Plus is designed and developed by FriendlyElec
> using the Allwinner 64-bit H5 SOC.

Copy'n'paste error?

> 
> NanoPi Neo2 key features
> - Allwinner H5, Quad-core 64-bit Cortex-A53
> - 512MB DDR3 RAM
> - microSD slot
> - 10/100/1000M Ethernet
> - Serial Debug Port
> - 5V 2A DC MicroUSB power-supply

Sorry, this time I also submitted it first and merged...

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/501672.html

> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile             |  1 +
>  .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 92 
> ++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
>  create mode 100644 
> arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> b/arch/arm64/boot/dts/allwinner/Makefile
> index c1dd6e4..8d50907 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -2,6 +2,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb 
> sun50i-a64-pine64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
> new file mode 100644
> index 0000000..c28779f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
> @@ -0,0 +1,92 @@
> +/*
> + * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of 
> the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
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
> +/dts-v1/;
> +
> +#include "sun50i-h5.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "FriendlyARM NanoPi NEO2";
> +	compatible = "friendlyarm,nanopi-neo2", "allwinner,sun50i-h5";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		reg = <0x40000000 0x20000000>;
> +	};
> +
> +	soc {
> +		reg_vcc3v3: vcc3v3 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "vcc3v3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +	};
> +};
> +
> +&mmc0 {
> +	compatible = "allwinner,sun50i-h5-mmc",
> +		     "allwinner,sun50i-a64-mmc",
> +		     "allwinner,sun5i-a13-mmc";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
> +	cd-inverted;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_a>;
> +	status = "okay";
> +};
