From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  6 Jul 2016 08:33:52 +0800
Subject: [PATCH -next] ARM: dts: sun8i: Add NFC node to Allwinner A23/A33 SoC
Message-ID: <20160706003352.28194-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NAND Flash controller node definition to the A23/A33 SoC.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 7e05e09..270c38a 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -209,6 +209,14 @@
 					"apb2_uart3", "apb2_uart4";
 		};
 
+		nand_clk: clk at 01c20080 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20080 0x4>;
+			clocks = <&osc24M>, <&pll6 1>;
+			clock-output-names = "nand";
+		};
+
 		mmc0_clk: clk at 01c20088 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
@@ -265,6 +273,21 @@
 			#dma-cells = <1>;
 		};
 
+		nfc: nand at 01c03000 {
+			compatible = "allwinner,sun4i-a10-nand";
+			reg = <0x01c03000 0x1000>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ahb1_gates 13>, <&nand_clk>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 5>;
+			dma-names = "rxtx";
+			resets = <&ahb1_rst 13>;
+			reset-names = "ahb";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.9.0
