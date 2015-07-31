From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 10:59:52 +0200
Subject: [PATCH 3/5] ARM: dts: sun5i: Enable USB DRC on A13 OLinuxIno
In-Reply-To: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
References: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1438333194-21181-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Janssen <mark@sig-io.nl>

Enable the otg/drc usb controller on the A13 OLinuxIno.

Signed-off-by: Mark Janssen <mark@sig-io.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 4232400..e659482 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -159,6 +159,10 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
 	mmc0_cd_pin_olinuxino: mmc0_cd_pin at 0 {
 		allwinner,pins = "PG0";
@@ -174,6 +178,24 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PG2";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+		allwinner,pins = "PG1";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_DOWN>;
+	};
+
+	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
+		allwinner,pins = "PG12";
+	};
+
 	usb1_vbus_pin_olinuxino: usb1_vbus_pin at 0 {
 		allwinner,pins = "PG11";
 		allwinner,function = "gpio_out";
@@ -182,6 +204,11 @@
 	};
 };
 
+&reg_usb0_vbus {
+	status = "okay";
+	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+};
+
 &reg_usb1_vbus {
 	pinctrl-0 = <&usb1_vbus_pin_olinuxino>;
 	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
@@ -194,7 +221,17 @@
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
+	usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
+	usb0_vbus_det-gpio = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
-- 
2.4.3
