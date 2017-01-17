From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 10:22:18 -0800
Subject: [PATCH v3 2/8] ARM: dts: armada-385-linksys: Utilize new DSA binding
In-Reply-To: <20170117182224.32212-1-f.fainelli@gmail.com>
References: <20170117182224.32212-1-f.fainelli@gmail.com>
Message-ID: <20170117182224.32212-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net: dsa:
Document new binding"). The legacy binding node is kept included, but is marked
disabled.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/armada-385-linksys.dtsi | 52 ++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 8f0e508f64ae..20d5e8b00f2d 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -103,8 +103,56 @@
 				};
 			};
 
-			mdio {
+			mdio at 72004 {
 				status = "okay";
+
+				switch at 0 {
+					compatible = "marvell,mv88e6095";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						port at 0 {
+							reg = <0>;
+							label = "lan4";
+						};
+
+						port at 1 {
+							reg = <1>;
+							label = "lan3";
+						};
+
+						port at 2 {
+							reg = <2>;
+							label = "lan2";
+						};
+
+						port at 3 {
+							reg = <3>;
+							label = "lan1";
+						};
+
+						port at 4 {
+							reg = <4>;
+							label = "wan";
+						};
+
+						port at 5 {
+							reg = <5>;
+							label = "cpu";
+							ethernet = <&eth2>;
+
+							fixed-link {
+								speed = <1000>;
+								full-duplex;
+							};
+						};
+					};
+				};
 			};
 
 			sata at a8000 {
@@ -261,6 +309,8 @@
 	};
 
 	dsa at 0 {
+		status = "disabled";
+
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
-- 
2.9.3
