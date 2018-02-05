From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 5 Feb 2018 15:00:10 +0000
Subject: [PATCH v2 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <20180201183126.32384-2-l.stach@pengutronix.de>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-2-l.stach@pengutronix.de>
Message-ID: <6d93d3cb-5078-3cc3-29de-1280d686fa46@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/18 18:31, Lucas Stach wrote:
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
> v2:
>  - move to freescale folder
>  - change compatibles to "fsl" vendor prefix
>  - remove unnecessary newlines
>  - move status property to be the last in all node
>  - remove imx21 compatibles from UART nodes
>  - document compatible
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt  |   4 +
>  arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h | 623 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi      | 411 ++++++++++++++++
>  3 files changed, 1038 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq.dtsi
> 

[...]

> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> new file mode 100644
> index 000000000000..50ed302d299a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -0,0 +1,411 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2017 NXP
> + * Copyright (C) 2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> + */
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
> +	/* This should really be the GPC, but we need a driver for this first */
> +	interrupt-parent = <&gic>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
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

GICv3 doesn't have express PPI affinity this way (and 6 feels slightly
wrong anyway).

> +		clock-frequency = <8333333>;

Really? Can't firmware be fixed, and/or the property overridden for
boards that are known to ship with a broken firmware?

> +		interrupt-parent = <&gic>;
> +		arm,no-tick-in-suspend;

/me very sad.

> +	};
> +
> +	peripherals at 0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x0 0x3e000000>;
> +
> +		bus at 30000000 { /* AIPS1 */
> +			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x30000000 0x30000000 0x400000>;
> +
> +			gpio1: gpio at 30200000 {
> +				compatible = "fsl,imx8mq-gpio", "fsl,imx35-gpio";
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
> +				compatible = "fsl,imx8mq-gpio", "fsl,imx35-gpio";
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
> +				compatible = "fsl,imx8mq-gpio", "fsl,imx35-gpio";
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
> +				compatible = "fsl,imx8mq-gpio", "fsl,imx35-gpio";
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
> +				compatible = "fsl,imx8mq-gpio", "fsl,imx35-gpio";
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
> +				compatible = "fsl,imx8mq-iomuxc";
> +				reg = <0x30330000 0x10000>;
> +			};
> +
> +			gpr: iomuxc-gpr at 30340000 {
> +				compatible = "fsl,imx8mq-iomuxc-gpr", "syscon";
> +				reg = <0x30340000 0x10000>;
> +			};
> +
> +			anatop: anatop at 30360000 {
> +				compatible = "fsl,imx8mq-anatop", "syscon";
> +				reg = <0x30360000 0x10000>;
> +				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			clk: clock-controller at 30380000 {
> +				compatible = "fsl,imx8mq-ccm";
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
> +		bus at 30400000 { /* AIPS2 */
> +			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x30400000 0x30400000 0x400000>;
> +		};
> +
> +		bus at 30800000 { /* AIPS3 */
> +			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x30800000 0x30800000 0x400000>;
> +
> +			uart1: serial at 30860000 {
> +				compatible = "fsl,imx8mq-uart",
> +				             "fsl,imx6q-uart";
> +				reg = <0x30860000 0x10000>;
> +				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_UART1_ROOT>,
> +				         <&clk IMX8MQ_CLK_UART1_ROOT>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			uart3: serial at 30880000 {
> +				compatible = "fsl,imx8mq-uart",
> +				             "fsl,imx6q-uart";
> +				reg = <0x30880000 0x10000>;
> +				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_UART3_ROOT>,
> +				         <&clk IMX8MQ_CLK_UART3_ROOT>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			uart2: serial at 30890000 {
> +				compatible = "fsl,imx8mq-uart",
> +				             "fsl,imx6q-uart";
> +				reg = <0x30890000 0x10000>;
> +				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_UART2_ROOT>,
> +				         <&clk IMX8MQ_CLK_UART2_ROOT>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c at 30a20000 {
> +				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a20000 0x10000>;
> +				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_I2C1_ROOT>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c at 30a30000 {
> +				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a30000 0x10000>;
> +				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_I2C2_ROOT>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c at 30a40000 {
> +				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a40000 0x10000>;
> +				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_I2C3_ROOT>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c4: i2c at 30a50000 {
> +				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
> +				reg = <0x30a50000 0x10000>;
> +				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_I2C4_ROOT>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			uart4: serial at 30a60000 {
> +				compatible = "fsl,imx8mq-uart",
> +				             "fsl,imx6q-uart";
> +				reg = <0x30a60000 0x10000>;
> +				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_UART4_ROOT>,
> +				         <&clk IMX8MQ_CLK_UART4_ROOT>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			usdhc1: usdhc at 30b40000 {
> +				compatible = "fsl,imx8mq-usdhc",
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
> +				compatible = "fsl,imx8mq-usdhc",
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
> +				compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
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

You are missing the memory-mapped version of the CPU interface (GICC,
GICH, GICV), which Cortex-A53 implements (see [1] for details).

> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-parent = <&gic>;
> +		};
> +	};
> +};
> 

Thanks,

	M.

[1]
http://arminfo.emea.arm.com/help/topic/com.arm.doc.ddi0500g/ch09s02s01.html
-- 
Jazz is not dead. It just smells funny...
