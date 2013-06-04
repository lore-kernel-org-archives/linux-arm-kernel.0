From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  4 Jun 2013 13:07:11 +0200
Subject: [PATCH 4/8] ARM i.MX53: mba53: add sound support
In-Reply-To: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1370344035-7417-5-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tqs.de>

Enable the sgtl5000 found on MBa53 mainboard.
Also enable audio muxer and ssi, which are needed for sound to work.

Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 2889bab..b171c00 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -42,6 +42,28 @@
 		interface-pix-fmt = "rgb24";
 		status = "disabled";
 	};
+
+	reg_3p2v: 3p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P2V";
+		regulator-min-microvolt = <3200000>;
+		regulator-max-microvolt = <3200000>;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "tq,imx53-mba53-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "imx53-mba53-sgtl5000";
+		ssi-controller = <&ssi2>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <2>;
+		mux-ext-port = <5>;
+	};
 };
 
 &ldb {
@@ -122,10 +144,19 @@
 	status = "okay";
 };
 
+&audmux {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux_1>;
+};
+
 &i2c2 {
 	codec: sgtl5000 at a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		clocks = <&clks 150>;
+		VDDA-supply = <&reg_3p2v>;
+		VDDIO-supply = <&reg_3p2v>;
 	};
 
 	expander: pca9554 at 20 {
@@ -169,6 +200,11 @@
 	status = "okay";
 };
 
+&ssi2 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
1.8.2.rc2
