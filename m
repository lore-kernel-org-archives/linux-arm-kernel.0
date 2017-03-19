From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 20 Mar 2017 00:31:18 +0800
Subject: [PATCH v4 8/8] arm64: allwinner: h5: enable USB OTG on Orange Pi PC 2
 board
In-Reply-To: <20170319163118.56301-1-icenowy@aosc.xyz>
References: <20170319163118.56301-1-icenowy@aosc.xyz>
Message-ID: <20170319163118.56301-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orange Pi PC 2 board features a OTG port like the one on older H3 Orange
Pi's, with PG12 pin being the id det pin and PL2 being the vbus driver
pin.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
New patch in v4.
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 27 +++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 30639729920d..dfecc17dcc92 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -90,6 +90,16 @@
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	reg_usb0_vbus: usb0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
+		status = "okay";
+	};
 };
 
 &codec {
@@ -100,6 +110,10 @@
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -127,6 +141,10 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
@@ -157,7 +175,14 @@
 	status = "disabled";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
-	/* USB VBUS is always on */
+	/* USB Type-A ports' VBUS is always on */
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 	status = "okay";
 };
-- 
2.12.0
