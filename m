From: jm@lentin.co.uk (Jamie Lentin)
Date: Sat, 16 Jul 2016 15:29:08 +0100
Subject: [PATCH v0 10/10] arm: orion5x: Configure Netgear WNR854T network port
 LEDs
In-Reply-To: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1468679348-10522-11-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default bootloader leaves the LEDs orange, and the 88E1121R driver
applies it's own inappropriate configuration. Configure as per manual,
i.e. orange = 100 / green = 1000 / blink = activity

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts | 45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
index a8e89d8..635b396 100644
--- a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
+++ b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
@@ -81,16 +81,19 @@
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
@@ -101,11 +104,13 @@
 			port at 5 {
 				reg = <5>;
 				label = "lan1";
+				phy-handle = <&lan1phy>;
 			};
 
 			port at 7 {
 				reg = <7>;
 				label = "lan2";
+				phy-handle = <&lan2phy>;
 			};
 		};
 	};
@@ -148,6 +153,46 @@
 
 &mdio {
 	status = "okay";
+
+	lan3phy: ethernet-phy at 0 {
+		/* Marvell 88E1121R (port 1) */
+		compatible = "ethernet-phy-id0141.0cb0",
+			     "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		marvell,reg-init = <3 16 0 0x1777 3 17 0 0x15>;
+	};
+
+	lan4phy: ethernet-phy at 1 {
+		/* Marvell 88E1121R (port 2) */
+		compatible = "ethernet-phy-id0141.0cb0",
+			     "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		marvell,reg-init = <3 16 0 0x1777 3 17 0 0x15>;
+	};
+
+	wanphy: ethernet-phy at 2 {
+		/* Marvell 88E1121R (port 1) */
+		compatible = "ethernet-phy-id0141.0cb0",
+			     "ethernet-phy-ieee802.3-c22";
+		reg = <2>;
+		marvell,reg-init = <3 16 0 0x1777 3 17 0 0x15>;
+	};
+
+	lan1phy: ethernet-phy at 5 {
+		/* Marvell 88E1112 */
+		compatible = "ethernet-phy-id0141.0cb0",
+			     "ethernet-phy-ieee802.3-c22";
+		reg = <5>;
+		marvell,reg-init = <3 16 0 0x1777 3 17 0 0x15>;
+	};
+
+	lan2phy: ethernet-phy at 7 {
+		/* Marvell 88E1112 */
+		compatible = "ethernet-phy-id0141.0cb0",
+			     "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+		marvell,reg-init = <3 16 0 0x1777 3 17 0 0x15>;
+	};
 };
 
 &eth {
-- 
2.8.1
