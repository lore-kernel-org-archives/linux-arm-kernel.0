From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Jul 2016 16:35:56 +0200
Subject: [PATCH 2/2] arm64: dts: marvell: add description for the Armada 8040
 dev board
In-Reply-To: <1469716556-15299-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1469716556-15299-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1469716556-15299-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a Device Tree description for the Marvell Armada 8040
Development Board. It features a quad-core Cortex A72 Armada 8040 SoC,
with a large number of peripherals: dual Gigabit, dual 10 GBit, 6 PCIe
interfaces, 6 SATA ports, 4 USB 3.0 ports, and more.

Only a subset of the functionalities are supported so far, and
additional features will be progressively enabled in the future.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/Makefile           |   1 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 150 +++++++++++++++++++++++++
 2 files changed, 151 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-db.dts

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 308468d..cf39531 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-stb.dtb
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
new file mode 100644
index 0000000..6e6f182
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -0,0 +1,150 @@
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
+ * Device Tree file for Marvell Armada 8040 Development board platform
+ */
+
+#include "armada-8040.dtsi"
+
+/ {
+	model = "Marvell Armada 8040 DB board";
+	compatible = "marvell,armada8040-db", "marvell,armada8040",
+		     "marvell,armada-ap806-quad", "marvell,armada-ap806";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 00000000 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0 0x200000>;
+			};
+			partition at 400000 {
+				label = "Filesystem";
+				reg = <0x200000 0xce0000>;
+			};
+		};
+	};
+};
+
+/* Accessible over the mini-USB CON9 connector on the main board */
+&uart0 {
+	status = "okay";
+};
+
+
+/* CON5 on CP0 expansion */
+&cpm_pcie2 {
+	status = "okay";
+};
+
+&cpm_i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+/* CON4 on CP0 expansion */
+&cpm_sata0 {
+	status = "okay";
+};
+
+/* CON9 on CP0 expansion */
+&cpm_usb3_0 {
+	status = "okay";
+};
+
+/* CON10 on CP0 expansion */
+&cpm_usb3_1 {
+	status = "okay";
+};
+
+/* CON5 on CP1 expansion */
+&cps_pcie2 {
+	status = "okay";
+};
+
+&cps_i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+/* CON4 on CP1 expansion */
+&cps_sata0 {
+	status = "okay";
+};
+
+/* CON9 on CP1 expansion */
+&cps_usb3_0 {
+	status = "okay";
+};
+
+/* CON10 on CP1 expansion */
+&cps_usb3_1 {
+	status = "okay";
+};
-- 
2.7.4
