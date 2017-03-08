From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  8 Mar 2017 03:50:13 +0100
Subject: [PATCH 2/2] ARM: dts: vf610-zii-dev-c: Wire up PHY interrupts
In-Reply-To: <1488941413-8112-1-git-send-email-andrew@lunn.ch>
References: <1488941413-8112-1-git-send-email-andrew@lunn.ch>
Message-ID: <1488941413-8112-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHYs embedded in the switch direct there interrupts through the
switch interrupt controllers. Now that devel C has its switch
interrupts connected to the SoC, the PHY interrupts can be used by
phylib. Explicitly include MDIO nodes in the switch device tree nodes,
and link the PHY interrupts back to the switch interrupt
controller. Also, link the ports to the PHYs on the MDIO bus.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 65 +++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index 352ecec64bb7..db3b408ea55a 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -97,21 +97,25 @@
 					port at 1 {
 						reg = <1>;
 						label = "lan1";
+						phy-handle = <&switch0phy1>;
 					};
 
 					port at 2 {
 						reg = <2>;
 						label = "lan2";
+						phy-handle = <&switch0phy2>;
 					};
 
 					port at 3 {
 						reg = <3>;
 						label = "lan3";
+						phy-handle = <&switch0phy3>;
 					};
 
 					port at 4 {
 						reg = <4>;
 						label = "lan4";
+						phy-handle = <&switch0phy4>;
 					};
 
 					switch0port10: port at 10 {
@@ -121,6 +125,35 @@
 						link = <&switch1port10>;
 					};
 				};
+
+				mdio {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					switch0phy1: switch0phy at 1 {
+						reg = <1>;
+						interrupt-parent = <&switch0>;
+						interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+					};
+
+					switch0phy2: switch0phy at 2 {
+						reg = <2>;
+						interrupt-parent = <&switch0>;
+						interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+					};
+
+					switch0phy3: switch0phy at 3 {
+						reg = <3>;
+						interrupt-parent = <&switch0>;
+						interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+					};
+
+					switch0phy4: switch0phy at 4 {
+						reg = <4>;
+						interrupt-parent = <&switch0>;
+						interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+					};
+				};
 			};
 		};
 
@@ -150,21 +183,25 @@
 					port at 1 {
 						reg = <1>;
 						label = "lan5";
+						phy-handle = <&switch1phy1>;
 					};
 
 					port at 2 {
 						reg = <2>;
 						label = "lan6";
+						phy-handle = <&switch1phy2>;
 					};
 
 					port at 3 {
 						reg = <3>;
 						label = "lan7";
+						phy-handle = <&switch1phy3>;
 					};
 
 					port at 4 {
 						reg = <4>;
 						label = "lan8";
+						phy-handle = <&switch1phy4>;
 					};
 
 
@@ -175,6 +212,34 @@
 						link = <&switch0port10>;
 					};
 				};
+				mdio {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					switch1phy1: switch1phy at 1 {
+						reg = <1>;
+						interrupt-parent = <&switch1>;
+						interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+					};
+
+					switch1phy2: switch1phy at 2 {
+						reg = <2>;
+						interrupt-parent = <&switch1>;
+						interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+					};
+
+					switch1phy3: switch1phy at 3 {
+						reg = <3>;
+						interrupt-parent = <&switch1>;
+						interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+					};
+
+					switch1phy4: switch1phy at 4 {
+						reg = <4>;
+						interrupt-parent = <&switch1>;
+						interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+					};
+				};
 			};
 		};
 
-- 
2.11.0
