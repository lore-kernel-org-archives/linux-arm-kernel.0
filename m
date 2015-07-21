From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 21 Jul 2015 16:00:28 -0500
Subject: [PATCHv3] ARM: dts: socfpga: Add support of Terasic DE0 Atlas board
Message-ID: <1437512428-13526-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dalon Westergreen <dwesterg@gmail.com>

The Terasic DE0 Atlas board is also known as the DE0-Nano board.
This patch adds the DTS board file for the DE0-Nano Sockit board, and not
the DE0 Nano "Development Board".

Signed-off-by: Dalon Westergreen <dwesterg@gmail.com>
Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v3: Updated skew settings for the gmac1 node as this board is using the
    KSZ9031 PHY instead of the 9021 PHY.
v2: use stdpath-out for console and remove comment regarding u-boot ethaddr
---
 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts | 111 ++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 246473a..29e33aa 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -522,6 +522,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
 	socfpga_cyclone5_socdk.dtb \
+	socfpga_cyclone5_de0_sockit.dtb \
 	socfpga_cyclone5_sockit.dtb \
 	socfpga_cyclone5_socrates.dtb \
 	socfpga_vt.dtb
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
new file mode 100644
index 0000000..555e9ca
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
@@ -0,0 +1,111 @@
+/*
+ * Copyright Altera Corporation (C) 2015. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Terasic DE-0(Atlas)";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+
+	chosen {
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>; /* 1GB */
+	};
+
+	aliases {
+		ethernet0 = &gmac1;
+	};
+
+	regulator_3_3v: 3-3-v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 24 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&gmac1 {
+	status = "okay";
+	phy-mode = "rgmii";
+
+	txd0-skew-ps = <0>; /* -420ps */
+	txd1-skew-ps = <0>; /* -420ps */
+	txd2-skew-ps = <0>; /* -420ps */
+	txd3-skew-ps = <0>; /* -420ps */
+	rxd0-skew-ps = <420>; /* 0ps */
+	rxd1-skew-ps = <420>; /* 0ps */
+	rxd2-skew-ps = <420>; /* 0ps */
+	rxd3-skew-ps = <420>; /* 0ps */
+	txen-skew-ps = <0>; /* -420ps */
+	txc-skew-ps = <1860>; /* 960ps */
+	rxdv-skew-ps = <420>; /* 0ps */
+	rxc-skew-ps = <1680>; /* 780ps */
+
+	max-frame-size = <3800>;
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	speed-mode = <0>;
+
+	adxl345: adxl345 at 0 {
+		compatible = "adi,adxl345";
+		reg = <0x53>;
+
+		interrupt-parent = <&portc>;
+		interrupts = <3 2>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&regulator_3_3v>;
+	vqmmc-supply = <&regulator_3_3v>;
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
2.4.5
