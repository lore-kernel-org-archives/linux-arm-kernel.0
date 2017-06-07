From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed,  7 Jun 2017 11:33:40 -0700
Subject: [PATCH v8 01/34] dt-bindings: Add bindings for video-multiplexer
 device
In-Reply-To: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1496860453-6282-2-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Add bindings documentation for the video multiplexer device.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 .../devicetree/bindings/media/video-mux.txt        | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/video-mux.txt

diff --git a/Documentation/devicetree/bindings/media/video-mux.txt b/Documentation/devicetree/bindings/media/video-mux.txt
new file mode 100644
index 0000000..63b9dc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/video-mux.txt
@@ -0,0 +1,60 @@
+Video Multiplexer
+=================
+
+Video multiplexers allow to select between multiple input ports. Video received
+on the active input port is passed through to the output port. Muxes described
+by this binding are controlled by a multiplexer controller that is described by
+the bindings in Documentation/devicetree/bindings/mux/mux-controller.txt
+
+Required properties:
+- compatible : should be "video-mux"
+- mux-controls : mux controller node to use for operating the mux
+- #address-cells: should be <1>
+- #size-cells: should be <0>
+- port@*: at least three port nodes containing endpoints connecting to the
+  source and sink devices according to of_graph bindings. The last port is
+  the output port, all others are inputs.
+
+Optionally, #address-cells, #size-cells, and port nodes can be grouped under a
+ports node as described in Documentation/devicetree/bindings/graph.txt.
+
+Example:
+
+	mux: mux-controller {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+	};
+
+	video-mux {
+		compatible = "video-mux";
+		mux-controls = <&mux>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+
+			mux_in0: endpoint {
+				remote-endpoint = <&video_source0_out>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+
+			mux_in1: endpoint {
+				remote-endpoint = <&video_source1_out>;
+			};
+		};
+
+		port at 2 {
+			reg = <2>;
+
+			mux_out: endpoint {
+				remote-endpoint = <&capture_interface_in>;
+			};
+		};
+	};
+};
-- 
2.7.4
