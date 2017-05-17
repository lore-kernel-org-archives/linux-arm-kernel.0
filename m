From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:45 +0200
Subject: [PATCH v3 16/21] dt-bindings: display: sun4i: Add HDMI display
 bindings
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <67bd9d191ce9cc8a172abbc558901ac79da9daab.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the possible output of the display pipeline, on the SoCs that have
it, is the HDMI controller.

Add a binding for it.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 79 +++++++-
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 7acdbf14ae1c..e74794f20ec5 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -14,6 +14,34 @@ Conversely, for the output ports of the same group, the remote endpoint
 ID must be the index of the local hardware block. If the local backend
 is backend 1, then the remote endpoint ID must be 1.
 
+HDMI Encoder
+------------
+
+The HDMI Encoder supports the HDMI video and audio outputs, and does
+CEC. It is one end of the pipeline.
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun5i-a10s-hdmi
+  - reg: base address and size of memory-mapped region
+  - interrupts: interrupt associated to this IP
+  - clocks: phandles to the clocks feeding the HDMI encoder
+    * ahb: the HDMI interface clock
+    * mod: the HDMI module clock
+    * pll-0: the first video PLL
+    * pll-1: the second video PLL
+  - clock-names: the clock names mentioned above
+  - dmas: phandles to the DMA channels used by the HDMI encoder
+    * ddc-tx: The channel for DDC transmission
+    * ddc-rx: The channel for DDC reception
+    * audio-tx: The channel used for audio transmission
+  - dma-names: the channel names mentioned above
+
+  - ports: A ports node with endpoint definitions as defined in
+    Documentation/devicetree/bindings/media/video-interfaces.txt. The
+    first port should be the input endpoint. The second should be the
+    output, usually to an HDMI connector.
+
 TV Encoder
 ----------
 
@@ -183,6 +211,57 @@ panel: panel {
 	};
 };
 
+connector {
+	compatible = "hdmi-connector";
+	type = "a";
+
+	port {
+		hdmi_con_in: endpoint {
+			remote-endpoint = <&hdmi_out_con>;
+		};
+	};
+};
+
+hdmi: hdmi at 01c16000 {
+	compatible = "allwinner,sun5i-a10s-hdmi";
+	reg = <0x01c16000 0x1000>;
+	interrupts = <58>;
+	clocks = <&ccu CLK_AHB_HDMI>, <&ccu CLK_HDMI>,
+		 <&ccu CLK_PLL_VIDEO0_2X>,
+		 <&ccu CLK_PLL_VIDEO1_2X>;
+	clock-names = "ahb", "mod", "pll-0", "pll-1";
+	dmas = <&dma SUN4I_DMA_NORMAL 16>,
+	       <&dma SUN4I_DMA_NORMAL 16>,
+	       <&dma SUN4I_DMA_DEDICATED 24>;
+	dma-names = "ddc-tx", "ddc-rx", "audio-tx";
+	status = "disabled";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			hdmi_in_tcon0: endpoint {
+				remote-endpoint = <&tcon0_out_hdmi>;
+			};
+		};
+
+		port at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			hdmi_out_con: endpoint {
+				remote-endpoint = <&hdmi_con_in>;
+			};
+		};
+	};
+};
+
 tve0: tv-encoder at 01c0a000 {
 	compatible = "allwinner,sun4i-a10-tv-encoder";
 	reg = <0x01c0a000 0x1000>;
-- 
git-series 0.9.1
