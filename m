From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri,  7 Oct 2016 10:25:52 +0200
Subject: [PATCH v4 05/10] ARM: dts: sun8i-h3: add sun8i-emac ethernet driver
In-Reply-To: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1475828757-926-6-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun8i-emac is an ethernet MAC hardware that support 10/100/1000
speed.

This patch enable the sun8i-emac on the Allwinner H3 SoC Device-tree.
The SoC H3 have an internal PHY, so optionals syscon and ephy are set.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 1101d2f..d218154 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -446,6 +446,30 @@
 			status = "disabled";
 		};
 
+		emac: ethernet at 1c30000 {
+			compatible = "allwinner,sun8i-h3-emac";
+			syscon = <&syscon>;
+			reg = <0x01c30000 0x104>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ccu RST_BUS_EMAC>;
+			reset-names = "ahb";
+			clocks = <&ccu CLK_BUS_EMAC>;
+			clock-names = "ahb";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				int_mii_phy: ethernet-phy at 1 {
+					reg = <1>;
+					clocks = <&ccu CLK_BUS_EPHY>;
+					resets = <&ccu RST_BUS_EPHY>;
+				};
+			};
+		};
+
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
2.7.3
