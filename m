From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Aug 2015 01:24:47 +0300
Subject: [PATCH 2/2] ARM: shmobile: silk: add VIN0/ADV7180 DT support
In-Reply-To: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
References: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
Message-ID: <4017919.utiMzpz6ED@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define  the  SILK board dependent part of the  VIN0  device  node.
Add the device node for Analog Devices ADV7180 video decoder to I2C1 bus.
Add the necessary subnodes to interconnect VIN0 and ADV7180 devices.

Based on the Henninger VIN0/ADV8170 device tree patch by myself.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794-silk.dts |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -104,6 +104,11 @@
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
 	};
+
+	vin0_pins: vin0 {
+		renesas,groups = "vin0_data8", "vin0_clk";
+		renesas,function = "vin0";
+	};
 };
 
 &scif2 {
@@ -135,6 +140,19 @@
 
 	status = "okay";
 	clock-frequency = <400000>;
+
+	composite-in at 20 {
+		compatible = "adi,adv7180";
+		reg = <0x20>;
+		remote = <&vin0>;
+
+		port {
+			adv7180: endpoint {
+				bus-width = <8>;
+				remote-endpoint = <&vin0ep>;
+			};
+		};
+	};
 };
 
 &mmcif0 {
@@ -193,3 +211,20 @@
 		};
 	};
 };
+
+/* composite video input */
+&vin0 {
+	status = "okay";
+	pinctrl-0 = <&vin0_pins>;
+	pinctrl-names = "default";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vin0ep: endpoint {
+			remote-endpoint = <&adv7180>;
+			bus-width = <8>;
+		};
+	};
+};
