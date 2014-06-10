From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 11 Jun 2014 03:07:34 +0400
Subject: [PATCH 2/2] ARM: shmobile: henninger: add VIN0/ADV7180 DT support
In-Reply-To: <201406110304.18976.sergei.shtylyov@cogentembedded.com>
References: <201406110304.18976.sergei.shtylyov@cogentembedded.com>
Message-ID: <201406110307.35534.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Henninger board dependent part of the VIN0 device node. Add the
device node for Analog Devices ADV7180 video decoder to I2C2  bus. Add the
necessary subnodes to interconnect VIN0 and ADV7180 devices.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7791-henninger.dts |   35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -125,6 +125,11 @@
 				 "msiof0_tx";
 		renesas,function = "msiof0";
 	};
+
+	vin0_pins: vin0 {
+		renesas,groups = "vin0_data8", "vin0_clk";
+		renesas,function = "vin0";
+	};
 };
 
 &scif0 {
@@ -181,6 +186,19 @@
 
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
 
 &qspi {
@@ -230,3 +248,20 @@
 		spi-cpha;
 	};
 };
+
+/* composite video input */
+&vin0 {
+	status = "ok";
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
