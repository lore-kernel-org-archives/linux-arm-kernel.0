From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 23 Apr 2018 12:02:39 +0530
Subject: [PATCH v6 3/3] arm64: allwinner: a64: bananapi-m64: add usb otg
In-Reply-To: <20180423063239.3988-1-jagan@amarulasolutions.com>
References: <20180423063239.3988-1-jagan@amarulasolutions.com>
Message-ID: <20180423063239.3988-3-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb otg support for bananapi-m64 board,
- USB-ID connected with PH9
- USB-DRVVBUS controlled by N_VBUSEN pin from PMIC

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes for v6:
- Rebase on master 
Changes for v5:
- Kept reg_drivevbus node in alphabetical order.
- Collect Chen-Yu reviewed-by tag
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
index 2250dec9974c..0716b1441187 100644
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
@@ -155,6 +159,10 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
@@ -167,6 +175,7 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
 
@@ -254,6 +263,11 @@
 	regulator-name = "vcc-wifi-io";
 };
 
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
 &reg_eldo1 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
@@ -294,6 +308,13 @@
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
2.14.3
