From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Jul 2014 01:15:47 +0800
Subject: [PATCH v2 5/5] ARM: dts: sun6i: Add Merrii A31 Hummingbird support
In-Reply-To: <1405444547-21870-1-git-send-email-wens@csie.org>
References: <1405444547-21870-1-git-send-email-wens@csie.org>
Message-ID: <1405444547-21870-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

This adds support for the A31 Hummingbird:
http://www.merrii.com/en/pla_d.asp?id=172

The Merrii A31 Hummingbird is a development board based on the
Allwinner A31 SoC with multiple USB ports through a USB hub chip,
a uSD slot, a 10/100/1000M ethernet port, an AP6210 WiFi/BT chip,
TV-in, HDMI, VGA, audio in/out ports, and LCD/CSI headers.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
[wens at csie.org: enable usbphy, ehci0, ohci0 for on-board usb hub;
 add pcf8563 rtc node; add comments for i2c0 and mmc0 pull-ups;
 correct ethernet phy address to 0x01; drop uart2 (BT chip has
 no power) and uart3 (no device); use proper commit message]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 119 ++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun6i-a31-hummingbird.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c3ee9fb..8be3687 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -375,6 +375,7 @@ dtb-$(CONFIG_MACH_SUN5I) += \
 dtb-$(CONFIG_MACH_SUN6I) += \
 	sun6i-a31-app4-evb1.dtb \
 	sun6i-a31-colombus.dtb \
+	sun6i-a31-hummingbird.dtb \
 	sun6i-a31-m9.dtb
 dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-cubieboard2.dtb \
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
new file mode 100644
index 0000000..f142065
--- /dev/null
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -0,0 +1,119 @@
+/*
+ * Copyright 2014 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
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
+/include/ "sun6i-a31.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "Merrii A31 Hummingbird";
+	compatible = "merrii,a31-hummingbird", "allwinner,sun6i-a31";
+
+	chosen {
+		bootargs = "earlyprintk console=ttyS0,115200";
+	};
+
+	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
+			vmmc-supply = <&reg_vcc3v0>;
+			bus-width = <4>;
+			cd-gpios = <&pio 0 8 0>; /* PA8 */
+			cd-inverted;
+			status = "okay";
+		};
+
+		usbphy: phy at 01c19400 {
+			usb1_vbus-supply = <&reg_usb1_vbus>;
+			status = "okay";
+		};
+
+		ehci0: usb at 01c1a000 {
+			status = "okay";
+		};
+
+		ohci0: usb at 01c1a400 {
+			status = "okay";
+		};
+
+		pio: pinctrl at 01c20800 {
+			mmc0_pins_a: mmc0 at 0 {
+				/* external pull-ups missing for some pins */
+				allwinner,pull = <1>;
+			};
+
+			mmc0_cd_pin_hummingbird: mmc0_cd_pin at 0 {
+				allwinner,pins = "PA8";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
+			usb1_vbus_pin_a: usb1_vbus_pin at 0 {
+				allwinner,pins = "PH24";
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
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			/* pull-ups and devices require AXP221 DLDO3 */
+			status = "failed";
+		};
+
+		i2c1: i2c at 01c2b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins_a>;
+			status = "okay";
+		};
+
+		i2c2: i2c at 01c2b400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins_a>;
+			status = "okay";
+
+			pcf8563: rtc at 51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+		};
+
+		gmac: ethernet at 01c30000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gmac_pins_rgmii_a>;
+			phy = <&phy1>;
+			phy-mode = "rgmii";
+			status = "okay";
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+	};
+
+	reg_usb1_vbus: usb1-vbus {
+		pinctrl-0 = <&usb1_vbus_pin_a>;
+		gpio = <&pio 7 24 0>; /* PH24 */
+		status = "okay";
+	};
+};
-- 
2.0.1
