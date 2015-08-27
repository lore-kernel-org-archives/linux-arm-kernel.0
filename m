From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 27 Aug 2015 20:37:31 +0200
Subject: [PATCH] ARM: dts: sun5i: inet98v_rev2 fix regulator for the usb wifi
 module
In-Reply-To: <1440700651-30575-1-git-send-email-hdegoede@redhat.com>
References: <1440700651-30575-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1440700651-30575-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb-wifi module is not connected to a gpio controller regulator
(as is typical on sunxi boards), instead is it connected to ldo3.

This commit fixes the us_phy usb1_vbus-supply setting thereby making
sure that we power the usb-wifi and that it can be used.

This commit also removes the wrong and now unused bits which refer to
the gpio controlled reg_usb1_vbus.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts b/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
index 6d466a2..6fa54b6 100644
--- a/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
+++ b/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
@@ -201,11 +201,6 @@
 	status = "okay";
 };
 
-&reg_usb1_vbus {
-	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
-	status = "okay";
-};
-
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins_b>;
@@ -221,16 +216,12 @@
 	allwinner,pins = "PG12";
 };
 
-&usb1_vbus_pin_a {
-	allwinner,pins = "PG11";
-};
-
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
 	usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
 	usb0_vbus_det-gpio = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
 	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb1_vbus-supply = <&reg_ldo3>;
 	status = "okay";
 };
-- 
2.4.3
