From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Mar 2014 10:20:59 +0100
Subject: [PATCH v5 08/11] ARM: dts: imx51: Add IPU ports and endpoints,
 move imx-drm node to dtsi
In-Reply-To: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394011262-16849-9-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch connects IPU and and parallel display device tree
nodes using the OF graph bindings described in
Documentation/devicetree/bindings/media/video-interfaces.txt

The IPU ports correspond to the two display interfaces. The
order of endpoints in the ports is arbitrary.

Since the imx-drm node now only needs to contain links to the
display interfaces, it can be moved to the SoC dtsi level. At
the board level, only connections between the display interface
ports and panels have to be added.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v4:
 - Changed DT compatible string to 'fsl,imx-display-subsystem' instead
   of Linux specific 'fsl,imx-drm', changed DT node name from 'imx-drm'
   to 'display-subsystem'.
---
 arch/arm/boot/dts/imx51-apf51dev.dts | 11 ++++++++++-
 arch/arm/boot/dts/imx51-babbage.dts  | 28 ++++++++++++++++++++--------
 arch/arm/boot/dts/imx51.dtsi         | 22 +++++++++++++++++++++-
 3 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index 5a7f552..d3f9814 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -18,7 +18,6 @@
 
 	display at di1 {
 		compatible = "fsl,imx-parallel-display";
-		crtcs = <&ipu 0>;
 		interface-pix-fmt = "bgr666";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ipu_disp1_1>;
@@ -41,6 +40,12 @@
 				pixelclk-active = <0>;
 			};
 		};
+
+		port {
+			display_in: endpoint {
+				remote-endpoint = <&ipu_di0_disp0>;
+			};
+		};
 	};
 
 	gpio-keys {
@@ -122,3 +127,7 @@
 		};
 	};
 };
+
+&ipu_di0_disp0 {
+	remote-endpoint = <&display_in>;
+};
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 6ff15a0..6719271 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -23,7 +23,6 @@
 
 	display0: display at di0 {
 		compatible = "fsl,imx-parallel-display";
-		crtcs = <&ipu 0>;
 		interface-pix-fmt = "rgb24";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ipu_disp1_1>;
@@ -41,11 +40,16 @@
 				vsync-len = <10>;
 			};
 		};
+
+		port {
+			display0_in: endpoint {
+				remote-endpoint = <&ipu_di0_disp0>;
+			};
+		};
 	};
 
 	display1: display at di1 {
 		compatible = "fsl,imx-parallel-display";
-		crtcs = <&ipu 1>;
 		interface-pix-fmt = "rgb565";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ipu_disp2_1>;
@@ -68,6 +72,12 @@
 				pixelclk-active = <0>;
 			};
 		};
+
+		port {
+			display1_in: endpoint {
+				remote-endpoint = <&ipu_di1_disp1>;
+			};
+		};
 	};
 
 	gpio-keys {
@@ -81,12 +91,6 @@
 		};
 	};
 
-	imx-drm {
-		compatible = "fsl,imx-drm";
-		crtcs = <&ipu 0>, <&ipu 1>;
-		connectors = <&display0>, <&display1>;
-	};
-
 	sound {
 		compatible = "fsl,imx51-babbage-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
@@ -264,6 +268,14 @@
 	};
 };
 
+&ipu_di0_disp0 {
+	remote-endpoint = <&display0_in>;
+};
+
+&ipu_di1_disp1 {
+	remote-endpoint = <&display1_in>;
+};
+
 &ssi2 {
 	fsl,mode = "i2s-slave";
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 4bcdd3a..28c96aa 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -79,6 +79,11 @@
 		};
 	};
 
+	display-subsystem {
+		compatible = "fsl,imx-display-subsystem";
+		ports = <&ipu_di0>, <&ipu_di1>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -92,13 +97,28 @@
 		};
 
 		ipu: ipu at 40000000 {
-			#crtc-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "fsl,imx51-ipu";
 			reg = <0x40000000 0x20000000>;
 			interrupts = <11 10>;
 			clocks = <&clks 59>, <&clks 110>, <&clks 61>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
+
+			ipu_di0: port at 2 {
+				reg = <2>;
+
+				ipu_di0_disp0: endpoint {
+				};
+			};
+
+			ipu_di1: port at 3 {
+				reg = <3>;
+
+				ipu_di1_disp1: endpoint {
+				};
+			};
 		};
 
 		aips at 70000000 { /* AIPS1 */
-- 
1.9.0.rc3
