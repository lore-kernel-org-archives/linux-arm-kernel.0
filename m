From: k@japko.eu (Krzysztof Adamski)
Date: Tue, 5 Dec 2017 23:03:58 +0100
Subject: [PATCH v2] ARM: dts: sun8i: h3: enable USB OTG for NanoPi Neo board
In-Reply-To: <20171205090706.et5a7dizkhn6auje@flea.lan>
References: <20171205090706.et5a7dizkhn6auje@flea.lan>
Message-ID: <20171205220358.GA28161@t440.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similarly to Orange Pi Zero, NanoPi Neo board has an USB OTG port with
an ID pin but with unpowered VBUS. This patch enables this port in
forced peripheral mode.

ohci/ehci nodes are still enabled since the host mode may work if
external power source is used. In that case, the mode can be switched
for example via sysfs. The same strategy is used for Orange Pi Zero
board DTS.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---

Changes since version 1:
- nodes sorted alphabetically
- added explanation why enabling ohci/ehci still makes sense

 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
index 78f6c24952dd..9f33f6fae595 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
@@ -47,9 +47,26 @@
 	compatible = "friendlyarm,nanopi-neo", "allwinner,sun8i-h3";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &emac {
 	phy-handle = <&int_mii_phy>;
 	phy-mode = "mii";
 	allwinner,leds-active-low;
 	status = "okay";
 };
+
+&ohci0 {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+	dr_mode = "peripheral";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+};
-- 
2.13.6
