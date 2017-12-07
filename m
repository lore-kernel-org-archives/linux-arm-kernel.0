From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Thu,  7 Dec 2017 16:35:48 +0530
Subject: [PATCH] arm64: allwinner: a64: orangepi-zero-plus2: add usb otg
Message-ID: <1512644748-14491-1-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb otg support for orangepi-zero-plus2 board:
- Add usb_otg node with dr_mode as 'otg'
- USB0-IDDET connected to PA21
- VBUS connected through DCIN which always on

Tested mass storage function.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note: Anyone please check vbus connection [1]
Since it is connected through DCIN of vcc-5v, I've added vcc-5v0
regulator for the same and attached to usb0_vbus-supply but it is
disabling during kernel boot.
[    1.887854] vcc5v0: disabling

[1] http://linux-sunxi.org/File:ORANGE_PI-ZERO-PLUS2_V1_0.pdf

 .../dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index d349399..7f298ee 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -73,6 +73,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>;
@@ -111,6 +115,10 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
@@ -122,3 +130,13 @@
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
 	status = "okay";
 };
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 0 21 GPIO_ACTIVE_HIGH>; /* PA21 */
+	status = "okay";
+};
-- 
2.7.4
