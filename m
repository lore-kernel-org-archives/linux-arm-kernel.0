From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 12 Jan 2018 12:27:10 +0530
Subject: [PATCH v2] arm64: allwinner: a64: a64-olinuxino: add usb otg
Message-ID: <1515740230-8006-1-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb otg support for a64-olinuxino board,
- USB0-ID connected with PH9
- USB0-VBUSDET connected with PH6
- USB-DRVVBUS controlled by N_VBUSEN pin from PMIC

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- rebase on master
- tested otg host mode.

 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 8807664..078ee94 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -64,6 +64,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -93,6 +97,10 @@
 	};
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -101,6 +109,7 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
 
@@ -215,8 +224,25 @@
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
