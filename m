From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 3 Aug 2015 14:11:58 -0400
Subject: [PATCH 2/2] ARM: dts: keystone: Fix the mdio bindings by moving it to
 soc specific file
In-Reply-To: <1438625518-21315-1-git-send-email-m-karicheri2@ti.com>
References: <1438625518-21315-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1438625518-21315-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently mdio bindings are defined in keystone.dtsi and this results
in incorrect unit address for the node on K2E and K2L SoCs. Fix this
by moving them to SoC specific DTS file.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/k2e.dtsi      | 15 +++++++++++----
 arch/arm/boot/dts/k2hk.dtsi     | 11 +++++++++++
 arch/arm/boot/dts/k2l.dtsi      | 16 +++++++++++-----
 arch/arm/boot/dts/keystone.dtsi | 11 -----------
 4 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
index 1b6494f..675fb8e 100644
--- a/arch/arm/boot/dts/k2e.dtsi
+++ b/arch/arm/boot/dts/k2e.dtsi
@@ -131,10 +131,17 @@
 					<GIC_SPI 376 IRQ_TYPE_EDGE_RISING>;
 			};
 		};
+
+		mdio: mdio at 24200f00 {
+			compatible	= "ti,keystone_mdio", "ti,davinci_mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x24200f00 0x100>;
+			status = "disabled";
+			clocks = <&clkcpgmac>;
+			clock-names = "fck";
+			bus_freq	= <2500000>;
+		};
 		/include/ "k2e-netcp.dtsi"
 	};
 };
-
-&mdio {
-	reg = <0x24200f00 0x100>;
-};
diff --git a/arch/arm/boot/dts/k2hk.dtsi b/arch/arm/boot/dts/k2hk.dtsi
index ae64724..d0810a5 100644
--- a/arch/arm/boot/dts/k2hk.dtsi
+++ b/arch/arm/boot/dts/k2hk.dtsi
@@ -98,6 +98,17 @@
 			#gpio-cells = <2>;
 			gpio,syscon-dev = <&devctrl 0x25c>;
 		};
+
+		mdio: mdio at 02090300 {
+			compatible	= "ti,keystone_mdio", "ti,davinci_mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x02090300 0x100>;
+			status = "disabled";
+			clocks = <&clkcpgmac>;
+			clock-names = "fck";
+			bus_freq	= <2500000>;
+		};
 		/include/ "k2hk-netcp.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/k2l.dtsi b/arch/arm/boot/dts/k2l.dtsi
index 0e00748..49fd414 100644
--- a/arch/arm/boot/dts/k2l.dtsi
+++ b/arch/arm/boot/dts/k2l.dtsi
@@ -29,7 +29,6 @@
 	};
 
 	soc {
-
 		/include/ "k2l-clocks.dtsi"
 
 		uart2: serial at 02348400 {
@@ -79,6 +78,17 @@
 			#gpio-cells = <2>;
 			gpio,syscon-dev = <&devctrl 0x24c>;
 		};
+
+		mdio: mdio at 26200f00 {
+			compatible	= "ti,keystone_mdio", "ti,davinci_mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x26200f00 0x100>;
+			status = "disabled";
+			clocks = <&clkcpgmac>;
+			clock-names = "fck";
+			bus_freq	= <2500000>;
+		};
 		/include/ "k2l-netcp.dtsi"
 	};
 };
@@ -96,7 +106,3 @@
        /* Pin muxed. Enabled and configured by Bootloader */
        status = "disabled";
 };
-
-&mdio {
-	reg = <0x26200f00 0x100>;
-};
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 6245a17..72816d6 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -267,17 +267,6 @@
 				  1 0 0x21000A00 0x00000100>;
 		};
 
-		mdio: mdio at 02090300 {
-			compatible	= "ti,keystone_mdio", "ti,davinci_mdio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg		= <0x02090300 0x100>;
-			status = "disabled";
-			clocks = <&clkcpgmac>;
-			clock-names = "fck";
-			bus_freq	= <2500000>;
-		};
-
 		kirq0: keystone_irq at 26202a0 {
 			compatible = "ti,keystone-irq";
 			interrupts = <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>;
-- 
1.9.1
