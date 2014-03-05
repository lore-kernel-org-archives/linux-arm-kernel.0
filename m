From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Mar 2014 10:21:00 +0100
Subject: [PATCH v5 09/11] ARM: dts: imx53: Add IPU DI ports and endpoints,
 move imx-drm node to dtsi
In-Reply-To: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394011262-16849-10-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch connects IPU and display encoder (VGA, LVDS)
device tree nodes, as well as parallel displays on the DISP0
and DISP1 outputs, using the OF graph bindings described in
Documentation/devicetree/bindings/media/video-interfaces.txt

The IPU ports correspond to the two display interfaces. The
order of endpoints in the ports is arbitrary.

Since the imx-drm node now only needs to contain links to the
display interfaces, it can be moved to the SoC dtsi level. At
the board level, only connections between the display interface
ports and encoders or panels have to be added.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 - Changed DT compatible string to 'fsl,imx-display-subsystem' instead
   of Linux specific 'fsl,imx-drm', changed DT node name from 'imx-drm'
   to 'display-subsystem'.
---
 arch/arm/boot/dts/imx53-m53evk.dts | 17 +++++-----
 arch/arm/boot/dts/imx53-mba53.dts  | 15 +++++----
 arch/arm/boot/dts/imx53-qsb.dts    | 17 +++++-----
 arch/arm/boot/dts/imx53.dtsi       | 64 +++++++++++++++++++++++++++++++++++---
 4 files changed, 89 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index ee6107b..0298adc 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -23,7 +23,6 @@
 	soc {
 		display1: display at di1 {
 			compatible = "fsl,imx-parallel-display";
-			crtcs = <&ipu 1>;
 			interface-pix-fmt = "bgr666";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ipu_disp2_1>;
@@ -44,6 +43,12 @@
 				};
 			};
 		};
+
+		port {
+			display1_in: endpoint {
+				remote-endpoint = <&ipu_di1_disp1>;
+			};
+		};
 	};
 
 	backlight {
@@ -53,12 +58,6 @@
 		default-brightness-level = <6>;
 	};
 
-	imx-drm {
-		compatible = "fsl,imx-drm";
-		crtcs = <&ipu 1>;
-		connectors = <&display1>;
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -227,6 +226,10 @@
 	};
 };
 
+&ipu_di1_disp1 {
+	remote-endpoint = <&display1_in>;
+};
+
 &nfc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_nand_1>;
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index f2affb0..a5b55c6 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -38,15 +38,14 @@
 		compatible = "fsl,imx-parallel-display";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_disp1_1>;
-		crtcs = <&ipu 1>;
 		interface-pix-fmt = "rgb24";
 		status = "disabled";
-	};
 
-	imx-drm {
-		compatible = "fsl,imx-drm";
-		crtcs = <&ipu 1>;
-		connectors = <&disp1>, <&tve>;
+		port {
+			display1_in: endpoint {
+				remote-endpoint = <&ipu_di1_disp1>;
+			};
+		};
 	};
 
 	reg_3p2v: 3p2v {
@@ -147,6 +146,10 @@
 	};
 };
 
+&ipu_di1_disp1 {
+	remote-endpoint = <&display1_in>;
+};
+
 &cspi {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 3cb4f77..8b25428 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -23,7 +23,6 @@
 
 	display0: display at di0 {
 		compatible = "fsl,imx-parallel-display";
-		crtcs = <&ipu 0>;
 		interface-pix-fmt = "rgb565";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ipu_disp0_1>;
@@ -46,6 +45,12 @@
 				pixelclk-active = <0>;
 			};
 		};
+
+		port {
+			display0_in: endpoint {
+				remote-endpoint = <&ipu_di0_disp0>;
+			};
+		};
 	};
 
 	gpio-keys {
@@ -72,12 +77,6 @@
 		};
 	};
 
-	imx-drm {
-		compatible = "fsl,imx-drm";
-		crtcs = <&ipu 0>;
-		connectors = <&display0>;
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -132,6 +131,10 @@
 	status = "okay";
 };
 
+&ipu_di0_disp0 {
+	remote-endpoint = <&display0_in>;
+};
+
 &ssi2 {
 	fsl,mode = "i2s-slave";
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 4307e80..04d3127 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -45,6 +45,11 @@
 		};
 	};
 
+	display-subsystem {
+		compatible = "fsl,imx-display-subsystem";
+		ports = <&ipu_di0>, <&ipu_di1>;
+	};
+
 	tzic: tz-interrupt-controller at 0fffc000 {
 		compatible = "fsl,imx53-tzic", "fsl,tzic";
 		interrupt-controller;
@@ -85,13 +90,49 @@
 		ranges;
 
 		ipu: ipu at 18000000 {
-			#crtc-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "fsl,imx53-ipu";
 			reg = <0x18000000 0x080000000>;
 			interrupts = <11 10>;
 			clocks = <&clks 59>, <&clks 110>, <&clks 61>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
+
+			ipu_di0: port at 2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;
+
+				ipu_di0_disp0: endpoint at 0 {
+					reg = <0>;
+				};
+
+				ipu_di0_lvds0: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&lvds0_in>;
+				};
+			};
+
+			ipu_di1: port at 3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+
+				ipu_di1_disp1: endpoint at 0 {
+					reg = <0>;
+				};
+
+				ipu_di1_lvds1: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&lvds1_in>;
+				};
+
+				ipu_di1_tve: endpoint at 2 {
+					reg = <2>;
+					remote-endpoint = <&tve_in>;
+				};
+			};
 		};
 
 		aips at 50000000 { /* AIPS1 */
@@ -838,14 +879,24 @@
 
 				lvds-channel at 0 {
 					reg = <0>;
-					crtcs = <&ipu 0>;
 					status = "disabled";
+
+					port {
+						lvds0_in: endpoint {
+							remote-endpoint = <&ipu_di0_lvds0>;
+						};
+					};
 				};
 
 				lvds-channel at 1 {
 					reg = <1>;
-					crtcs = <&ipu 1>;
 					status = "disabled";
+
+					port {
+						lvds1_in: endpoint {
+							remote-endpoint = <&ipu_di0_lvds0>;
+						};
+					};
 				};
 			};
 
@@ -1103,8 +1154,13 @@
 				interrupts = <92>;
 				clocks = <&clks 69>, <&clks 116>;
 				clock-names = "tve", "di_sel";
-				crtcs = <&ipu 1>;
 				status = "disabled";
+
+				port {
+					tve_in: endpoint {
+						remote-endpoint = <&ipu_di1_tve>;
+					};
+				};
 			};
 
 			vpu: vpu at 63ff4000 {
-- 
1.9.0.rc3
