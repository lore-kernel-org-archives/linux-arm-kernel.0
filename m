From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 16 Feb 2017 19:03:57 +0100
Subject: [PATCH 2/2] media: dt-bindings: vpif: extend the example with an
 output port
In-Reply-To: <1487268237-4240-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487268237-4240-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487268237-4240-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the example more or less correspond with the da850-evm
hardware setup.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/media/ti,da850-vpif.txt    | 36 +++++++++++++++++-----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
index 9c7510b..d6f93a1 100644
--- a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
+++ b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
@@ -16,7 +16,7 @@ Required properties:
 Video Capture:
 
 VPIF has a 16-bit parallel bus input, supporting 2 8-bit channels or a
-single 16-bit channel.  It should contain at least one port child node
+single 16-bit channel. It should contain one or two port child nodes
 with child 'endpoint' node. Please refer to the bindings defined in
 Documentation/devicetree/bindings/media/video-interfaces.txt.
 
@@ -28,19 +28,26 @@ I2C-connected TVP5147 decoder:
 		reg = <0x217000 0x1000>;
 		interrupts = <92>;
 
-		port {
-			vpif_ch0: endpoint at 0 {
+		port at 0 {
+			vpif_input_ch0: endpoint at 0 {
 				reg = <0>;
 				bus-width = <8>;
-				remote-endpoint = <&composite>;
+				remote-endpoint = <&composite_in>;
 			};
 
-			vpif_ch1: endpoint at 1 {
+			vpif_input_ch1: endpoint at 1 {
 				reg = <1>;
 				bus-width = <8>;
 				data-shift = <8>;
 			};
 		};
+
+		port at 1 {
+			vpif_output_ch0: endpoint {
+				bus-width = <8>;
+				remote-endpoint = <&composite_out>;
+			};
+		};
 	};
 
 [ ... ]
@@ -53,13 +60,28 @@ I2C-connected TVP5147 decoder:
 		status = "okay";
 
 		port {
-			composite: endpoint {
+			composite_in: endpoint {
 				hsync-active = <1>;
 				vsync-active = <1>;
 				pclk-sample = <0>;
 
 				/* VPIF channel 0 (lower 8-bits) */
-				remote-endpoint = <&vpif_ch0>;
+				remote-endpoint = <&vpif_input_ch0>;
+				bus-width = <8>;
+			};
+		};
+	};
+
+	adv7343 at 2a {
+		compatible = "adi,adv7343";
+		reg = <0x2a>;
+
+		port {
+			composite_out: endpoint {
+				adi,dac-enable = <1 1 1>;
+				adi,sd-dac-enable = <1>;
+
+				remote-endpoint = <&vpif_output_ch0>;
 				bus-width = <8>;
 			};
 		};
-- 
2.9.3
