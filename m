From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Jul 2016 16:35:55 +0200
Subject: [PATCH 1/2] arm64: dts: marvell: add description for the slave CP110
 in Armada 8K
In-Reply-To: <1469716556-15299-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1469716556-15299-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1469716556-15299-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 8K platforms (8020 and 8040) have two CP110 HW blocks: one
master, one slave. So far, only the master CP110 was described. This
commit adds the Device Tree description for the slave CP110, and hooks
it up in the DT description of the Armada 8020 and Armada 8040 SoCs.

The slave CP110 description is somewhat similar to the master CP110
description except for a number of things like register offsets,
interrupt numbers, references to clocks, etc.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   1 +
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 246 +++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi

diff --git a/arch/arm64/boot/dts/marvell/armada-8020.dtsi b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
index 3753c1c..048e5cf 100644
--- a/arch/arm64/boot/dts/marvell/armada-8020.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
@@ -47,6 +47,7 @@
 
 #include "armada-ap806-dual.dtsi"
 #include "armada-cp110-master.dtsi"
+#include "armada-cp110-slave.dtsi"
 
 / {
 	model = "Marvell Armada 8020";
diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
index 8bd0d8f..9c1b28c 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
@@ -47,6 +47,7 @@
 
 #include "armada-ap806-quad.dtsi"
 #include "armada-cp110-master.dtsi"
+#include "armada-cp110-slave.dtsi"
 
 / {
 	model = "Marvell Armada 8040";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
new file mode 100644
index 0000000..6ff1201
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -0,0 +1,246 @@
+/*
+ * Copyright (C) 2016 Marvell Technology Group Ltd.
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
+/*
+ * Device Tree file for Marvell Armada CP110 Slave.
+ */
+
+/ {
+	cp110-slave {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		config-space {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			interrupt-parent = <&gic>;
+			ranges = <0x0 0x0 0xf4000000 0x2000000>;
+
+			cps_syscon0: system-controller at 440000 {
+				compatible = "marvell,cp110-system-controller0",
+					     "syscon";
+				reg = <0x440000 0x1000>;
+				#clock-cells = <2>;
+				core-clock-output-names =
+					"cps-apll", "cps-ppv2-core", "cps-eip",
+					"cps-core", "cps-nand-core";
+				gate-clock-output-names =
+					"cps-audio", "cps-communit", "cps-nand",
+					"cps-ppv2", "cps-sdio", "cps-mg-domain",
+					"cps-mg-core", "cps-xor1", "cps-xor0",
+					"cps-gop-dp", "none", "cps-pcie_x10",
+					"cps-pcie_x11", "cps-pcie_x4", "cps-pcie-xor",
+					"cps-sata", "cps-sata-usb", "cps-main",
+					"cps-sd-mmc", "none", "none",
+					"cps-slow-io", "cps-usb3h0", "cps-usb3h1",
+					"cps-usb3dev", "cps-eip150", "cps-eip197";
+			};
+
+			cps_sata0: sata at 540000 {
+				compatible = "marvell,armada-8k-ahci";
+				reg = <0x540000 0x30000>;
+				interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cps_syscon0 1 15>;
+				status = "disabled";
+			};
+
+			cps_usb3_0: usb3 at 500000 {
+				compatible = "marvell,armada-8k-xhci",
+					     "generic-xhci";
+				reg = <0x500000 0x4000>;
+				dma-coherent;
+				interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cps_syscon0 1 22>;
+				status = "disabled";
+			};
+
+			cps_usb3_1: usb3 at 510000 {
+				compatible = "marvell,armada-8k-xhci",
+					     "generic-xhci";
+				reg = <0x510000 0x4000>;
+				dma-coherent;
+				interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cps_syscon0 1 23>;
+				status = "disabled";
+			};
+
+			cps_xor0: xor at 6a0000 {
+				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
+				reg = <0x6a0000 0x1000>,
+				      <0x6b0000 0x1000>;
+				dma-coherent;
+				msi-parent = <&gic_v2m0>;
+				clocks = <&cps_syscon0 1 8>;
+			};
+
+			cps_xor1: xor at 6c0000 {
+				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
+				reg = <0x6c0000 0x1000>,
+				      <0x6d0000 0x1000>;
+				dma-coherent;
+				msi-parent = <&gic_v2m0>;
+				clocks = <&cps_syscon0 1 7>;
+			};
+
+			cps_spi0: spi at 700600 {
+				compatible = "marvell,armada-380-spi";
+				reg = <0x700600 0x50>;
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+				cell-index = <1>;
+				clocks = <&cps_syscon0 0 3>;
+				status = "disabled";
+			};
+
+			cps_spi1: spi at 700680 {
+				compatible = "marvell,armada-380-spi";
+				reg = <0x700680 0x50>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <2>;
+				clocks = <&cps_syscon0 1 21>;
+				status = "disabled";
+			};
+
+			cps_i2c0: i2c at 701000 {
+				compatible = "marvell,mv78230-i2c";
+				reg = <0x701000 0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cps_syscon0 1 21>;
+				status = "disabled";
+			};
+
+			cps_i2c1: i2c at 701100 {
+				compatible = "marvell,mv78230-i2c";
+				reg = <0x701100 0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cps_syscon0 1 21>;
+				status = "disabled";
+			};
+		};
+
+		cps_pcie0: pcie at f4600000 {
+			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
+			reg = <0 0xf4600000 0 0x10000>,
+			      <0 0xfaf00000 0 0x80000>;
+			reg-names = "ctrl", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			dma-coherent;
+
+			bus-range = <0 0xff>;
+			ranges =
+				/* downstream I/O */
+				<0x81000000 0 0xfd000000 0  0xfd000000 0 0x10000
+				/* non-prefetchable memory */
+				0x82000000 0 0xfa000000 0  0xfa000000 0 0xf00000>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			num-lanes = <1>;
+			clocks = <&cps_syscon0 1 13>;
+			status = "disabled";
+		};
+
+		cps_pcie1: pcie at f4620000 {
+			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
+			reg = <0 0xf4620000 0 0x10000>,
+			      <0 0xfbf00000 0 0x80000>;
+			reg-names = "ctrl", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			dma-coherent;
+
+			bus-range = <0 0xff>;
+			ranges =
+				/* downstream I/O */
+				<0x81000000 0 0xfd010000 0  0xfd010000 0 0x10000
+				/* non-prefetchable memory */
+				0x82000000 0 0xfb000000 0  0xfb000000 0 0xf00000>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+
+			num-lanes = <1>;
+			clocks = <&cps_syscon0 1 11>;
+			status = "disabled";
+		};
+
+		cps_pcie2: pcie at f4640000 {
+			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
+			reg = <0 0xf4640000 0 0x10000>,
+			      <0 0xfcf00000 0 0x80000>;
+			reg-names = "ctrl", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			dma-coherent;
+
+			bus-range = <0 0xff>;
+			ranges =
+				/* downstream I/O */
+				<0x81000000 0 0xfd020000 0  0xfd020000 0 0x10000
+				/* non-prefetchable memory */
+				0x82000000 0 0xfc000000 0  0xfc000000 0 0xf00000>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>;
+
+			num-lanes = <1>;
+			clocks = <&cps_syscon0 1 12>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.7.4
