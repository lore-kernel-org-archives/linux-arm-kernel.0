From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Sep 2014 13:49:55 +0800
Subject: [PATCHv4 1/6] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <1411371952-5618-2-git-send-email-jingchang.lu@freescale.com>
References: <1411371952-5618-1-git-send-email-jingchang.lu@freescale.com>
 <1411371952-5618-2-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20140926054939.GC31948@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 03:45:47PM +0800, Jingchang Lu wrote:
> From: Jingchang Lu <b35083@freescale.com>
> 
> Add Freescale LS1021A SoC device tree support
> 
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> Signed-off-by: Suresh Gupta <suresh.gupta@freescale.com>
> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> Signed-off-by: Ruchika Gupta <ruchika.gupta@freescale.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Chao Fu <b44548@freescale.com>
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 539 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 539 insertions(+)
>  create mode 100644 arch/arm/boot/dts/ls1021a.dtsi
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> new file mode 100644
> index 0000000..b498838
> --- /dev/null
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -0,0 +1,539 @@
> +/*
> + * Copyright 2013-2014 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include "skeleton64.dtsi"
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "fsl,ls1021a";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;

These two are already in skeleton64.dtsi.

> +
> +	aliases {
> +		serial0 = &lpuart0;
> +		serial1 = &lpuart1;
> +		serial2 = &lpuart2;
> +		serial3 = &lpuart3;
> +		serial4 = &lpuart4;
> +		serial5 = &lpuart5;
> +		ethernet0 = &enet0;
> +		ethernet1 = &enet1;
> +		ethernet2 = &enet2;
> +		sysclk = &sysclk;

Sort these aliases alphabetically.

> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at f00 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0xf00>;
> +		};
> +
> +		cpu at f01 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0xf01>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = 	<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,

For consistency, please use space than tab after "=".

> +				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		gic: interrupt-controller at 1400000 {
> +			compatible = "arm,cortex-a7-gic";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x0 0x1401000 0x0 0x1000>,
> +				<0x0 0x1402000 0x0 0x1000>,
> +				<0x0 0x1404000 0x0 0x2000>,
> +				<0x0 0x1406000 0x0 0x2000>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +
> +		};
> +
> +		ifc: ifc at 1530000 {
> +			compatible = "fsl,ifc", "simple-bus";
> +			reg = <0x0 0x1530000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		dcfg: dcfg at 1ee0000 {
> +			compatible = "fsl,ls1021a-dcfg", "syscon";
> +			reg = <0x0 0x1ee0000 0x0 0x10000>;
> +			big-endian;
> +		};
> +
> +		esdhc: esdhc at 1560000 {
> +			compatible = "fsl,esdhc";
> +			reg = <0x0 0x1560000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <0>;
> +			voltage-ranges = <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			big-endian;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		scfg: scfg at 1570000 {
> +			compatible = "fsl,ls1021a-scfg", "syscon";
> +			reg = <0x0 0x1570000 0x0 0x10000>;
> +		};
> +
> +		crypto: crypto at 1700000 {
> +			compatible = "fsl,sec-v5.3", "fsl,sec-v5.0", "fsl,sec-v4.0";

Is it really necessary to have the compatible string so long with so
many version history.  In the end, device driver only needs one to bind
the device.

> +			fsl,sec-era = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg		 = <0x0 0x1700000 0x0 0x100000>;
> +			ranges		 = <0x0 0x0 0x1700000 0x100000>;
> +			interrupts	 = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			sec_jr0: jr at 10000 {
> +				compatible = "fsl,sec-v5.3-job-ring",
> +				     "fsl,sec-v5.0-job-ring",
> +				     "fsl,sec-v4.0-job-ring";

Ditto

> +				reg = <0x10000 0x10000>;
> +				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			sec_jr1: jr at 20000 {

Is "jr" the name of the device name given by hardware manual?

> +				compatible = "fsl,sec-v5.3-job-ring",
> +				     "fsl,sec-v5.0-job-ring",
> +				     "fsl,sec-v4.0-job-ring";
> +				reg = <0x20000 0x10000>;
> +				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			sec_jr2: jr at 30000 {
> +				compatible = "fsl,sec-v5.3-job-ring",
> +				     "fsl,sec-v5.0-job-ring",
> +				     "fsl,sec-v4.0-job-ring";
> +				reg = <0x30000 0x10000>;
> +				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			sec_jr3: jr at 40000 {
> +				compatible = "fsl,sec-v5.3-job-ring",
> +				     "fsl,sec-v5.0-job-ring",
> +				     "fsl,sec-v4.0-job-ring";
> +				reg = <0x40000 0x10000>;
> +				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +		};
> +
> +		clockgen: clocking at 1ee1000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x1ee1000 0x10000>;
> +
> +			sysclk: sysclk {
> +				compatible = "fixed-clock";
> +				#clock-cells = <0>;
> +				clock-output-names = "sysclk";
> +			};
> +
> +			cga_pll1: pll1 at 800 {

The node name should just be "pll".

> +				compatible = "fsl,qoriq-core-pll-2.0";
> +				#clock-cells = <1>;
> +				reg = <0x800 0x10>;
> +				clocks = <&sysclk>;
> +				clock-output-names = "cga-pll1", "cga-pll1-div2",
> +						"cga-pll1-div3", "cga-pll1-div4";
> +			};
> +
> +			platform_clk: pll at c00 {
> +				compatible = "fsl,qoriq-core-pll-2.0";
> +				#clock-cells = <1>;
> +				reg = <0xc00 0x10>;
> +				clocks = <&sysclk>;
> +				clock-output-names = "platform-clk", "platform-clk-div2";
> +			};
> +
> +			cluster1_clk: clk0c0 at 0 {
> +				compatible = "fsl,qoriq-core-mux-2.0";
> +				#clock-cells = <0>;
> +				reg = <0x0 0x10>;
> +				clock-names = "pll1cga", "pll1cga-div2";
> +				clocks = <&cga_pll1 0>, <&cga_pll1 2>;
> +				clock-output-names = "cluster1-clk";
> +			};
> +		};
> +
> +		dspi0: dspi at 2100000 {
> +			compatible = "fsl,vf610-dspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2100000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "dspi";
> +			clocks = <&platform_clk 1>;
> +			spi-num-chipselects = <5>;
> +			big-endian;
> +			status = "disabled";
> +		};
> +
> +		dspi1: dspi at 2110000 {
> +			compatible = "fsl,vf610-dspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2110000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "dspi";
> +			clocks = <&platform_clk 1>;
> +			spi-num-chipselects = <5>;
> +			big-endian;
> +			status = "disabled";
> +		};
> +
> +		i2c0: i2c at 2180000 {
> +			compatible = "fsl,vf610-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2180000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "i2c";
> +			clocks = <&platform_clk 1>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c at 2190000 {
> +			compatible = "fsl,vf610-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2190000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "i2c";
> +			clocks = <&platform_clk 1>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c at 21a0000 {
> +			compatible = "fsl,vf610-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x21a0000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "i2c";
> +			clocks = <&platform_clk 1>;
> +			status = "disabled";
> +		};
> +
> +		uart0: serial at 21c0500 {
> +			compatible = "fsl,16550-FIFO64", "ns16550a";

We generally use lowercase only for compatible string.

> +			reg = <0x0 0x21c0500 0x0 0x100>;
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <0>;
> +			fifo-size = <15>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial at 21c0600 {
> +			compatible = "fsl,16550-FIFO64", "ns16550a";
> +			reg = <0x0 0x21c0600 0x0 0x100>;
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <0>;
> +			fifo-size = <15>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial at 21d0500 {
> +			compatible = "fsl,16550-FIFO64", "ns16550a";
> +			reg = <0x0 0x21d0500 0x0 0x100>;
> +			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <0>;
> +			fifo-size = <15>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial at 21d0600 {
> +			compatible = "fsl,16550-FIFO64", "ns16550a";
> +			reg = <0x0 0x21d0600 0x0 0x100>;
> +			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <0>;
> +			fifo-size = <15>;
> +			status = "disabled";
> +		};
> +
> +		lpuart0: serial at 2950000 {
> +			compatible = "fsl,ls1021a-lpuart";
> +			reg = <0x0 0x2950000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysclk>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		lpuart1: serial at 2960000 {
> +			compatible = "fsl,ls1021a-lpuart";
> +			reg = <0x0 0x2960000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 1>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		lpuart2: serial at 2970000 {
> +			compatible = "fsl,ls1021a-lpuart";
> +			reg = <0x0 0x2970000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 1>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		lpuart3: serial at 2980000 {
> +			compatible = "fsl,ls1021a-lpuart";
> +			reg = <0x0 0x2980000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 1>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		lpuart4: serial at 2990000 {
> +			compatible = "fsl,ls1021a-lpuart";
> +			reg = <0x0 0x2990000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 1>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		lpuart5: serial at 29a0000 {
> +			compatible = "fsl,ls1021a-lpuart";
> +			reg = <0x0 0x29a0000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 1>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		ftm0_1: ftm0_1 at 29d0000 {

ftm0_1?  It doesn't sounds like a good name for a timer device node.

> +			compatible = "fsl,ftm-timer";
> +			reg = <0x0 0x29d0000 0x0 0x10000>,
> +				<0x0 0x29e0000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "ftm-evt", "ftm-src",
> +			        "ftm-evt-counter-en", "ftm-src-counter-en";
> +			clocks = <&platform_clk 1>, <&platform_clk 1>,
> +			       <&platform_clk 1>, <&platform_clk 1>;
> +			big-endian;
> +			status = "disabled";
> +		};
> +
> +		pwm3: ftm at 2a00000 {

"ftm" doesn't sounds like a good name for a pwm device node.

> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2a00000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				"ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&platform_clk 1>, <&platform_clk 1>,
> +				<&platform_clk 1>, <&platform_clk 1>;
> +			big-endian;
> +			status = "disabled";
> +		};
> +
> +		pwm6: ftm at 2a30000 {
> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2a30000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				"ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&platform_clk 1>, <&platform_clk 1>,
> +				<&platform_clk 1>, <&platform_clk 1>;
> +			big-endian;
> +			status = "disabled";
> +		};
> +
> +		pwm7: ftm at 2a40000 {
> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2a40000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				"ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&platform_clk 1>, <&platform_clk 1>,
> +				<&platform_clk 1>, <&platform_clk 1>;
> +			big-endian;
> +			status = "disabled";
> +		};
> +
> +		wdog0: wdog at 2ad0000 {

Use "watchdog" to name the node.

> +			compatible = "fsl,imx21-wdt";
> +			reg = <0x0 0x2ad0000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 1>;
> +			clock-names = "wdog";

The property is to describe the clock from wdog inside point of view,
not from outside, so "wdog" isn't a good description.

> +			big-endian;
> +		};
> +
> +		sai1: sai at 2b50000 {
> +			compatible = "fsl,vf610-sai";
> +			reg = <0x0 0x2b50000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 1>;
> +			clock-names = "sai";
> +			dma-names = "tx", "rx";
> +			dmas = <&edma0 1 47>,
> +				<&edma0 1 46>;
> +			big-endian-regs;

Is it a valid property for SAI device?  At least I cannot find in
Documentation/devicetree/bindings.

> +			status = "disabled";
> +		};
> +
> +		sai2: sai at 2b60000 {
> +			compatible = "fsl,vf610-sai";
> +			reg = <0x0 0x2b60000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 1>;
> +			clock-names = "sai";
> +			dma-names = "tx", "rx";
> +			dmas = <&edma0 1 45>,
> +				<&edma0 1 44>;
> +			big-endian-regs;
> +			status = "disabled";
> +		};
> +
> +		edma0: edma at 2c00000 {
> +			#dma-cells = <2>;
> +			compatible = "fsl,vf610-edma";
> +			reg = <0x0 0x2c00000 0x0 0x10000>,
> +				<0x0 0x2c10000 0x0 0x10000>,
> +				<0x0 0x2c20000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "edma-tx", "edma-err";
> +			dma-channels = <32>;
> +			big-endian;
> +			clock-names = "dmamux0", "dmamux1";
> +			clocks = <&platform_clk 1>,
> +				<&platform_clk 1>;
> +		};
> +
> +		mdio0: mdio at 2d24000 {
> +			compatible = "gianfar";
> +			device_type = "mdio";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2d24000 0x0 0x4000>;
> +		};
> +
> +		enet0: ethernet at 2d10000 {
> +			compatible = "fsl,etsec2";
> +			device_type = "network";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-parent = <&gic>;
> +			model = "eTSEC";
> +			fsl,dma-endian-le;
> +			fsl,num_rx_queues = <0x1>;
> +			fsl,num_tx_queues = <0x1>;
> +			ranges;
> +
> +			queue-group at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = <0x0 0x2d10000 0x0 0x8000>;
> +				fsl,rx-bit-map = <0xff>;
> +				fsl,tx-bit-map = <0xff>;
> +				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};

Are the device tree bindings for this ethernet device accepted?  I
cannot find anything about it on even linux-next.

Shawn

> +
> +		enet1: ethernet at 2d50000 {
> +			compatible = "fsl,etsec2";
> +			device_type = "network";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-parent = <&gic>;
> +			model = "eTSEC";
> +			fsl,dma-endian-le;
> +			fsl,num_rx_queues = <0x1>;
> +			fsl,num_tx_queues = <0x1>;
> +			ranges;
> +
> +			queue-group at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = <0x0 0x2d50000 0x0 0x8000>;
> +				fsl,rx-bit-map = <0xff>;
> +				fsl,tx-bit-map = <0xff>;
> +				interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		enet2: ethernet at 2d90000 {
> +			compatible = "fsl,etsec2";
> +			device_type = "network";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-parent = <&gic>;
> +			model = "eTSEC";
> +			fsl,dma-endian-le;
> +			fsl,num_rx_queues = <0x1>;
> +			fsl,num_tx_queues = <0x1>;
> +			ranges;
> +
> +			queue-group at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = <0x0 0x2d90000 0x0 0x8000>;
> +				fsl,rx-bit-map = <0xff>;
> +				fsl,tx-bit-map = <0xff>;
> +				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		usb at 8600000 {
> +			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
> +			reg = <0x0 0x8600000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
> +			dr_mode = "host";
> +			phy_type = "ulpi";
> +		};
> +
> +		usb3 at 3100000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0x3100000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
> +			dr_mode = "host";
> +		};
> +	};
> +};
> -- 
> 1.8.0
> 
