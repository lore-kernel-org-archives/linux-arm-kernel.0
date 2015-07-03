From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sat, 04 Jul 2015 00:03:45 +0200
Subject: [PATCH v2 2/2] ARM: dts: mediatek: add 6580 support
In-Reply-To: <1435647751-20422-3-git-send-email-mars.cheng@mediatek.com>
References: <1435647751-20422-1-git-send-email-mars.cheng@mediatek.com>
 <1435647751-20422-3-git-send-email-mars.cheng@mediatek.com>
Message-ID: <1665353.lNSALdu3Cy@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 30, 2015 03:02:31 PM Mars Cheng wrote:
> This adds basic chip support for Mediatek 6580.
> 
> Change-Id: Ic5c93eb5d1e6e23503dabd28d41c30a7f02e9c18

Please delete the change-id.

> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  arch/arm/boot/dts/Makefile         |   1 +
>  arch/arm/boot/dts/mt6580-evbp1.dts |  35 +++++++++++
>  arch/arm/boot/dts/mt6580.dtsi      | 125
> +++++++++++++++++++++++++++++++++++++ 3 files changed, 161 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mt6580-evbp1.dts
>  create mode 100644 arch/arm/boot/dts/mt6580.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 86217db..9298531 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -656,6 +656,7 @@ dtb-$(CONFIG_MACH_DOVE) += \
>  	dove-d3plug.dtb \
>  	dove-dove-db.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += \
> +	mt6580-evbp1.dtb \
>  	mt6589-aquaris5.dtb \
>  	mt6592-evb.dtb \
>  	mt8127-moose.dtb \
> diff --git a/arch/arm/boot/dts/mt6580-evbp1.dts
> b/arch/arm/boot/dts/mt6580-evbp1.dts new file mode 100644
> index 0000000..8c42335
> --- /dev/null
> +++ b/arch/arm/boot/dts/mt6580-evbp1.dts
> @@ -0,0 +1,35 @@
> +/*
> + * Copyright (c) 2015 MediaTek Inc.
> + * Author: Mars.C <mars.cheng@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +#include "mt6580.dtsi"
> +
> +/ {
> +	model = "MediaTek MT6580 evaluation board";
> +	compatible = "mediatek,mt6580-evbp1", "mediatek,mt6580";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,921600n8 earlyprintk";
> +		stdout-path = &uart0;
> +	};
> +
> +	memory {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm/boot/dts/mt6580.dtsi b/arch/arm/boot/dts/mt6580.dtsi
> new file mode 100644
> index 0000000..ac97d64
> --- /dev/null
> +++ b/arch/arm/boot/dts/mt6580.dtsi
> @@ -0,0 +1,125 @@
> +/*
> + * Copyright (c) 2015 MediaTek Inc.
> + * Author: Mars.C <mars.cheng@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include "skeleton.dtsi"
> +
> +/ {
> +	compatible = "mediatek,mt6580";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&sysirq>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x0>;
> +		};
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x1>;
> +		};
> +		cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x2>;
> +		};
> +		cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x3>;
> +		};
> +
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		system_clk: dummy13m {
> +			compatible = "fixed-clock";
> +			clock-frequency = <13000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		rtc_clk: dummy32k {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		uart_clk: dummy26m {
> +			compatible = "fixed-clock";
> +			clock-frequency = <26000000>;
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	timer: timer at 10008000 {
> +		compatible = "mediatek,mt6580-timer",
> +			     "mediatek,mt6577-timer";
> +		reg = <0x10008000 0x80>;
> +		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&system_clk>, <&rtc_clk>;
> +		clock-names = "system-clk", "rtc-clk";
> +	};
> +
> +	sysirq: interrupt-controller at 10200100 {
> +		compatible = "mediatek,mt6580-sysirq",
> +			     "mediatek,mt6577-sysirq";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
> +		reg = <0x10200100 0x1c>;
> +	};
> +
> +	gic: interrupt-controller at 10211000 {
> +		compatible = "arm,cortex-a7-gic";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
> +		reg = <0x10211000 0x1000>,
> +		      <0x10212000 0x1000>,
> +		      <0x10214000 0x2000>,
> +		      <0x10216000 0x2000>;
> +	};
> +
> +	uart0: serial at 11005000 {
> +		compatible = "mediatek,mt6580-uart",
> +			     "mediatek,mt6577-uart";

Please update the dts documentation about the compatible string.
Apart from that it looks fine for me.

Cheers,
Matthias
