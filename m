From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu,  9 Nov 2017 09:29:49 +0100
Subject: [PATCH v2 1/2] ARM: sun8i: a83t: add dwmac-sun8i device node
In-Reply-To: <20171109082950.21124-1-clabbe.montjoie@gmail.com>
References: <20171109082950.21124-1-clabbe.montjoie@gmail.com>
Message-ID: <20171109082950.21124-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i is an ethernet MAC hardware that support 10/100/1000 speed.
This patch add support for it on the Allwinner a83t SoC Device-tree.

This patch add the emac device node and the related RGMII pins node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 19acae1b4089..a384b766f3dc 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -336,6 +336,18 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			emac_rgmii_pins: emac-rgmii-pins {
+				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+				       "PD11", "PD12", "PD13", "PD14", "PD18",
+				       "PD19", "PD21", "PD22", "PD23";
+				function = "gmac";
+				/*
+				 * data lines in RGMII mode use DDR mode
+				 * and need a higher signal drive strength
+				 */
+				drive-strength = <40>;
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
@@ -440,6 +452,27 @@
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
