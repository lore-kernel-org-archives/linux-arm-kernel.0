From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon,  8 Feb 2016 16:59:27 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sun7i: Enable USB DRC on Itead Ibox
Message-ID: <1454947167-12236-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Enable the otg/drc usb controller on the Itead Ibox device.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts     | 14 ++++++++++++++
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
index 661c21d..a512581 100644
--- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
@@ -118,8 +118,22 @@
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PH4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &reg_ahci_5v {
 	status = "okay";
 };
+
+&usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>;
+	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
index 2565d51..d22eea3 100644
--- a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
+++ b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
@@ -88,6 +88,10 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 #include "axp209.dtsi"
 
 &reg_dcdc2 {
@@ -129,6 +133,11 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
-- 
2.7.1
