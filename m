From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 21 Mar 2016 17:10:40 +0100
Subject: [linux-sunxi][PATCH v2 3/5] ARM: dts: sunxi: Add the SPDIF to the A10
 and A20
In-Reply-To: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
References: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
Message-ID: <1458576642-4078-4-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF transceiver controller and clock to the A10 and
A20 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 0483640..be5f2b2 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -477,6 +477,17 @@
 			clock-output-names = "ir1";
 		};
 
+		spdif_clk: clk at 01c200c0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200c0 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "spdif";
+		};
+
 		usb_clk: clk at 01c200cc {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -1055,6 +1066,19 @@
 			status = "disabled";
 		};
 
+		spdif: spdif at 01c21000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun4i-a10-spdif";
+			reg = <0x01c21000 0x400>;
+			interrupts = <13>;
+			clocks = <&apb0_gates 1>, <&spdif_clk>;
+			clock-names = "apb", "spdif";
+			dmas = <&dma SUN4I_DMA_NORMAL 2>,
+			       <&dma SUN4I_DMA_NORMAL 2>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		ir0: ir at 01c21800 {
 			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&apb0_gates 6>, <&ir0_clk>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 7264d5e..ebce332 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -476,6 +476,17 @@
 			clock-output-names = "ir1";
 		};
 
+		spdif_clk: clk at 01c200c0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200c0 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "spdif";
+		};
+
 		keypad_clk: clk at 01c200c4 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -1247,6 +1258,19 @@
 			status = "disabled";
 		};
 
+		spdif: spdif at 01c21000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun4i-a10-spdif";
+			reg = <0x01c21000 0x400>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 1>, <&spdif_clk>;
+			clock-names = "apb", "spdif";
+			dmas = <&dma SUN4I_DMA_NORMAL 2>,
+			       <&dma SUN4I_DMA_NORMAL 2>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		ir0: ir at 01c21800 {
 			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&apb0_gates 6>, <&ir0_clk>;
-- 
2.7.4
