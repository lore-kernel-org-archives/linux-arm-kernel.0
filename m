From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:36 +0200
Subject: [PATCH 074/102] arm64: dts: renesas: r8a7795: salvator-xs: enable
 usb2_phy3 node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <cd49f631dd7dc2dcd08a22c0f78197aa7970fe5d.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch enables usb2_phy3 node for r8a7795 with Salvator-XS.
You must change the SW31 to OFF-OFF-ON-ON-ON-ON on the board.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
index 83676684c6b4..622b2a22ab0f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
@@ -145,6 +145,23 @@
 		groups = "usb2";
 		function = "usb2";
 	};
+
+	/*
+	 * - On Salvator-X[S], GP6_3[01] are connected to ADV7482 as irq pins
+	 *   (when SW31 is the default setting on Salvator-XS).
+	 * - If SW31 is the default setting, you cannot use USB2.0 ch3 on
+	 *   r8a7795 with Salvator-XS.
+	 *   Hence the SW31 setting must be changed like 2) below.
+	 *   1) Default setting of SW31: ON-ON-OFF-OFF-OFF-OFF:
+	 *	- Connect GP6_3[01] to ADV7842.
+	 *   2) Changed setting of SW31: OFF-OFF-ON-ON-ON-ON:
+	 *	- Connect GP6_3[01] to BD082065 (USB2.0 ch3's host power).
+	 *	- Connect GP6_{04,21} to ADV7842.
+	 */
+	usb2_ch3_pins: usb2_ch3 {
+		groups = "usb2_ch3";
+		function = "usb2_ch3";
+	};
 };
 
 &usb2_phy2 {
@@ -153,3 +170,10 @@
 
 	status = "okay";
 };
+
+&usb2_phy3 {
+	pinctrl-0 = <&usb2_ch3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.11.0
