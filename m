From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 02 Jan 2017 14:58:57 +0000
Subject: [PATCH 4/9] ARM: dts: armada388-clearfog: move DSA switch
In-Reply-To: <E1cO43Q-0007yJ-ON@rmk-PC.armlinux.org.uk>
References: <E1cO43Q-0007yJ-ON@rmk-PC.armlinux.org.uk>
Message-ID: <E1cO44f-00082b-5n@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the DSA switch configuration to the clearfog .dts file as this is
only present on the pro models.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dts  | 75 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-388-clearfog.dtsi | 69 ---------------------------
 2 files changed, 75 insertions(+), 69 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index c5f2ca5f6144..a1176d23a444 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -53,4 +53,79 @@
 	model = "SolidRun Clearfog A1";
 	compatible = "solidrun,clearfog-a1", "marvell,armada388",
 		"marvell,armada385", "marvell,armada380";
+
+	dsa at 0 {
+		compatible = "marvell,dsa";
+		dsa,ethernet = <&eth1>;
+		dsa,mii-bus = <&mdio>;
+		pinctrl-0 = <&clearfog_dsa0_clk_pins &clearfog_dsa0_pins>;
+		pinctrl-names = "default";
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		switch at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4 0>;
+
+			port at 0 {
+				reg = <0>;
+				label = "lan5";
+			};
+
+			port at 1 {
+				reg = <1>;
+				label = "lan4";
+			};
+
+			port at 2 {
+				reg = <2>;
+				label = "lan3";
+			};
+
+			port at 3 {
+				reg = <3>;
+				label = "lan2";
+			};
+
+			port at 4 {
+				reg = <4>;
+				label = "lan1";
+			};
+
+			port at 5 {
+				reg = <5>;
+				label = "cpu";
+			};
+
+			port at 6 {
+				/* 88E1512 external phy */
+				reg = <6>;
+				label = "lan6";
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
+};
+
+&eth1 {
+	/* ethernet at 30000 */
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&pinctrl {
+	clearfog_dsa0_clk_pins: clearfog-dsa0-clk-pins {
+		marvell,pins = "mpp46";
+		marvell,function = "ref";
+	};
+	clearfog_dsa0_pins: clearfog-dsa0-pins {
+		marvell,pins = "mpp23", "mpp41";
+		marvell,function = "gpio";
+	};
 };
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
index 59438777287a..fb02997a52a1 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
@@ -77,11 +77,6 @@
 				bm,pool-long = <2>;
 				bm,pool-short = <1>;
 				status = "okay";
-
-				fixed-link {
-					speed = <1000>;
-					full-duplex;
-				};
 			};
 
 			ethernet at 34000 {
@@ -235,14 +230,6 @@
 			};
 
 			pinctrl at 18000 {
-				clearfog_dsa0_clk_pins: clearfog-dsa0-clk-pins {
-					marvell,pins = "mpp46";
-					marvell,function = "ref";
-				};
-				clearfog_dsa0_pins: clearfog-dsa0-pins {
-					marvell,pins = "mpp23", "mpp41";
-					marvell,function = "gpio";
-				};
 				clearfog_i2c1_pins: i2c1-pins {
 					/* SFP, PCIe, mSATA, mikrobus */
 					marvell,pins = "mpp26", "mpp27";
@@ -339,62 +326,6 @@
 		};
 	};
 
-	dsa at 0 {
-		compatible = "marvell,dsa";
-		dsa,ethernet = <&eth1>;
-		dsa,mii-bus = <&mdio>;
-		pinctrl-0 = <&clearfog_dsa0_clk_pins &clearfog_dsa0_pins>;
-		pinctrl-names = "default";
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		switch at 0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4 0>;
-
-			port at 0 {
-				reg = <0>;
-				label = "lan5";
-			};
-
-			port at 1 {
-				reg = <1>;
-				label = "lan4";
-			};
-
-			port at 2 {
-				reg = <2>;
-				label = "lan3";
-			};
-
-			port at 3 {
-				reg = <3>;
-				label = "lan2";
-			};
-
-			port at 4 {
-				reg = <4>;
-				label = "lan1";
-			};
-
-			port at 5 {
-				reg = <5>;
-				label = "cpu";
-			};
-
-			port at 6 {
-				/* 88E1512 external phy */
-				reg = <6>;
-				label = "lan6";
-				fixed-link {
-					speed = <1000>;
-					full-duplex;
-				};
-			};
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-0 = <&rear_button_pins>;
-- 
2.7.4
