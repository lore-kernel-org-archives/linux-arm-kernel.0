From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 31 Mar 2016 14:26:55 +0800
Subject: [PATCH 3/3] ARM: dts: imx6sx-sdb: Add SAI support
In-Reply-To: <1457439974-1149-3-git-send-email-festevam@gmail.com>
References: <1457439974-1149-1-git-send-email-festevam@gmail.com>
 <1457439974-1149-3-git-send-email-festevam@gmail.com>
Message-ID: <20160331062655.GQ28207@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 09:26:14AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Introduce imx6sx-sdb-sai.dts so that it is possible to use SAI
> interface. 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb-sai.dts | 67 ++++++++++++++++++++++++++++++++++++

Add it to arch/arm/boot/dts/Makefile.

>  arch/arm/boot/dts/imx6sx-sdb.dtsi    | 16 +++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6sx-sdb-sai.dts
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb-sai.dts b/arch/arm/boot/dts/imx6sx-sdb-sai.dts
> new file mode 100644
> index 0000000..0155450
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6sx-sdb-sai.dts
> @@ -0,0 +1,67 @@
> +/*
> + * Copyright (C) 2016 NXP Semiconductors
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
> + *
> + *     This file is distributed in the hope that it will be useful
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include "imx6sx-sdb.dts"
> +
> +/ {
> +	sound {
> +		audio-cpu = <&sai1>;
> +	};
> +};
> +
> +&audmux {
> +	/* pin conflict with sai */
> +	status = "disabled";
> +};
> +
> +&sai1 {
> +	status = "okay";
> +};
> +
> +&sdma {
> +	gpr = <&gpr>;
> +	/* SDMA event remap for SAI1 */
> +	fsl,sdma-event-remap = <0 15 1>, <0 16 1>;

Undocumented device tree bindings?

Shawn

> +};
> +
> +&ssi2 {
> +	status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> index f1d3730..9f7a71e 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> @@ -254,6 +254,12 @@
>  	status = "okay";
>  };
>  
> +&sai1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai1>;
> +	status = "disabled";
> +};
> +
>  &ssi2 {
>  	status = "okay";
>  };
> @@ -468,6 +474,16 @@
>  			>;
>  		};
>  
> +		pinctrl_sai1: sai1grp {
> +			fsl,pins = <
> +				MX6SX_PAD_CSI_DATA00__SAI1_TX_BCLK	0x130b0
> +				MX6SX_PAD_CSI_DATA01__SAI1_TX_SYNC	0x130b0
> +				MX6SX_PAD_CSI_HSYNC__SAI1_TX_DATA_0	0x120b0
> +				MX6SX_PAD_CSI_VSYNC__SAI1_RX_DATA_0	0x130b0
> +				MX6SX_PAD_CSI_PIXCLK__AUDMUX_MCLK	0x130b0
> +			>;
> +		};
> +
>  		pinctrl_uart1: uart1grp {
>  			fsl,pins = <
>  				MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
> -- 
> 1.9.1
> 
> 
