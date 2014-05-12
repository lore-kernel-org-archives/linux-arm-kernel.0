From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 12 May 2014 14:11:06 +0200
Subject: [PATCH] ARM: dts: sun5i: Add new A10s r7 hdmi tv dongle board
Message-ID: <1399896666-6366-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R7 tv-dongle is an A10s based hdmi tv dongle, with 1G RAM, 4G nand flash,
and rtl8189es sdio wifi. It has a standard male hdmi connector, an USB host
port using an USB-A receptacle and a micro-usb receptacle for both power
and USB OTG.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts | 100 ++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3a38a66..e4c5a79 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -341,6 +341,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
 	sun4i-a10-olinuxino-lime.dtb \
 	sun4i-a10-pcduino.dtb \
 	sun5i-a10s-olinuxino-micro.dtb \
+	sun5i-a10s-r7-tv-dongle.dtb \
 	sun5i-a13-olinuxino.dtb \
 	sun5i-a13-olinuxino-micro.dtb \
 	sun6i-a31-app4-evb1.dtb \
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
new file mode 100644
index 0000000..43a9376
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -0,0 +1,100 @@
+/*
+ * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
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
+/include/ "sun5i-a10s.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "R7 A10s hdmi tv-stick";
+	compatible = "allwinner,r7-tv-dongle", "allwinner,sun5i-a10s";
+
+	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_r7>;
+			vmmc-supply = <&reg_vcc3v3>;
+			bus-width = <4>;
+			cd-gpios = <&pio 6 1 0>; /* PG1 */
+			cd-inverted;
+			status = "okay";
+		};
+
+		mmc1: mmc at 01c10000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc1_pins_a>;
+			vmmc-supply = <&reg_vcc3v3>;
+			bus-width = <4>;
+			non-removable;
+			status = "okay";
+		};
+
+		usbphy: phy at 01c13400 {
+			usb1_vbus-supply = <&reg_usb1_vbus>;
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
+		pinctrl at 01c20800 {
+			mmc0_cd_pin_r7: mmc0_cd_pin at 0 {
+				allwinner,pins = "PG1";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
+			led_pins_r7: led_pins at 0 {
+				allwinner,pins = "PB2";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <1>;
+				allwinner,pull = <0>;
+			};
+
+			usb1_vbus_pin_r7: usb1_vbus_pin at 0 {
+				allwinner,pins = "PG13";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
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
+		pinctrl-0 = <&led_pins_r7>;
+
+		green {
+			label = "r7-tv-dongle:green:usr";
+			gpios = <&pio 1 2 0>;
+			default-state = "on";
+		};
+	};
+
+	reg_usb1_vbus: usb1-vbus {
+		pinctrl-0 = <&usb1_vbus_pin_r7>;
+		gpio = <&pio 6 13 0>;
+		status = "okay";
+	};
+};
-- 
1.9.0
