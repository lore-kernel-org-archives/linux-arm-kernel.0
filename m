From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Mar 2016 17:00:32 +0100
Subject: [PATCH 4/8] ARM: dts: sun8i: Enable USB host controllers on Orangepi
 Plus boards
In-Reply-To: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
References: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1458489636-2825-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jens Kuske <jenskuske@gmail.com>

Enable the 2 USB host controllers used on the Orange Pi Plus
and add the necessary regulators.

Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jens Kuske <jenskuske@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index e67df59..1cb6c66 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -58,6 +58,35 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_usb3_vbus: usb3-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3_vbus_pin_a>;
+		regulator-name = "usb3-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&pio {
+	usb3_vbus_pin_a: usb3_vbus_pin at 0 {
+		allwinner,pins = "PG11";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &mmc0 {
@@ -70,8 +99,23 @@
 	status = "okay";
 };
 
+&reg_usb1_vbus {
+	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
+
+&usb1_vbus_pin_a {
+	allwinner,pins = "PG13";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb3_vbus-supply = <&reg_usb3_vbus>;
+	status = "okay";
+};
-- 
2.7.3
