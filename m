From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 29 Nov 2016 15:57:12 -0800
Subject: [PATCH v4 4/4] [media] dt-bindings: add TI VPIF documentation
In-Reply-To: <20161129235712.29846-1-khilman@baylibre.com>
References: <20161129235712.29846-1-khilman@baylibre.com>
Message-ID: <20161129235712.29846-5-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 .../devicetree/bindings/media/ti,da850-vpif.txt    | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/ti,da850-vpif.txt

diff --git a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
new file mode 100644
index 000000000000..fa06dfdb6898
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
@@ -0,0 +1,67 @@
+Texas Instruments VPIF
+----------------------
+
+The TI Video Port InterFace (VPIF) is the primary component for video
+capture and display on the DA850/AM18x family of TI DaVinci/Sitara
+SoCs.
+
+TI Document reference: SPRUH82C, Chapter 35
+http://www.ti.com/lit/pdf/spruh82
+
+Required properties:
+- compatible: must be "ti,da850-vpif"
+- reg: physical base address and length of the registers set for the device;
+- interrupts: should contain IRQ line for the VPIF
+
+Video Capture:
+
+VPIF has a 16-bit parallel bus input, supporting 2 8-bit channels or a
+single 16-bit channel.  It should contain at least one port child node
+with child 'endpoint' node. Please refer to the bindings defined in
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Example using 2 8-bit input channels, one of which is connected to an
+I2C-connected TVP5147 decoder:
+
+	vpif: vpif at 217000 {
+		compatible = "ti,da850-vpif";
+		reg = <0x217000 0x1000>;
+		interrupts = <92>;
+
+		port {
+			vpif_ch0: endpoint at 0 {
+				  reg = <0>;
+				  bus-width = <8>;
+				  remote-endpoint = <&composite>;
+			};
+
+			vpif_ch1: endpoint at 1 {
+				  reg = <1>;
+				  bus-width = <8>;
+				  data-shift = <8>;
+			};
+		};
+	};
+
+[ ... ]
+
+&i2c0 {
+
+	tvp5147 at 5d {
+		compatible = "ti,tvp5147";
+		reg = <0x5d>;
+		status = "okay";
+
+		port {
+			composite: endpoint {
+				hsync-active = <1>;
+				vsync-active = <1>;
+				pclk-sample = <0>;
+
+				/* VPIF channel 0 (lower 8-bits) */
+				remote-endpoint = <&vpif_ch0>;
+				bus-width = <8>;
+			};
+		};
+	};
+};
-- 
2.9.3
