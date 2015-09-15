From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Tue, 15 Sep 2015 17:37:07 +0800
Subject: [PATCH RFC 1/8] dt-bindings: Document the hi6220 bindings for DRM
 driver
In-Reply-To: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <1442309834-21420-2-git-send-email-kong.kongxinwei@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the
Graphics Processing Unit of hi6220 SOC.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
Signed-off-by: Yu Gong <gongyu@hisilicon.com>
---
 .../devicetree/bindings/gpu/hisilicon,hi6220.txt   | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/hisilicon,hi6220.txt

diff --git a/Documentation/devicetree/bindings/gpu/hisilicon,hi6220.txt b/Documentation/devicetree/bindings/gpu/hisilicon,hi6220.txt
new file mode 100644
index 0000000..173ac63
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/hisilicon,hi6220.txt
@@ -0,0 +1,69 @@
+ * Hisilicon hi6220 Graphics Processing Unit for HiKey board
+
+ ** display-subsystem: Master device for binding DRM sub-components
+    This master device is parent node and it will be responsible to bind all
+    sub-components devices node.
+    - Required properties :
+      - compatible: "hisilicon,display-subsystem".
+      - #address-cells, #size-cells: Must be present if the device has sub-nodes.
+      - ranges: to allow probing of subdevices.
+      - dma-coherent: Present if dma operations are coherent.
+
+ ** ade: Graphic overlay, Graphic post-processing, display timing control.
+    This device is child node of display-subsystem
+    - Required properties :
+      - compatible: "hisilicon,hi6220-ade".
+      - reg: physical base address of the ADE register and length of memory
+	region.
+      - reg-names: Should contain the reg names "ade_base" and "media_base".
+      - interrupt: The interrupt number to the cpu. Defines the interrupt
+        by ADE.
+      - clocks: The clocks needed by the ADE module.
+      - clock-names: the name of the clocks.
+
+ ** dsi: support mipi dsi interface
+    This device is child node of display-subsystem
+    - Required properties :
+      - compatible: "hisilicon,hi6220-dsi".
+      - reg: physical base address of the DSI register and length of memory
+	region.
+      - clocks: The clocks needed by the DSI module.
+      - clock-names: the name of the clocks.
+      -	encoder-slave: phandles to a 'encoder-slave' subnode which DSI connect
+        ADV7533 in order to support hdmi display.
+
+Example:
+
+	display-subsystem {
+		compatible = "hisilicon,display-subsystem";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-coherent;
+
+		ade: ade at f4100000 {
+			compatible = "hisilicon,hi6220-ade";
+			reg = <0x0 0xf4100000 0x0 0x7800>,
+			      <0x0 0xf4410000 0x0 0x1000>;
+			reg-names = "ade_base",
+				    "media_base";
+			interrupts = <0 115 4>;
+
+			clocks = <&media_ctrl HI6220_ADE_CORE>,
+				 <&media_ctrl HI6220_CODEC_JPEG>,
+				 <&media_ctrl HI6220_ADE_PIX_SRC>;
+			/*clock name*/
+			clock-names  = "clk_ade_core",
+				       "aclk_codec_jpeg_src",
+				       "clk_ade_pix";
+		};
+
+		dsi {
+			compatible = "hisilicon,hi6220-dsi";
+			reg = <0x0 0xf4107800 0x0 0x100>;
+			clocks = <&media_ctrl  HI6220_DSI_PCLK>;
+			clock-names = "pclk_dsi";
+			encoder-slave = <&adv7533>;
+		};
+	};
+
-- 
1.9.1
