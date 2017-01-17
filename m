From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 10:22:22 -0800
Subject: [PATCH v3 6/8] ARM: dts: kirkwood-linksys-viper: Utilize new DSA
 binding
In-Reply-To: <20170117182224.32212-1-f.fainelli@gmail.com>
References: <20170117182224.32212-1-f.fainelli@gmail.com>
Message-ID: <20170117182224.32212-7-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net: dsa:
Document new binding"). The legacy binding node is kept included, but is marked
disabled.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/kirkwood-linksys-viper.dts | 49 ++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-linksys-viper.dts b/arch/arm/boot/dts/kirkwood-linksys-viper.dts
index 345fcac48dc7..df7851820507 100644
--- a/arch/arm/boot/dts/kirkwood-linksys-viper.dts
+++ b/arch/arm/boot/dts/kirkwood-linksys-viper.dts
@@ -70,6 +70,8 @@
 	};
 
 	dsa {
+		status = "disabled";
+
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -207,6 +209,53 @@
 
 &mdio {
 	status = "okay";
+
+	switch at 10 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <16>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				label = "ethernet1";
+			};
+
+			port at 1 {
+				reg = <1>;
+				label = "ethernet2";
+			};
+
+			port at 2 {
+				reg = <2>;
+				label = "ethernet3";
+			};
+
+			port at 3 {
+				reg = <3>;
+				label = "ethernet4";
+			};
+
+			port at 4 {
+				reg = <4>;
+				label = "internet";
+			};
+
+			port at 5 {
+				reg = <5>;
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
 
 &uart0 {
-- 
2.9.3
