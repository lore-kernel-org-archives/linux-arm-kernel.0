From: yannick.fertre@st.com (Yannick Fertre)
Date: Mon, 16 Jan 2017 14:28:58 +0100
Subject: [PATCH v1 1/7] dt-bindings: display: add STM32 LTDC driver
In-Reply-To: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
References: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1484573344-11609-2-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 .../devicetree/bindings/display/st,ltdc.txt        | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/st,ltdc.txt

diff --git a/Documentation/devicetree/bindings/display/st,ltdc.txt b/Documentation/devicetree/bindings/display/st,ltdc.txt
new file mode 100644
index 0000000..20e89da
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/st,ltdc.txt
@@ -0,0 +1,57 @@
+* STMicroelectronics STM32 lcd-tft display controller
+
+- st-display-subsystem: Master device for DRM sub-components
+  This device must be the parent of all the sub-components and is responsible
+  of bind them.
+  Required properties:
+  - compatible: "st,display-subsystem"
+  - ranges: to allow probing of subdevices
+
+- ltdc_host: lcd-tft display controller host
+  must be a sub-node of st-display-subsystem
+  Required properties:
+  - compatible: "st,ltdc"
+  - reg: Physical base address of the IP registers and length of memory mapped region.
+  - clocks: from common clock binding: handle hardware IP needed clocks, the
+    number of clocks may depend of the SoC type.
+    See ../clocks/clock-bindings.txt for details.
+  - clock-names: names of the clocks listed in clocks property in the same
+    order.
+  - resets: resets to be used by the device
+    See ../reset/reset.txt for details.
+  - reset-names: names of the resets listed in resets property in the same
+    order.
+  Required nodes:
+    - Video port for RGB output.
+
+Example:
+
+/ {
+	...
+	soc {
+	...
+		st-display-subsystem {
+			compatible = "st,display-subsystem";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			dma-ranges;
+
+			ltdc_host: stm32-ltdc at 40016800 {
+				compatible = "st,ltdc";
+				reg = <0x40016800 0x200>;
+				interrupts = <88>, <89>;
+				resets = <&rcc 314>;
+				clocks = <&rcc 1 8>;
+				clock-names = "clk-lcd";
+				status = "disabled";
+
+				port {
+					ltdc_out_rgb: endpoint {
+					};
+				};
+			};
+		};
+	...
+	};
+};
-- 
1.9.1
