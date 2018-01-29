From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Jan 2018 11:45:57 -0600
Subject: [PATCH 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <20180117183244.28303-2-l.stach@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-2-l.stach@pengutronix.de>
Message-ID: <20180129174557.ml2gemh3s7pym7v4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 07:32:42PM +0100, Lucas Stach wrote:
> This adds the basic DTS for the i.MX8MQ.
> For now only the following peripherals are supported:
> - IOMUXC (pin controller)
> - CCM (clock controller)
> - GPIO
> - UART
> - uSDHC (SD/eMMC controller)
> - FEC (ethernet controller)
> - i2c
> 
> This is enough to get a very basic board support up and running.
> 
> One known limitation is that the driver for the GPC interrupt
> controller is still missing, rendering the CPU sleep states unusable
> as there is nothing waking them up anymore. This will be fixed in
> due course.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/boot/dts/Makefile             |   1 +
>  arch/arm64/boot/dts/nxp/imx8mq-pinfunc.h | 632 +++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/nxp/imx8mq.dtsi      | 418 ++++++++++++++++++++
>  3 files changed, 1051 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nxp/imx8mq-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/nxp/imx8mq.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 4aa50b9b26bc..2713cf715664 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -16,6 +16,7 @@ subdir-y += lg
>  subdir-y += marvell
>  subdir-y += mediatek
>  subdir-y += nvidia
> +subdir-y += nxp
>  subdir-y += qcom
>  subdir-y += realtek
>  subdir-y += renesas
> diff --git a/arch/arm64/boot/dts/nxp/imx8mq-pinfunc.h b/arch/arm64/boot/dts/nxp/imx8mq-pinfunc.h
> new file mode 100644
> index 000000000000..0e1d67d414b5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nxp/imx8mq-pinfunc.h
> @@ -0,0 +1,632 @@
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017 NXP
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

SPDX tag

[...]

> diff --git a/arch/arm64/boot/dts/nxp/imx8mq.dtsi b/arch/arm64/boot/dts/nxp/imx8mq.dtsi
> new file mode 100644
> index 000000000000..64955a97558e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/nxp/imx8mq.dtsi
> @@ -0,0 +1,418 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dt-bindings/clock/imx8mq-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include "imx8mq-pinfunc.h"
> +
> +/* first 128 KiB of memory are owned by ATF */
> +/memreserve/ 0x40000000 0x00020000;
> +
> +/ {
> +	compatible = "nxp,imx8mq";

No point in this because every board should set it with board specific 
compatible in addition.

> +	/* This should really be the GPC, but we need a driver for this first */
> +	interrupt-parent = <&gic>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		gpio4 = &gpio5;

Please drop these.

> +		i2c0 = &i2c1;
> +		i2c1 = &i2c2;
> +		i2c2 = &i2c3;
> +		i2c3 = &i2c4;
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		serial3 = &uart4;
> +	};
> +
> +	ckil: clk-ckil {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "ckil";
> +	};
> +
> +	osc_25m: clk-osc-25m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +		clock-output-names = "osc_25m";
> +	};
> +
> +	osc_27m: clk-osc-27m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <27000000>;
> +		clock-output-names = "osc_27m";
> +	};
> +
> +	clk_ext1: clk-ext1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <133000000>;
> +		clock-output-names = "clk_ext1";
> +	};
> +
> +	clk_ext2: clk-ext2 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <133000000>;
> +		clock-output-names = "clk_ext2";
> +	};
> +
> +	clk_ext3: clk-ext3 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <133000000>;
> +		clock-output-names = "clk_ext3";
> +	};
> +
> +	clk_ext4: clk-ext4 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency= <133000000>;
> +		clock-output-names = "clk_ext4";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			CPU_SLEEP: cpu-sleep {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0010033>;
> +				local-timer-stop;
> +				entry-latency-us = <1000>;
> +				exit-latency-us = <700>;
> +				min-residency-us = <2700>;
> +				wakeup-latency-us = <1500>;
> +			};
> +		};
> +
> +		A53_0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP>;
> +		};
> +
> +		A53_1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP>;
> +		};
> +
> +		A53_2: cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x2>;
> +			enable-method = "psci";
> +			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP>;
> +		};
> +
> +		A53_3: cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			enable-method = "psci";
> +			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP>;
> +		};
> +
> +		A53_L2: l2-cache0 {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>, /* Physical Secure */
> +		             <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>, /* Physical Non-Secure */
> +		             <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>, /* Virtual */
> +		             <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>; /* Hypervisor */
> +		clock-frequency = <8333333>;
> +		interrupt-parent = <&gic>;
> +		arm,no-tick-in-suspend;
> +	};
> +
> +	peripherals at 0 {
> +		compatible = "simple-bus";
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x0 0x3e000000>;
> +
> +
> +		aips-bus at 30000000 { /* AIPS1 */
> +			compatible = "nxp,imx8mq-aips-bus", "simple-bus";
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x30000000 0x30000000 0x400000>;
> +
> +			gpio1: gpio at 30200000 {
> +				compatible = "nxp,imx8mq-gpio", "fsl,imx35-gpio";
> +				reg = <0x30200000 0x10000>;
> +				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +				             <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio2: gpio at 30210000 {
> +				compatible = "nxp,imx8mq-gpio", "fsl,imx35-gpio";
> +				reg = <0x30210000 0x10000>;
> +				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
> +				        <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio3: gpio at 30220000 {
> +				compatible = "nxp,imx8mq-gpio", "fsl,imx35-gpio";
> +				reg = <0x30220000 0x10000>;
> +				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> +				        <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio4: gpio at 30230000 {
> +				compatible = "nxp,imx8mq-gpio", "fsl,imx35-gpio";
> +				reg = <0x30230000 0x10000>;
> +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +				                <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio5: gpio at 30240000 {
> +				compatible = "nxp,imx8mq-gpio", "fsl,imx35-gpio";
> +				reg = <0x30240000 0x10000>;
> +				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +				        <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			iomuxc: iomuxc at 30330000 {
> +				compatible = "nxp,imx8mq-iomuxc";
> +				reg = <0x30330000 0x10000>;
> +			};
> +
> +			gpr: iomuxc-gpr at 30340000 {
> +				compatible = "nxp,imx8mq-iomuxc-gpr", "syscon";
> +				reg = <0x30340000 0x10000>;
> +			};
> +
> +			anatop: anatop at 30360000 {
> +				compatible = "nxp,imx8mq-anatop", "syscon";
> +				reg = <0x30360000 0x10000>;
> +				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			clk: ccm at 30380000 {

clock-controller at ...

> +				compatible = "nxp,imx8mq-ccm";
> +				reg = <0x30380000 0x10000>;
> +				interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
> +				             <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +				#clock-cells = <1>;
> +				clocks = <&ckil>, <&osc_25m>, <&osc_27m>,
> +				         <&clk_ext1>, <&clk_ext2>,
> +				         <&clk_ext3>, <&clk_ext4>;
> +				clock-names = "ckil", "osc_25m", "osc_27m",
> +				              "clk_ext1", "clk_ext2",
> +				              "clk_ext3", "clk_ext4";
> +			};
> +		};
> +
> +		aips-bus at 30400000 { /* AIPS2 */

bus at ...

> +			compatible = "nxp,imx8mq-aips-bus", "simple-bus";
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x30400000 0x30400000 0x400000>;
> +		};
> +
> +		aips-bus at 30800000 { /* AIPS3 */

bus at ...

> +			compatible = "nxp,imx8mq-aips-bus", "simple-bus";
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x30800000 0x30800000 0x400000>;
> +
> +			uart1: serial at 30860000 {
> +				compatible = "nxp,imx8mq-uart",
> +				             "fsl,imx6q-uart", "fsl,imx21-uart";
> +				reg = <0x30860000 0x10000>;
> +				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_UART1_ROOT>,
> +				         <&clk IMX8MQ_CLK_UART1_ROOT>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			uart3: serial at 30880000 {
> +				compatible = "nxp,imx8mq-uart",
> +				             "fsl,imx6q-uart", "fsl,imx21-uart";
> +				reg = <0x30880000 0x10000>;
> +				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_UART3_ROOT>,
> +				         <&clk IMX8MQ_CLK_UART3_ROOT>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			uart2: serial at 30890000 {
> +				compatible = "nxp,imx8mq-uart",
> +				             "fsl,imx6q-uart", "fsl,imx21-uart";
> +				reg = <0x30890000 0x10000>;
> +				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_UART2_ROOT>,
> +				         <&clk IMX8MQ_CLK_UART2_ROOT>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c at 30a20000 {
> +				compatible = "nxp,imx8mq-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a20000 0x10000>;
> +				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_I2C1_ROOT>;
> +				status = "disabled";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			i2c2: i2c at 30a30000 {
> +				compatible = "nxp,imx8mq-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a30000 0x10000>;
> +				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_I2C2_ROOT>;
> +				status = "disabled";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			i2c3: i2c at 30a40000 {
> +				compatible = "nxp,imx8mq-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a40000 0x10000>;
> +				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_I2C3_ROOT>;
> +				status = "disabled";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			i2c4: i2c at 30a50000 {
> +				compatible = "nxp,imx8mq-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a50000 0x10000>;
> +				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_I2C4_ROOT>;
> +				status = "disabled";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			uart4: serial at 30a60000 {
> +				compatible = "nxp,imx8mq-uart",
> +				             "fsl,imx6q-uart", "fsl,imx21-uart";
> +				reg = <0x30a60000 0x10000>;
> +				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_UART4_ROOT>,
> +				         <&clk IMX8MQ_CLK_UART4_ROOT>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			usdhc1: usdhc at 30b40000 {
> +				compatible = "nxp,imx8mq-usdhc",
> +				             "fsl,imx7d-usdhc";
> +				reg = <0x30b40000 0x10000>;
> +				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_DUMMY>,
> +				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS_DIV>,
> +				         <&clk IMX8MQ_CLK_USDHC1_ROOT>;
> +				clock-names = "ipg", "ahb", "per";
> +				fsl,tuning-start-tap = <20>;
> +				fsl,tuning-step = <2>;
> +				bus-width = <4>;
> +				status = "disabled";
> +			};
> +
> +			usdhc2: usdhc at 30b50000 {
> +				compatible = "nxp,imx8mq-usdhc",
> +				             "fsl,imx7d-usdhc";
> +				reg = <0x30b50000 0x10000>;
> +				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_DUMMY>,
> +				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS_DIV>,
> +				         <&clk IMX8MQ_CLK_USDHC2_ROOT>;
> +				clock-names = "ipg", "ahb", "per";
> +				fsl,tuning-start-tap = <20>;
> +				fsl,tuning-step = <2>;
> +				bus-width = <4>;
> +				status = "disabled";
> +			};
> +
> +			fec1: ethernet at 30be0000 {
> +				compatible = "nxp,imx8mq-fec", "fsl,imx6sx-fec";
> +				reg = <0x30be0000 0x10000>;
> +				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				             <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
> +				             <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_ENET1_ROOT>,
> +				         <&clk IMX8MQ_CLK_ENET1_ROOT>,
> +				         <&clk IMX8MQ_CLK_ENET_TIMER_DIV>,
> +				         <&clk IMX8MQ_CLK_ENET_REF_DIV>,
> +				         <&clk IMX8MQ_CLK_ENET_PHY_REF_DIV>;
> +				clock-names = "ipg", "ahb", "ptp",
> +				              "enet_clk_ref", "enet_out";
> +				fsl,num-tx-queues = <3>;
> +				fsl,num-rx-queues = <3>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		gic: interrupt-controller at 38800000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x38800000 0x10000>, /* GIC Dist */
> +			      <0x38880000 0xc0000>; /* GICR (RD_base + SGI_base) */
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-parent = <&gic>;
> +		};
> +	};
> +};
> -- 
> 2.11.0
> 
