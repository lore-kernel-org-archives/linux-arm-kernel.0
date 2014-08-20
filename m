From: naobsd@gmail.com (FUKAUMI Naoki)
Date: Wed, 20 Aug 2014 14:25:03 +0900
Subject: [PATCH] ARM: sun7i: Add support for Olimex A20-OLinuXino-LIME
Message-ID: <1408512303-3181-1-git-send-email-naobsd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Olimex A20-OLinuXino-LIME board.

Signed-off-by: FUKAUMI Naoki <naobsd@gmail.com>
---
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts | 137 +++++++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..d6d5687 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -417,6 +417,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-cubieboard2.dtb \
 	sun7i-a20-cubietruck.dtb \
 	sun7i-a20-i12-tvbox.dtb \
+	sun7i-a20-olinuxino-lime.dtb \
 	sun7i-a20-olinuxino-micro.dtb \
 	sun7i-a20-pcduino3.dtb
 dtb-$(CONFIG_MACH_SUN8I) += \
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
new file mode 100644
index 0000000..1eb8175
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -0,0 +1,137 @@
+/*
+ * This is based on sun4i-a10-olinuxino-lime.dts
+ *
+ * Copyright 2014 - Hans de Goede <hdegoede@redhat.com>
+ * Copyright (c) 2014 FUKAUMI Naoki <naobsd@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "sun7i-a20.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "Olimex A20-OLinuXino-LIME";
+	compatible = "olimex,a20-olinuxino-lime", "allwinner,sun7i-a20";
+
+	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+			vmmc-supply = <&reg_vcc3v3>;
+			bus-width = <4>;
+			cd-gpios = <&pio 7 1 0>; /* PH1 */
+			cd-inverted;
+			status = "okay";
+		};
+
+		usbphy: phy at 01c13400 {
+			usb1_vbus-supply = <&reg_usb1_vbus>;
+			usb2_vbus-supply = <&reg_usb2_vbus>;
+			status = "okay";
+		};
+
+		ehci0: usb at 01c14000 {
+			status = "okay";
+		};
+
+		ohci0: usb at 01c14400 {
+			status = "okay";
+		};
+
+		ahci: sata at 01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
+		ehci1: usb at 01c1c000 {
+			status = "okay";
+		};
+
+		ohci1: usb at 01c1c400 {
+			status = "okay";
+		};
+
+		pinctrl at 01c20800 {
+			ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
+				allwinner,pins = "PC3";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			led_pins_olinuxinolime: led_pins at 0 {
+				allwinner,pins = "PH2";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <1>;
+				allwinner,pull = <0>;
+			};
+		};
+
+		uart0: serial at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
+			status = "okay";
+		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		gmac: ethernet at 01c50000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gmac_pins_mii_a>;
+			phy = <&phy1>;
+			phy-mode = "mii";
+			status = "okay";
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxinolime>;
+
+		green {
+			label = "a20-olinuxino-lime:green:usr";
+			gpios = <&pio 7 2 0>;
+			default-state = "on";
+		};
+	};
+
+	reg_ahci_5v: ahci-5v {
+		pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
+		gpio = <&pio 2 3 0>;
+		status = "okay";
+	};
+
+	reg_usb1_vbus: usb1-vbus {
+		status = "okay";
+	};
+
+	reg_usb2_vbus: usb2-vbus {
+		status = "okay";
+	};
+};
-- 
2.0.4
