From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Mar 2016 17:38:36 +0100
Subject: [PATCH v3 13/19] drm: sun4i: Add DT bindings documentation
In-Reply-To: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1458751122-23976-14-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display pipeline of the Allwinner A10 is involving several loosely
coupled components.

Add a documentation for the bindings.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../bindings/display/sunxi/sun4i-drm.txt           | 254 +++++++++++++++++++++
 1 file changed, 254 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
new file mode 100644
index 000000000000..378edb919eae
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -0,0 +1,254 @@
+Allwinner A10 Display Pipeline
+==============================
+
+The Allwinner A10 Display pipeline is composed of several components
+that are going to be documented below:
+
+TV Encoder
+----------
+
+The TV Encoder supports the composite and VGA output. It is one end of
+the pipeline.
+
+Required properties:
+ - compatible: value should be "allwinner,sun4i-a10-tv-encoder".
+ - reg: base address and size of memory-mapped region
+ - clocks: the clocks driving the TV encoder
+ - resets: phandle to the reset controller driving the encoder
+
+- ports: A ports node with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt. The
+  first port should be the input endpoint.
+
+TCON
+----
+
+The TCON acts as a timing controller for RGB, LVDS and TV interfaces.
+
+Required properties:
+ - compatible: value should be "allwinner,sun5i-a13-tcon".
+ - reg: base address and size of memory-mapped region
+ - interrupts: interrupt associated to this IP
+ - clocks: phandles to the clocks feeding the TCON. Three are needed:
+   - 'ahb': the interface clocks
+   - 'tcon-ch0': The clock driving the TCON channel 0
+   - 'tcon-ch1': The clock driving the TCON channel 1
+ - resets: phandles to the reset controllers driving the encoder
+   - "lcd": the reset line for the TCON channel 0
+
+ - clock-names: the clock names mentioned above
+ - reset-names: the reset names mentioned above
+ - clock-output-names: Name of the pixel clock created
+
+- ports: A ports node with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt. The
+  first port should be the input endpoint, the second one the output
+
+Endpoints optional property:
+  - allwinner,panel: boolean to indicate that the endpoint is a panel
+
+
+Display Engine Backend
+----------------------
+
+The display engine backend exposes layers and sprites to the
+system.
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun5i-a13-display-backend
+  - reg: base address and size of the memory-mapped region.
+  - clocks: phandles to the clocks feeding the frontend and backend
+    * ahb: the backend interface clock
+    * mod: the backend module clock
+    * ram: the backend DRAM clock
+  - clock-names: the clock names mentioned above
+  - resets: phandles to the reset controllers driving the backend
+
+- ports: A ports node with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt. The
+  first port should be the input endpoints, the second one the output
+
+Display Engine Frontend
+-----------------------
+
+The display engine frontend does formats conversion, scaling,
+deinterlacing and color space conversion.
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun5i-a13-display-frontend
+  - reg: base address and size of the memory-mapped region.
+  - interrupts: interrupt associated to this IP
+  - clocks: phandles to the clocks feeding the frontend and backend
+    * ahb: the backend interface clock
+    * mod: the backend module clock
+    * ram: the backend DRAM clock
+  - clock-names: the clock names mentioned above
+  - resets: phandles to the reset controllers driving the backend
+
+Display Engine Pipeline
+-----------------------
+
+The display engine pipeline (and its entry point, since it can be
+either directly the backend or the frontend) is represented as an
+extra node.
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun5i-a13-display-engine
+  - allwinner,pipelines: list of phandle to the entry points of the
+    pipelines (either to the frontend or backend)
+
+Example:
+
+panel: panel {
+	compatible = "olimex,lcd-olinuxino-43-ts";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port at 0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		panel_input: endpoint at 0 {
+			reg = <0>;
+			remote-endpoint = <&tcon0_out_panel>;
+		};
+	};
+};
+
+tve0: tv-encoder at 01c0a000 {
+	compatible = "allwinner,sun4i-a10-tv-encoder";
+	reg = <0x01c0a000 0x1000>;
+	clocks = <&ahb_gates 34>;
+	resets = <&tcon_ch0_clk 0>;
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		tve0_in_tcon0: endpoint at 0 {
+			reg = <0>;
+			remote-endpoint = <&tcon0_out_tve0>;
+		};
+	};
+};
+
+tcon0: lcd-controller at 01c0c000 {
+	compatible = "allwinner,sun5i-a13-tcon";
+	reg = <0x01c0c000 0x1000>;
+	interrupts = <44>;
+	resets = <&tcon_ch0_clk 1>;
+	reset-names = "lcd";
+	clocks = <&ahb_gates 36>,
+		 <&tcon_ch0_clk>,
+		 <&tcon_ch1_clk>;
+	clock-names = "ahb",
+		      "tcon-ch0",
+		      "tcon-ch1";
+	clock-output-names = "tcon-pixel-clock";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		tcon0_in: port at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			tcon0_in_be0: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&be0_out_tcon0>;
+			};
+		};
+
+		tcon0_out: port at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			tcon0_out_tve0: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&tve0_in_tcon0>;
+			};
+
+			tcon0_out_panel: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&panel_input>;
+				allwinner,panel;
+			};
+		};
+	};
+};
+
+fe0: display-frontend at 01e00000 {
+	compatible = "allwinner,sun5i-a13-display-frontend";
+	reg = <0x01e00000 0x20000>;
+	interrupts = <47>;
+	clocks = <&ahb_gates 46>, <&de_fe_clk>,
+		 <&dram_gates 25>;
+	clock-names = "ahb", "mod",
+		      "ram";
+	resets = <&de_fe_clk>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fe0_out: port at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			fe0_out_be0: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&be0_in_fe0>;
+			};
+		};
+	};
+};
+
+be0: display-backend at 01e60000 {
+	compatible = "allwinner,sun5i-a13-display-backend";
+	reg = <0x01e60000 0x10000>;
+	clocks = <&ahb_gates 44>, <&de_be_clk>,
+		 <&dram_gates 26>;
+	clock-names = "ahb", "mod",
+		      "ram";
+	resets = <&de_be_clk>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		be0_in: port at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			be0_in_fe0: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&fe0_out_be0>;
+			};
+		};
+
+		be0_out: port at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			be0_out_tcon0: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&tcon0_in_be0>;
+			};
+		};
+	};
+};
+
+display-engine {
+	compatible = "allwinner,sun5i-a13-display-engine";
+	pipelines = <&be0>;
+};
-- 
2.7.3
