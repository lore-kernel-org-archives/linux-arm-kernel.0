From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:23 +0200
Subject: [PATCH 061/102] arm64: dts: renesas: v3msk: add DU/LVDS/HDMI support
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <0c1861fe0a39e1f4d5d2684f1aec5a60b30c7400.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the V3M Starter Kit board dependent part of the DU and LVDS device
nodes. Also add the device nodes for Thine THC63LVD1024 LVDS decoder and
Analog Devices ADV7511W HDMI transmitter...

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts | 129 +++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
index 55aa01b663e5..9fce031a596f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -29,6 +29,65 @@
 		/* first 128MB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
+
+	osc5_clk: osc5-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
+
+	vcc_d1_8v: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_D1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc_d3_3v: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_D3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	lvds-decoder {
+		compatible = "thine,thc63lvd1024";
+		vcc-supply = <&vcc_d3_3v>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				thc63lvd1024_in: endpoint {
+					remote-endpoint = <&lvds0_out>;
+				};
+			};
+
+			port at 2 {
+				reg = <2>;
+				thc63lvd1024_out: endpoint {
+					remote-endpoint = <&adv7511_in>;
+				};
+			};
+		};
+	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7511_out>;
+			};
+		};
+	};
 };
 
 &avb {
@@ -46,6 +105,13 @@
 	};
 };
 
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&osc5_clk>;
+	clock-names = "du.0", "dclkin.0";
+	status = "okay";
+};
+
 &extal_clk {
 	clock-frequency = <16666666>;
 };
@@ -60,12 +126,75 @@
 		function = "avb0";
 	};
 
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data";
 		function = "scif0";
 	};
 };
 
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	hdmi at 39{
+		compatible = "adi,adv7511w";
+		#sound-dai-cells = <0>;
+		reg = <0x39>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+		avdd-supply = <&vcc_d1_8v>;
+		dvdd-supply = <&vcc_d1_8v>;
+		pvdd-supply = <&vcc_d1_8v>;
+		bgvdd-supply = <&vcc_d1_8v>;
+		dvdd-3v-supply = <&vcc_d3_3v>;
+
+		adi,input-depth = <8>;
+		adi,input-colorspace = "rgb";
+		adi,input-clock = "1x";
+		adi,input-style = <1>;
+		adi,input-justification = "evenly";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				adv7511_in: endpoint {
+					remote-endpoint = <&thc63lvd1024_out>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				adv7511_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
+&lvds0 {
+	status = "okay";
+
+	ports {
+		port at 1 {
+			lvds0_out: endpoint {
+				remote-endpoint = <&thc63lvd1024_in>;
+			};
+		};
+	};
+};
+
 &scif0 {
 	pinctrl-0 = <&scif0_pins>;
 	pinctrl-names = "default";
-- 
2.11.0
