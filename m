From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  5 Nov 2014 20:02:00 +0100
Subject: [PATCH 2/3] mvebu: 370 RD: Add support for the switch
In-Reply-To: <1415214121-29286-1-git-send-email-andrew@lunn.ch>
References: <1415214121-29286-1-git-send-email-andrew@lunn.ch>
Message-ID: <1415214121-29286-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 370 rd has a 7 port, mv88E6182 switch, connected to eth1.  Add a
fixed-link subnode to the ethernet device tree node, to force
gigabit/full duplex.  Add a dsa node, with describing the four used
ports. This requires adding an alias to the mdio node, so it can be
referenced as a phandle.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-370-rd.dts  | 49 ++++++++++++++++++++++++++++++++----
 arch/arm/boot/dts/armada-370-xp.dtsi |  2 +-
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index f57a8f841498..2bb671a778db 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -85,10 +85,6 @@
 				phy0: ethernet-phy at 0 {
 					reg = <0>;
 				};
-
-				phy1: ethernet-phy at 1 {
-					reg = <1>;
-				};
 			};
 
 			ethernet at 70000 {
@@ -100,8 +96,11 @@
 				pinctrl-0 = <&ge1_rgmii_pins>;
 				pinctrl-names = "default";
 				status = "okay";
-				phy = <&phy1>;
 				phy-mode = "rgmii-id";
+				fixed-link {
+					   speed = <1000>;
+					   full-duplex;
+				};
 			};
 
 			mvsdio at d4000 {
@@ -173,4 +172,44 @@
 			};
 		};
 	};
+
+	dsa at 0 {
+		compatible = "marvell,dsa";
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		dsa,ethernet = <&eth1>;
+		dsa,mii-bus = <&mdio>;
+
+		switch at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x10 0>;	/* MDIO address 16, switch 0 in tree */
+
+			port at 0 {
+				reg = <0>;
+				label = "lan0";
+			};
+
+			port at 1 {
+			       reg = <1>;
+			       label = "lan1";
+			};
+
+			port at 2 {
+			       reg = <2>;
+			       label = "lan2";
+			};
+
+			port at 3 {
+			       reg = <3>;
+			       label = "lan3";
+			};
+
+			port at 5 {
+			      reg = <5>;
+			      label = "cpu";
+			};
+		};
+	 };
  };
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 83286ec9702c..4d84ca981fe0 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -232,7 +232,7 @@
 				status = "disabled";
 			};
 
-			mdio {
+			mdio: mdio {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "marvell,orion-mdio";
-- 
2.1.3
