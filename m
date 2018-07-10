From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 10 Jul 2018 10:01:05 +0200
Subject: [PATCH v5 13/22] ARM: sun8i-a23-a33: Add SRAM controller node and C1
 SRAM region
In-Reply-To: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180710080114.31469-14-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

This adds a SRAM controller node for the A23 and A33, with support for
the C1 SRAM region that is shared between the Video Engine and the CPU.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 44f3cad3de75..ad2dd62205d6 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -124,6 +124,29 @@
 		#size-cells = <1>;
 		ranges;
 
+		system-control at 1c00000 {
+			compatible = "allwinner,sun8i-a23-system-control",
+				     "allwinner,sun4i-a10-system-control";
+			reg = <0x01c00000 0x30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_c: sram at 1d00000 {
+				compatible = "mmio-sram";
+				reg = <0x01d00000 0x80000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x01d00000 0x80000>;
+
+				ve_sram: sram-section at 0 {
+					compatible = "allwinner,sun8i-a23-sram-c1",
+						     "allwinner,sun4i-a10-sram-c1";
+					reg = <0x000000 0x80000>;
+				};
+			};
+		};
+
 		dma: dma-controller at 1c02000 {
 			compatible = "allwinner,sun8i-a23-dma";
 			reg = <0x01c02000 0x1000>;
-- 
2.17.1
