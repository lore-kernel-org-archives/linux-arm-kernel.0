From: noodles@earth.li (Jonathan McDowell)
Date: Thu, 25 Oct 2018 20:55:19 +0100
Subject: [PATCH] dts: sun8i-h3: Add DTS for Mapleboard MP130
Message-ID: <20181025195519.hil6o66h4ev2m62q@earth.li>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The Mapleboard MP130 is a single board computer based on the Allwinner
H3 SoC, with all schematics freely available. The Lite version includes
1GB main memory and 8GB eMMC.

https://www.mapleboard.org/en (still mostly in Chinese even when English
is selected)

This DTS is based upon the DTS shipped with the board which uses
mapleboard,mp130- prefixes instead of the allwinner,sun8i variants.

Signed-off-by: Jonathan McDowell <noodles@earth.li>

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de87c33..dcf1b9e7f71e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1035,6 +1035,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-bananapi-m2-plus.dtb \
 	sun8i-h3-beelink-x2.dtb \
 	sun8i-h3-libretech-all-h3-cc.dtb \
+	sun8i-h3-mapleboard-mp130.dtb \
 	sun8i-h3-nanopi-m1.dtb	\
 	sun8i-h3-nanopi-m1-plus.dtb \
 	sun8i-h3-nanopi-neo.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts b/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
new file mode 100644
index 000000000000..bf948128af94
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
@@ -0,0 +1,179 @@
+/*
+ * Copyright (C) 2017 Centrum Embedded Systems, Jia-Bin Huang <jb@ces.com.tw>
+ * Copyright (C) 2018 Jonathan McDowell <noodles@earth.li>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "sun8i-h3.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "MapleBoard MP130 Board";
+	compatible = "mapleboard,mp130_board", "allwinner,sun8i-h3";
+
+	aliases {
+		ethernet0 = &emac;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_pio>, <&leds_r_pio>;
+
+		pwr_led {
+			label = "mp130_board:orange:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+		status_led {
+			label = "mp130_board:orange:status";
+			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	r_gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&sw_r_pio>;
+
+		power {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>; /* PL3 */
+		};
+
+		user {
+			label = "user";
+			linux,code = <BTN_0>;
+			gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&codec {
+	allwinner,audio-routing =
+		"Line Out", "LINEOUT",
+		"LINEIN", "Line In";
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&ir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir_pins_a>;
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
+	cd-inverted;
+	status = "okay";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&pio {
+	leds_pio: led_pins {
+		pins = "PA15";
+		function = "gpio_out";
+	};
+};
+
+&r_pio {
+	leds_r_pio: led_pins {
+		pins = "PL10";
+		function = "gpio_out";
+	};
+
+	sw_r_pio: key_pins {
+		pins = "PL3", "PL4";
+		function = "gpio_in";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "disabled";
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	/* USB VBUS is always on */
+	status = "okay";
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+

J.

-- 
Revd Jonathan McDowell, ULC | Do you believe in happy endings?
