From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 12 Jan 2018 12:00:18 +0530
Subject: [PATCH v4 3/3] arm64: allwinner: a64: bananapi-m64: add usb otg
In-Reply-To: <1515738618-3617-1-git-send-email-jagan@amarulasolutions.com>
References: <1515738618-3617-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1515738618-3617-3-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb otg support for bananapi-m64 board,
- USB-ID connected with PH9
- USB-DRVVBUS controlled by N_VBUSEN pin from PMIC

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- rebase on master
- tested otg host mode.
Changes for v3:
- Move the position of reg_drivevbus as per binding documentation.
Changes for v2:
- add drvvbus regulator
- add N_VBUSEN pin

 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts  | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index a697567..26e8534 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -86,6 +86,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -156,6 +160,10 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
@@ -168,6 +176,7 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
 
@@ -283,6 +292,11 @@
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
@@ -295,6 +309,13 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
+	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb0_vbus-supply = <&reg_drivevbus>;
 	status = "okay";
 };
-- 
2.7.4
