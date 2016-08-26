From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Aug 2016 10:21:04 +0100
Subject: [PATCH 8/8] arm: orion5x: Configure WNR854T ethernet PHY LEDs
In-Reply-To: <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1472203264-21089-9-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default PHY configuration disables most of the LEDs. The following
configures the ethernet activity LEDs as Netgear intended.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
Andrew, note that the slave mdio bus is called "mdio", however there is
an example in bindings/net/dsa/dsa.txt using "mdio-bus". Is this a
mismatch to fix?

That said there's no formal definition of either node, and there's at
least one DT (vf610-zii-dev-rev-b.dts) that uses "mdio" already merged.
---
 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
index 402a364..2a35a04 100644
--- a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
+++ b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
@@ -136,31 +136,82 @@
 			port at 0 {
 				reg = <0>;
 				label = "lan3";
+				phy-handle = <&lan3phy>;
 			};
 
 			port at 1 {
 				reg = <1>;
 				label = "lan4";
+				phy-handle = <&lan4phy>;
 			};
 
 			port at 2 {
 				reg = <2>;
 				label = "wan";
+				phy-handle = <&wanphy>;
 			};
 
 			port at 3 {
 				reg = <3>;
 				label = "cpu";
+				ethernet = <&ethport>;
 			};
 
 			port at 5 {
 				reg = <5>;
 				label = "lan1";
+				phy-handle = <&lan1phy>;
 			};
 
 			port at 7 {
 				reg = <7>;
 				label = "lan2";
+				phy-handle = <&lan2phy>;
+			};
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lan3phy: ethernet-phy at 0 {
+				/* Marvell 88E1121R (port 1) */
+				compatible = "ethernet-phy-id0141.0cb0",
+					     "ethernet-phy-ieee802.3-c22";
+				reg = <0>;
+				marvell,reg-init = <3 16 0 0x1777 3 17 0 0x15>;
+			};
+
+			lan4phy: ethernet-phy at 1 {
+				/* Marvell 88E1121R (port 2) */
+				compatible = "ethernet-phy-id0141.0cb0",
+					     "ethernet-phy-ieee802.3-c22";
+				reg = <1>;
+				marvell,reg-init = <3 16 0 0x1777 3 17 0 0x15>;
+			};
+
+			wanphy: ethernet-phy at 2 {
+				/* Marvell 88E1121R (port 1) */
+				compatible = "ethernet-phy-id0141.0cb0",
+					     "ethernet-phy-ieee802.3-c22";
+				reg = <2>;
+				marvell,reg-init = <3 16 0 0x1777 3 17 0 0x15>;
+			};
+
+			lan1phy: ethernet-phy at 5 {
+				/* Marvell 88E1112 */
+				compatible = "ethernet-phy-id0141.0cb0",
+					     "ethernet-phy-ieee802.3-c22";
+				reg = <5>;
+				marvell,reg-init = <3 16 0 0x1777 3 17 0 0x15>;
+			};
+
+			lan2phy: ethernet-phy at 7 {
+				/* Marvell 88E1112 */
+				compatible = "ethernet-phy-id0141.0cb0",
+					     "ethernet-phy-ieee802.3-c22";
+				reg = <7>;
+				marvell,reg-init = <3 16 0 0x1777 3 17 0 0x15>;
 			};
 		};
 	};
-- 
2.8.1
