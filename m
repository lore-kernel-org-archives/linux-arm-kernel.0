From: philippe.cornu@st.com (Philippe CORNU)
Date: Mon, 3 Jul 2017 10:41:26 +0200
Subject: [PATCH v5 6/7] dt-bindings: display: stm32: Add DSI controller
In-Reply-To: <1499071287-10414-1-git-send-email-philippe.cornu@st.com>
References: <1499071287-10414-1-git-send-email-philippe.cornu@st.com>
Message-ID: <1499071287-10414-7-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for the STM32 DSI
controller based on the Synopsys DesignWare MIPI DSI host controller.

Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/st,stm32-ltdc.txt  | 104 ++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
index 90a8459..74b5ac7 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
@@ -12,8 +12,40 @@
   Required nodes:
     - Video port for RGB output.
 
-Example:
+* STMicroelectronics STM32 DSI controller specific extensions to Synopsys
+  DesignWare MIPI DSI host controller
 
+The STMicroelectronics STM32 DSI controller uses the Synopsys DesignWare MIPI
+DSI host controller. For all mandatory properties & nodes, please refer
+to the related documentation in [5].
+
+Mandatory properties specific to STM32 DSI:
+- #address-cells: Should be <1>.
+- #size-cells: Should be <0>.
+- compatible: "st,stm32-dsi".
+- clock-names:
+  - phy pll reference clock string name, must be "ref".
+- resets: see [5].
+- reset-names: see [5].
+
+Mandatory nodes specific to STM32 DSI:
+- ports: A node containing DSI input & output port nodes with endpoint
+  definitions as documented in [3] & [4].
+  - port at 0: DSI input port node, connected to the ltdc rgb output port.
+  - port at 1: DSI output port node, connected to a panel or a bridge input port.
+- panel or bridge node: A node containing the panel or bridge description as
+  documented in [6].
+  - port: panel or bridge port node, connected to the DSI output port (port at 1).
+
+Note: You can find more documentation in the following references
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/reset/reset.txt
+[3] Documentation/devicetree/bindings/media/video-interfaces.txt
+[4] Documentation/devicetree/bindings/graph.txt
+[5] Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
+[6] Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
+
+Example 1: RGB panel
 / {
 	...
 	soc {
@@ -33,3 +65,73 @@ Example:
 		};
 	};
 };
+
+Example 2: DSI panel
+
+/ {
+	...
+	soc {
+	...
+		ltdc: display-controller at 40016800 {
+			compatible = "st,stm32-ltdc";
+			reg = <0x40016800 0x200>;
+			interrupts = <88>, <89>;
+			resets = <&rcc STM32F4_APB2_RESET(LTDC)>;
+			clocks = <&rcc 1 CLK_LCD>;
+			clock-names = "lcd";
+
+			port {
+				ltdc_out_dsi: endpoint {
+					remote-endpoint = <&dsi_in>;
+				};
+			};
+		};
+
+
+		dsi: dsi at 40016c00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-dsi";
+			reg = <0x40016c00 0x800>;
+			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
+			clock-names = "ref", "pclk";
+			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
+			reset-names = "apb";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					dsi_in: endpoint {
+						remote-endpoint = <&ltdc_out_dsi>;
+					};
+				};
+
+				port at 1 {
+					reg = <1>;
+					dsi_out: endpoint {
+						remote-endpoint = <&dsi_in_panel>;
+					};
+				};
+
+			};
+
+			panel-dsi at 0 {
+				reg = <0>; /* dsi virtual channel (0..3) */
+				compatible = ...;
+				enable-gpios = ...;
+
+				port {
+					dsi_in_panel: endpoint {
+						remote-endpoint = <&dsi_out>;
+					};
+				};
+
+			};
+
+		};
+
+	};
+};
-- 
1.9.1
