From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:52 +0200
Subject: [PATCH 57/58] arm64: dts: renesas: draak: Sort device nodes
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <7acc17b1a3e96d1e541c48abd89fa74d1e752f15.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

- Device nodes with unit addresses are sorted by unit address,
  - Device nodes without unit addresses and references are sorted
    alphabetically.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 276 ++++++++++++-------------
 1 file changed, 138 insertions(+), 138 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index a8e8f2669d4c..e39b73005381 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -24,38 +24,6 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	vga {
-		compatible = "vga-connector";
-
-		port {
-			vga_in: endpoint {
-				remote-endpoint = <&adv7123_out>;
-			};
-		};
-	};
-
-	vga-encoder {
-		compatible = "adi,adv7123";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port at 0 {
-				reg = <0>;
-				adv7123_in: endpoint {
-					remote-endpoint = <&du_out_rgb>;
-				};
-			};
-			port at 1 {
-				reg = <1>;
-				adv7123_out: endpoint {
-					remote-endpoint = <&vga_in>;
-				};
-			};
-		};
-	};
-
 	composite-in {
 		compatible = "composite-video-connector";
 
@@ -101,76 +69,86 @@
 		regulator-always-on;
 	};
 
-	x12_clk: x12 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <74250000>;
-	};
-};
-
-&extal_clk {
-	clock-frequency = <48000000>;
-};
+	vga {
+		compatible = "vga-connector";
 
-&pfc {
-	avb0_pins: avb {
-		mux {
-			groups = "avb0_link", "avb0_mdio", "avb0_mii";
-			function = "avb0";
+		port {
+			vga_in: endpoint {
+				remote-endpoint = <&adv7123_out>;
+			};
 		};
 	};
 
-	du_pins: du {
-		groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
-		function = "du";
-	};
+	vga-encoder {
+		compatible = "adi,adv7123";
 
-	i2c0_pins: i2c0 {
-		groups = "i2c0";
-		function = "i2c0";
-	};
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
 
-	i2c1_pins: i2c1 {
-		groups = "i2c1";
-		function = "i2c1";
+			port at 0 {
+				reg = <0>;
+				adv7123_in: endpoint {
+					remote-endpoint = <&du_out_rgb>;
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				adv7123_out: endpoint {
+					remote-endpoint = <&vga_in>;
+				};
+			};
+		};
 	};
 
-	pwm0_pins: pwm0 {
-		groups = "pwm0_c";
-		function = "pwm0";
+	x12_clk: x12 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
 	};
+};
 
-	pwm1_pins: pwm1 {
-		groups = "pwm1_c";
-		function = "pwm1";
-	};
+&avb {
+	pinctrl-0 = <&avb0_pins>;
+	pinctrl-names = "default";
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-txid";
+	status = "okay";
 
-	scif2_pins: scif2 {
-		groups = "scif2_data";
-		function = "scif2";
+	phy0: ethernet-phy at 0 {
+		rxc-skew-ps = <1500>;
+		reg = <0>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
 	};
+};
 
-	sdhi2_pins: sd2 {
-		groups = "mmc_data8", "mmc_ctrl";
-		function = "mmc";
-		power-source = <1800>;
-	};
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
 
-	sdhi2_pins_uhs: sd2_uhs {
-		groups = "mmc_data8", "mmc_ctrl";
-		function = "mmc";
-		power-source = <1800>;
-	};
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&x12_clk>;
+	clock-names = "du.0", "du.1", "dclkin.0";
 
-	usb0_pins: usb0 {
-		groups = "usb0";
-		function = "usb0";
+	ports {
+		port at 0 {
+			endpoint {
+				remote-endpoint = <&adv7123_in>;
+			};
+		};
 	};
+};
 
-	vin4_pins_cvbs: vin4 {
-		groups = "vin4_data8", "vin4_sync", "vin4_clk";
-		function = "vin4";
-	};
+&ehci0 {
+	status = "okay";
+};
+
+&extal_clk {
+	clock-frequency = <48000000>;
 };
 
 &i2c0 {
@@ -178,12 +156,6 @@
 	pinctrl-names = "default";
 	status = "okay";
 
-	eeprom at 50 {
-		compatible = "rohm,br24t01", "atmel,24c01";
-		reg = <0x50>;
-		pagesize = <8>;
-	};
-
 	composite-in at 20 {
 		compatible = "adi,adv7180cp";
 		reg = <0x20>;
@@ -254,6 +226,12 @@
 			};
 		};
 	};
+
+	eeprom at 50 {
+		compatible = "rohm,br24t01", "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
 };
 
 &i2c1 {
@@ -262,47 +240,88 @@
 	status = "okay";
 };
 
-&du {
-	pinctrl-0 = <&du_pins>;
-	pinctrl-names = "default";
+&ohci0 {
 	status = "okay";
+};
 
-	clocks = <&cpg CPG_MOD 724>,
-		 <&cpg CPG_MOD 723>,
-		 <&x12_clk>;
-	clock-names = "du.0", "du.1", "dclkin.0";
-
-	ports {
-		port at 0 {
-			endpoint {
-				remote-endpoint = <&adv7123_in>;
-			};
+&pfc {
+	avb0_pins: avb {
+		mux {
+			groups = "avb0_link", "avb0_mdio", "avb0_mii";
+			function = "avb0";
 		};
 	};
-};
 
-&ehci0 {
-	status = "okay";
+	du_pins: du {
+		groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
+		function = "du";
+	};
+
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
+	i2c1_pins: i2c1 {
+		groups = "i2c1";
+		function = "i2c1";
+	};
+
+	pwm0_pins: pwm0 {
+		groups = "pwm0_c";
+		function = "pwm0";
+	};
+
+	pwm1_pins: pwm1 {
+		groups = "pwm1_c";
+		function = "pwm1";
+	};
+
+	scif2_pins: scif2 {
+		groups = "scif2_data";
+		function = "scif2";
+	};
+
+	sdhi2_pins: sd2 {
+		groups = "mmc_data8", "mmc_ctrl";
+		function = "mmc";
+		power-source = <1800>;
+	};
+
+	sdhi2_pins_uhs: sd2_uhs {
+		groups = "mmc_data8", "mmc_ctrl";
+		function = "mmc";
+		power-source = <1800>;
+	};
+
+	usb0_pins: usb0 {
+		groups = "usb0";
+		function = "usb0";
+	};
+
+	vin4_pins_cvbs: vin4 {
+		groups = "vin4_data8", "vin4_sync", "vin4_clk";
+		function = "vin4";
+	};
 };
 
-&ohci0 {
+&pwm0 {
+	pinctrl-0 = <&pwm0_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
-&avb {
-	pinctrl-0 = <&avb0_pins>;
+&pwm1 {
+	pinctrl-0 = <&pwm1_pins>;
 	pinctrl-names = "default";
-	renesas,no-ether-link;
-	phy-handle = <&phy0>;
-	phy-mode = "rgmii-txid";
+
 	status = "okay";
+};
 
-	phy0: ethernet-phy at 0 {
-		rxc-skew-ps = <1500>;
-		reg = <0>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
-	};
+&rwdt {
+	timeout-sec = <60>;
+	status = "okay";
 };
 
 &scif2 {
@@ -333,25 +352,6 @@
 	status = "okay";
 };
 
-&pwm0 {
-	pinctrl-0 = <&pwm0_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
-&pwm1 {
-	pinctrl-0 = <&pwm1_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
-&rwdt {
-	timeout-sec = <60>;
-	status = "okay";
-};
-
 &vin4 {
 	pinctrl-0 = <&vin4_pins_cvbs>;
 	pinctrl-names = "default";
-- 
2.11.0
