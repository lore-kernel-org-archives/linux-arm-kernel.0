From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 20 Nov 2018 14:53:09 +0800
Subject: [PATCH 1/3] arm64: dts: allwinner: h6: orangepi: Add board-wide 5V
 regulator
In-Reply-To: <20181120065311.30009-1-wens@csie.org>
References: <20181120065311.30009-1-wens@csie.org>
Message-ID: <20181120065311.30009-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orange Pi Lite 2 and Orange Pi One Plus share the same design for
their USB 2.0 ports. VBUS is directly tied to the board wide 5V rail,
which is also directly tied to the DC jack. There is no current limiting
in this design. This 5V rail also supplies the various inputs to the
PMIC.

This patch adds a board wide 5V regulator and sets it as the input to
the PMIC inputs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 0612c19cd994..f910d5eb9267 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -21,6 +21,15 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the DC jack */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
 
 &mmc0 {
@@ -43,6 +52,14 @@
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		x-powers,self-working-mode;
+		vina-supply = <&reg_vcc5v>;
+		vinb-supply = <&reg_vcc5v>;
+		vinc-supply = <&reg_vcc5v>;
+		vind-supply = <&reg_vcc5v>;
+		vine-supply = <&reg_vcc5v>;
+		aldoin-supply = <&reg_vcc5v>;
+		bldoin-supply = <&reg_vcc5v>;
+		cldoin-supply = <&reg_vcc5v>;
 
 		regulators {
 			reg_aldo1: aldo1 {
-- 
2.19.1
