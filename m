From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 14:53:36 +0200
Subject: [PATCH v2 1/3] ARM: dts: sun5i: Enable USB DRC on A10s OLinuxIno Micro
Message-ID: <1438347218-8158-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the otg/drc usb controller on the A10s OLinuxIno Micro.

Note the A10s OlinuxIno Micro always has some voltage on its otg power
pin, even if the usb-vbus0-regulator is disabled, the leaked voltage is
enough to make vbus-det always report 1, so we do not use vbus-det on
this board.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Address usb0_vbus_pin_a node by reference instead of by full path
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 30 +++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 7b26e17..5a422c1 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -196,6 +196,10 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
 	mmc0_cd_pin_olinuxino_micro: mmc0_cd_pin at 0 {
 		allwinner,pins = "PG1";
@@ -224,6 +228,18 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PG12";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+};
+
+&reg_usb0_vbus {
+	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
+	status = "okay";
 };
 
 &reg_usb1_vbus {
@@ -250,8 +266,20 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb0_vbus_pin_a {
+	allwinner,pins = "PG11";
+};
+
 &usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>;
+	usb0_id_det-gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
-
-- 
2.4.3
