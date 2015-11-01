From: marex@denx.de (Marek Vasut)
Date: Mon,  2 Nov 2015 00:29:09 +0100
Subject: [PATCH] ARM: socfpga: Add support for DENX MCV SoM and MCVEVK
 baseboard
Message-ID: <1446420549-5572-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the DENX MCV SoM and MCVEVK baseboard. The SoM contains
eMMC, DRAM, Altera Cyclone V SoC. The baseboard contains CAN ports, UART
ports, STMPE811 touchscreen controller, USB OTG port, ethernet port and
a lot of IO pins.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Vince Bridgers <vbridgers2013@gmail.com>
Cc: Alan Tull <atull@altera.com>
Cc: Thor Thayer <tthayer@altera.com>
Cc: Dinh Nguyen <dinguyen@altear.com>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi   | 33 ++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts | 94 +++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7d3e495..8f322be 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -555,6 +555,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
+	socfpga_cyclone5_mcvevk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_de0_sockit.dtb \
 	socfpga_cyclone5_sockit.dtb \
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
new file mode 100644
index 0000000..70dacf3
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2015 Marek Vasut <marex@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "DENX MCV";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>;	/* 1 GiB */
+	};
+};
+
+&mmc0 {	/* On-SoM eMMC */
+	bus-width = <8>;
+};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
new file mode 100644
index 0000000..7cbe9b3
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2015 Marek Vasut <marex@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "socfpga_cyclone5_mcv.dtsi"
+
+/ {
+	model = "DENX MCV EVK";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+
+	aliases {
+		ethernet0 = &gmac0;
+		stmpe-i2c0 = &stmpe1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&gpio0 {	/* GPIO  0 ... 28 */
+	status = "okay";
+};
+
+&gpio1 {	/* GPIO 29 ... 57 */
+	status = "okay";
+};
+
+&gpio2 {	/* GPIO 58..66 (HLGPI 0..13 at offset 13) */
+	status = "okay";
+};
+
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	speed-mode = <0>;
+
+	stmpe1: stmpe811 at 41 {
+		compatible = "st,stmpe811";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x41>;
+		id = <0>;
+		blocks = <0x5>;
+		irq-gpio = <&portb 28 0x4>;	/* GPIO 57, trig. level HI */
+
+		stmpe_touchscreen {
+			compatible = "st,stmpe-ts";
+			reg = <0>;
+			ts,sample-time = <4>;
+			ts,mod-12b = <1>;
+			ts,ref-sel = <0>;
+			ts,adc-freq = <1>;
+			ts,ave-ctrl = <1>;
+			ts,touch-det-delay = <3>;
+			ts,settling = <4>;
+			ts,fraction-z = <7>;
+			ts,i-drive = <1>;
+		};
+	};
+};
+
+&gmac0 {
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
-- 
2.1.4
