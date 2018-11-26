From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Sun, 25 Nov 2018 18:15:28 -0600
Subject: [PATCH linux-next 07/10] ARM: dts: am4372: switch to use phy-gmii-sel
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
Message-ID: <20181126001531.12974-8-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to use phy-gmii-sel PHY instead of cpsw-phy-sel.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/am437x-l4.dtsi     | 17 +++++++++--------
 arch/arm/boot/dts/am43x-epos-evm.dts |  5 +----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
index ff2c11e..121a71d 100644
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -280,12 +280,6 @@
 				#size-cells = <1>;
 				ranges = <0 0 0x4000>;
 
-				phy_sel: cpsw-phy-sel at 650 {
-					compatible = "ti,am43xx-cpsw-phy-sel";
-					reg= <0x650 0x4>;
-					reg-names = "gmii-sel";
-				};
-
 				am43xx_pinmux: pinmux at 800 {
 					compatible = "ti,am437-padconf",
 						     "pinctrl-single";
@@ -300,11 +294,17 @@
 				};
 
 				scm_conf: scm_conf at 0 {
-					compatible = "syscon";
+					compatible = "syscon", "simple-bus";
 					reg = <0x0 0x800>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 
+					phy_gmii_sel: phy-gmii-sel {
+						compatible = "ti,am43xx-phy-gmii-sel";
+						reg = <0x650 0x4>;
+						#phy-cells = <2>;
+					};
+
 					scm_clocks: clocks {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -555,7 +555,6 @@
 				cpts_clock_shift = <29>;
 				ranges = <0 0 0x8000>;
 				syscon = <&scm_conf>;
-				cpsw-phy-sel = <&phy_sel>;
 
 				davinci_mdio: mdio at 1000 {
 					compatible = "ti,am4372-mdio","ti,cpsw-mdio","ti,davinci_mdio";
@@ -572,11 +571,13 @@
 				cpsw_emac0: slave at 200 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 1 0>;
 				};
 
 				cpsw_emac1: slave at 300 {
 					/* Filled in by U-Boot */
 					mac-address = [ 00 00 00 00 00 00 ];
+					phys = <&phy_gmii_sel 2 0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 4ea753b..9dfd80e 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -584,10 +584,7 @@
 &cpsw_emac0 {
 	phy-handle = <&ethphy0>;
 	phy-mode = "rmii";
-};
-
-&phy_sel {
-	rmii-clock-ext;
+	phys = <&phy_gmii_sel 1 1>;
 };
 
 &i2c0 {
-- 
2.10.5
