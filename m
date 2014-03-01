From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:37 +0100
Subject: [PATCH 18/19] ARM: sun4i: dt: Add support for the A10-OLinuXino-LIME
 board
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-19-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add support for the A10-OLinuXino-LIME:
https://www.olimex.com/Products/OLinuXino/A10/A10-OLinuXino-LIME

A low cost Allwinner A10 based dev-board, with sata, ethernet, hdmi and 2x USB.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 111 +++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8e1d636..66d6df3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -284,6 +284,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
 	sun4i-a10-cubieboard.dtb \
 	sun4i-a10-mini-xplus.dtb \
 	sun4i-a10-hackberry.dtb \
+	sun4i-a10-olinuxino-lime.dtb \
 	sun4i-a10-pcduino.dtb \
 	sun5i-a10s-olinuxino-micro.dtb \
 	sun5i-a13-olinuxino.dtb \
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
new file mode 100644
index 0000000..66cf0c7
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -0,0 +1,111 @@
+/*
+ * Copyright 2014 - Hans de Goede <hdegoede@redhat.com>
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
+/include/ "sun4i-a10.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "Olimex A10-OLinuXino-LIME";
+	compatible = "olimex,a10-olinuxino-lime", "allwinner,sun4i-a10";
+
+	soc at 01c00000 {
+		emac: ethernet at 01c0b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&emac_pins_a>;
+			phy = <&phy1>;
+			status = "okay";
+		};
+
+		mdio at 01c0b080 {
+			status = "okay";
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
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
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxinolime>;
+
+		green {
+			label = "a10-olinuxino-lime:green:usr";
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
1.9.0
