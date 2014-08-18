From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Aug 2014 17:17:44 +0100
Subject: [PATCH 5/7] ARM: meson: dts: add basic
 Meson/Meson6/Meson6-atv1200 DTSI/DTS
In-Reply-To: <1408272594-10814-6-git-send-email-carlo@caione.org>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-6-git-send-email-carlo@caione.org>
Message-ID: <20140818161744.GD3302@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 11:49:52AM +0100, Carlo Caione wrote:
> The Meson6 SoC is produced by Amlogic inc. and it is based on 2 Cortex A9
> and an ARM Mali-400 GPU.
> This patch adds two basic DTSI for the preliminary support of Meson and
> Meson6 SoCs. Another DTS is also added for supporting the atv1200 board,
> produced by Geniatech inc.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  arch/arm/boot/dts/Makefile           |  1 +
>  arch/arm/boot/dts/meson.dtsi         | 75 ++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/meson6-atv1200.dts | 27 +++++++++++++
>  arch/arm/boot/dts/meson6.dtsi        | 44 +++++++++++++++++++++
>  4 files changed, 147 insertions(+)
>  create mode 100644 arch/arm/boot/dts/meson.dtsi
>  create mode 100644 arch/arm/boot/dts/meson6-atv1200.dts
>  create mode 100644 arch/arm/boot/dts/meson6.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b8c5cd3..604acce 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -159,6 +159,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
>  	kirkwood-ts419-6282.dtb
>  dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
>  dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
> +dtb-$(CONFIG_MACH_MESON6) += meson6-atv1200.dtb
>  dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += \
>  	imx25-eukrea-mbimxsd25-baseboard.dtb \
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
> new file mode 100644
> index 0000000..934bb2c
> --- /dev/null
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -0,0 +1,75 @@
> +/*
> + * Copyright 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +
> +	aliases {
> +		serial0 = &uart_AO;
> +		serial1 = &uart_A;
> +		serial2 = &uart_B;
> +		serial3 = &uart_C;
> +	};
> +
> +	gic: interrupt-controller at c4301000 {
> +		compatible = "arm,cortex-a9-gic";
> +		reg = <0xc4301000 0x1000>,
> +		      <0xc4300100 0x0100>;
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +	};
> +
> +	timer at c1109940 {
> +		compatible = "amlogic,meson6-timer";
> +		reg = <0xc1109940 0x14>;
> +		interrupts = <0 10 1>;
> +	};
> +
> +	soc at c8100000 {

What's the unit-address for? This node doesn't have a reg or compatible.

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		uart_AO: serial at c81004c0 {
> +			compatible = "amlogic,meson-uart";
> +			reg = <0xc81004c0 0x14>;
> +			interrupts = <0 90 1>;
> +			clocks = <&clk81>;
> +			status = "disabled";
> +		};
> +
> +		uart_A: serial at c81084c0 {
> +			compatible = "amlogic,meson-uart";
> +			reg = <0xc81084c0 0x14>;
> +			interrupts = <0 90 1>;
> +			clocks = <&clk81>;
> +			status = "disabled";
> +		};
> +
> +		uart_B: serial at c81084dc {
> +			compatible = "amlogic,meson-uart";
> +			reg = <0xc81084dc 0x14>;
> +			interrupts = <0 90 1>;
> +			clocks = <&clk81>;
> +			status = "disabled";
> +		};
> +
> +		uart_C: serial at c8108700 {
> +			compatible = "amlogic,meson-uart";
> +			reg = <0xc8108700 0x14>;
> +			interrupts = <0 90 1>;
> +			clocks = <&clk81>;
> +			status = "disabled";

I guess these are disabled because they aren't always wired up?

> +		};
> +	};
> +}; /* end of / */
> +
> diff --git a/arch/arm/boot/dts/meson6-atv1200.dts b/arch/arm/boot/dts/meson6-atv1200.dts
> new file mode 100644
> index 0000000..b358402
> --- /dev/null
> +++ b/arch/arm/boot/dts/meson6-atv1200.dts
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +/include/ "meson6.dtsi"
> +
> +/ {
> +	model = "Geniatech ATV1200";
> +	compatible = "geniatech,atv1200";
> +
> +	memory {
> +		reg = <0x40000000 0x80000000>;
> +	};
> +
> +	soc at c8100000 {
> +		uart_AO: serial at c81004c0 {
> +			status = "okay";
> +		};
> +	};
> +}; /* end of / */
> +
> diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
> new file mode 100644
> index 0000000..d62add4
> --- /dev/null
> +++ b/arch/arm/boot/dts/meson6.dtsi
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +/include/ "meson.dtsi"
> +
> +/ {
> +	model = "Amlogic Meson6 SoC";
> +	compatible = "amlogic,meson6", "amlogic,8726_mx";
> +
> +	interrupt-parent = <&gic>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0x200>;
> +		};
> +
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0x1>;
> +		};
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +
> +		clk81: clk at 0 {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <200000000>;
> +		};
> +	};

There is really no need to put clocks in a container.

Just put them under the root, and drop the unit-address.

Thanks,
Mark.
