From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Aug 2016 23:42:54 +0300
Subject: [PATCH] ARM: dts: blanche: add DU support
In-Reply-To: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
Message-ID: <1783132.r9t2y3QUUq@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define  the  Blanche board dependent part of the DU device node.
Add the device nodes for the  Analog Devices ADV7511W  HDMI transmitter
(connected to DU0) and ADV7123 video DAC (connected to DU1).  Add the
necessary subnodes to interconnect DU, HDMI/VDAC devices, and HDMI/VGA
connectors.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20160817-v4.8-rc2' of Simon Horman's
'renesas.git' repo plus the general purpose switches patch and the SDHI0 patch
posted earlier.

 arch/arm/boot/dts/r8a7792-blanche.dts |  125 ++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
+++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -57,6 +57,61 @@
 		pinctrl-names = "default";
 	};
 
+	vga-encoder {
+		compatible = "adi,adv7123";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				adv7123_in: endpoint {
+					remote-endpoint = <&du_out_rgb1>;
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				adv7123_out: endpoint {
+					remote-endpoint = <&vga_in>;
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
+
+	vga {
+		compatible = "vga-connector";
+
+		port {
+			vga_in: endpoint {
+				remote-endpoint = <&adv7123_out>;
+			};
+		};
+	};
+
+	x1_clk: x1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
+	};
+
+	x2_clk: x2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <65000000>;
+	};
+
 	keyboard {
 		compatible = "gpio-keys";
 
@@ -155,6 +210,16 @@
 		groups = "sdhi0_data4", "sdhi0_ctrl";
 		function = "sdhi0";
 	};
+
+	du0_pins: du0 {
+		groups = "du0_rgb888", "du0_sync", "du0_disp";
+		function = "du0";
+	};
+
+	du1_pins: du1 {
+		groups = "du1_rgb666", "du1_sync", "du1_disp";
+		function = "du1";
+	};
 };
 
 &scif0 {
@@ -186,3 +251,63 @@
 	cd-gpios = <&gpio11 11 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	hdmi at 39 {
+		compatible = "adi,adv7511w";
+		reg = <0x39>;
+		interrupt-parent = <&irqc>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
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
+					remote-endpoint = <&du_out_rgb0>;
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
+&du {
+	pinctrl-0 = <&du0_pins &du1_pins>;
+	pinctrl-names = "default";
+
+	clocks = <&mstp7_clks R8A7792_CLK_DU0>, <&mstp7_clks R8A7792_CLK_DU1>,
+		 <&x1_clk>, <&x2_clk>;
+	clock-names = "du.0", "du.1", "dclkin.0", "dclkin.1";
+	status = "okay";
+
+	ports {
+		port at 0 {
+			endpoint {
+				remote-endpoint = <&adv7511_in>;
+			};
+		};
+		port at 1 {
+			endpoint {
+				remote-endpoint = <&adv7123_in>;
+			};
+		};
+	};
+};
