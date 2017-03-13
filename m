From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 13 Mar 2017 13:04:42 +0100
Subject: [PATCH v5 2/2] arm64: dts: move from ARCH_VULCAN to ARCH_THUNDER2
In-Reply-To: <1489313015-4783-3-git-send-email-jnair@caviumnetworks.com>
References: <1489313015-4783-1-git-send-email-jnair@caviumnetworks.com>
 <1489313015-4783-3-git-send-email-jnair@caviumnetworks.com>
Message-ID: <24cdda5a-beb8-4cfe-e1b8-5faa2474c063@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/03/17 11:03, Jayachandran C wrote:
> Move and update device tree files as part of transition from Broadcom
> Vulcan to Cavium ThunderX2.
>
> The changes are to:
>  * rename dts/broadcom/vulcan.dtsi to cavium/thunder2-99xx.dtsi,
>    update cpu cores to be "cavium,thunder2", and update SoC to be
>    "cavium,thunderx2-cn9900"
>  * move SoC dts/broadcom/vulcan-eval.dtsi to cavium/thunder2-99xx.dtsi
>    and update board name string
>  * Update dts/broadcom/Makefile not to build vulcan dtbs
>  * Update dts/cavium/Makefile to build thunder2 dtbs
>
> No changes to the dts contents except the updated "compatible" and
> "model" properties.
>
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> ---
>  arch/arm64/boot/dts/broadcom/Makefile         |   1 -
>  arch/arm64/boot/dts/broadcom/vulcan-eval.dts  |  33 ------
>  arch/arm64/boot/dts/broadcom/vulcan.dtsi      | 147 --------------------------
>  arch/arm64/boot/dts/cavium/Makefile           |   1 +
>  arch/arm64/boot/dts/cavium/thunder2-99xx.dts  |  33 ++++++
>  arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi | 147 ++++++++++++++++++++++++++
>  6 files changed, 181 insertions(+), 181 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/broadcom/vulcan-eval.dts
>  delete mode 100644 arch/arm64/boot/dts/broadcom/vulcan.dtsi
>  create mode 100644 arch/arm64/boot/dts/cavium/thunder2-99xx.dts
>  create mode 100644 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
>
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
> index f1caece..bfa8f8e 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -1,6 +1,5 @@
>  dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb
>  dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-svk.dtb ns2-xmc.dtb
> -dtb-$(CONFIG_ARCH_VULCAN) += vulcan-eval.dtb
>
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/broadcom/vulcan-eval.dts b/arch/arm64/boot/dts/broadcom/vulcan-eval.dts
> deleted file mode 100644
> index 9ee8d3d..0000000
> --- a/arch/arm64/boot/dts/broadcom/vulcan-eval.dts
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/*
> - * dts file for Broadcom (BRCM) Vulcan Evaluation Platform
> - *
> - * Copyright (c) 2013-2016 Broadcom
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> - */
> -
> -/dts-v1/;
> -
> -#include "vulcan.dtsi"
> -
> -/ {
> -	model = "Broadcom Vulcan Eval Platform";
> -	compatible = "brcm,vulcan-eval", "brcm,vulcan-soc";
> -
> -	memory {
> -		device_type = "memory";
> -		reg = <0x00000000 0x80000000 0x0 0x80000000>,  /* 2G @ 2G  */
> -		      <0x00000008 0x80000000 0x0 0x80000000>;  /* 2G @ 34G */
> -	};
> -
> -	aliases {
> -		serial0 = &uart0;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> diff --git a/arch/arm64/boot/dts/broadcom/vulcan.dtsi b/arch/arm64/boot/dts/broadcom/vulcan.dtsi
> deleted file mode 100644
> index 34e11a9..0000000
> --- a/arch/arm64/boot/dts/broadcom/vulcan.dtsi
> +++ /dev/null
> @@ -1,147 +0,0 @@
> -/*
> - * dtsi file for Broadcom (BRCM) Vulcan processor
> - *
> - * Copyright (c) 2013-2016 Broadcom
> - * Author: Zi Shen Lim <zlim@broadcom.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> - */
> -
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -
> -/ {
> -	model = "Broadcom Vulcan";
> -	compatible = "brcm,vulcan-soc";
> -	interrupt-parent = <&gic>;
> -	#address-cells = <2>;
> -	#size-cells = <2>;
> -
> -	/* just 4 cpus now, 128 needed in full config */
> -	cpus {
> -		#address-cells = <0x2>;
> -		#size-cells = <0x0>;
> -
> -		cpu at 0 {
> -			device_type = "cpu";
> -			compatible = "brcm,vulcan", "arm,armv8";
> -			reg = <0x0 0x0>;
> -			enable-method = "psci";
> -		};
> -
> -		cpu at 1 {
> -			device_type = "cpu";
> -			compatible = "brcm,vulcan", "arm,armv8";
> -			reg = <0x0 0x1>;
> -			enable-method = "psci";
> -		};
> -
> -		cpu at 2 {
> -			device_type = "cpu";
> -			compatible = "brcm,vulcan", "arm,armv8";
> -			reg = <0x0 0x2>;
> -			enable-method = "psci";
> -		};
> -
> -		cpu at 3 {
> -			device_type = "cpu";
> -			compatible = "brcm,vulcan", "arm,armv8";
> -			reg = <0x0 0x3>;
> -			enable-method = "psci";
> -		};
> -	};
> -
> -	psci {
> -		compatible = "arm,psci-0.2";
> -		method = "smc";
> -	};
> -
> -	gic: interrupt-controller at 400080000 {
> -		compatible = "arm,gic-v3";
> -		#interrupt-cells = <3>;
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -		interrupt-controller;
> -		#redistributor-regions = <1>;
> -		reg = <0x04 0x00080000 0x0 0x20000>,	/* GICD */
> -		      <0x04 0x01000000 0x0 0x1000000>;	/* GICR */
> -		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		gicits: gic-its at 40010000 {
> -			compatible = "arm,gic-v3-its";
> -			msi-controller;
> -			reg = <0x04 0x00100000 0x0 0x20000>;	/* GIC ITS */
> -		};
> -	};
> -
> -	timer {
> -		compatible = "arm,armv8-timer";
> -		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> -
> -	pmu {
> -		compatible = "brcm,vulcan-pmu", "arm,armv8-pmuv3";
> -		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>; /* PMU overflow */
> -	};
> -
> -	clk125mhz: uart_clk125mhz {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clk125mhz";
> -	};
> -
> -	pci {
> -		compatible = "pci-host-ecam-generic";
> -		device_type = "pci";
> -		#interrupt-cells = <1>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -
> -		/* ECAM at 0x3000_0000 - 0x4000_0000 */
> -		reg = <0x0 0x30000000  0x0 0x10000000>;
> -		reg-names = "PCI ECAM";
> -
> -		/*
> -		 * PCI ranges:
> -		 *   IO		no supported
> -		 *   MEM        0x4000_0000 - 0x6000_0000
> -		 *   MEM64 pref 0x40_0000_0000 - 0x60_0000_0000
> -		 */
> -		ranges =
> -		  <0x02000000    0 0x40000000    0 0x40000000    0 0x20000000
> -		   0x43000000 0x40 0x00000000 0x40 0x00000000 0x20 0x00000000>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map =
> -		      /* addr  pin  ic   icaddr  icintr */
> -			<0 0 0  1  &gic   0 0    GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH
> -			 0 0 0  2  &gic   0 0    GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH
> -			 0 0 0  3  &gic   0 0    GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH
> -			 0 0 0  4  &gic   0 0    GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> -		msi-parent = <&gicits>;
> -		dma-coherent;
> -	};
> -
> -	soc {
> -		compatible = "simple-bus";
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		uart0: serial at 402020000 {
> -			compatible = "arm,pl011", "arm,primecell";
> -			reg = <0x04 0x02020000 0x0 0x1000>;
> -			interrupt-parent = <&gic>;
> -			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&clk125mhz>;
> -			clock-names = "apb_pclk";
> -		};
> -	};
> -
> -};
> diff --git a/arch/arm64/boot/dts/cavium/Makefile b/arch/arm64/boot/dts/cavium/Makefile
> index e34f89d..581b2c1 100644
> --- a/arch/arm64/boot/dts/cavium/Makefile
> +++ b/arch/arm64/boot/dts/cavium/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
> +dtb-$(CONFIG_ARCH_THUNDER2) += thunder2-99xx.dtb
>
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/cavium/thunder2-99xx.dts b/arch/arm64/boot/dts/cavium/thunder2-99xx.dts
> new file mode 100644
> index 0000000..57a6f75
> --- /dev/null
> +++ b/arch/arm64/boot/dts/cavium/thunder2-99xx.dts
> @@ -0,0 +1,33 @@
> +/*
> + * dts file for Broadcom (BRCM) Vulcan Evaluation Platform
> + *
> + * Copyright (c) 2013-2016 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +#include "thunder2-99xx.dtsi"
> +
> +/ {
> +	model = "Cavium ThunderX2 CN99XX";
> +	compatible = "cavium,thunderx2-cn9900", "brcm,vulcan-soc";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0x0 0x80000000>,  /* 2G @ 2G  */
> +		      <0x00000008 0x80000000 0x0 0x80000000>;  /* 2G @ 34G */
> +	};
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi b/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
> new file mode 100644
> index 0000000..46afe3a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
> @@ -0,0 +1,147 @@
> +/*
> + * dtsi file for Broadcom (BRCM) Vulcan processor

You might want to add Cavium CN99 here.

Apart from that:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> + *
> + * Copyright (c) 2013-2016 Broadcom
> + * Author: Zi Shen Lim <zlim@broadcom.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "Cavium ThunderX2 CN99XX";
> +	compatible = "cavium,thunderx2-cn9900", "brcm,vulcan-soc";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	/* just 4 cpus now, 128 needed in full config */
> +	cpus {
> +		#address-cells = <0x2>;
> +		#size-cells = <0x0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "cavium,thunder2", "brcm,vulcan", "arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "cavium,thunder2", "brcm,vulcan", "arm,armv8";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "cavium,thunder2", "brcm,vulcan", "arm,armv8";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "cavium,thunder2", "brcm,vulcan", "arm,armv8";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	gic: interrupt-controller at 400080000 {
> +		compatible = "arm,gic-v3";
> +		#interrupt-cells = <3>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		interrupt-controller;
> +		#redistributor-regions = <1>;
> +		reg = <0x04 0x00080000 0x0 0x20000>,	/* GICD */
> +		      <0x04 0x01000000 0x0 0x1000000>;	/* GICR */
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		gicits: gic-its at 40010000 {
> +			compatible = "arm,gic-v3-its";
> +			msi-controller;
> +			reg = <0x04 0x00100000 0x0 0x20000>;	/* GIC ITS */
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	pmu {
> +		compatible = "brcm,vulcan-pmu", "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>; /* PMU overflow */
> +	};
> +
> +	clk125mhz: uart_clk125mhz {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clk125mhz";
> +	};
> +
> +	pci {
> +		compatible = "pci-host-ecam-generic";
> +		device_type = "pci";
> +		#interrupt-cells = <1>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +
> +		/* ECAM at 0x3000_0000 - 0x4000_0000 */
> +		reg = <0x0 0x30000000  0x0 0x10000000>;
> +		reg-names = "PCI ECAM";
> +
> +		/*
> +		 * PCI ranges:
> +		 *   IO		no supported
> +		 *   MEM        0x4000_0000 - 0x6000_0000
> +		 *   MEM64 pref 0x40_0000_0000 - 0x60_0000_0000
> +		 */
> +		ranges =
> +		  <0x02000000    0 0x40000000    0 0x40000000    0 0x20000000
> +		   0x43000000 0x40 0x00000000 0x40 0x00000000 0x20 0x00000000>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map =
> +		      /* addr  pin  ic   icaddr  icintr */
> +			<0 0 0  1  &gic   0 0    GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH
> +			 0 0 0  2  &gic   0 0    GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH
> +			 0 0 0  3  &gic   0 0    GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH
> +			 0 0 0  4  &gic   0 0    GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +		msi-parent = <&gicits>;
> +		dma-coherent;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		uart0: serial at 402020000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x04 0x02020000 0x0 0x1000>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk125mhz>;
> +			clock-names = "apb_pclk";
> +		};
> +	};
> +
> +};
>
