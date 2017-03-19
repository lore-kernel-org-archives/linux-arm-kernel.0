From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 20 Mar 2017 00:31:17 +0800
Subject: [PATCH v4 7/8] ARM: sun8i: h2+: enable USB OTG for Orange Pi Zero
 board
In-Reply-To: <20170319163118.56301-1-icenowy@aosc.xyz>
References: <20170319163118.56301-1-icenowy@aosc.xyz>
Message-ID: <20170319163118.56301-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orange Pi Zero board features a USB OTG port, which has a ID pin, and
can be used to power up the board. However, even if the board is powered
via +5V pin in GPIO/expansion headers, the VBUS in the OTG port cannot
be powered up, thus it's impossible to use it in host mode with simple
OTG cables.

Add support for it in peripheral mode.

If someone really want to use it in host mode, the mode of PHY can be
switch via sysfs, then use a powered USB OTG cable or powered USB HUB to
power up external USB devices.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v3:
- Add "h3:" in commit message.

 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 96c32293598a..9e8b082c134f 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -95,6 +95,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -131,6 +135,10 @@
 	bias-pull-up;
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
@@ -153,7 +161,17 @@
 	status = "disabled";
 };
 
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &usbphy {
-	/* USB VBUS is always on */
+	/*
+	 * USB Type-A port VBUS is always on. However, MicroUSB VBUS can only
+	 * power up the board; when it's used as OTG port, this VBUS is
+	 * always off even if the board is powered via GPIO pins.
+	 */
 	status = "okay";
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
 };
-- 
2.12.0
