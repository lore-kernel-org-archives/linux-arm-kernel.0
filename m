From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  3 Feb 2018 02:04:55 +0800
Subject: [PATCH 2/3] ARM: sun8i: v3s: add V3s EMAC device tree node
In-Reply-To: <20180202180456.60378-1-icenowy@aosc.io>
References: <20180202180456.60378-1-icenowy@aosc.io>
Message-ID: <20180202180456.60378-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The V3/V3s EMAC is just similar to the one in H3 SoC, but as the package
of V3s is pin-limited, the external MII/MDIO bus is not wired out.

Add V3s EMAC device tree node. As V3s is only capable of using the
internal PHY, it's hardcoded in the V3s DTSI file.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 443b083c6adc..4d49a8b22a1c 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -141,6 +141,12 @@
 			};
 		};
 
+		syscon: syscon at 1c00000 {
+			compatible = "allwinner,sun8i-v3-system-controller",
+				"syscon";
+			reg = <0x01c00000 0x1000>;
+		};
+
 		tcon0: lcd-controller at 1c0c000 {
 			compatible = "allwinner,sun8i-v3s-tcon";
 			reg = <0x01c0c000 0x1000>;
@@ -402,6 +408,55 @@
 			#size-cells = <0>;
 		};
 
+		emac: ethernet at 1c30000 {
+			compatible = "allwinner,sun8i-v3-emac";
+			syscon = <&syscon>;
+			reg = <0x01c30000 0x10000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&ccu RST_BUS_EMAC>;
+			reset-names = "stmmaceth";
+			clocks = <&ccu CLK_BUS_EMAC>;
+			clock-names = "stmmaceth";
+			phy-handle = <&int_mii_phy>;
+			phy-mode = "mii";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+			};
+
+			mdio-mux {
+				compatible = "allwinner,sun8i-v3-mdio-mux",
+					     "allwinner,sun8i-h3-mdio-mux";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mdio-parent-bus = <&mdio>;
+
+				internal_mdio: mdio at 1 {
+					compatible = "allwinner,sun8i-v3-mdio-internal",
+						     "allwinner,sun8i-h3-mdio-internal";
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					int_mii_phy: ethernet-phy at 1 {
+						compatible = "ethernet-phy-ieee802.3-c22";
+						reg = <1>;
+						clocks = <&ccu CLK_BUS_EPHY>;
+						resets = <&ccu RST_BUS_EPHY>;
+					};
+				};
+
+				/* V3s has no external MDIO bus, but V3 has it */
+			};
+		};
+
 		spi0: spi at 1c68000 {
 			compatible = "allwinner,sun8i-h3-spi";
 			reg = <0x01c68000 0x1000>;
-- 
2.15.1
