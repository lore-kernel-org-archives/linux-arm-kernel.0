From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  1 Sep 2014 22:14:39 +0800
Subject: [PATCH v2] ARM: sun5i: Add DT for HSG H702 tablet board
Message-ID: <1409580879-15601-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a Q8 format 7 inch tablet with an Allwinner A13 SoC.
It has 512MB DRAM, 4GB NAND flash, an accelerometer, camera,
RTL8188-based WiFi, and micro SD slot for external storage.

It is likely made by a subsidiary of Hanns.G (Hannstar).

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Added missing '>' to the email address in the header.

Sorry for the noise.

---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts | 101 +++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..94e61a6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -406,6 +406,7 @@ dtb-$(CONFIG_MACH_SUN4I) += \
 dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a10s-olinuxino-micro.dtb \
 	sun5i-a10s-r7-tv-dongle.dtb \
+	sun5i-a13-hsg-h702.dtb \
 	sun5i-a13-olinuxino.dtb \
 	sun5i-a13-olinuxino-micro.dtb
 dtb-$(CONFIG_MACH_SUN6I) += \
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
new file mode 100644
index 0000000..6335c1e
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -0,0 +1,101 @@
+/*
+ * Copyright 2014 Chen-Yu Tsai <wens@csie.org>
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
+/include/ "sun5i-a13.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "HSG H702";
+	compatible = "hsg,h702", "allwinner,sun5i-a13";
+
+	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_h702>;
+			vmmc-supply = <&reg_vcc3v3>;
+			bus-width = <4>;
+			cd-gpios = <&pio 6 0 0>; /* PG0 */
+			cd-inverted;
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
+			mmc0_cd_pin_h702: mmc0_cd_pin at 0 {
+				allwinner,pins = "PG0";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+		};
+
+		uart1: serial at 01c28400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_pins_b>;
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
+				interrupts = <0>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		i2c1: i2c at 01c2b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins_a>;
+			status = "okay";
+
+			pcf8563: rtc at 51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+		};
+
+		i2c2: i2c at 01c2b400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins_a>;
+			status = "okay";
+		};
+	};
+
+	reg_usb1_vbus: usb1-vbus {
+		/*
+		 * There doesn't seem to be a GPIO for controlling
+		 * vbus, despite the fex file saying otherwise.
+		 * Override the original settings with empty ones.
+		 */
+		pinctrl-0 = <>;
+		gpio = <>;
+		status = "okay";
+	};
+};
-- 
2.1.0
