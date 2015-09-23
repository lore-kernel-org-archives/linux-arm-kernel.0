From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 23 Sep 2015 12:34:39 +0800
Subject: [PATCH] ARM: dts: sun8i-a33: Add security system crypto engine clock
 and device nodes
Message-ID: <1442982879-6823-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A33 has the same "Security System" crypto engine as A10/A20, but with a
separate reset control.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 3457edb3bf50..001d8402ca18 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -99,6 +99,14 @@
 					"ahb1_sat";
 		};
 
+		ss_clk: clk at 01c2009c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c2009c 0x4>;
+			clocks = <&osc24M>, <&pll6 0>;
+			clock-output-names = "ss";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun8i-a23-mbus-clk";
@@ -109,6 +117,16 @@
 	};
 
 	soc at 01c00000 {
+		crypto: crypto-engine at 01c15000 {
+			compatible = "allwinner,sun4i-a10-crypto";
+			reg = <0x01c15000 0x1000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ahb1_gates 5>, <&ss_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 5>;
+			reset-names = "ahb";
+		};
+
 		usb_otg: usb at 01c19000 {
 			compatible = "allwinner,sun8i-a33-musb";
 			reg = <0x01c19000 0x0400>;
-- 
2.5.3
