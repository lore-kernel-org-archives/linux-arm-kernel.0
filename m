From: sergei.shtylyov@cogentembedded.com (sergei.shtylyov at cogentembedded.com)
Date: Wed, 06 Aug 2014 22:38:22 +0400
Subject: [PATCH] ARM: shmobile: koelsch: add VIN1/ADV7180 DT support
In-Reply-To: <201408020402.14560.sergei.shtylyov@cogentembedded.com>
References: <201408020402.14560.sergei.shtylyov@cogentembedded.com>
Message-ID: <2131152.vMTPsJUYLQ@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Koelsch board dependent part of the VIN1 device node. Add the device
node for Analog  Devices ADV7180  video decoder to  I2C2 bus. Add the necessary
subnodes to interconnect VIN1 and ADV7180 devices.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-v3.16-20140804' tag of Simon Horman's
'renesas.git' repo. It requires the 'soc_camera' and 'rcar_vin' device tree
support patches (already merged to the 'media_tree.git' repo) in order to work.

 arch/arm/boot/dts/r8a7791-koelsch.dts |   35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -289,6 +289,11 @@
 		renesas,groups = "usb1";
 		renesas,function = "usb1";
 	};
+
+	vin1_pins: vin1 {
+		renesas,groups = "vin1_data8", "vin1_clk";
+		renesas,function = "vin1";
+	};
 };
 
 &ether {
@@ -416,6 +421,19 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
+	composite-in at 20 {
+		compatible = "adi,adv7180";
+		reg = <0x20>;
+		remote = <&vin1>;
+
+		port {
+			adv7180: endpoint {
+				bus-width = <8>;
+				remote-endpoint = <&vin1ep>;
+			};
+		};
+	};
+
 	eeprom at 50 {
 		compatible = "renesas,24c02";
 		reg = <0x50>;
@@ -463,3 +481,20 @@
 &cpu0 {
 	cpu0-supply = <&vdd_dvfs>;
 };
+
+/* composite video input */
+&vin1 {
+	status = "ok";
+	pinctrl-0 = <&vin1_pins>;
+	pinctrl-names = "default";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vin1ep: endpoint {
+			remote-endpoint = <&adv7180>;
+			bus-width = <8>;
+		};
+	};
+};
