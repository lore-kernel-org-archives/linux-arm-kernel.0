From: philippe.cornu@st.com (Philippe CORNU)
Date: Fri, 2 Jun 2017 16:37:14 +0200
Subject: [PATCH v3 5/6] dt-bindings: display: stm32: Add DSI host driver
In-Reply-To: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
References: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
Message-ID: <1496414235-20098-6-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for the STM32
DSI host driver based on the Synopsys DW MIPI DSI bridge driver.
---
 .../devicetree/bindings/display/st,stm32-ltdc.txt  | 83 +++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
index 90a8459..4cd32bd 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
@@ -12,8 +12,39 @@
   Required nodes:
     - Video port for RGB output.
 
-Example:
+* STMicroelectronics STM32 dsi specific extensions to Synopsys DesignWare MIPI
+  DSI host controller
 
+The STMicroelectronics STM32 dsi driver uses the Synopsys DesignWare MIPI
+DSI host controller driver (related documentation in [5]).
+
+Required properties:
+- #address-cells: Should be <1>.
+- #size-cells: Should be <0>.
+- compatible: "st,stm32-dsi".
+- reg: Memory mapped base address and length of the DWC MIPI DSI registers.
+- clocks: References to all the clocks specified in the clock-names property
+  as specified in [1].
+- clock-names:
+  - peripheral clock string name, must be "pclk".
+  - phy pll reference clock string name, must be "ref".
+- resets: References to all the resets specified in the reset-names property
+  as specified in [2].
+- reset-names: string reset name, must be "apb".
+
+Required nodes:
+- dsi input port node: connected to the ltdc rgb output port, see [3] & [4].
+- panel or bridge node: see [6].
+
+Note: You can find more documentation
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
@@ -33,3 +64,53 @@ Example:
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
+			port {
+				dsi_in: endpoint {
+					remote-endpoint = <&ltdc_out_dsi>;
+				};
+			};
+
+			panel-dsi at 0 {
+				reg = <0>; /* dsi virtual channel (0..3) */
+				compatible = ...;
+				enable-gpios = ...;
+
+			};
+
+		};
+
+	};
+};
-- 
1.9.1
