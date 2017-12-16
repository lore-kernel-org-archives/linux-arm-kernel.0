From: kettenis@openbsd.org (Mark Kettenis)
Date: Sat, 16 Dec 2017 21:58:09 +0100
Subject: [PATCH] ARM: dts: sun9i: Enable USB support on Cubieboard4
Message-ID: <20171216205809.5485-1-kettenis@openbsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Cubieboard4 HCI0 is directly connected to a USB connector,
and HCI2 is connected to a USB hub on the board.  HCI1 is available
with HSIC throug 2 pins on the GPIO expansion header, but left
disabled just like on the Optimus board.

This patch also adds the VBUS regulators.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 4024639aa005..e38623265695 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -74,6 +74,24 @@
 		};
 	};
 
+	reg_usb1_vbus: usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb2-drvbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
+	};
+
+	reg_usb3_vbus: usb3-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-drvbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 7 14 GPIO_ACTIVE_HIGH>; /* PH14 */
+	};
+
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&ac100_rtc 1>;
@@ -83,6 +101,14 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -408,3 +434,13 @@
 	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
+
+&usbphy1 {
+	phy-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
+
+&usbphy3 {
+	phy-supply = <&reg_usb3_vbus>;
+	status = "okay";
+};
-- 
2.15.1
