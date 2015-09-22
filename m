From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Sep 2015 15:36:02 +0200
Subject: [PATCH 3/6] ARM: dts: sun7i: Enable USB DRC on orangepi-mini
In-Reply-To: <1442928966-6418-1-git-send-email-hdegoede@redhat.com>
References: <1442928966-6418-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1442928966-6418-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the otg/drc usb controller on the orangepi-mini.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
index 73cd81ee..4f65664 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
@@ -156,7 +156,18 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PH4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
 	mmc0_cd_pin_orangepi: mmc0_cd_pin at 0 {
 		allwinner,pins = "PH10";
 		allwinner,function = "gpio_in";
@@ -225,6 +236,10 @@
 	regulator-name = "avcc";
 };
 
+&reg_usb0_vbus {
+	status = "okay";
+};
+
 &reg_usb1_vbus {
 	pinctrl-0 = <&usb1_vbus_pin_bananapro>;
 	gpio = <&pio 7 26 GPIO_ACTIVE_HIGH>; /* PH26 */
@@ -243,7 +258,21 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
 &usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>;
+	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
-- 
2.4.3
