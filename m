From: noodles@earth.li (Jonathan McDowell)
Date: Tue, 30 Oct 2018 22:14:30 +0000
Subject: [PATCHv2] ARM: dts: sun8i-h3: Add dts for the Mapleboard MP130
Message-ID: <20181030221430.wu5cxicyf4ub2boa@earth.li>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Mapleboard MP130 is a single board computer based on the Allwinner
H3 SoC, with all schematics freely available. The Lite version includes
1GB main memory and 8GB eMMC.

https://www.mapleboard.org/en (still mostly in Chinese even when English
is selected)

This DTS is based upon the DTS shipped with the board which uses
mapleboard,mp130- prefixes instead of the allwinner,sun8i variants.

v2: Fold in review comments from Maxime Ripard

Signed-off-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun8i-h3-mapleboard-mp130.dts    | 174 ++++++++++++++++++
 2 files changed, 175 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts

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
index 000000000000..13ad55be4454
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Centrum Embedded Systems, Jia-Bin Huang <jb@ces.com.tw>
+ * Copyright (C) 2018 Jonathan McDowell <noodles@earth.li>
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
+	model = "MapleBoard MP130";
+	compatible = "mapleboard,mp130", "allwinner,sun8i-h3";
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
+
+		pwr_led {
+			label = "mp130:orange:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		status_led {
+			label = "mp130:orange:status";
+			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	r_gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+
+		power {
+			label = "mp130:power";
+			linux,code = <KEY_POWER>;
+			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>; /* PL3 */
+		};
+
+		user {
+			label = "mp130:user";
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
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
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
-- 
2.19.1
