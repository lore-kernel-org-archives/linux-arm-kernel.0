From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  6 Jan 2014 15:52:00 +0100
Subject: [RFC PATCH 1/3] ARM: dts: imx6qdl: Add ports and endpoints to IPU DIs
In-Reply-To: <1389019922-31992-1-git-send-email-p.zabel@pengutronix.de>
References: <1389019922-31992-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1389019922-31992-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This connects the IPU and display encoder (HDMI, LVDS, MIPI)
device tree nodes using the bindings described in
Documentation/devicetree/bindings/media/video-interfaces.txt

The IPU ports correspond to the two display interfaces. Port
numbering begins at 2 to leave space for the two CSI input
ports. The order of endpoints in the ports is arbitrary.

Each encoder with an associated input multiplexer has multiple
input ports in the device tree. The order and reg property of
the ports must correspond to the multiplexer input order.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi   | 115 +++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl.dtsi | 127 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 234 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 187fe33..f36f739 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -132,13 +132,75 @@
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
+			port at 2 {
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
+				};
+
+				ipu2_di0_lvds1: endpoint at 4 {
+				};
+			};
+
+			port at 3 {
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
+				};
+
+				ipu2_di1_lvds1: endpoint at 4 {
+				};
+			};
+		};
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
@@ -152,15 +214,56 @@
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
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 930ebe0..3438ef6 100644
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
@@ -1588,8 +1642,26 @@
 				reg = <0x021dc000 0x4000>;
 			};
 
-			mipi at 021e0000 { /* MIPI-DSI */
+			mipi_dsi: mipi at 021e0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x021e0000 0x4000>;
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
@@ -1643,13 +1715,64 @@
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
+			port at 2 {
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
+			port at 3 {
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
1.8.5.2
