From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Wed, 2 Jul 2014 17:02:48 +0800
Subject: [PATCH 1/5] ARM: dts: Add SoC level device tree support for LS1021A
In-Reply-To: <1404291772-2644-1-git-send-email-jingchang.lu@freescale.com>
References: <1404291772-2644-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <1404291772-2644-2-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jingchang Lu <b35083@freescale.com>

Add Freescale LS1021A SoC device tree support

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
Signed-off-by: Suresh Gupta <suresh.gupta@freescale.com>
Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
Signed-off-by: Adrian Sendroiu <adrian.sendroiu@freescale.com>
Signed-off-by: Ruchika Gupta <ruchika.gupta@freescale.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Chao Fu <b44548@freescale.com>
Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 852 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 852 insertions(+)
 create mode 100644 arch/arm/boot/dts/ls1021a.dtsi

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
new file mode 100644
index 0000000..b06b320
--- /dev/null
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -0,0 +1,852 @@
+/*
+ * Copyright 2013-2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include "skeleton64.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "fsl,ls1021a";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &lpuart0;
+		serial1 = &lpuart1;
+		serial2 = &lpuart2;
+		serial3 = &lpuart3;
+		serial4 = &lpuart4;
+		serial5 = &lpuart5;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+	};
+
+	memory {
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <0xf00>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <0xf01>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = 	<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		gic: interrupt-controller at 1400000 {
+			compatible = "arm,cortex-a15-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x0 0x1401000 0x0 0x1000>,
+				<0x0 0x1402000 0x0 0x1000>,
+				<0x0 0x1404000 0x0 0x2000>,
+				<0x0 0x1406000 0x0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+
+		};
+
+		tzasc: tzasc at 1500000 {
+			reg = <0x0 0x1500000 0x0 0x10000>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		ifc: ifc at 1530000 {
+			compatible = "fsl,ls1021a-ifc", "fsl,ifc", "simple-bus";
+			reg = <0x0 0x1530000 0x0 0x10000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		dcfg: dcfg at 1ee0000 {
+			compatible = "fsl,ls1021a-dcfg";
+			reg = <0x0 0x1ee0000 0x0 0x10000>;
+		};
+
+		qspi: quadspi at 1550000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,vf610-qspi";
+			reg = <0x0 0x1550000 0x0 0x10000>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "qspi_en", "qspi";
+			clocks = <&platform_clk 1>, <&platform_clk 1>;
+			big-endian;
+			amba-base = <0x40000000>;
+			status = "disabled";
+		};
+
+		esdhc: esdhc at 1560000 {
+			compatible = "fsl,ls1021a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x1560000 0x0 0x10000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <0>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			big-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		scfg: scfg at 1570000 {
+			compatible = "fsl,ls1021a-scfg";
+			reg = <0x0 0x1570000 0x0 0x10000>;
+		};
+
+		crypto: crypto at 1700000 {
+			compatible = "fsl,sec-v5.3", "fsl,sec-v5.0", "fsl,sec-v4.0";
+			fsl,sec-era = <4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg		 = <0x0 0x1700000 0x0 0x100000>;
+			ranges		 = <0x0 0x0 0x1700000 0x100000>;
+			interrupts	 = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+
+			sec_jr0: jr at 10000 {
+				compatible = "fsl,sec-v5.3-job-ring",
+				     "fsl,sec-v5.0-job-ring",
+				     "fsl,sec-v4.0-job-ring";
+				reg = <0x10000 0x10000>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr1: jr at 20000 {
+				compatible = "fsl,sec-v5.3-job-ring",
+				     "fsl,sec-v5.0-job-ring",
+				     "fsl,sec-v4.0-job-ring";
+				reg = <0x20000 0x10000>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr2: jr at 30000 {
+				compatible = "fsl,sec-v5.3-job-ring",
+				     "fsl,sec-v5.0-job-ring",
+				     "fsl,sec-v4.0-job-ring";
+				reg = <0x30000 0x10000>;
+				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr3: jr at 40000 {
+				compatible = "fsl,sec-v5.3-job-ring",
+				     "fsl,sec-v5.0-job-ring",
+				     "fsl,sec-v4.0-job-ring";
+				reg = <0x40000 0x10000>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+		};
+
+		clockgen: clocking at 1ee1000 {
+			compatible = "fsl,ls1021a-clockgen";
+			reg = <0x0 0x1ee1000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x1ee1000 0x10000>;
+			sysclk: sysclk {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <100000000>;
+				clock-output-names = "sysclk";
+			};
+
+			cga_pll1: pll1 at 800 {
+				compatible = "fsl,qoriq-core-pll-2.0";
+				#clock-cells = <1>;
+				reg = <0x800 0x10>;
+				clocks = <&sysclk>;
+				clock-output-names = "cga-pll1", "cga-pll1-div2",
+						"cga-pll1-div3", "cga-pll1-div4";
+			};
+
+			cga_pll2: pll2 at 820 {
+				compatible = "fsl,qoriq-core-pll-2.0";
+				#clock-cells = <1>;
+				reg = <0x820 0x10>;
+				clocks = <&sysclk>;
+				clock-output-names = "cga-pll2", "cga-pll2-div2",
+						"cga-pll2-div3", "cga-pll2-div4";
+			};
+
+			platform_clk: pll at c00 {
+				compatible = "fsl,qoriq-core-pll-2.0";
+				#clock-cells = <1>;
+				reg = <0xc00 0x10>;
+				clocks = <&sysclk>;
+				clock-output-names = "platform-clk", "platform-clk-div2";
+			};
+
+
+			cluster1_clk: clk0c0 at 0 {
+				compatible = "fsl,qoriq-core-mux-2.0";
+				#clock-cells = <1>;
+				reg = <0x0 0x10>;
+				clock-names = "pll1cga", "pll1cga-div2";
+				clocks = <&cga_pll1 0>, <&cga_pll1 2>;
+				clock-output-names = "cluster1-clk";
+
+			};
+
+		};
+
+		rcpm: rcpm at 1ee2000 {
+			compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1";
+			reg = <0x0 0x1ee2000 0x0 0x10000>;
+		};
+
+		dspi0: dspi at 2100000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,vf610-dspi";
+			reg = <0x0 0x2100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "dspi";
+			clocks = <&platform_clk 1>;
+			spi-num-chipselects = <5>;
+			big-endian;
+			status = "disabled";
+		};
+
+		dspi1: dspi at 2110000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,vf610-dspi";
+			reg = <0x0 0x2110000 0x0 0x10000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "dspi";
+			clocks = <&platform_clk 1>;
+			spi-num-chipselects = <5>;
+			big-endian;
+			status = "disabled";
+		};
+
+		i2c0: i2c at 2180000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,vf610-i2c";
+			reg = <0x0 0x2180000 0x0 0x10000>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&platform_clk 1>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 2190000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,vf610-i2c";
+			reg = <0x0 0x2190000 0x0 0x10000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&platform_clk 1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at 21a0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,vf610-i2c";
+			reg = <0x0 0x21a0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&platform_clk 1>;
+			status = "disabled";
+		};
+
+		duart0: serial at 21c0500 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x0 0x21c0500 0x0 0x100>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <0>;
+			fifo-size = <8>;
+			status = "disabled";
+		};
+
+		duart1: serial at 21c0600 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x0 0x21c0600 0x0 0x100>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <0>;
+			fifo-size = <8>;
+			status = "disabled";
+		};
+
+		duart2: serial at 21d0500 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x0 0x21d0500 0x0 0x100>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <0>;
+			fifo-size = <8>;
+			status = "disabled";
+		};
+
+		duart3: serial at 21d0600 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x0 0x21d0600 0x0 0x100>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <0>;
+			fifo-size = <8>;
+			status = "disabled";
+		};
+
+		gpio1: gpio at 2300000 {
+			compatible = "fsl,ls1021a-gpio";
+			reg = <0x0 0x2300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio2: gpio at 2310000 {
+			compatible = "fsl,ls1021a-gpio";
+			reg = <0x0 0x2310000 0x0 0x10000>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio3: gpio at 2320000 {
+			compatible = "fsl,ls1021a-gpio";
+			reg = <0x0 0x2320000 0x0 0x10000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio4: gpio at 2330000 {
+			compatible = "fsl,ls1021a-gpio";
+			reg = <0x0 0x2330000 0x0 0x10000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		uqe: uqe at 2400000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "qe";
+			compatible = "fsl,qe";
+			fsl,qe-num-riscs = <1>;
+			fsl,qe-num-snums = <28>;
+
+			qeic: qeic at 80 {
+				compatible = "fsl,qe-ic";
+				reg = <0x80 0x80>;
+				#address-cells = <0>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+						< GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			ucc at 2000 {
+				cell-index = <1>;
+				reg = <0x2000 0x200>;
+				interrupts = <32>;
+				interrupt-parent = <&qeic>;
+			};
+
+			ucc at 2200 {
+				cell-index = <3>;
+				reg = <0x2200 0x200>;
+				interrupts = <34>;
+				interrupt-parent = <&qeic>;
+			};
+
+			muram at 10000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,qe-muram", "fsl,cpm-muram";
+				ranges = <0x0 0x10000 0x6000>;
+
+				data-only at 0 {
+					compatible = "fsl,qe-muram-data",
+					"fsl,cpm-muram-data";
+					reg = <0x0 0x6000>;
+				};
+			};
+		};
+
+		lpuart0: serial at 2950000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2950000 0x0 0x1000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart1: serial at 2960000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2960000 0x0 0x1000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart2: serial at 2970000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2970000 0x0 0x1000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart3: serial at 2980000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2980000 0x0 0x1000>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart4: serial at 2990000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2990000 0x0 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart5: serial at 29a0000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x29a0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		ftm0_1: ftm0_1 at 29d0000 {
+			compatible = "fsl,ftm-timer";
+			reg = <0x0 0x29d0000 0x0 0x10000>,
+				<0x0 0x29e0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "ftm-evt", "ftm-src",
+			        "ftm-evt-counter-en", "ftm-src-counter-en";
+			clocks = <&platform_clk 1>, <&platform_clk 1>,
+			       <&platform_clk 1>, <&platform_clk 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		ftm2: ftm at 29f0000 {
+			reg = <0x0 0x29f0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		pwm3: ftm at 2a00000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a00000 0x0 0x10000>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&platform_clk 1>, <&platform_clk 1>,
+				<&platform_clk 1>, <&platform_clk 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		ftm4: ftm at 2a10000 {
+			reg = <0x0 0x2a10000 0x0 0x10000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		ftm5: ftm at 2a20000 {
+			reg = <0x0 0x2a20000 0x0 0x10000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		pwm6: ftm at 2a30000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a30000 0x0 0x10000>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&platform_clk 1>, <&platform_clk 1>,
+				<&platform_clk 1>, <&platform_clk 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm7: ftm at 2a40000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a40000 0x0 0x10000>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&platform_clk 1>, <&platform_clk 1>,
+				<&platform_clk 1>, <&platform_clk 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		wdog0: wdog at 2ad0000 {
+			compatible = "fsl,ls1021a-wdt", "fsl,imx21-wdt";
+			reg = <0x0 0x2ad0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "wdog";
+			big-endian;
+		};
+
+		sai2: sai at 2b60000 {
+			compatible = "fsl,vf610-sai";
+			reg = <0x0 0x2b60000 0x0 0x10000>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "sai";
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 45>,
+				<&edma0 1 44>;
+			big-endian-regs;
+			status = "disabled";
+		};
+
+		edma0: edma at 2c00000 {
+			#dma-cells = <2>;
+			compatible = "fsl,vf610-edma";
+			reg = <0x0 0x2c00000 0x0 0x10000>,
+				<0x0 0x2c10000 0x0 0x10000>,
+				<0x0 0x2c20000 0x0 0x10000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma-tx", "edma-err";
+			dma-channels = <32>;
+			big-endian;
+			clock-names = "dmamux0", "dmamux1";
+			clocks = <&platform_clk 1>,
+				<&platform_clk 1>;
+		};
+
+		dcu0: dcu at 2ce0000 {
+			compatible = "fsl,vf610-dcu";
+			reg = <0x0 0x2ce000 0x0 0x10000>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "dcu";
+			big-endian;
+			status = "disabled";
+		};
+
+		mdio0: mdio at 2d24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <0x0 0x2d24000 0x0 0x4000>;
+			tbi0: tbi-phy at 8 {
+				reg = <0x8>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		enet0: ethernet at 2d10000 {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,dma-endian-le;
+			fsl,num_rx_queues = <0x1>;
+			fsl,num_tx_queues = <0x1>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			ranges;
+
+			queue-group at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x0 0x2d10000 0x0 0x8000>;
+				fsl,rx-bit-map = <0xff>;
+				fsl,tx-bit-map = <0xff>;
+				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+		};
+
+		enet1: ethernet at 2d50000 {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,dma-endian-le;
+			fsl,num_rx_queues = <0x1>;
+			fsl,num_tx_queues = <0x1>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			ranges;
+
+			queue-group at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x0 0x2d50000 0x0 0x8000>;
+				fsl,rx-bit-map = <0xff>;
+				fsl,tx-bit-map = <0xff>;
+				interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+		};
+
+		enet2: ethernet at 2d90000 {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,dma-endian-le;
+			fsl,num_rx_queues = <0x1>;
+			fsl,num_tx_queues = <0x1>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			ranges;
+
+			queue-group at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x0 0x2d90000 0x0 0x8000>;
+				fsl,rx-bit-map = <0xff>;
+				fsl,tx-bit-map = <0xff>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		usb at 8600000 {
+			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
+			reg = <0x0 0x8600000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			phy_type = "ulpi";
+		};
+
+		usb at 3100000 {
+			compatible = "fsl,fsl-dwc3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			dwc3 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3100000 0x0 0x10000>;
+				interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				maximum-speed = "high-speed";
+			};
+		};
+
+		can0: can at 2a70000 {
+			compatible = "fsl,ls1021a-flexcan";
+			reg = <0x0 0x2a70000 0x0 0x1000>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "per";
+			status = "disabled";
+		};
+
+		can1: can at 2a80000 {
+			compatible = "fsl,ls1021a-flexcan";
+			reg = <0x0 0x2a80000 0x0 0x1000>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "per";
+			status = "disabled";
+		};
+
+		can2: can at 2a90000 {
+			compatible = "fsl,ls1021a-flexcan";
+			reg = <0x0 0x2a90000 0x0 0x1000>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "per";
+			status = "disabled";
+		};
+
+		can3: can at 2aa0000 {
+			compatible = "fsl,ls1021a-flexcan";
+			reg = <0x0 0x2aa0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-names = "per";
+			status = "disabled";
+		};
+	};
+
+	dcsr at 20000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,ls1021a-dcsr", "simple-bus";
+
+		ranges = <0x0 0x0 0x20000000 0x1000000>;
+
+		dcsr-epu at 0 {
+			compatible = "fsl,ls1021a-dcsr-epu";
+			reg = <0x0 0x10000>;
+		};
+
+		dcsr-gdi at 100000 {
+			compatible = "fsl,ls1021a-dcsr-gdi";
+			reg = <0x100000 0x10000>;
+		};
+
+		dcsr-dddi at 120000 {
+			compatible = "fsl,ls1021a-dcsr-dddi";
+			reg = <0x120000 0x10000>;
+		};
+
+		dcsr-dcfg at 220000 {
+			compatible = "fsl,ls1021a-dcsr-dcfg";
+			reg = <0x220000 0x1000>;
+		};
+
+		dcsr-clock at 221000 {
+			compatible = "fsl,ls1021a-dcsr-clock";
+			reg = <0x221000 0x1000>;
+		};
+
+		dcsr-rcpm at 222000 {
+			compatible = "fsl,ls1021a-dcsr-rcpm";
+			reg = <0x222000 0x1000 0x223000 0x1000>;
+		};
+
+		dcsr-ccp at 225000 {
+			compatible = "fsl,ls1021a-dcsr-ccp";
+			reg = <0x225000 0x1000>;
+		};
+
+		dcsr-fusectrl at 226000 {
+			compatible = "fsl,ls1021a-dcsr-fusectrl";
+			reg = <0x226000 0x1000>;
+		};
+
+		dcsr-dap at 300000 {
+			compatible = "fsl,ls1021a-dcsr-dap";
+			reg = <0x300000 0x10000>;
+		};
+
+		dcsr-cstf at 350000 {
+			compatible = "fsl,ls1021a-dcsr-cstf";
+			reg = <0x350000 0x1000 0x3a7000 0x1000>;
+		};
+
+		dcsr-a7rom at 360000 {
+			compatible = "fsl,ls1021a-dcsr-a7rom";
+			reg = <0x360000 0x10000>;
+		};
+
+		dcsr-a7cpu at 370000 {
+			compatible = "fsl,ls1021a-dcsr-a7cpu";
+			reg = <0x370000 0x8000>;
+		};
+
+		dcsr-a7cti at 378000 {
+			compatible = "fsl,ls1021a-dcsr-a7cti";
+			reg = <0x378000 0x4000>;
+		};
+
+		dcsr-etm at 37c000 {
+			compatible = "fsl,ls1021a-dcsr-etm";
+			reg = <0x37c000 0x1000 0x37d000 0x3000>;
+		};
+
+		dcsr-hugorom at 3a0000 {
+			compatible = "fsl,ls1021a-dcsr-hugorom";
+			reg = <0x3a0000 0x1000>;
+		};
+
+		dcsr-etf at 3a1000 {
+			compatible = "fsl,ls1021a-dcsr-etf";
+			reg = <0x3a1000 0x1000 0x3a2000 0x1000>;
+		};
+
+		dcsr-etr at 3a3000 {
+			compatible = "fsl,ls1021a-dcsr-etr";
+			reg = <0x3a3000 0x1000>;
+		};
+
+		dcsr-cti at 3a4000 {
+			compatible = "fsl,ls1021a-dcsr-cti";
+			reg = <0x3a4000 0x1000 0x3a5000 0x1000 0x3a6000 0x1000>;
+		};
+
+		dcsr-atbrepl at 3a8000 {
+			compatible = "fsl,ls1021a-dcsr-atbrepl";
+			reg = <0x3a8000 0x1000>;
+		};
+
+		dcsr-tsgen-ctrl at 3a9000 {
+			compatible = "fsl,ls1021a-dcsr-tsgen-ctrl";
+			reg = <0x3a9000 0x1000>;
+		};
+
+		dcsr-tsgen-read at 3aa000 {
+			compatible = "fsl,ls1021a-dcsr-tsgen-read";
+			reg = <0x3aa000 0x1000>;
+		};
+	};
+};
-- 
1.8.0
