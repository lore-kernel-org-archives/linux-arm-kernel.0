From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 6 Jun 2018 19:59:35 +0300
Subject: [PATCH 5/5] arm64: dts: renesas: condor: add DU/LVDS/HDMI support
In-Reply-To: <4fbd0895-c1ec-41fc-912d-8306dd933997@cogentembedded.com>
References: <4fbd0895-c1ec-41fc-912d-8306dd933997@cogentembedded.com>
Message-ID: <67b499db-c8de-eff8-0547-1063c8ebd358@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Condor board dependent part of the DU and  LVDS device nodes.
Also add the device nodes for Thine THC63LVD1024 LVDS decoder and Analog
Devices ADV7511W HDMI transmitter...

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts |  106 ++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

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
+	hdmi at 39{
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
