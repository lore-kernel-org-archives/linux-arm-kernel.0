From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon,  7 May 2018 14:44:53 +0200
Subject: [PATCH v3 07/14] ARM: sun8i-a33: Add SRAM controller node and C1 SRAM
 region
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180507124500.20434-8-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

This adds a SRAM controller node for the A33, with support for the C1
SRAM region that is shared between the Video Engine and the CPU.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index a21f2ed07a52..97a976b3b1ef 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -204,6 +204,28 @@
 	};
 
 	soc at 1c00000 {
+		sram-controller at 1c00000 {
+			compatible = "allwinner,sun8i-a33-sram-controller";
+			reg = <0x01c00000 0x30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_c: sram at 1d00000 {
+				compatible = "mmio-sram";
+				reg = <0x01d00000 0xd00000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x01d00000 0xd00000>;
+
+				ve_sram: sram-section at 0 {
+					compatible = "allwinner,sun8i-a33-sram-c1",
+						     "allwinner,sun4i-a10-sram-c1";
+					reg = <0x000000 0x80000>;
+				};
+			};
+		};
+
 		tcon0: lcd-controller at 1c0c000 {
 			compatible = "allwinner,sun8i-a33-tcon";
 			reg = <0x01c0c000 0x1000>;
-- 
2.16.3
