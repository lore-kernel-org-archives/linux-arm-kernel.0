From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Feb 2017 19:49:44 +0100
Subject: [PATCH 8/9] ARM: sun5i: r8: Merge common controllers into the common
 DTSI
In-Reply-To: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <8008c3ca3c8451e4f961477ef5c0f4769c65538c.1486320544.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers found in the R8 DTSI actually apply to all of the sun5i
family. Move those into the common DTSI so that all SoCs can benefit from
it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8.dtsi | 40 +----------------------------------
 arch/arm/boot/dts/sun5i.dtsi    | 23 ++++++++++++++++++++-
 2 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-r8.dtsi b/arch/arm/boot/dts/sun5i-r8.dtsi
index 4c1141396c99..de35dbcd1191 100644
--- a/arch/arm/boot/dts/sun5i-r8.dtsi
+++ b/arch/arm/boot/dts/sun5i-r8.dtsi
@@ -45,43 +45,3 @@
 
 #include "sun5i-a13.dtsi"
 
-/ {
-	chosen {
-		framebuffer at 1 {
-			compatible = "allwinner,simple-framebuffer",
-				     "simple-framebuffer";
-			allwinner,pipeline = "de_be0-lcd0-tve0";
-			clocks = <&ccu CLK_AHB_TVE>, <&ccu CLK_AHB_LCD>,
-				 <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DE_BE>,
-				 <&ccu CLK_TCON_CH1>, <&ccu CLK_DRAM_DE_BE>;
-			status = "disabled";
-		};
-	};
-
-	soc at 01c00000 {
-		tve0: tv-encoder at 01c0a000 {
-			compatible = "allwinner,sun4i-a10-tv-encoder";
-			reg = <0x01c0a000 0x1000>;
-			clocks = <&ccu CLK_AHB_TVE>;
-			resets = <&ccu RST_TVE>;
-			status = "disabled";
-
-			port {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				tve0_in_tcon0: endpoint at 0 {
-					reg = <0>;
-					remote-endpoint = <&tcon0_out_tve0>;
-				};
-			};
-		};
-	};
-};
-
-&tcon0_out {
-	tcon0_out_tve0: endpoint at 1 {
-		reg = <1>;
-		remote-endpoint = <&tve0_in_tcon0>;
-	};
-};
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 9ba0c0302183..c8e2253cac1d 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -187,6 +187,24 @@
 			#size-cells = <0>;
 		};
 
+		tve0: tv-encoder at 01c0a000 {
+			compatible = "allwinner,sun4i-a10-tv-encoder";
+			reg = <0x01c0a000 0x1000>;
+			clocks = <&ccu CLK_AHB_TVE>;
+			resets = <&ccu RST_TVE>;
+			status = "disabled";
+
+			port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tve0_in_tcon0: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&tcon0_out_tve0>;
+				};
+			};
+		};
+
 		emac: ethernet at 01c0b000 {
 			compatible = "allwinner,sun4i-a10-emac";
 			reg = <0x01c0b000 0x1000>;
@@ -238,6 +256,11 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <1>;
+
+					tcon0_out_tve0: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&tve0_in_tcon0>;
+					};
 				};
 			};
 		};
-- 
git-series 0.8.11
