From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 17 Jan 2017 03:14:49 +0800
Subject: [PATCH 4/4] ARM: dts: sun8i: enable USB OTG on Orange Pi One board
In-Reply-To: <20170116191449.50397-1-icenowy@aosc.xyz>
References: <20170116191449.50397-1-icenowy@aosc.xyz>
Message-ID: <20170116191449.50397-5-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orange Pi One board features a USB OTG port, which cannot be used to
power up the board, but have a gateable VBUS and an ID pin, which makes
it possible to be used in both host and peripheral mode.

Enable its OTG port in dual-role mode.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 34da853ee037..8f69c8c9995c 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -115,6 +115,11 @@
 	};
 };
 
+&reg_usb0_vbus {
+	gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
+	status = "okay";
+};
+
 &r_pio {
 	leds_r_opc: led_pins at 0 {
 		pins = "PL10";
@@ -151,7 +156,14 @@
 	status = "disabled";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
 	/* USB VBUS is always on */
 	status = "okay";
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 };
-- 
2.11.0
