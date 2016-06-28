From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 27 Jun 2016 17:45:56 -0700
Subject: [PATCH v3] ARM: dts: sun7i: Add BCM53125 switch nodes to the
 lamobo-r1 board
Message-ID: <1467074756-8402-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a proper binding for Ethernet switches hanging off
different buses, and a driver for the BCM53125 switch, add its Device
Tree as a child MDIO node, at MDIO address 30 (Broadcom pseudo-PHY
address) and describe the ports layout of the Lamobo R1 board.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts | 60 +++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 5ee43d8bf174..fbca93406e1b 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -110,13 +110,67 @@
 &gmac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_pins_rgmii_a>;
-	phy = <&phy1>;
 	phy-mode = "rgmii";
 	phy-supply = <&reg_gmac_3v3>;
 	status = "okay";
 
-	phy1: ethernet-phy at 1 {
-		reg = <1>;
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch: ethernet-switch at 1e {
+			compatible = "brcm,bcm53125";
+			reg = <30>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port0: port at 0 {
+					reg = <0>;
+					label = "lan2";
+				};
+
+				port1: port at 1 {
+					reg = <1>;
+					label = "lan3";
+				};
+
+				port2: port at 2 {
+					reg = <2>;
+					label = "lan4";
+				};
+
+				port3: port at 3 {
+					reg = <3>;
+					label = "wan";
+				};
+
+				port4: port at 4 {
+					reg = <4>;
+					label = "lan1";
+				};
+
+				port8: port at 8 {
+					reg = <8>;
+					label = "cpu";
+					ethernet = <&gmac>;
+					phy-mode = "rgmii";
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+			};
+		};
 	};
 };
 
-- 
2.7.4
