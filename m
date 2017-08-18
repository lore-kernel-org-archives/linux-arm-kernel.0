From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 18 Aug 2017 14:21:15 +0200
Subject: [PATCH v3 1/4] ARM: dts: sunxi: h3/h5: represent the mdio switch used
 by sun8i-h3-emac
In-Reply-To: <20170818122118.4925-1-clabbe.montjoie@gmail.com>
References: <20170818122118.4925-1-clabbe.montjoie@gmail.com>
Message-ID: <20170818122118.4925-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since dwmac-sun8i could use either an integrated PHY or an external PHY
(which could be at same MDIO address), we need to represent this selection
by a MDIO switch.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 4b599b5d26f6..74fdfcc9dfd3 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -417,14 +417,32 @@
 			#size-cells = <0>;
 			status = "disabled";
 
-			mdio: mdio {
+			mdio_parent: mdio {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				int_mii_phy: ethernet-phy at 1 {
-					compatible = "ethernet-phy-ieee802.3-c22";
+			};
+			mdio-mux {
+				compatible = "allwinner,sun8i-h3-mdio-switch";
+				mdio-parent-bus = <&mdio_parent>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				internal_mdio: mdio at 1 {
 					reg = <1>;
-					clocks = <&ccu CLK_BUS_EPHY>;
-					resets = <&ccu RST_BUS_EPHY>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					int_mii_phy: ethernet-phy at 1 {
+						compatible = "ethernet-phy-ieee802.3-c22";
+						reg = <1>;
+						clocks = <&ccu CLK_BUS_EPHY>;
+						resets = <&ccu RST_BUS_EPHY>;
+						phy-is-integrated;
+					};
+				};
+				mdio: mdio at 0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
 				};
 			};
 		};
-- 
2.13.0
