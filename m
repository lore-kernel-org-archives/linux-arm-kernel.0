From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:18 +0100
Subject: [PATCH 15/54] arm64: dts: renesas: ulcb-kf: enable USB2 PHY of
 channel 0
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <80785024767c03ff28861db0faf274fffb8d713a.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

This supports USB2 PHY channel #0 on ULCB Kingfisher board

The dedicated USB0_PWEN pin is used to control CN13 VBUS source from U43
power supply.
MAX3355 can also provide VBUS, hence it should be disabled via OTG_OFFVBUSn
node coming from gpio expander TCA9539.
Set MAX3355 enabled using OTG_EXTLPn node to be able to read OTG ID of
CN13.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 657ad1041965..48a2e8f48e3f 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -67,6 +67,20 @@
 			output-high;
 			line-name = "HUB rst";
 		};
+
+		otg_offvbusn {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "OTG OFFVBUSn";
+		};
+
+		otg_extlpn {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "OTG EXTLPn";
+		};
 	};
 
 	gpio_exp_75: gpio at 75 {
@@ -154,6 +168,11 @@
 		groups = "scif1_data_b", "scif1_ctrl";
 		function = "scif1";
 	};
+
+	usb0_pins: usb0 {
+		groups = "usb0";
+		function = "usb0";
+	};
 };
 
 &scif1 {
@@ -164,6 +183,13 @@
 	status = "okay";
 };
 
+&usb2_phy0 {
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &xhci0 {
 	status = "okay";
 };
-- 
2.11.0
