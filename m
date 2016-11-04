From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:19 +0100
Subject: [PATCH 20/29] ARM: dts: koelsch: add HDMI input
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <84e3a74664c52b58cd7f5b6fa381f7f1cd1956e0.1478252309.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hans Verkuil <hverkuil@xs4all.nl>

Add support in the dts for the HDMI input. Based on the Lager dts
patch from Ulrich Hecht.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
[uli: removed "renesas," prefixes from pfc nodes]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 68 +++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index f17bfa000f73..c457b43deb7d 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -265,12 +265,23 @@
 		};
 	};
 
+	hdmi-in {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&adv7612_in>;
+			};
+		};
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
 
 		port {
-			hdmi_con: endpoint {
+			hdmi_con_out: endpoint {
 				remote-endpoint = <&adv7511_out>;
 			};
 		};
@@ -414,6 +425,11 @@
 		function = "usb1";
 	};
 
+	vin0_pins: vin0 {
+		groups = "vin0_data24", "vin0_sync", "vin0_clkenb", "vin0_clk";
+		function = "vin0";
+	};
+
 	vin1_pins: vin1 {
 		groups = "vin1_data8", "vin1_clk";
 		function = "vin1";
@@ -617,7 +633,34 @@
 			port at 1 {
 				reg = <1>;
 				adv7511_out: endpoint {
-					remote-endpoint = <&hdmi_con>;
+					remote-endpoint = <&hdmi_con_out>;
+				};
+			};
+		};
+	};
+
+	hdmi-in at 4c {
+		compatible = "adi,adv7612";
+		reg = <0x4c>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		default-input = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				adv7612_in: endpoint {
+					remote-endpoint = <&hdmi_con_in>;
+				};
+			};
+
+			port at 2 {
+				reg = <2>;
+				adv7612_out: endpoint {
+					remote-endpoint = <&vin0ep2>;
 				};
 			};
 		};
@@ -699,6 +742,27 @@
 	cpu0-supply = <&vdd_dvfs>;
 };
 
+/* HDMI video input */
+&vin0 {
+	status = "okay";
+	pinctrl-0 = <&vin0_pins>;
+	pinctrl-names = "default";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vin0ep2: endpoint {
+			remote-endpoint = <&adv7612_out>;
+			bus-width = <24>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			pclk-sample = <1>;
+			data-active = <1>;
+		};
+	};
+};
+
 /* composite video input */
 &vin1 {
 	status = "okay";
-- 
2.7.0.rc3.207.g0ac5344
