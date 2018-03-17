From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 Mar 2018 17:28:56 +0800
Subject: [PATCH net-next 11/12] ARM: dts: sun8i: r40: Add device node and
 RGMII pinmux node for GMAC
In-Reply-To: <20180317092857.4396-1-wens@csie.org>
References: <20180317092857.4396-1-wens@csie.org>
Message-ID: <20180317092857.4396-12-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R40 SoC has a GMAC (gigabit capable Ethernet controller). Add a
device node for it. The only publicly available board for this SoC
uses an RGMII PHY. Add a pinmux node for it as well.

Since this SoC also has an old 10/100 Mbps EMAC, which also has an
MDIO bus controller, the MDIO bus for the GMAC is labeled "gmac_mdio".

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 173dcc1652d2..bd97ca3dc2fa 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -265,6 +265,19 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			gmac_rgmii_pins: gmac-rgmii-pins {
+				pins = "PA0", "PA1", "PA2", "PA3",
+				       "PA4", "PA5", "PA6", "PA7",
+				       "PA8", "PA10", "PA11", "PA12",
+				       "PA13", "PA15", "PA16";
+				function = "gmac";
+				/*
+				 * data lines in RGMII mode use DDR mode
+				 * and need a higher signal drive strength
+				 */
+				drive-strength = <40>;
+			};
+
 			i2c0_pins: i2c0-pins {
 				pins = "PB0", "PB1";
 				function = "i2c0";
@@ -451,6 +464,27 @@
 			#size-cells = <0>;
 		};
 
+		gmac: ethernet at 1c50000 {
+			compatible = "allwinner,sun8i-r40-gmac";
+			syscon = <&ccu>;
+			reg = <0x01c50000 0x10000>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&ccu RST_BUS_GMAC>;
+			reset-names = "stmmaceth";
+			clocks = <&ccu CLK_BUS_GMAC>;
+			clock-names = "stmmaceth";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			gmac_mdio: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
-- 
2.16.2
