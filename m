From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:28:57 +0100
Subject: [PATCH 03/70] ARM: dts: porter: add DU DT support
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <c5af8a4248d3cb01078d2a20df28081dd588b0e3.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define  the Porter board dependent part of the DU device node.
Add the device node  for Analog Devices ADV7511W  HDMI transmitter to I2C2
bus and the HDMI connector. Add the necessary subnodes to interconnect  DU
and HDMI devices.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 81 ++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 6713b1ea732b..fe81fa0e478c 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -78,6 +78,29 @@
 		states = <3300000 1
 			  1800000 0>;
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
+	x3_clk: x3-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
+
+	x16_clk: x16-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
+	};
 };
 
 &extal_clk {
@@ -139,6 +162,11 @@
 		renesas,groups = "can0_data";
 		renesas,function = "can0";
 	};
+
+	du_pins: du {
+		renesas,groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
+		renesas,function = "du";
+	};
 };
 
 &scif0 {
@@ -241,6 +269,38 @@
 			};
 		};
 	};
+
+	hdmi at 39 {
+		compatible = "adi,adv7511w";
+		reg = <0x39>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
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
+					remote-endpoint = <&du_out_rgb>;
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
 };
 
 &sata0 {
@@ -304,3 +364,24 @@
 
 	status = "okay";
 };
+
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	clocks = <&mstp7_clks R8A7791_CLK_DU0>,
+		 <&mstp7_clks R8A7791_CLK_DU1>,
+		 <&mstp7_clks R8A7791_CLK_LVDS0>,
+		 <&x3_clk>, <&x16_clk>;
+	clock-names = "du.0", "du.1", "lvds.0",
+		      "dclkin.0", "dclkin.1";
+
+	ports {
+		port at 1 {
+			endpoint {
+				remote-endpoint = <&adv7511_in>;
+			};
+		};
+	};
+};
-- 
2.7.0.rc3.207.g0ac5344
