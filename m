From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  1 May 2017 14:45:07 +0200
Subject: [PATCH v5 07/20] arm: sun8i: sunxi-h3-h5: add dwmac-sun8i ethernet
 driver
In-Reply-To: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
References: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
Message-ID: <20170501124520.3769-8-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i is an ethernet MAC hardware that support 10/100/1000
speed.

This patch enable the dwmac-sun8i on Allwinner H3/H5 SoC Device-tree.
SoC H3/H5 have an internal PHY, so optionals syscon and ephy are set.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index d9691fc..45a9a30 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -285,6 +285,14 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			emac_rgmii_pins: emac0 {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4",
+				       "PD5", "PD7", "PD8", "PD9", "PD10",
+				       "PD12", "PD13", "PD15", "PD16", "PD17";
+				function = "emac";
+				drive-strength = <40>;
+			};
+
 			i2c0_pins: i2c0 {
 				pins = "PA11", "PA12";
 				function = "i2c0";
@@ -381,6 +389,32 @@
 			clocks = <&osc24M>;
 		};
 
+		emac: ethernet at 1c30000 {
+			compatible = "allwinner,sun8i-h3-emac";
+			syscon = <&syscon>;
+			reg = <0x01c30000 0x104>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&ccu RST_BUS_EMAC>;
+			reset-names = "stmmaceth";
+			clocks = <&ccu CLK_BUS_EMAC>;
+			clock-names = "stmmaceth";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				int_mii_phy: ethernet-phy at 1 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <1>;
+					clocks = <&ccu CLK_BUS_EPHY>;
+					resets = <&ccu RST_BUS_EPHY>;
+				};
+			};
+		};
+
 		spi0: spi at 01c68000 {
 			compatible = "allwinner,sun8i-h3-spi";
 			reg = <0x01c68000 0x1000>;
-- 
2.10.2
