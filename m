From: robh@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 10:55:42 -0500
Subject: [PATCH] arm: tegra: initial support for apalis tk1
In-Reply-To: <1463056032-25888-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1463056032-25888-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <20160516155542.GA25949@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 02:27:12PM +0200, Marcel Ziswiler wrote:
> This patch adds the device tree to support Toradex Apalis TK1 a
> computer on module which can be used on different carrier boards.
> 
> The module consists of a Tegra TK1 SoC, a PMIC solution, 2 GB of DDR3L
> RAM, a bunch of level shifters, an eMMC, a TMP451 temperature sensor
> chip and an I210 gigabit Ethernet controller. Furthermore, there is an
> SGTL5000 audio codec plus a Kinetis MK20DN512 companion micro
> controller for analogue, CAN and resistive touch functionality which
> are not yet supported. Anything that is not self contained on the
> module is disabled by default.
> 
> The device tree for the Evaluation Board includes the module's device
> tree and enables the supported peripherals of the carrier board (the
> Evaluation Board supports almost all of them).
> 
> While at it also add the device tree binding documentation for Apalis
> TK1 as well as for Colibri T30 which was missing so far.

"While at it" and "also" are keywords for put in a separate patch.

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/arm/tegra.txt |    4 +
>  arch/arm/boot/dts/Makefile                      |    1 +
>  arch/arm/boot/dts/tegra124-apalis-emc.dtsi      | 2462 +++++++++++++++++++++++
>  arch/arm/boot/dts/tegra124-apalis-eval.dts      |  283 +++
>  arch/arm/boot/dts/tegra124-apalis.dtsi          | 2058 +++++++++++++++++++
>  5 files changed, 4808 insertions(+)
>  create mode 100644 arch/arm/boot/dts/tegra124-apalis-emc.dtsi
>  create mode 100644 arch/arm/boot/dts/tegra124-apalis-eval.dts
>  create mode 100644 arch/arm/boot/dts/tegra124-apalis.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
> index 73278c6..7709f3d 100644
> --- a/Documentation/devicetree/bindings/arm/tegra.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra.txt
> @@ -31,8 +31,12 @@ board-specific compatible values:
>    nvidia,ventana
>    nvidia,whistler
>    toradex,apalis_t30
> +  toradex,apalis_tk1
>    toradex,apalis_t30-eval
> +  toradex,apalis_tk1-eval
>    toradex,colibri_t20-512
> +  toradex,colibri_t30
> +  toradex,colibri_t30-eval-v3
>    toradex,iris

Please use '-' rather than '_' for new strings even if that's what 
previous strings have. For ones that already in use in upstream dts 
files, then keep the underscore.

>  
>  Trusted Foundations
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 06b6c2d..3a13d4f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -793,6 +793,7 @@ dtb-$(CONFIG_ARCH_TEGRA_114_SOC) += \
>  	tegra114-roth.dtb \
>  	tegra114-tn7.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_124_SOC) += \
> +	tegra124-apalis-eval.dtb \
>  	tegra124-jetson-tk1.dtb \
>  	tegra124-nyan-big.dtb \
>  	tegra124-nyan-blaze.dtb \
> diff --git a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
> new file mode 100644
> index 0000000..31b31ea
> --- /dev/null
> +++ b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
> @@ -0,0 +1,2462 @@
> +/*
> + * Copyright 2016 Toradex AG
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
> +/ {
> +	clock at 0,60006000 {

All these commas should be dropped. These have been fixed in -next and 
will go into 4.7.

> +		emc-timings-1 {
> +			nvidia,ram-code = <1>;
> +
> +			timing-12750000 {
> +				clock-frequency = <12750000>;
> +				nvidia,parent-clock-frequency = <408000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_P>;
> +				clock-names = "emc-parent";
> +			};
> +			timing-20400000 {
> +				clock-frequency = <20400000>;
> +				nvidia,parent-clock-frequency = <408000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_P>;
> +				clock-names = "emc-parent";
> +			};
> +			timing-40800000 {
> +				clock-frequency = <40800000>;
> +				nvidia,parent-clock-frequency = <408000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_P>;
> +				clock-names = "emc-parent";
> +			};
> +			timing-68000000 {
> +				clock-frequency = <68000000>;
> +				nvidia,parent-clock-frequency = <408000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_P>;
> +				clock-names = "emc-parent";
> +			};
> +			timing-102000000 {
> +				clock-frequency = <102000000>;
> +				nvidia,parent-clock-frequency = <408000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_P>;
> +				clock-names = "emc-parent";
> +			};
> +			timing-204000000 {
> +				clock-frequency = <204000000>;
> +				nvidia,parent-clock-frequency = <408000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_P>;
> +				clock-names = "emc-parent";
> +			};
> +			timing-300000000 {
> +				clock-frequency = <300000000>;
> +				nvidia,parent-clock-frequency = <600000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_C>;
> +				clock-names = "emc-parent";
> +			};
> +			timing-396000000 {
> +				clock-frequency = <396000000>;
> +				nvidia,parent-clock-frequency = <792000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_M>;
> +				clock-names = "emc-parent";
> +			};
> +			timing-528000000 {
> +				clock-frequency = <528000000>;
> +				nvidia,parent-clock-frequency = <528000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_M_UD>;
> +				clock-names = "emc-parent";
> +			};
> +			timing-600000000 {
> +				clock-frequency = <600000000>;
> +				nvidia,parent-clock-frequency = <600000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_C_UD>;
> +				clock-names = "emc-parent";
> +			};
> +			timing-792000000 {
> +				clock-frequency = <792000000>;
> +				nvidia,parent-clock-frequency = <792000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_M_UD>;
> +				clock-names = "emc-parent";
> +			};
> +			timing-924000000 {
> +				clock-frequency = <924000000>;
> +				nvidia,parent-clock-frequency = <924000000>;
> +				clocks = <&tegra_car TEGRA124_CLK_PLL_M_UD>;
> +				clock-names = "emc-parent";
> +			};
> +		};
> +	};
> +
> +	emc at 0,7001b000 {
> +		emc-timings-1 {
> +			nvidia,ram-code = <1>;
> +
> +			timing-12750000 {
> +				clock-frequency = <12750000>;
> +
> +				nvidia,emc-auto-cal-config = <0xa1430000>;
> +				nvidia,emc-auto-cal-config2 = <0x00000000>;
> +				nvidia,emc-auto-cal-config3 = <0x00000000>;
> +				nvidia,emc-auto-cal-interval = <0x001fffff>;
> +				nvidia,emc-bgbias-ctl0 = <0x00000008>;
> +				nvidia,emc-cfg = <0x73240000>;
> +				nvidia,emc-cfg-2 = <0x000008c5>;
> +				nvidia,emc-ctt-term-ctrl = <0x00000802>;
> +				nvidia,emc-mode-1 = <0x80100003>;
> +				nvidia,emc-mode-2 = <0x80200008>;
> +				nvidia,emc-mode-4 = <0x00000000>;
> +				nvidia,emc-mode-reset = <0x80001221>;
> +				nvidia,emc-mrs-wait-cnt = <0x000e000e>;
> +				nvidia,emc-sel-dpd-ctrl = <0x00040128>;
> +				nvidia,emc-xm2dqspadctrl2 = <0x0130b118>;
> +				nvidia,emc-zcal-cnt-long = <0x00000042>;
> +				nvidia,emc-zcal-interval = <0x00000000>;
> +
> +				nvidia,emc-configuration = <
> +					0x00000000
> +					0x00000003

This is a bit long. Do multiple values per line.

> +					0x00000000
> +					0x00000000
> +					0x00000000
> +					0x00000004
> +					0x0000000a
> +					0x00000005
