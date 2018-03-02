From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  2 Mar 2018 20:21:35 +0100
Subject: [PATCH v3 3/5] arm: zynq: Add support for Xilinx zc770 xm011 dc2 board
In-Reply-To: <cover.1520018484.git.michal.simek@xilinx.com>
References: <cover.1520018484.git.michal.simek@xilinx.com>
Message-ID: <1723ff499e33d7d6b2dd677d78c83bf4fe98d8e7.1520018484.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

zc770 is based board which is extended by FMC/DC cards for SoC
validation. FMCs/DCs are supposed to cover all SoC configurations.
FMC/DC contains can, i2c, nand uart, spi and usb.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3: None
Changes in v2:
- Record compatible string to xilinx.txt

 Documentation/devicetree/bindings/arm/xilinx.txt |  1 +
 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/zynq-zc770-xm011.dts           | 64 ++++++++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm011.dts

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 019e69037d42..80139a7cfcdc 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -13,6 +13,7 @@ Additional compatible strings:
 
 - Xilinx internal board zc770 with different FMC cards
   "xlnx,zynq-zc770-xm010"
+  "xlnx,zynq-zc770-xm011"
 
 ---------------------------------------------------------------
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index be9ffae2a1ec..801a46a88e93 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1068,6 +1068,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-zc702.dtb \
 	zynq-zc706.dtb \
 	zynq-zc770-xm010.dtb \
+	zynq-zc770-xm011.dtb \
 	zynq-zed.dtb \
 	zynq-zybo.dtb
 dtb-$(CONFIG_MACH_ARMADA_370) += \
diff --git a/arch/arm/boot/dts/zynq-zc770-xm011.dts b/arch/arm/boot/dts/zynq-zc770-xm011.dts
new file mode 100644
index 000000000000..b78883cee96a
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-zc770-xm011.dts
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx ZC770 XM013 board DTS
+ *
+ * Copyright (C) 2013-2018 Xilinx, Inc.
+ */
+/dts-v1/;
+#include "zynq-7000.dtsi"
+
+/ {
+	compatible = "xlnx,zynq-zc770-xm011", "xlnx,zynq-7000";
+	model = "Xilinx Zynq";
+
+	aliases {
+		i2c0 = &i2c1;
+		serial0 = &uart1;
+		spi0 = &spi0;
+	};
+
+	chosen {
+		bootargs = "";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
+	};
+
+	usb_phy1: phy1 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
+};
+
+&can0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom: eeprom at 52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+	};
+};
+
+&spi0 {
+	status = "okay";
+	num-cs = <4>;
+	is-decoded-cs = <0>;
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+	dr_mode = "host";
+	usb-phy = <&usb_phy1>;
+};
-- 
1.9.1
