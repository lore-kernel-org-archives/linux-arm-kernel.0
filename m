From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 13 Aug 2014 00:18:26 +0400
Subject: [PATCH v5 2/2] ARM: shmobile: lager: add VIN1/ADV7180 device nodes
In-Reply-To: <1793694.Z8xUpkGDQx@wasted.cogentembedded.com>
References: <1793694.Z8xUpkGDQx@wasted.cogentembedded.com>
Message-ID: <703960137.fSsccWupA3@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add the Lager board specific device node part for VIN1 (composite video in);
add the device node for Analog Devices ADV7180 video decoder to IIC2 bus.
Add the necessary subnodes to interconnect VIN1 and ADV7180 devices.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[Sergei: rebased, edited changelog and summary]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 5:
- edited changelog and summary;
- resolved reject, refreshed patch.

 arch/arm/boot/dts/r8a7790-lager.dts |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790-lager.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790-lager.dts
+++ renesas/arch/arm/boot/dts/r8a7790-lager.dts
@@ -234,6 +234,11 @@
 		renesas,groups = "usb2";
 		renesas,function = "usb2";
 	};
+
+	vin1_pins: vin {
+		renesas,groups = "vin1_data8", "vin1_clk";
+		renesas,function = "vin1";
+	};
 };
 
 &ether {
@@ -370,6 +375,19 @@
 	status = "ok";
 	pinctrl-0 = <&iic2_pins>;
 	pinctrl-names = "default";
+
+	composite-in at 20 {
+		compatible = "adi,adv7180";
+		reg = <0x20>;
+		remote = <&vin1>;
+
+		port {
+			adv7180: endpoint {
+				bus-width = <8>;
+				remote-endpoint = <&vin1ep0>;
+			};
+		};
+	};
 };
 
 &iic3 {
@@ -405,3 +423,21 @@
 	pinctrl-0 = <&usb2_pins>;
 	pinctrl-names = "default";
 };
+
+/* composite video input */
+&vin1 {
+	pinctrl-0 = <&vin1_pins>;
+	pinctrl-names = "default";
+
+	status = "ok";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vin1ep0: endpoint {
+			remote-endpoint = <&adv7180>;
+			bus-width = <8>;
+		};
+	};
+};
