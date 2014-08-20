From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 09:23:54 +0900
Subject: [PATCH 03/12] ARM: shmobile: koelsch: add VIN1/ADV7180 DT support
In-Reply-To: <cover.1408492753.git.horms+renesas@verge.net.au>
References: <cover.1408492753.git.horms+renesas@verge.net.au>
Message-ID: <2cf088105db14c00ad69df09b9b4a37c2370ff44.1408492753.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>

Define the Koelsch board dependent part of the VIN1 device node. Add the device
node for Analog  Devices ADV7180  video decoder to  I2C2 bus. Add the necessary
subnodes to interconnect VIN1 and ADV7180 devices.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 23486c0..6be43da 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
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
@@ -412,6 +417,19 @@
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
@@ -459,3 +477,20 @@
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
-- 
2.0.1
