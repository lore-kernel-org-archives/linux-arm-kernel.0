From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Jan 2018 22:42:38 +0300
Subject: [PATCH 5/5] arm64: dts: renesas: v3msk: add DU/LVDS/HDMI support
Message-ID: <20180119195442.569346951@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the V3M Starter Kit board dependent part of the DU and LVDS device
nodes. Also add the device nodes for the Analog Devices ADV7511W HDMI
transmitter -- it's actually connected to the LVDS output via an LVDS
decoder (deliberately omitted here since there's no driver yet anyway).

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts |  106 +++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -29,6 +29,41 @@
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
+	vcc_d1p8v: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_D1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc_d3p3v: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_D3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
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
@@ -42,6 +77,13 @@
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
@@ -50,6 +92,70 @@
 	clock-frequency = <32768>;
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
+		avdd-supply = <&vcc_d1p8v>;
+		dvdd-supply = <&vcc_d1p8v>;
+		pvdd-supply = <&vcc_d1p8v>;
+		bgvdd-supply = <&vcc_d1p8v>;
+		dvdd-3v-supply = <&vcc_d3p3v>;
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
+					remote-endpoint = <&lvds_out>;
+				};
+			};
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
+&lvds {
+	status = "okay";
+
+	ports {
+		port at 1 {
+			endpoint {
+				remote-endpoint = <&adv7511_in>;
+			};
+		};
+	};
+};
+
+&pfc {
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+};
+
 &scif0 {
 	status = "okay";
 };
