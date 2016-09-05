From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Mon, 5 Sep 2016 18:01:31 +0800
Subject: [PATCH 3/7] [v2] arm64: dts: add QorIQ LS1046A SoC support
In-Reply-To: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
Message-ID: <1473069695-33092-4-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mingkai Hu <Mingkai.Hu@nxp.com>

LS1046A is an SoC with 4 ARMv8 A72 cores and most other IP blocks
are similar to LS1043A which also complies to Freescale Chassis 2.1
spec.

Created LS1046A SoC DTSI file to be included by board level DTS
files.

Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
Signed-off-by: Mihai Bantea <mihai.bantea@nxp.com>
Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
Signed-off-by: Gong Qianyu <Qianyu.Gong@nxp.com>
Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Mingkai Hu <Mingkai.Hu@nxp.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
---
Changes in V2:
1. addressed Arnd's comments.
   removed memory size property.
   refined devices' names.
   removed PCIe and MSI nodes.
2. updated interrupt properties with readable defines.
3. removed clock-names property from I2C and watchdog nodes.
4. added crypto nodes.
   binding of crypto nodes available at:
   http://patchwork.ozlabs.org/patch/663184/
5. added CPU idle-states node.
6. added ddr controller node.

 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 511 +++++++++++++++++++++++++
 1 file changed, 511 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
new file mode 100644
index 0000000..9697332
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -0,0 +1,511 @@
+/*
+ * Device Tree Include file for Freescale Layerscape-1046A family SoC.
+ *
+ * Copyright 2016, Freescale Semiconductor, Inc.
+ *
+ * Mingkai Hu <mingkai.hu@nxp.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPLv2 or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "fsl,ls1046a";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		crypto = &crypto;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x0>;
+			clocks = <&clockgen 1 0>;
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_PH20>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x1>;
+			clocks = <&clockgen 1 0>;
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_PH20>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x2>;
+			clocks = <&clockgen 1 0>;
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_PH20>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x3>;
+			clocks = <&clockgen 1 0>;
+			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_PH20>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	idle-states {
+		entry-method = "arm,psci";
+
+		CPU_PH20: cpu-ph20 {
+			compatible = "arm,idle-state";
+			idle-state-name = "PH20";
+			arm,psci-suspend-param = <0x00010000>;
+			entry-latency-us = <1000>;
+			exit-latency-us = <1000>;
+			min-residency-us = <3000>;
+		};
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+	};
+
+	sysclk: sysclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "sysclk";
+	};
+
+	reboot {
+		compatible ="syscon-reboot";
+		regmap = <&dcfg>;
+		offset = <0xb0>;
+		mask = <0x02>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_PPI 14 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_PPI 10 IRQ_TYPE_EDGE_RISING>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>,
+				     <&cpu2>,
+				     <&cpu3>;
+	};
+
+	gic: interrupt-controller at 1400000 {
+		compatible = "arm,gic-400";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x0 0x1410000 0 0x10000>, /* GICD */
+		      <0x0 0x1420000 0 0x20000>, /* GICC */
+		      <0x0 0x1440000 0 0x20000>, /* GICH */
+		      <0x0 0x1460000 0 0x20000>; /* GICV */
+		interrupts = <1 9 0xf08>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		clockgen: clocking at 1ee1000 {
+			compatible = "fsl,ls1046a-clockgen";
+			reg = <0x0 0x1ee1000 0x0 0x1000>;
+			#clock-cells = <2>;
+			clocks = <&sysclk>;
+		};
+
+		scfg: scfg at 1570000 {
+			compatible = "fsl,ls1046a-scfg", "syscon";
+			reg = <0x0 0x1570000 0x0 0x10000>;
+			big-endian;
+		};
+
+		dcfg: dcfg at 1ee0000 {
+			compatible = "fsl,ls1046a-dcfg", "syscon";
+			reg = <0x0 0x1ee0000 0x0 0x10000>;
+			big-endian;
+		};
+
+		rcpm: rcpm at 1ee2000 {
+			compatible = "fsl,ls1046a-rcpm", "fsl,qoriq-rcpm-2.1";
+			reg = <0x0 0x1ee2000 0x0 0x10000>;
+		};
+
+		ifc: ifc at 1530000 {
+			compatible = "fsl,ifc", "simple-bus";
+			reg = <0x0 0x1530000 0x0 0x10000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		esdhc: esdhc at 1560000 {
+			compatible = "fsl,esdhc";
+			reg = <0x0 0x1560000 0x0 0x10000>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <0>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			big-endian;
+			bus-width = <4>;
+		};
+
+		ddr: memory-controller at 1080000 {
+			compatible = "fsl,qoriq-memory-controller";
+			reg = <0x0 0x1080000 0x0 0x1000>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
+		};
+
+		crypto: crypto at 1700000 {
+			compatible = "fsl,sec-v5.4", "fsl,sec-v5.0",
+				     "fsl,sec-v4.0";
+			fsl,sec-era = <8>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x00 0x1700000 0x100000>;
+			reg = <0x00 0x1700000 0x0 0x100000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+
+			sec_jr0: jr at 10000 {
+				compatible = "fsl,sec-v5.4-job-ring",
+					     "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x10000 0x10000>;
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr1: jr at 20000 {
+				compatible = "fsl,sec-v5.4-job-ring",
+					     "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x20000 0x10000>;
+				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr2: jr at 30000 {
+				compatible = "fsl,sec-v5.4-job-ring",
+					     "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x30000 0x10000>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr3: jr at 40000 {
+				compatible = "fsl,sec-v5.4-job-ring",
+					     "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x40000 0x10000>;
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		dspi: dspi at 2100000 {
+			compatible = "fsl,ls1021a-v1.0-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "dspi";
+			clocks = <&clockgen 4 1>;
+			spi-num-chipselects = <5>;
+			big-endian;
+			status = "disabled";
+		};
+
+		qspi: quadspi at 1550000 {
+			compatible = "fsl,ls1021a-qspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x1550000 0x0 0x10000>,
+				<0x0 0x40000000 0x0 0x10000000>;
+			reg-names = "QuadSPI", "QuadSPI-memory";
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "qspi_en", "qspi";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			fsl,qspi-has-second-chip;
+			status = "disabled";
+		};
+
+		i2c0: i2c at 2180000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2180000 0x0 0x10000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			dmas = <&edma0 1 39>,
+			       <&edma0 1 38>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		i2c1: i2c at 2190000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2190000 0x0 0x10000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at 21a0000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x21a0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at 21b0000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x21b0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		duart0: serial at 21c0500 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x00 0x21c0500 0x0 0x100>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+		};
+
+		duart1: serial at 21c0600 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x00 0x21c0600 0x0 0x100>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+		};
+
+		duart2: serial at 21d0500 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x0 0x21d0500 0x0 0x100>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+		};
+
+		duart3: serial at 21d0600 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x0 0x21d0600 0x0 0x100>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+		};
+
+		gpio0: gpio at 2300000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio at 2310000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2310000 0x0 0x10000>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio2: gpio at 2320000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2320000 0x0 0x10000>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio3: gpio at 2330000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2330000 0x0 0x10000>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		lpuart0: serial at 2950000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2950000 0x0 0x1000>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 0>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart1: serial at 2960000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2960000 0x0 0x1000>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart2: serial at 2970000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2970000 0x0 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart3: serial at 2980000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2980000 0x0 0x1000>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart4: serial at 2990000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2990000 0x0 0x1000>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart5: serial at 29a0000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x29a0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		wdog0: watchdog at 2ad0000 {
+			compatible = "fsl,imx21-wdt";
+			reg = <0x0 0x2ad0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			big-endian;
+		};
+
+		edma0: edma at 2c00000 {
+			#dma-cells = <2>;
+			compatible = "fsl,vf610-edma";
+			reg = <0x0 0x2c00000 0x0 0x10000>,
+			      <0x0 0x2c10000 0x0 0x10000>,
+			      <0x0 0x2c20000 0x0 0x10000>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma-tx", "edma-err";
+			dma-channels = <32>;
+			big-endian;
+			clock-names = "dmamux0", "dmamux1";
+			clocks = <&clockgen 4 1>,
+				 <&clockgen 4 1>;
+		};
+
+		usb0: usb at 2f00000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x2f00000 0x0 0x10000>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+		};
+
+		usb1: usb at 3000000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3000000 0x0 0x10000>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+		};
+
+		usb2: usb at 3100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+		};
+
+		sata: sata at 3200000 {
+			compatible = "fsl,ls1046a-ahci";
+			reg = <0x0 0x3200000 0x0 0x10000>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+		};
+	};
+};
-- 
2.1.0.27.g96db324
