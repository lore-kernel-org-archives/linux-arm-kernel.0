From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 17 Aug 2017 11:40:48 +0800
Subject: [PATCH] ARM: sun8i: a83t: Add device tree for Sinovoip Bananapi BPI-M3
Message-ID: <20170817034048.11601-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BPI-M3 is an Allwinner A83T based SBC in the Bananapi/Bpi family.
It is roughly the same form factor as the BPI-M1+, with roughly the
same peripherals and connectors:

  - 2GB LPDDR3 DRAM
  - 8GB eMMC
  - Micro-SD card slot
  - HDMI output
  - Headset (stereo + mic) jack
  - Onboard mic
  - Gigabit Ethernet with RTL8211E transceiver
  - Ampak AP6212 WiFi + BT
  - USB OTG connector
  - USB-to-SATA bridge connected through a USB 2.0 hub
  - Consumer IR receiver
  - MIPI DSI LCD panel connector
  - Camera interface (parallel and MIPI CSI) connector
  - 3 LEDs (Red, Green, Blue), of which 2 are controllable (GB)
  - Raspberry Pi 2 compatible GPIO header

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Note that the file name follows the convention of most of the other
bananapi boards, that is the vendor "sinovoip" is not included in
the name. This deviates from what is already in U-boot.

This applies on top of my A83t USB patches.

---
 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 148 +++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e0d77ab79f5f..791fecc0774a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -903,6 +903,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a33-q8-tablet.dtb \
 	sun8i-a33-sinlinx-sina33.dtb \
 	sun8i-a83t-allwinner-h8homlet-v2.dtb \
+	sun8i-a83t-bananapi-m3.dtb \
 	sun8i-a83t-cubietruck-plus.dtb \
 	sun8i-h2-plus-orangepi-zero.dtb \
 	sun8i-h3-bananapi-m2-plus.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
new file mode 100644
index 000000000000..2bafd7e99ef7
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -0,0 +1,148 @@
+/*
+ * Copyright 2017 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+/dts-v1/;
+#include "sun8i-a83t.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Banana Pi BPI-M3";
+	compatible = "sinovoip,bpi-m3", "allwinner,sun8i-a83t";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&ehci0 {
+	/* Terminus Tech FE 1.1s 4-port USB 2.0 hub here */
+	status = "okay";
+
+	/* TODO GL830 USB-to-SATA bridge downstream w/ GPIO power controls */
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
+	cd-inverted;
+	status = "okay";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&r_rsb {
+	status = "okay";
+
+	axp81x: pmic at 3a3 {
+		compatible = "x-powers,axp813";
+		reg = <0x3a3>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	ac100: codec at e89 {
+		compatible = "x-powers,ac100";
+		reg = <0xe89>;
+
+		ac100_codec: codec {
+			compatible = "x-powers,ac100-codec";
+			interrupt-parent = <&r_pio>;
+			interrupts = <0 11 IRQ_TYPE_LEVEL_LOW>; /* PL11 */
+			#clock-cells = <0>;
+			clock-output-names = "4M_adda";
+		};
+
+		ac100_rtc: rtc {
+			compatible = "x-powers,ac100-rtc";
+			interrupt-parent = <&r_intc>;
+			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&ac100_codec>;
+			#clock-cells = <1>;
+			clock-output-names = "cko1_rtc",
+					     "cko2_rtc",
+					     "cko3_rtc";
+		};
+	};
+};
+
+&reg_usb1_vbus {
+	gpio = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+	status = "okay";
+};
+
+&reg_vcc3v0 {
+	status = "disabled";
+};
+
+&reg_vcc5v0 {
+	status = "disabled";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.13.3
