From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 10:22:21 -0800
Subject: [PATCH v3 5/8] ARM: dts: kirkwood-dir665: Utilize new DSA binding
In-Reply-To: <20170117182224.32212-1-f.fainelli@gmail.com>
References: <20170117182224.32212-1-f.fainelli@gmail.com>
Message-ID: <20170117182224.32212-6-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net: dsa:
Document new binding"). The legacy binding node is kept included, but is marked
disabled.

Tested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/kirkwood-dir665.dts | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-dir665.dts b/arch/arm/boot/dts/kirkwood-dir665.dts
index 41acbb6dd6ab..4d2b15d6244a 100644
--- a/arch/arm/boot/dts/kirkwood-dir665.dts
+++ b/arch/arm/boot/dts/kirkwood-dir665.dts
@@ -194,6 +194,8 @@
 	};
 
 	dsa {
+		status = "disabled";
+
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -241,6 +243,53 @@
 
 &mdio {
 	status = "okay";
+
+	switch at 0 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				label = "lan4";
+			};
+
+			port at 1 {
+			       reg = <1>;
+			       label = "lan3";
+			};
+
+			port at 2 {
+			       reg = <2>;
+			       label = "lan2";
+			};
+
+			port at 3 {
+			       reg = <3>;
+			       label = "lan1";
+			};
+
+			port at 4 {
+				reg = <4>;
+				label = "wan";
+			};
+
+			port at 6 {
+				reg = <6>;
+				label = "cpu";
+				ethernet = <&eth0port>;
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
 };
 
 /* eth0 is connected to a Marvell 88E6171 switch, without a PHY. So set
-- 
2.9.3
