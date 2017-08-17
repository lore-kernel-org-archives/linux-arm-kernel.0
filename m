From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 15:20:29 -0500
Subject: [PATCH v2] arm64: dts: rockchip: add rk3328-rock64 board
In-Reply-To: <20170811232947.18698-1-heiko@sntech.de>
References: <20170811232947.18698-1-heiko@sntech.de>
Message-ID: <20170817202029.iset3te4zvb4jhfo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 12, 2017 at 01:29:47AM +0200, Heiko Stuebner wrote:
> The ROCK64 is a credit card size 4K60P HDR Media Board Computer using the
> Rockchip RK3328 Quad-Core ARM Cortex A53 64-Bit Processor and supporting
> up to 4GB 1600MHz LPDDR3 memory. It provides eMMC module socket, MicroSD
> Card slot, Pi-2 Bus, Pi-P5+ Bus, USB 3.0 and many others peripheral
> devices interface for makers to integrate with sensors and devices.
> 
> The devicetree currently supports basic peripherals, with more to be
> added later on.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes in v2:
> - remove obsolete mmc properties found by Shawn
> - enable newly added tsadc node
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     | 375 +++++++++++++++++++++
>  3 files changed, 380 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index 88d95323d301..b54e9bfd9562 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -134,6 +134,10 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>       - compatible = "phytec,rk3288-pcm-947", "phytec,rk3288-phycore-som", "rockchip,rk3288";
>  
> +- Pine64 Rock64 board:
> +    Required root node properties:
> +    - compatible = "pine64,rock64", "rockchip,rk3328";
> +
>  - Rockchip PX3 Evaluation board:
>      Required root node properties:
>        - compatible = "rockchip,px3-evb", "rockchip,px3", "rockchip,rk3188";
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index d0ad366bbd12..106fb8e0f2f8 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-geekbox.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-orion-r68-meta.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> new file mode 100644
> index 000000000000..7b9bc57a1536
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -0,0 +1,375 @@
> +/*
> + * Copyright (c) 2017 PINE64
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
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

Use SPDX tags here instead if you want.

[...]

> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
> +	status = "disabled";

Normally, this is disabled in the SOC dts and enabled here.

> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <150000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_dectn &sdmmc0_bus4>;
> +	supports-sd;
> +	vmmc-supply = <&vcc_sd>;
> +	status = "okay";
> +};
