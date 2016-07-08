From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Fri, 8 Jul 2016 18:15:40 +0800
Subject: [PATCH 1/5] arm64: dts: add QorIQ LS1046A SoC support
In-Reply-To: <1467972944-12293-1-git-send-email-shh.xie@gmail.com>
References: <1467972944-12293-1-git-send-email-shh.xie@gmail.com>
Message-ID: <1467972944-12293-2-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mingkai Hu <Mingkai.Hu@nxp.com>

LS1046A is an SoC with 4 ARMv8 A72 cores and most other IP blocks
are similar to LS1043A which also complies to Freescale Chassis 2.1
spec.

Created LS1046A SoC DTSI file to be included by board level DTS
files.

Signed-off-by: Mihai Bantea <mihai.bantea@nxp.com>
Signed-off-by: Gong Qianyu <Qianyu.Gong@nxp.com>
Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Mingkai Hu <Mingkai.Hu@nxp.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 549 +++++++++++++++++++++++++
 1 file changed, 549 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
new file mode 100644
index 0000000..e28a686
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -0,0 +1,549 @@
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
+/ {
+	compatible = "fsl,ls1046a";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
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
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x1>;
+			clocks = <&clockgen 1 0>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x2>;
+			clocks = <&clockgen 1 0>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x3>;
+			clocks = <&clockgen 1 0>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>;
+		      /* DRAM space 1, size: 2GiB DRAM */
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
+		interrupts = <1 13 0x1>, /* Physical Secure PPI */
+			     <1 14 0x1>, /* Physical Non-Secure PPI */
+			     <1 11 0x1>, /* Virtual PPI */
+			     <1 10 0x1>; /* Hypervisor PPI */
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <0 106 0x4>,
+			     <0 107 0x4>,
+			     <0 95 0x4>,
+			     <0 97 0x4>;
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
+			interrupts = <0 43 0x4>;
+		};
+
+		esdhc: esdhc at 1560000 {
+			compatible = "fsl,ls1046a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x1560000 0x0 0x10000>;
+			interrupts = <0 62 0x4>;
+			clock-frequency = <0>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			big-endian;
+			bus-width = <4>;
+		};
+
+		dspi: dspi at 2100000 {
+			compatible = "fsl,ls1046a-dspi", "fsl,ls1021a-v1.0-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2100000 0x0 0x10000>;
+			interrupts = <0 64 0x4>;
+			clock-names = "dspi";
+			clocks = <&clockgen 4 1>;
+			spi-num-chipselects = <5>;
+			big-endian;
+			status = "disabled";
+		};
+
+		qspi: quadspi at 1550000 {
+			compatible = "fsl,ls1046a-qspi", "fsl,ls1021a-qspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x1550000 0x0 0x10000>,
+				<0x0 0x40000000 0x0 0x10000000>;
+			reg-names = "QuadSPI", "QuadSPI-memory";
+			interrupts = <0 99 0x4>;
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
+			interrupts = <0 56 0x4>;
+			clock-names = "i2c";
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
+			interrupts = <0 57 0x4>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at 21a0000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x21a0000 0x0 0x10000>;
+			interrupts = <0 58 0x4>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at 21b0000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x21b0000 0x0 0x10000>;
+			interrupts = <0 59 0x4>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 1>;
+			status = "disabled";
+		};
+
+		duart0: serial at 21c0500 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x00 0x21c0500 0x0 0x100>;
+			interrupts = <0 54 0x4>;
+			clocks = <&clockgen 4 1>;
+		};
+
+		duart1: serial at 21c0600 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x00 0x21c0600 0x0 0x100>;
+			interrupts = <0 54 0x4>;
+			clocks = <&clockgen 4 1>;
+		};
+
+		duart2: serial at 21d0500 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x0 0x21d0500 0x0 0x100>;
+			interrupts = <0 55 0x4>;
+			clocks = <&clockgen 4 1>;
+		};
+
+		duart3: serial at 21d0600 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x0 0x21d0600 0x0 0x100>;
+			interrupts = <0 55 0x4>;
+			clocks = <&clockgen 4 1>;
+		};
+
+		gpio0: gpio at 2300000 {
+			compatible = "fsl,ls1046a-gpio";
+			reg = <0x0 0x2300000 0x0 0x10000>;
+			interrupts = <0 66 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio at 2310000 {
+			compatible = "fsl,ls1046a-gpio";
+			reg = <0x0 0x2310000 0x0 0x10000>;
+			interrupts = <0 67 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio2: gpio at 2320000 {
+			compatible = "fsl,ls1046a-gpio";
+			reg = <0x0 0x2320000 0x0 0x10000>;
+			interrupts = <0 68 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio3: gpio at 2330000 {
+			compatible = "fsl,ls1046a-gpio";
+			reg = <0x0 0x2330000 0x0 0x10000>;
+			interrupts = <0 134 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		lpuart0: serial at 2950000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2950000 0x0 0x1000>;
+			interrupts = <0 48 0x4>;
+			clocks = <&clockgen 0 0>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart1: serial at 2960000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2960000 0x0 0x1000>;
+			interrupts = <0 49 0x4>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart2: serial at 2970000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2970000 0x0 0x1000>;
+			interrupts = <0 50 0x4>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart3: serial at 2980000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2980000 0x0 0x1000>;
+			interrupts = <0 51 0x4>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart4: serial at 2990000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x2990000 0x0 0x1000>;
+			interrupts = <0 52 0x4>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart5: serial at 29a0000 {
+			compatible = "fsl,ls1021a-lpuart";
+			reg = <0x0 0x29a0000 0x0 0x1000>;
+			interrupts = <0 53 0x4>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		wdog0: wdog at 2ad0000 {
+			compatible = "fsl,ls1046a-wdt", "fsl,imx21-wdt";
+			reg = <0x0 0x2ad0000 0x0 0x10000>;
+			interrupts = <0 83 0x4>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "wdog";
+			big-endian;
+		};
+
+		edma0: edma at 2c00000 {
+			#dma-cells = <2>;
+			compatible = "fsl,vf610-edma";
+			reg = <0x0 0x2c00000 0x0 0x10000>,
+			      <0x0 0x2c10000 0x0 0x10000>,
+			      <0x0 0x2c20000 0x0 0x10000>;
+			interrupts = <0 103 0x4>,
+				     <0 103 0x4>;
+			interrupt-names = "edma-tx", "edma-err";
+			dma-channels = <32>;
+			big-endian;
+			clock-names = "dmamux0", "dmamux1";
+			clocks = <&clockgen 4 1>,
+				 <&clockgen 4 1>;
+		};
+
+		usb0: usb3 at 2f00000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x2f00000 0x0 0x10000>;
+			interrupts = <0 60 0x4>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+		};
+
+		usb1: usb3 at 3000000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3000000 0x0 0x10000>;
+			interrupts = <0 61 0x4>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+		};
+
+		usb2: usb3 at 3100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3100000 0x0 0x10000>;
+			interrupts = <0 63 0x4>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+		};
+
+		sata: sata at 3200000 {
+			compatible = "fsl,ls1046a-ahci", "fsl,ls1021a-ahci";
+			reg = <0x0 0x3200000 0x0 0x10000>;
+			interrupts = <0 69 0x4>;
+			clocks = <&clockgen 4 1>;
+		};
+
+		msi: msi-controller at 1580000 {
+			compatible = "fsl,ls1046a-msi";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			msi-controller;
+			msi-bank at 1580000 {
+				reg = <0x0 0x1580000 0x0 0x10000>;
+				interrupts = <0 116 0x4>,
+					     <0 111 0x4>,
+					     <0 112 0x4>,
+					     <0 113 0x4>;
+
+			};
+
+			msi-bank at 1590000 {
+				reg = <0x0 0x1590000 0x0 0x10000>;
+				interrupts = <0 126 0x4>,
+					     <0 121 0x4>,
+					     <0 122 0x4>,
+					     <0 123 0x4>;
+			};
+
+			msi-bank at 15a0000 {
+				reg = <0x0 0x15a0000 0x0 0x10000>;
+				interrupts = <0 160 0x4>,
+					     <0 155 0x4>,
+					     <0 156 0x4>,
+					     <0 157 0x4>;
+			};
+		};
+
+		pcie at 3400000 {
+			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <0 118 0x4>, /* controller interrupt */
+				     <0 117 0x4>; /* PME interrupt */
+			interrupt-names = "intr", "pme";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			num-lanes = <4>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&msi>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 110 0x4>,
+					<0000 0 0 2 &gic 0 110 0x4>,
+					<0000 0 0 3 &gic 0 110 0x4>,
+					<0000 0 0 4 &gic 0 110 0x4>;
+		};
+
+		pcie at 3500000 {
+			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <0 128 0x4>,
+				     <0 127 0x4>;
+			interrupt-names = "intr", "pme";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			num-lanes = <2>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&msi>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 120 0x4>,
+					<0000 0 0 2 &gic 0 120 0x4>,
+					<0000 0 0 3 &gic 0 120 0x4>,
+					<0000 0 0 4 &gic 0 120 0x4>;
+		};
+
+		pcie at 3600000 {
+			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
+			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <0 162 0x4>,
+				     <0 161 0x4>;
+			interrupt-names = "intr", "pme";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			num-lanes = <2>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x50 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&msi>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 154 0x4>,
+					<0000 0 0 2 &gic 0 154 0x4>,
+					<0000 0 0 3 &gic 0 154 0x4>,
+					<0000 0 0 4 &gic 0 154 0x4>;
+		};
+	};
+};
-- 
2.1.0.27.g96db324
