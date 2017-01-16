From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 17 Jan 2017 03:14:48 +0800
Subject: [PATCH 3/4] ARM: dts: sun8i: enable USB OTG for Orange Pi Zero board
In-Reply-To: <20170116191449.50397-1-icenowy@aosc.xyz>
References: <20170116191449.50397-1-icenowy@aosc.xyz>
Message-ID: <20170116191449.50397-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orange Pi Zero board features a USB OTG port, which has a ID pin, and
can be used to power up the borad. However, even if the board is powered
via +5V pin in GPIO/expansion headers, the VBUS in the OTG port cannot
be powered up, thus it's impossible to use it in host mode with simple
OTG cables.

Add support for it in peripheral mode.

If someone really want to use it in host mode, the dr_mode property of
&usb_otg can be changed into "otg", then a powered USB OTG cable or USB
HUB is needed for powering out the external USB devices.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index b7ca916d871d..437536e2b594 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -154,7 +154,13 @@
 	status = "disabled";
 };
 
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &usbphy {
 	/* USB VBUS is always on */
 	status = "okay";
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
 };
-- 
2.11.0
