From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 27 Mar 2017 17:40:18 -0700
Subject: [PATCH v6 01/39] [media] dt-bindings: Add bindings for
 video-multiplexer device
In-Reply-To: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1490661656-10318-2-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Add bindings documentation for the video multiplexer device.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 .../bindings/media/video-multiplexer.txt           | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/video-multiplexer.txt

diff --git a/Documentation/devicetree/bindings/media/video-multiplexer.txt b/Documentation/devicetree/bindings/media/video-multiplexer.txt
new file mode 100644
index 0000000..9d133d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/video-multiplexer.txt
@@ -0,0 +1,59 @@
+Video Multiplexer
+=================
+
+Video multiplexers allow to select between multiple input ports. Video received
+on the active input port is passed through to the output port. Muxes described
+by this binding may be controlled by a syscon register bitfield or by a GPIO.
+
+Required properties:
+- compatible : should be "video-multiplexer"
+- reg: should be register base of the register containing the control bitfield
+- bit-mask: bitmask of the control bitfield in the control register
+- bit-shift: bit offset of the control bitfield in the control register
+- gpios: alternatively to reg, bit-mask, and bit-shift, a single GPIO phandle
+  may be given to switch between two inputs
+- #address-cells: should be <1>
+- #size-cells: should be <0>
+- port@*: at least three port nodes containing endpoints connecting to the
+  source and sink devices according to of_graph bindings. The last port is
+  the output port, all others are inputs.
+
+Example:
+
+syscon {
+	compatible = "syscon", "simple-mfd";
+
+	mux {
+		compatible = "video-multiplexer";
+		/* Single bit (1 << 19) in syscon register 0x04: */
+		reg = <0x04>;
+		bit-mask = <1>;
+		bit-shift = <19>;
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
