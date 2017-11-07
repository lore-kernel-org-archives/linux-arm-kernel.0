From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue,  7 Nov 2017 21:13:25 +0100
Subject: [PATCH 1/2] ARM: sun8i: a83t: add dwmac-sun8i ethernet driver
Message-ID: <20171107201326.17401-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i is an ethernet MAC hardware that support 10/100/1000 speed.
This patch enable the dwmac-sun8i on the Allwinner a83t SoC Device-tree.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 19acae1b4089..68e5135410ec 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -336,6 +336,14 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			emac_rgmii_pins: emac-rgmii-pins {
+				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+				       "PD11", "PD12", "PD13", "PD14", "PD18",
+				       "PD19", "PD21", "PD22", "PD23";
+				function = "gmac";
+				drive-strength = <40>;
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
@@ -440,6 +448,27 @@
 			status = "disabled";
 		};
 
+		emac: ethernet at 1c30000 {
+			compatible = "allwinner,sun8i-a83t-emac";
+			syscon = <&syscon>;
+			reg = <0x01c30000 0x104>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&ccu 13>;
+			reset-names = "stmmaceth";
+			clocks = <&ccu 27>;
+			clock-names = "stmmaceth";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			mdio: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
2.13.6
