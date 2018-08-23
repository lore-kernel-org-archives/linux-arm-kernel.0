From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 23 Aug 2018 19:59:20 +0300
Subject: [PATCH v4] arm64: dts: renesas: condor/v3hsk: add DU/LVDS/HDMI support
In-Reply-To: <95d0db34-713d-8206-00c2-ee9a42aab823@cogentembedded.com>
References: <95d0db34-713d-8206-00c2-ee9a42aab823@cogentembedded.com>
Message-ID: <fe3794e1-2452-d1af-5c30-203fcbb9932e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Condor/V3HSK board dependent parts of the DU and  LVDS device
nodes. Also add the device nodes for Thine THC63LVD1024 LVDS decoder and
Analog Devices ADV7511W HDMI transmitter...

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---
The patch is against the 'renesas-devel-20180822-v4.18' tag of Simon Horman's
'renesas.git' repo. The only driver support still unmerged seems to be the
R8A77980 LVDS support patches...

Changes in version 4:
- added the OSC1 clock node and a reference to it from the DU device node in
  the V3HSK board DT;
- added Ulrich's and Laurent's tags.

Changes in version 2:
- added the V3HSK DT update, reworded the description, renamed the patch;
- added a space between the HDMI node name and a brace.

 arch/arm64/boot/dts/renesas/r8a77980-condor.dts |  106 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts  |  129 ++++++++++++++++++++++++
 2 files changed, 235 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -45,6 +45,56 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	d1_8v: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "D1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
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
+
+	lvds-decoder {
+		compatible = "thine,thc63lvd1024";
+		vcc-supply = <&d3_3v>;
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
+	x1_clk: x1-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
 };
 
 &avb {
@@ -74,6 +124,13 @@
 	};
 };
 
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&x1_clk>;
+	clock-names = "du.0", "dclkin.0";
+	status = "okay";
+};
+
 &extal_clk {
 	clock-frequency = <16666666>;
 };
@@ -102,6 +159,55 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	hdmi at 39 {
+		compatible = "adi,adv7511w";
+		reg = <0x39>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+		avdd-supply = <&d1_8v>;
+		dvdd-supply = <&d1_8v>;
+		pvdd-supply = <&d1_8v>;
+		bgvdd-supply = <&d1_8v>;
+		dvdd-3v-supply = <&d3_3v>;
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
 };
 
 &mmc0 {
Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
@@ -27,6 +27,72 @@
 		/* first 128MB is reserved for secure area. */
 		reg = <0 0x48000000 0 0x78000000>;
 	};
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
+
+	lvds-decoder {
+		compatible = "thine,thc63lvd1024";
+		vcc-supply = <&vcc3v3_d5>;
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
+	osc1_clk: osc1-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
+
+	vcc1v8_d4: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC1V8_D4";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc3v3_d5: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC3V3_D5";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&osc1_clk>;
+	clock-names = "du.0", "dclkin.0";
+	status = "okay";
 };
 
 &extal_clk {
@@ -53,6 +119,64 @@
 	};
 };
 
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
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	hdmi at 39 {
+		compatible = "adi,adv7511w";
+		#sound-dai-cells = <0>;
+		reg = <0x39>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+		avdd-supply = <&vcc1v8_d4>;
+		dvdd-supply = <&vcc1v8_d4>;
+		pvdd-supply = <&vcc1v8_d4>;
+		bgvdd-supply = <&vcc1v8_d4>;
+		dvdd-3v-supply = <&vcc3v3_d5>;
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
 &pfc {
 	gether_pins: gether {
 		groups = "gether_mdio_a", "gether_rgmii",
@@ -60,6 +184,11 @@
 		function = "gether";
 	};
 
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data";
 		function = "scif0";
