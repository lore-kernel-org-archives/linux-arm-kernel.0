From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Sep 2015 08:19:53 -0700
Subject: [PATCH] ARM: dts: Fix dm814x control base to properly initialize
 Ethernet PHY
Message-ID: <1442243993-30056-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like I made a typo on the control base, all the 81xx
SoCs have it at 0x48140000 base. We've just gotten away with
the typo as the Ethernet phy was configured by the bootloader
on my test system and we're not yet using the pinctrl.

In addition to fixing the contol base, we need to also use the
right Ethernet phy flags to initialize it. And we are still
missing the PLL driver for dm814x and only relying on the
divider and mux clocks.

Fixes: f3d953ea3721 ("ARM: dts: Add minimal dm814x support")
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm8148-evm.dts  | 4 ++--
 arch/arm/boot/dts/dm8148-t410.dts | 4 ++--
 arch/arm/boot/dts/dm814x.dtsi     | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -19,10 +19,10 @@
 
 &cpsw_emac0 {
 	phy_id = <&davinci_mdio>, <0>;
-	phy-mode = "mii";
+	phy-mode = "rgmii";
 };
 
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
-	phy-mode = "mii";
+	phy-mode = "rgmii";
 };
--- a/arch/arm/boot/dts/dm8148-t410.dts
+++ b/arch/arm/boot/dts/dm8148-t410.dts
@@ -19,10 +19,10 @@
 
 &cpsw_emac0 {
 	phy_id = <&davinci_mdio>, <0>;
-	phy-mode = "mii";
+	phy-mode = "rgmii";
 };
 
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
-	phy-mode = "mii";
+	phy-mode = "rgmii";
 };
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -181,9 +181,9 @@
 				ti,hwmods = "timer3";
 			};
 
-			control: control at 160000 {
+			control: control at 140000 {
 				compatible = "ti,dm814-scm", "simple-bus";
-				reg = <0x160000 0x16d000>;
+				reg = <0x140000 0x16d000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0 0x160000 0x16d000>;
@@ -321,9 +321,9 @@
 				mac-address = [ 00 00 00 00 00 00 ];
 			};
 
-			phy_sel: cpsw-phy-sel at 0x48160650 {
+			phy_sel: cpsw-phy-sel at 48140650 {
 				compatible = "ti,am3352-cpsw-phy-sel";
-				reg= <0x48160650 0x4>;
+				reg= <0x48140650 0x4>;
 				reg-names = "gmii-sel";
 			};
 		};
-- 
2.1.4
