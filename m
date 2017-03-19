From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 20 Mar 2017 00:31:16 +0800
Subject: [PATCH v4 6/8] ARM: sun8i: h3: enable USB OTG on Orange Pi One
In-Reply-To: <20170319163118.56301-1-icenowy@aosc.xyz>
References: <20170319163118.56301-1-icenowy@aosc.xyz>
Message-ID: <20170319163118.56301-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orange Pi One features a MicroUSB port that can work in both host mode
and peripheral mode.

When in host mode, its VBUS is controlled via a GPIO; when in peripheral
mode, its VBUS cannot be used to power up the board.

Add support for this port.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v3:
- Add "h3:" in commit message.

 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index ea8fd1325356..5fea430e0eb1 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -89,6 +89,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -103,6 +107,10 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
@@ -126,6 +134,11 @@
 	};
 };
 
+&reg_usb0_vbus {
+	gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
@@ -150,7 +163,14 @@
 	status = "disabled";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
-	/* USB VBUS is always on */
+	/* USB Type-A port's VBUS is always on */
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 	status = "okay";
 };
-- 
2.12.0
