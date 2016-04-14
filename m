From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 14 Apr 2016 17:38:32 +0200
Subject: [PATCH v2 3/4] arm64: dts: marvell: initial DT description of Armada
 7K/8K CP110 master
In-Reply-To: <1460648313-31642-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1460648313-31642-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1460648313-31642-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds an initial Device Tree description for the CP110
master that is found in the Armada 7K and 8K SoCs. This initial
description only describes the system controller (to provide clocks)
and three PCIe interfaces.

For the record, the organization of the SoCs is as follows:

 - 7020: dual-core AP, one CP110 (master)
 - 7040: quad-core AP, one CP110 (master)
 - 8020: dual-core AP, two CP110s (master and slave)
 - 8040: quad-core AP, two CP110s (master and slave)

For this reason, all of the 7020, 7040, 8020 and 8040 include
armada-cp110-master.dtsi. When support for the second CP110 (slave)
used in 8020 and 8040 will be added, the .dtsi files for those SoCs
will in addition include armada-cp110-slave.dtsi.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   1 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 140 +++++++++++++++++++++
 5 files changed, 144 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi

diff --git a/arch/arm64/boot/dts/marvell/armada-7020.dtsi b/arch/arm64/boot/dts/marvell/armada-7020.dtsi
index 5257575..975e733 100644
--- a/arch/arm64/boot/dts/marvell/armada-7020.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-7020.dtsi
@@ -46,6 +46,7 @@
  */
 
 #include "armada-ap806-dual.dtsi"
+#include "armada-cp110-master.dtsi"
 
 / {
 	model = "Marvell Armada 7020";
diff --git a/arch/arm64/boot/dts/marvell/armada-7040.dtsi b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
index 7a2de8b..78d995d 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
@@ -46,6 +46,7 @@
  */
 
 #include "armada-ap806-quad.dtsi"
+#include "armada-cp110-master.dtsi"
 
 / {
 	model = "Marvell Armada 7040";
diff --git a/arch/arm64/boot/dts/marvell/armada-8020.dtsi b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
index 73d69d9..3753c1c 100644
--- a/arch/arm64/boot/dts/marvell/armada-8020.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
@@ -46,6 +46,7 @@
  */
 
 #include "armada-ap806-dual.dtsi"
+#include "armada-cp110-master.dtsi"
 
 / {
 	model = "Marvell Armada 8020";
diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
index a1406a4..8bd0d8f 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
@@ -46,6 +46,7 @@
  */
 
 #include "armada-ap806-quad.dtsi"
+#include "armada-cp110-master.dtsi"
 
 / {
 	model = "Marvell Armada 8040";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
new file mode 100644
index 0000000..6361c58
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -0,0 +1,140 @@
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
+ * Device Tree file for Marvell Armada CP110 Master.
+ */
+
+/ {
+	cp110-master {
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
+			ranges = <0x0 0x0 0xf2000000 0x2000000>;
+
+			cpm_syscon0: system-controller at 440000 {
+				compatible = "marvell,cp110-system-controller0", "syscon";
+				reg = <0x440000 0x1000>;
+				#clock-cells = <2>;
+				core-clock-output-names = "cpm-apll", "cpm-ppv2-core", "cpm-eip", "cpm-core", "cpm-nand-core";
+				gate-clock-output-names = "cpm-audio", "cpm-communit", "cpm-nand", "cpm-ppv2", "cpm-sdio",
+					"cpm-mg-domain", "cpm-mg-core", "cpm-xor1", "cpm-xor0", "cpm-gop-dp", "none",
+					"cpm-pcie_x10", "cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor", "cpm-sata",
+					"cpm-sata-usb", "cpm-main", "cpm-sd-mmc", "none", "none", "cpm-slow-io",
+					"cpm-usb3h0", "cpm-usb3h1", "cpm-usb3dev", "cpm-eip150", "cpm-eip197";
+			};
+		};
+
+		pcie at f2600000 {
+			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
+			reg = <0 0xf2600000 0 0x10000>, <0 0xf6f00000 0 0x80000>;
+			reg-names = "ctrl", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			dma-coherent;
+
+			bus-range = <0 0xff>;
+			ranges = <0x81000000 0 0xf9000000 0  0xf9000000 0 0x10000	/* downstream I/O */
+				  0x82000000 0 0xf6000000 0  0xf6000000 0 0xf00000>;	/* non-prefetchable memory */
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			num-lanes = <1>;
+			clocks = <&cpm_syscon0 1 13>;
+			status = "disabled";
+		};
+
+		pcie at f2620000 {
+			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
+			reg = <0 0xf2620000 0 0x10000>, <0 0xf7f00000 0 0x80000>;
+			reg-names = "ctrl", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			dma-coherent;
+
+			bus-range = <0 0xff>;
+			ranges = <0x81000000 0 0xf9010000 0  0xf9010000 0 0x10000	/* downstream I/O */
+				  0x82000000 0 0xf7000000 0  0xf7000000 0 0xf00000>;	/* non-prefetchable memory */
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+
+			num-lanes = <1>;
+			clocks = <&cpm_syscon0 1 11>;
+			status = "disabled";
+		};
+
+		pcie at f2640000 {
+			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
+			reg = <0 0xf2640000 0 0x10000>, <0 0xf8f00000 0 0x80000>;
+			reg-names = "ctrl", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			dma-coherent;
+
+			bus-range = <0 0xff>;
+			ranges = <0x81000000 0 0xf9020000 0  0xf9020000 0 0x10000	/* downstream I/O */
+				  0x82000000 0 0xf8000000 0  0xf8000000 0 0xf00000>;	/* non-prefetchable memory */
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+
+			num-lanes = <1>;
+			clocks = <&cpm_syscon0 1 12>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.6.4
