From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Jun 2013 15:05:40 -0700
Subject: [PATCH v5 4/4] ARM: hi3xxx: enable hi4511 with device tree
In-Reply-To: <1371459376-25438-5-git-send-email-haojian.zhuang@linaro.org>
References: <1371459376-25438-1-git-send-email-haojian.zhuang@linaro.org>
 <1371459376-25438-5-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130617220540.GP28497@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some comments below. I didn't research the history of reviews so some might
already have been pointed out and debated; apoligies if they have.

You should also post the device-tree bindings, in particular the clock ones
since they seem to be a bit different from what else we have seen so far, to
device-tree discuss and get them reviewed by Grant/Rob as well as Mike.


-Olof

On Mon, Jun 17, 2013 at 04:56:16PM +0800, Haojian Zhuang wrote:
> Enable Hisilicon Hi4511 development platform with device tree support.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile          |    1 +
>  arch/arm/boot/dts/hi3620.dtsi       | 1147 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/hi4511.dts        |  648 ++++++++++++++++++++
>  arch/arm/configs/multi_v7_defconfig |    1 +
>  4 files changed, 1797 insertions(+)
>  create mode 100644 arch/arm/boot/dts/hi3620.dtsi
>  create mode 100644 arch/arm/boot/dts/hi4511.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f0895c5..216f983 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -58,6 +58,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>  	exynos5250-smdk5250.dtb \
>  	exynos5250-snow.dtb \
>  	exynos5440-ssdk5440.dtb
> +dtb-$(CONFIG_ARCH_HI3xxx) += hi4511.dtb
>  dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
>  	ecx-2000.dtb
>  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
> diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
> new file mode 100644
> index 0000000..1f0a4aa
> --- /dev/null
> +++ b/arch/arm/boot/dts/hi3620.dtsi
> @@ -0,0 +1,1147 @@
> +/*
> + * Hisilicon Ltd. Hi3620 SoC
> + *
> + * Copyright (C) 2012-2013 Hisilicon Ltd.
> + * Copyright (C) 2012-2013 Linaro Ltd.
> + *
> + * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +	};

I would expect a cpus entry around here...?
And a #size-cells and #address-cells.

> +
> +	osc32k: osc at 0 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "osc32khz";
> +	};
> +	osc26m: osc at 1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "osc26mhz";
> +	};
> +	pclk: clk at 0 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "apb_pclk";
> +	};

These are not good names. There's nothing inherently addressable by them but
you still have unit addresses on them. Also, if they have an unit address @<x>,
then they need a reg property. It's probably better to give them unique names
(and not abbreviated). "clock-armpclk". Or something.

> +	pll_arm0: clk at 1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1600000000>;
> +		clock-output-names = "armpll0";
> +	};
> +	pll_arm1: clk at 2 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1600000000>;
> +		clock-output-names = "armpll1";
> +	};
> +	pll_peri: clk at 3 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1440000000>;
> +		clock-output-names = "armpll2";
> +	};
> +	pll_usb: clk at 4 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1440000000>;
> +		clock-output-names = "armpll3";
> +	};
> +	pll_hdmi: clk at 5 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1188000000>;
> +		clock-output-names = "armpll4";
> +	};
> +	pll_gpu: clk at 6 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1300000000>;
> +		clock-output-names = "armpll5";
> +	};

Are these clocks really just there on the board, or are they provided from
a PMIC or similar? Even if you don't have a driver for that chip, describing
the hardware correctly now (with the exception of calling the clocks
fixed-clock) seems like a good idea.

> +
> +	amba {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "arm,amba-bus";
> +		interrupt-parent = <&intc>;
> +		ranges;
> +
> +		pmctrl: pmctrl at fca08000 {
> +			compatible = "hisilicon,pmctrl";
> +			reg = <0xfca08000 0x1000>;
> +		};

[...]

> +			dtable: dtable {
> +				#hisilicon,clkdiv-table-cells = <2>;

This definitely needs some review by the devicetree guys, Rob/Grant. It seems
like a quite unusual binding. What hardware does dtable represent?

> +			};
> +			div_shareaxi: div_shareaxi {
> +				compatible = "hisilicon,hi3620-clk-div";
> +				#clock-cells = <0>;
> +				clocks = <&rclk_shareAXI>;
> +				clock-output-names = "shareAXI_div";
> +				hisilicon,clkdiv-table = <
> +					&dtable 0 1 &dtable 1 2 &dtable 2 3 &dtable 3 4
> +					&dtable 4 5 &dtable 5 6 &dtable 6 7 &dtable 7 8
> +					&dtable 8 9 &dtable 9 10 &dtable 10 11 &dtable 11 12
> +					&dtable 12 13 &dtable 13 14 &dtable 14 15 &dtable 15 16
> +					&dtable 16 17 &dtable 17 18 &dtable 18 19 &dtable 19 20
> +					&dtable 20 21 &dtable 21 22 &dtable 22 23 &dtable 23 24
> +					&dtable 24 25 &dtable 25 26 &dtable 26 27 &dtable 27 28
> +					&dtable 28 29 &dtable 29 30 &dtable 30 31 &dtable 31 32>;
> +				/* divider register offset, mask */
> +				hisilicon,clkdiv = <0x100 0x1f>;
> +			};

> +
> +		l2: l2-cache {
> +			compatible = "arm,pl310-cache";
> +			reg = <0xfc10000 0x100000>;
> +			interrupts = <0 15 4>;
> +			cache-unified;
> +			cache-level = <2>;
> +		};

L2 is on amba?

> +
> +		intc: interrupt-controller at fc001000 {

It's common to use "gic" as the label instead.

> +			compatible = "arm,cortex-a9-gic";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			/* gic dist base, gic cpu base */
> +			reg = <0xfc001000 0x1000>, <0xfc000100 0x100>;
> +		};
> +

[...]



-Olof
