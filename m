From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Mar 2014 10:21:01 +0100
Subject: [PATCH v5 10/11] ARM: dts: imx6qdl: Add IPU DI ports and endpoints,
 move imx-drm node to dtsi
In-Reply-To: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394011262-16849-11-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch connects IPU and display encoder (HDMI, LVDS, MIPI)
device tree nodes, as well as parallel displays on the DISP0
and DISP1 outputs, using the OF graph bindings described in
Documentation/devicetree/bindings/media/video-interfaces.txt

The IPU ports correspond to the two display interfaces. The
order of endpoints in the ports is arbitrary.

Each encoder with an associated input multiplexer has multiple
input ports in the device tree. The order and reg property of
the ports must correspond to the multiplexer input order.

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
 arch/arm/boot/dts/imx6dl.dtsi          |  22 +++---
 arch/arm/boot/dts/imx6q-sabresd.dts    |   4 --
 arch/arm/boot/dts/imx6q.dtsi           | 124 ++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   6 --
 arch/arm/boot/dts/imx6qdl.dtsi         | 128 ++++++++++++++++++++++++++++++++-
 5 files changed, 253 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 6dc3970..25bbdd6 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -70,6 +70,15 @@
 			};
 		};
 	};
+
+	display-subsystem {
+		compatible = "fsl,imx-display-subsystem";
+		ports = <&ipu1_di0>, <&ipu1_di1>;
+	};
+};
+
+&hdmi {
+	compatible = "fsl,imx6dl-hdmi";
 };
 
 &ldb {
@@ -79,17 +88,4 @@
 	clock-names = "di0_pll", "di1_pll",
 		      "di0_sel", "di1_sel",
 		      "di0", "di1";
-
-	lvds-channel at 0 {
-		crtcs = <&ipu1 0>, <&ipu1 1>;
-	};
-
-	lvds-channel at 1 {
-		crtcs = <&ipu1 0>, <&ipu1 1>;
-	};
-};
-
-&hdmi {
-	compatible = "fsl,imx6dl-hdmi";
-	crtcs = <&ipu1 0>, <&ipu1 1>;
 };
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index 66f220a..9cbdfe7 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -20,10 +20,6 @@
 	compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
 };
 
-&imx_drm {
-	crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
-};
-
 &sata {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 187fe33..2a8d9de 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -132,13 +132,84 @@
 		};
 
 		ipu2: ipu at 02800000 {
-			#crtc-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "fsl,imx6q-ipu";
 			reg = <0x02800000 0x400000>;
 			interrupts = <0 8 0x4 0 7 0x4>;
 			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 4>;
+
+			ipu2_di0: port at 2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;
+
+				ipu2_di0_disp0: endpoint at 0 {
+				};
+
+				ipu2_di0_hdmi: endpoint at 1 {
+					remote-endpoint = <&hdmi_mux_2>;
+				};
+
+				ipu2_di0_mipi: endpoint at 2 {
+				};
+
+				ipu2_di0_lvds0: endpoint at 3 {
+					remote-endpoint = <&lvds0_mux_2>;
+				};
+
+				ipu2_di0_lvds1: endpoint at 4 {
+					remote-endpoint = <&lvds1_mux_2>;
+				};
+			};
+
+			ipu2_di1: port at 3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+
+				ipu2_di1_hdmi: endpoint at 1 {
+					remote-endpoint = <&hdmi_mux_3>;
+				};
+
+				ipu2_di1_mipi: endpoint at 2 {
+				};
+
+				ipu2_di1_lvds0: endpoint at 3 {
+					remote-endpoint = <&lvds0_mux_3>;
+				};
+
+				ipu2_di1_lvds1: endpoint at 4 {
+					remote-endpoint = <&lvds1_mux_3>;
+				};
+			};
+		};
+	};
+
+	display-subsystem {
+		compatible = "fsl,imx-display-subsystem";
+		ports = <&ipu1_di0>, <&ipu1_di1>, <&ipu2_di0>, <&ipu2_di1>;
+	};
+};
+
+&hdmi {
+	compatible = "fsl,imx6q-hdmi";
+
+	port at 2 {
+		reg = <2>;
+
+		hdmi_mux_2: endpoint {
+			remote-endpoint = <&ipu2_di0_hdmi>;
+		};
+	};
+
+	port at 3 {
+		reg = <3>;
+
+		hdmi_mux_3: endpoint {
+			remote-endpoint = <&ipu2_di1_hdmi>;
 		};
 	};
 };
@@ -152,15 +223,56 @@
 		      "di0", "di1";
 
 	lvds-channel at 0 {
-		crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
+		port at 2 {
+			reg = <2>;
+
+			lvds0_mux_2: endpoint {
+				remote-endpoint = <&ipu2_di0_lvds0>;
+			};
+		};
+
+		port at 3 {
+			reg = <3>;
+
+			lvds0_mux_3: endpoint {
+				remote-endpoint = <&ipu2_di1_lvds0>;
+			};
+		};
 	};
 
 	lvds-channel at 1 {
-		crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
+		port at 2 {
+			reg = <2>;
+
+			lvds1_mux_2: endpoint {
+				remote-endpoint = <&ipu2_di0_lvds1>;
+			};
+		};
+
+		port at 3 {
+			reg = <3>;
+
+			lvds1_mux_3: endpoint {
+				remote-endpoint = <&ipu2_di1_lvds1>;
+			};
+		};
 	};
 };
 
-&hdmi {
-	compatible = "fsl,imx6q-hdmi";
-	crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
+&mipi_dsi {
+	port at 2 {
+		reg = <2>;
+
+		mipi_mux_2: endpoint {
+			remote-endpoint = <&ipu2_di0_mipi>;
+		};
+	};
+
+	port at 3 {
+		reg = <3>;
+
+		mipi_mux_3: endpoint {
+			remote-endpoint = <&ipu2_di1_mipi>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index dfca3e0..e75e11b 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -62,12 +62,6 @@
 		};
 	};
 
-	imx_drm: imx-drm {
-		compatible = "fsl,imx-drm";
-		crtcs = <&ipu1 0>, <&ipu1 1>;
-		connectors = <&ldb>;
-	};
-
 	sound {
 		compatible = "fsl,imx6q-sabresd-wm8962",
 			   "fsl,imx-audio-wm8962";
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 930ebe0..64a8cbe 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1358,23 +1358,77 @@
 				status = "disabled";
 
 				lvds-channel at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <0>;
 					status = "disabled";
+
+					port at 0 {
+						reg = <0>;
+
+						lvds0_mux_0: endpoint {
+							remote-endpoint = <&ipu1_di0_lvds0>;
+						};
+					};
+
+					port at 1 {
+						reg = <1>;
+
+						lvds0_mux_1: endpoint {
+							remote-endpoint = <&ipu1_di1_lvds0>;
+						};
+					};
 				};
 
 				lvds-channel at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <1>;
 					status = "disabled";
+
+					port at 0 {
+						reg = <0>;
+
+						lvds1_mux_0: endpoint {
+							remote-endpoint = <&ipu1_di0_lvds1>;
+						};
+					};
+
+					port at 1 {
+						reg = <1>;
+
+						lvds1_mux_1: endpoint {
+							remote-endpoint = <&ipu1_di1_lvds1>;
+						};
+					};
 				};
 			};
 
 			hdmi: hdmi at 0120000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x00120000 0x9000>;
 				interrupts = <0 115 0x04>;
 				gpr = <&gpr>;
 				clocks = <&clks 123>, <&clks 124>;
 				clock-names = "iahb", "isfr";
 				status = "disabled";
+
+				port at 0 {
+					reg = <0>;
+
+					hdmi_mux_0: endpoint {
+						remote-endpoint = <&ipu1_di0_hdmi>;
+					};
+				};
+
+				port at 1 {
+					reg = <1>;
+
+					hdmi_mux_1: endpoint {
+						remote-endpoint = <&ipu1_di1_hdmi>;
+					};
+				};
 			};
 
 			dcic1: dcic at 020e4000 {
@@ -1588,8 +1642,27 @@
 				reg = <0x021dc000 0x4000>;
 			};
 
-			mipi at 021e0000 { /* MIPI-DSI */
+			mipi_dsi: mipi at 021e0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x021e0000 0x4000>;
+				status = "disabled";
+
+				port at 0 {
+					reg = <0>;
+
+					mipi_mux_0: endpoint {
+						remote-endpoint = <&ipu1_di0_mipi>;
+					};
+				};
+
+				port at 1 {
+					reg = <1>;
+
+					mipi_mux_1: endpoint {
+						remote-endpoint = <&ipu1_di1_mipi>;
+					};
+				};
 			};
 
 			vdoa at 021e4000 {
@@ -1643,13 +1716,64 @@
 		};
 
 		ipu1: ipu at 02400000 {
-			#crtc-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "fsl,imx6q-ipu";
 			reg = <0x02400000 0x400000>;
 			interrupts = <0 6 0x4 0 5 0x4>;
 			clocks = <&clks 130>, <&clks 131>, <&clks 132>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
+
+			ipu1_di0: port at 2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;
+
+				ipu1_di0_disp0: endpoint at 0 {
+				};
+
+				ipu1_di0_hdmi: endpoint at 1 {
+					remote-endpoint = <&hdmi_mux_0>;
+				};
+
+				ipu1_di0_mipi: endpoint at 2 {
+					remote-endpoint = <&mipi_mux_0>;
+				};
+
+				ipu1_di0_lvds0: endpoint at 3 {
+					remote-endpoint = <&lvds0_mux_0>;
+				};
+
+				ipu1_di0_lvds1: endpoint at 4 {
+					remote-endpoint = <&lvds1_mux_0>;
+				};
+			};
+
+			ipu1_di1: port at 3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+
+				ipu1_di0_disp1: endpoint at 0 {
+				};
+
+				ipu1_di1_hdmi: endpoint at 1 {
+					remote-endpoint = <&hdmi_mux_1>;
+				};
+
+				ipu1_di1_mipi: endpoint at 2 {
+					remote-endpoint = <&mipi_mux_1>;
+				};
+
+				ipu1_di1_lvds0: endpoint at 3 {
+					remote-endpoint = <&lvds0_mux_1>;
+				};
+
+				ipu1_di1_lvds1: endpoint at 4 {
+					remote-endpoint = <&lvds1_mux_1>;
+				};
+			};
 		};
 	};
 };
-- 
1.9.0.rc3
