From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 12 Dec 2017 11:26:09 +0530
Subject: [PATCH] arm64: allwinner: a64: a64-olinuxino: add usb otg
Message-ID: <1513058169-25516-1-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb otg support for a64-olinuxino board,
- USB0-ID connected with PH9
- USB0-VBUSDET connected with PH6
- USB-DRVVBUS controlled by N_VBUSEN pin from PMIC

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 338e7861..f9bc6c3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -59,6 +59,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -70,6 +74,10 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -78,6 +86,7 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
 
@@ -192,8 +201,25 @@
 	regulator-name = "vcc-rtc";
 };
 
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb0_vbus_det-gpio = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
+	usb0_vbus-supply = <&reg_drivevbus>;
+	status = "okay";
+};
-- 
2.7.4
