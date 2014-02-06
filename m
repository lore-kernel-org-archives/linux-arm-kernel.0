From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 14:21:06 +0100
Subject: [PATCH V2 2/3] ARM: dts: add dts files for exynos5260 SoC
In-Reply-To: <1391577375-17625-3-git-send-email-rahul.sharma@samsung.com>
References: <1391577375-17625-1-git-send-email-rahul.sharma@samsung.com>
 <1391577375-17625-3-git-send-email-rahul.sharma@samsung.com>
Message-ID: <52F38C42.5030508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul, Pankaj, Arun,

[adding linux-arm-kernel, devicetree MLs and DT people on Cc]

I think it's good time to stop accepting DTS files like this and force 
new ones to use the proper structure with soc node, labels for every 
node and node references.

In case of previous Exynos 5 SoCs I hadn't complained, because they 
shared a lot of data with already existing exynos5.dtsi, but since 
Exynos5260 is completely different, I'd say it should be converted to 
the new layout.

As an example you can look at arch/arm/boot/dts/s3c64xx.dtsi and files 
that include it or, for more complete structures, DTS of other 
platforms, such as imx6*.

Btw. Please remember that linux-samsung-soc mailing list is just a 
convenient utility for reviewers of Samsung-specific patches to have all 
of them in one place. Sending patches to it alone is not enough - a 
general kernel ML list needs to be CCed as well, in this case 
linux-arm-kernel.

Also, please see my comments inline, for review comments unrelated to 
the issue described above.

On 05.02.2014 06:16, Rahul Sharma wrote:
> The patch adds the dts files for exynos5260.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5260-pinctrl.dtsi |  572 +++++++++++++++++++++++++++++
>   arch/arm/boot/dts/exynos5260.dtsi         |  317 ++++++++++++++++
>   2 files changed, 889 insertions(+)
>   create mode 100644 arch/arm/boot/dts/exynos5260-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/exynos5260.dtsi
>
> diff --git a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
> new file mode 100644
> index 0000000..3f2c5c4
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
> @@ -0,0 +1,572 @@
> +/*
> + * Samsung's Exynos5260 SoC pin-mux and pin-config device tree source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Samsung's Exynos5260 SoC pin-mux and pin-config options are listed as device
> + * tree nodes are listed in this file.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +/ {
> +	pinctrl at 11600000 {

[snip]

> +		spi0_bus: spi0-bus {
> +			samsung,pins = "gpa2-0", "gpa2-1", "gpa2-2", "gpa2-3";

What is the reason for SPI0 to have 4 pins, while SPI1 has just 3?

> +			samsung,pin-function = <2>;
> +			samsung,pin-pud = <3>;
> +			samsung,pin-drv = <0>;
> +		};

[snip]

> diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
> new file mode 100644
> index 0000000..32a95c7
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5260.dtsi
> @@ -0,0 +1,317 @@
> +/*
> + * SAMSUNG EXYNOS5260 SoC device tree source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include "skeleton.dtsi"
> +#include "exynos5260-pinctrl.dtsi"
> +
> +#include <dt-bindings/clk/exynos5260-clk.h>
> +
> +/ {
> +	compatible = "samsung,exynos5260";
> +	interrupt-parent = <&gic>;
> +
> +	aliases {
> +		pinctrl0 = &pinctrl_0;
> +		pinctrl1 = &pinctrl_1;
> +		pinctrl2 = &pinctrl_2;
> +	};
> +
> +	chipid at 10000000 {
> +		compatible = "samsung,exynos4210-chipid";
> +		reg = <0x10000000 0x100>;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <0>;

nit: Please make this consistent with CPUs 10x below, by using hex here 
as well.

> +			cci-control-port = <&cci_control1>;
> +		};

nit: Please keep 1 blank line of spacing between nodes.

> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <1>;
> +			cci-control-port = <&cci_control1>;
> +		};
> +		cpu at 100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x100>;
> +			cci-control-port = <&cci_control0>;
> +		};
> +		cpu at 101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x101>;
> +			cci-control-port = <&cci_control0>;
> +		};
> +		cpu at 102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x102>;
> +			cci-control-port = <&cci_control0>;
> +		};
> +		cpu at 103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x103>;
> +			cci-control-port = <&cci_control0>;
> +		};
> +	};
> +
> +	cmus {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +

I don't think there is a need to group these nodes under a parent node 
that doesn't give any additional information, especially when the CMUs 
are scattered trough the whole address space, while we'd like to keep 
the nodes ordered by their addresses, as most platforms do.

> +		cmu_top: clock-controller at 10010000 {
> +			compatible = "exynos5260-cmu-top", "samsung,exynos5260-clock";

I don't think that having the "samsung,exynos5260-clock" compatible 
string for every CMU is appropriate here, because there is no way to 
automatically recognize which CMU it is. Since every CMU instance is 
different, they need to have different compatible strings.

> +			reg = <0x10010000 0x10000>;
> +			#clock-cells = <1>;
> +		};

[snip]

> +	mct at 100B0000 {
> +		compatible = "samsung,exynos4210-mct";
> +		reg = <0x100B0000 0x1000>;
> +		interrupt-controller;
> +		#interrups-cells = <1>;

MCT is not an interrupt controller, so the 2 properties above are incorrect.

> +		interrupt-parent = <&mct_map>;
> +		interrupts = <0>, <1>, <2>, <3>,
> +				<4>, <5>, <6>, <7>,
> +				<8>, <9>, <10>, <11>;
> +		clocks = <&cmu_top FIN_PLL>, <&cmu_peri PERI_CLK_MCT>;
> +		clock-names = "fin_pll", "mct";
> +
> +		mct_map: mct-map {
> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-map = <0 &gic 0 104 0>,
> +					<1 &gic 0 105 0>,
> +					<2 &gic 0 106 0>,
> +					<3 &gic 0 107 0>,
> +					<4 &gic 0 122 0>,
> +					<5 &gic 0 123 0>,
> +					<6 &gic 0 124 0>,
> +					<7 &gic 0 125 0>,
> +					<8 &gic 0 126 0>,
> +					<9 &gic 0 127 0>,
> +					<10 &gic 0 128 0>,
> +					<11 &gic 0 129 0>;
> +		};

There is no need for interrupt-map here, because all the interrupts are 
from GIC.

> +	};

[snip]

> +	mmc_0: mmc0 at 12140000 {
> +		compatible = "samsung,exynos5250-dw-mshc";
> +		reg = <0x12140000 0x2000>;
> +		interrupts = <0 156 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&cmu_fsys FSYS_CLK_MMC0>, <&cmu_top TOP_SCLK_MMC0>;
> +		clock-names = "biu", "ciu";
> +		fifo-depth = <0x40>;

nit: It might be more readable to use decimal 64 here.

Best regards,
Tomasz
