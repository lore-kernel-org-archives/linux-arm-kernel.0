From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 10:59:50 +0200
Subject: [PATCH 1/5] ARM: dts: sun4i: Enable USB DRC on A10 OLinuxIno Lime
In-Reply-To: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
References: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1438333194-21181-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Remy van Elst <relst@relst.nl>

Enable the otg/drc usb controller on the A10 OLinuxIno Lime.

Signed-off-by: Remy van Elst <relst@relst.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index b64aa4e..28e32ad 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -150,6 +150,10 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
 	ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
 		allwinner,pins = "PC3";
@@ -164,6 +168,20 @@
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PH4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+		allwinner,pins = "PH5";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_DOWN>;
+	};
 };
 
 &reg_ahci_5v {
@@ -172,6 +190,10 @@
 	status = "okay";
 };
 
+&reg_usb0_vbus {
+	status = "okay";
+};
+
 &reg_usb1_vbus {
 	status = "okay";
 };
@@ -186,7 +208,17 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
+	usb0_id_det-gpio   = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_det-gpio = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+	usb0_vbus-supply   = <&reg_usb0_vbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
-- 
2.4.3
