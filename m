From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 29 Jun 2016 20:46:59 +0200
Subject: [PATCH 1/4] ARM: dts: sun5i: Enable otg on the auxtex t004
Message-ID: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The auxtek t004 has its otg usb vbus hardwired to 5v (likely in case
people use it to power the board instead of the dedicated power micro
usb connector), it does have an id pin, so it allows full otg
functionality.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index e15d1ef..7ddebce 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -130,7 +130,18 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PG12";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
 	mmc0_cd_pin_t004: mmc0_cd_pin at 0 {
 		allwinner,pins = "PG1";
 		allwinner,function = "gpio_in";
@@ -164,11 +175,19 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usb1_vbus_pin_a {
 	allwinner,pins = "PG13";
 };
 
 &usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>;
+	usb0_id_det-gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
-- 
2.7.4
