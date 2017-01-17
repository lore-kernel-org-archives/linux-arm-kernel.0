From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 10:22:24 -0800
Subject: [PATCH v3 8/8] ARM: dts: kirkwood-rd88f6281: Utilize new DSA binding
In-Reply-To: <20170117182224.32212-1-f.fainelli@gmail.com>
References: <20170117182224.32212-1-f.fainelli@gmail.com>
Message-ID: <20170117182224.32212-9-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net: dsa:
Document new binding"). The legacy binding node is kept included, but is marked
disabled.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts  |  9 +++---
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts | 11 ++++++++
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi   | 44 +++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts b/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
index 6f771a99cb02..9ec5a65561e9 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
@@ -19,11 +19,6 @@
 	model = "Marvell RD88f6281 Reference design, with A0 or higher SoC";
 	compatible = "marvell,rd88f6281-a", "marvell,rd88f6281","marvell,kirkwood-88f6281", "marvell,kirkwood";
 
-	dsa {
-		switch at 0 {
-			reg = <10 0>;	 /* MDIO address 10, switch 0 in tree */
-		};
-	};
 };
 
 &mdio {
@@ -34,6 +29,10 @@
 	};
 };
 
+&switch {
+	reg = <10>;
+};
+
 &eth1 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
index 1a797381d3d4..6a4a65ec7944 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
@@ -33,3 +33,14 @@
 &eth1 {
       status = "disabled";
 };
+
+&switch {
+	reg = <0>;
+
+	ports {
+		port at 4 {
+			reg = <4>;
+			label = "wan";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
index d5aacf137e40..91f5da5dae5f 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
@@ -54,6 +54,8 @@
 	};
 
 	dsa {
+		status = "disabled";
+
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -115,6 +117,48 @@
 
 &mdio {
 	status = "okay";
+
+	switch: switch at 0 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				label = "lan1";
+			};
+
+			port at 1 {
+				reg = <1>;
+				label = "lan2";
+			};
+
+			port at 2 {
+				reg = <2>;
+				label = "lan3";
+			};
+
+			port at 3 {
+				reg = <3>;
+				label = "lan4";
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
+
+		};
+	};
 };
 
 &eth0 {
-- 
2.9.3
