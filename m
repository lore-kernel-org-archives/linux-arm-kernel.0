From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 22:31:47 +0800
Subject: [PATCH][v2] arm64: dts: ls2081ardb: Add DTS support for NXP
 LS2081ARDB
In-Reply-To: <1493367930-10612-1-git-send-email-priyanka.jain@nxp.com>
References: <1493367930-10612-1-git-send-email-priyanka.jain@nxp.com>
Message-ID: <20170503143145.GK18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 01:55:30PM +0530, Priyanka Jain wrote:
> This patch add support for NXP LS2081ARDB board which has
> LS2081A SoC.
> 
> LS2081A SoC is 40-pin derivative of LS2088A SoC
> So, from functional perspective both are same.
> Hence,ls2088a SoC dtsi files are included from ls2081ARDB dts
> 
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> ---
> Changes for v2: Updated subject and NXP copyright
> 	based on Leo's comments
> 
>  arch/arm64/boot/dts/freescale/Makefile            |    1 +
>  arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts |  139 +++++++++++++++++++++
>  2 files changed, 140 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 72c4b52..58b80de 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2081a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
> new file mode 100644
> index 0000000..bc1c4f6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts
> @@ -0,0 +1,139 @@
> +/*
> + * Device Tree file for NXP LS2081A RDB Board.
> + *
> + * Copyright 2017, NXP

It still doesn't match what Leo's patch does.

https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/dt64&id=827270124c75c7eca8d2e0b41e21fc668e04932e

Hint: there is no comma in the middle.

> + *
> + * Priyanka Jain <priyanka.jain@nxp.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPLv2 or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
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
> +#include "fsl-ls2088a.dtsi"
> +
> +/ {
> +	model = "NXP Layerscape 2081A RDB Board";
> +	compatible = "fsl,ls2081a-rdb", "fsl,ls2081a";
> +
> +	aliases {
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +};
> +
> +&esdhc {
> +	status = "okay";
> +};
> +
> +&ifc {
> +	status = "disabled";

We should have those devices which will need board level connector/pinout
disabled in <soc>.dtsi, and enable the device in <board>.dts which
actually has the device pinout on board.

> +};
> +
> +&i2c0 {
> +	status = "okay";

Have a newline between property list and child node.

> +	pca9547 at 75 {

Node name should be as generic as possible.  The name used in bindings
doc example is obviously better.

This comment applies to other nodes added by this patch.

> +		compatible = "nxp,pca9547";
> +		reg = <0x75>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x01>;
> +			rtc at 51 {
> +				compatible = "nxp,pcf2129";
> +				reg = <0x51>;
> +			};
> +		};
> +
> +		i2c at 3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			adt7481 at 4c {
> +				compatible = "adi,adt7461";
> +				reg = <0x4c>;
> +			};
> +		};
> +	};
> +};
> +
> +&dspi {

Sort these labeled nodes alphabetically.

> +	status = "okay";
> +	dflash0: n25q512a {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "st,m25p80";
> +		spi-max-frequency = <3000000>;
> +		reg = <0>;
> +	};
> +};
> +
> +
> +&qspi {
> +	status = "okay";
> +	flash0: n25q512a at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "st,m25p80";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +	};

Have a newline between nodes.

Shawn

> +	flash1: n25q512a at 1 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "st,m25p80";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> -- 
> 1.7.4.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
