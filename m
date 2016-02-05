From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 Feb 2016 09:50:26 +0100
Subject: [PATCH 10/11] arm64: dts: add Allwinner A64 SoC .dtsi
In-Reply-To: <1454348370-3816-11-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-11-git-send-email-andre.przywara@arm.com>
Message-ID: <20160205085026.GA1139@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Mon, Feb 01, 2016 at 05:39:29PM +0000, Andre Przywara wrote:
> The Allwinner A64 SoC is low-cost SoC with 4 ARM Cortex-A53 cores
> and the typical tablet / TV box peripherals.
> The Soc is based on the (32-bit) Allwinner H3 chip, sharing most of
> the peripherals and the memory map.
> Although the cores are proper 64-bit ones, the whole SoC is actually
> limited to 4GB (including all the supported DRAM), so we use 32-bit
> address and size cells. This has the nice feature of us being able to
> reuse the DT for 32-bit kernels as well.
> This .dtsi lists the hardware that we support so far.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.txt   |   1 +
>  Documentation/devicetree/bindings/clock/sunxi.txt |   1 +
>  arch/arm64/boot/dts/allwinner/a64.dtsi            | 583 ++++++++++++++++++++++
>  3 files changed, 585 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/a64.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> index 980e065..4a83853 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> @@ -14,6 +14,7 @@ using one of the following compatible strings:
>    allwinner,sun8i-a83t
>    allwinner,sun8i-h3
>    allwinner,sun9i-a80
> +  allwinner,a64
>  
>  For Allwinner SoCs without any specific needs the generic fallback value of:
>    allwinner,sunxi
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index e59f57b..44b0c6c 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -77,6 +77,7 @@ Required properties:
>  	"allwinner,sun9i-a80-usb-mod-clk" - for usb gates + resets on A80
>  	"allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates + resets on A80
>  	"allwinner,sun4i-a10-ve-clk" - for the Video Engine clock
> +	"allwinner,a64-bus-gates-clk" - for the A64 multi-parent bus gates clock
>  
>  Required properties for all clocks:
>  - reg : shall be the control register address for the clock.
> diff --git a/arch/arm64/boot/dts/allwinner/a64.dtsi b/arch/arm64/boot/dts/allwinner/a64.dtsi
> new file mode 100644
> index 0000000..8dce10f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/a64.dtsi
> @@ -0,0 +1,583 @@
> +/*
> + * Copyright (C) 2016 ARM Ltd.
> + * based on the Allwinner H3 dtsi:
> + *    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
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
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
> +
> +/ {
> +	compatible = "allwinner,a64", "allwinner,sunxi";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +	};

The aliases are usually per-board, as it will vary depending on what
the board enables.

> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 1 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 2 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 3 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <3>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2", "arm,psci";
> +		method = "smc";
> +		cpu_suspend = <0xc4000001>;
> +		cpu_off = <0x84000002>;
> +		cpu_on = <0xc4000003>;
> +	};

I thought that the function IDs were not needed anymore with PSCI 0.2?


> +	memory {
> +		device_type = "memory";
> +		reg = <0x40000000 0>;
> +	};

I'm guessing u-boot fixes that, can we just remove it entirely?

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 14
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 11
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 10
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		osc24M: osc24M_clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <24000000>;
> +			clock-output-names = "osc24M";
> +		};
> +
> +		osc32k: osc32k_clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <32768>;
> +			clock-output-names = "osc32k";
> +		};
> +
> +		pll1: clk at 01c20000 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun8i-a23-pll1-clk";
> +			reg = <0x01c20000 0x4>;
> +			clocks = <&osc24M>;
> +			clock-output-names = "pll1";
> +		};
> +
> +		pll6: clk at 01c20028 {
> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun6i-a31-pll6-clk";
> +			reg = <0x01c20028 0x4>;
> +			clocks = <&osc24M>;
> +			clock-output-names = "pll6", "pll6x2";

The output names have changed, and it doesn't take an argument
anymore.

> +		};
> +
> +		pll6d2: pll6d2_clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-factor-clock";
> +			clock-div = <2>;
> +			clock-mult = <1>;
> +			clocks = <&pll6 0>;
> +			clock-output-names = "pll6d2";
> +		};
> +
> +		/* dummy clock until pll6 can be reused */
> +		pll8: pll8_clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <1>;
> +			clock-output-names = "pll8";
> +		};
> +
> +		cpu: cpu_clk at 01c20050 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-a10-cpu-clk";
> +			reg = <0x01c20050 0x4>;
> +			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll1>;
> +			clock-output-names = "cpu";
> +			critical-clocks = <0>;
> +		};
> +
> +		axi: axi_clk at 01c20050 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-a10-axi-clk";
> +			reg = <0x01c20050 0x4>;
> +			clocks = <&cpu>;
> +			clock-output-names = "axi";
> +		};
> +
> +		ahb1: ahb1_clk at 01c20054 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun6i-a31-ahb1-clk";
> +			reg = <0x01c20054 0x4>;
> +			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
> +			clock-output-names = "ahb1";
> +		};
> +
> +		ahb2: ahb2_clk at 01c2005c {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun8i-h3-ahb2-clk";
> +			reg = <0x01c2005c 0x4>;
> +			clocks = <&ahb1>, <&pll6d2>;
> +			clock-output-names = "ahb2";
> +		};
> +
> +		apb1: apb1_clk at 01c20054 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-a10-apb0-clk";
> +			reg = <0x01c20054 0x4>;
> +			clocks = <&ahb1>;
> +			clock-output-names = "apb1";
> +		};
> +
> +		apb2: apb2_clk at 01c20058 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-a10-apb1-clk";
> +			reg = <0x01c20058 0x4>;
> +			clocks = <&osc32k>, <&osc24M>, <&pll6 1>, <&pll6 1>;
> +			clock-output-names = "apb2";
> +		};
> +
> +		bus_gates: clk at 01c20060 {
> +			#clock-cells = <1>;
> +			compatible = "allwinner,a64-bus-gates-clk",
> +				     "allwinner,sunxi-multi-bus-gates-clk";
> +			reg = <0x01c20060 0x14>;
> +			ahb1_parent {
> +				clocks = <&ahb1>;
> +				clock-indices = <1>, <5>,
> +						<6>, <8>,
> +						<9>, <10>,
> +						<13>, <14>,
> +						<18>, <19>,
> +						<20>, <21>,
> +						<23>, <24>,
> +						<25>, <28>,
> +						<32>, <35>,
> +						<36>, <37>,
> +						<40>, <43>,
> +						<44>, <52>,
> +						<53>, <54>,
> +						<135>;
> +				clock-output-names = "bus_mipidsi", "bus_ce",
> +						"bus_dma", "bus_mmc0",
> +						"bus_mmc1", "bus_mmc2",
> +						"bus_nand", "bus_sdram",
> +						"bus_ts", "bus_hstimer",
> +						"bus_spi0", "bus_spi1",
> +						"bus_otg", "bus_otg_ehci0",
> +						"bus_ehci0", "bus_otg_ohci0",
> +						"bus_ve", "bus_lcd0",
> +						"bus_lcd1", "bus_deint",
> +						"bus_csi", "bus_hdmi",
> +						"bus_de", "bus_gpu",
> +						"bus_msgbox", "bus_spinlock",
> +						"bus_dbg";
> +			};
> +			ahb2_parent {
> +				clocks = <&ahb2>;
> +				clock-indices = <17>, <29>;
> +				clock-output-names = "bus_gmac", "bus_ohci0";
> +			};
> +			apb1_parent {
> +				clocks = <&apb1>;
> +				clock-indices = <64>, <65>,
> +						<69>, <72>,
> +						<76>, <77>,
> +						<78>;
> +				clock-output-names = "bus_codec", "bus_spdif",
> +						"bus_pio", "bus_ths",
> +						"bus_i2s0", "bus_i2s1",
> +						"bus_i2s2";
> +			};
> +			abp2_parent {
> +				clocks = <&apb2>;
> +				clock-indices = <96>, <97>,
> +						<98>, <101>,
> +						<112>, <113>,
> +						<114>, <115>,
> +						<116>;
> +				clock-output-names = "bus_i2c0", "bus_i2c1",
> +						"bus_i2c2", "bus_scr",
> +						"bus_uart0", "bus_uart1",
> +						"bus_uart2", "bus_uart3",
> +						"bus_uart4";
> +			};
> +		};

As I've already told you I'm not really fond of this one, for two main
topics.

The first one is about the DT bindings itself which is quite exotic,
especially the fact that you define clocks using clocks, clock-indices
and clock-output-names in nodes that are not the one referred to by
consumer, which goes against both the clock bindings documentation and
the usage.

The second one is pretty much the same one than for the discussion we
had about pinctrl. There is SoCs where we simply don't have that
information, or at least are not really sure about what to put where
(namely, the A83t). In such a case, we would knowingly put invalid
information in the DT, which is already quite bad in itself. The worst
part is, when we will identify issues and fix them (hopefully), there
will be no way to fix the current DT users. And it just became a pain
to maintain in the long run.

On the opposite side, having something like the H3 bus gates driver
address all these concerns and is easily extensible, which is why we
ended up merging it.

So please use it.

> +		mmc0_clk: clk at 01c20088 {
> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun4i-a10-mmc-clk";
> +			reg = <0x01c20088 0x4>;
> +			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
> +			clock-output-names = "mmc0",
> +					     "mmc0_output",
> +					     "mmc0_sample";
> +		};
> +
> +		mmc1_clk: clk at 01c2008c {
> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun4i-a10-mmc-clk";
> +			reg = <0x01c2008c 0x4>;
> +			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
> +			clock-output-names = "mmc1",
> +					     "mmc1_output",
> +					     "mmc1_sample";
> +		};
> +
> +		mmc2_clk: clk at 01c20090 {
> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun4i-a10-mmc-clk";
> +			reg = <0x01c20090 0x4>;
> +			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
> +			clock-output-names = "mmc2",
> +					     "mmc2_output",
> +					     "mmc2_sample";
> +		};
> +	};
> +
> +	regulators {
> +		reg_vcc3v3: vcc3v3 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "vcc3v3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		mmc0: mmc at 01c0f000 {
> +			compatible = "allwinner,sun5i-a13-mmc";
> +			reg = <0x01c0f000 0x1000>;
> +			clocks = <&bus_gates 8>,
> +				 <&mmc0_clk 0>,
> +				 <&mmc0_clk 1>,
> +				 <&mmc0_clk 2>;
> +			clock-names = "ahb",
> +				      "mmc",
> +				      "output",
> +				      "sample";
> +			resets = <&ahb_rst 8>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mmc1: mmc at 01c10000 {
> +			compatible = "allwinner,sun5i-a13-mmc";
> +			reg = <0x01c10000 0x1000>;
> +			clocks = <&bus_gates 9>,
> +				 <&mmc1_clk 0>,
> +				 <&mmc1_clk 1>,
> +				 <&mmc1_clk 2>;
> +			clock-names = "ahb",
> +				      "mmc",
> +				      "output",
> +				      "sample";
> +			resets = <&ahb_rst 9>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mmc2: mmc at 01c11000 {
> +			compatible = "allwinner,sun5i-a13-mmc";
> +			reg = <0x01c11000 0x1000>;
> +			clocks = <&bus_gates 10>,
> +				 <&mmc2_clk 0>,
> +				 <&mmc2_clk 1>,
> +				 <&mmc2_clk 2>;
> +			clock-names = "ahb",
> +				      "mmc",
> +				      "output",
> +				      "sample";
> +			resets = <&ahb_rst 10>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		pio: pinctrl at 01c20800 {
> +			compatible = "allwinner,a64-pinctrl";
> +			reg = <0x01c20800 0x400>;
> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&bus_gates 69>;
> +			gpio-controller;
> +			#gpio-cells = <3>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> +			uart0_pins_a: uart0 at 0 {
> +				allwinner,pins = "PB8", "PB9";
> +				allwinner,function = "uart0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			uart0_pins_b: uart0 at 1 {
> +				allwinner,pins = "PF2", "PF3";
> +				allwinner,function = "uart0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			uart1_pins: uart1 at 0 {
> +				allwinner,pins = "PG6", "PG7", "PG8", "PG9";
> +				allwinner,function = "uart1";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			uart2_pins: uart2 at 0 {
> +				allwinner,pins = "PB0", "PB1", "PB2", "PB3";
> +				allwinner,function = "uart2";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			uart3_pins_a: uart3 at 0 {
> +				allwinner,pins = "PD0", "PD1";
> +				allwinner,function = "uart3";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			uart3_pins_b: uart3 at 1 {
> +				allwinner,pins = "PH4", "PH5", "PH6", "PH7";
> +				allwinner,function = "uart3";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};

You have several options for all these controllers, which is why we
have the _a or _b suffices.

Usually, the uart pins we had were only using RX and TX, I guess you
could add a separate node for the RTS / CTS pins if some board want to
use them.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160205/46492fa2/attachment.sig>
