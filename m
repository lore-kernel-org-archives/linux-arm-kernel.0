From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 21 Dec 2016 11:20:47 +0100
Subject: [PATCH] ARM: dts: turris-omnia: add support for ethernet switch
Message-ID: <20161221102047.28036-1-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Turris Omnia features a Marvell MV88E7176 ethernet switch. Add it to
the dts.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
Hello,

when the MAC is operated in rgmii mode and the switch in rgmii-id
communication between them works fine. The other way round it doesn't work.
The fixed-link nodes in the cpu port description is necessary to let the
mv88e6xxx driver use the phy-mode description. Is this a bug?

Regarding the binding, I think the label in the port nodes is strange.

	label = "lan2"

for an external port is fine. But

	label = "cpu"

for a port facing a CPU MAC looks wrong, still more as the Turris Omnia has
two ports connected to the SoC and so there are two ports with the same
label. I would suggest to use a separate property for that, e.g.

	cpu-port;

and no label.

Best regards
Uwe

 arch/arm/boot/dts/armada-385-turris-omnia.dts | 101 +++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index ab49acb2d452..6722d3243f9b 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -122,7 +122,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&ge0_rgmii_pins>;
 	status = "okay";
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii";
 
 	fixed-link {
 		speed = <1000>;
@@ -135,7 +135,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&ge1_rgmii_pins>;
 	status = "okay";
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii";
 
 	fixed-link {
 		speed = <1000>;
@@ -274,6 +274,103 @@
 	};
 
 	/* Switch MV88E7176 at address 0x10 */
+	switch at 10 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dsa,member = <0 0>;
+
+		reg = <0x10>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ports at 0 {
+				reg = <0>;
+				label = "lan0";
+				phy-handle = <&lan0phy>;
+			};
+
+			ports at 1 {
+				reg = <1>;
+				label = "lan1";
+				phy-handle = <&lan1phy>;
+			};
+
+			ports at 2 {
+				reg = <2>;
+				label = "lan2";
+				phy-handle = <&lan2phy>;
+			};
+
+			ports at 3 {
+				reg = <3>;
+				label = "lan3";
+				phy-handle = <&lan3phy>;
+			};
+
+			ports at 4 {
+				reg = <4>;
+				label = "lan4";
+				phy-handle = <&lan4phy>;
+			};
+
+			ports at 5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&eth1>;
+				phy-mode = "rgmii-id";
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			ports at 6 {
+				reg = <6>;
+				label = "cpu";
+				ethernet = <&eth0>;
+				phy-mode = "rgmii-id";
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lan0phy: ethernet-phy at 0 {
+				compatible = "ethernet-phy-ieee802.3-c22";
+				reg = <0>;
+			};
+
+			lan1phy: ethernet-phy at 1 {
+				compatible = "ethernet-phy-ieee802.3-c22";
+				reg = <1>;
+			};
+
+			lan2phy: ethernet-phy at 2 {
+				compatible = "ethernet-phy-ieee802.3-c22";
+				reg = <2>;
+			};
+
+			lan3phy: ethernet-phy at 3 {
+				compatible = "ethernet-phy-ieee802.3-c22";
+				reg = <3>;
+			};
+
+			lan4phy: ethernet-phy at 4 {
+				compatible = "ethernet-phy-ieee802.3-c22";
+				reg = <4>;
+			};
+		};
+	};
 };
 
 &pinctrl {
-- 
2.11.0
