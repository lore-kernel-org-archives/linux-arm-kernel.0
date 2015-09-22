From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Sep 2015 15:36:01 +0200
Subject: [PATCH 2/6] ARM: dts: sun7i: Enable USB DRC on Bananapi
In-Reply-To: <1442928966-6418-1-git-send-email-hdegoede@redhat.com>
References: <1442928966-6418-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1442928966-6418-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the otg/drc usb controller on the Bananapi.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 74382f3..61436ad 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -159,7 +159,18 @@
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
 	mmc0_cd_pin_bananapi: mmc0_cd_pin at 0 {
 		allwinner,pins = "PH10";
 		allwinner,function = "gpio_in";
@@ -209,6 +220,10 @@
 	regulator-name = "avcc";
 };
 
+&reg_usb0_vbus {
+	status = "okay";
+};
+
 &reg_usb1_vbus {
 	status = "okay";
 };
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
