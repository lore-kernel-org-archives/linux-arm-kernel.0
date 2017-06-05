From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  5 Jun 2017 21:21:30 +0200
Subject: [PATCH 5/5] ARM: sun8i: a83t: add dwmac-sun8i ethernet driver
In-Reply-To: <20170605192130.25320-1-clabbe.montjoie@gmail.com>
References: <20170605192130.25320-1-clabbe.montjoie@gmail.com>
Message-ID: <20170605192130.25320-6-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i is an ethernet MAC hardware that support 10/100/1000 speed.
This patch enable the dwmac-sun8i on the Allwinner a83t SoC Device-tree.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index ae559dc42caa..304a966c8048 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -200,6 +200,14 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			emac_rgmii_pins: emac0-pins {
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
@@ -266,6 +274,26 @@
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
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
2.13.0
