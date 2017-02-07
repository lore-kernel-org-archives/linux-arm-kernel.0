From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue,  7 Feb 2017 17:41:16 +0100
Subject: [PATCH 03/10] media: dt-bindings: vpif: extend the example with an
 output port
In-Reply-To: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1486485683-11427-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the example more or less correspond with the da850-evm
hardware setup.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/media/ti,da850-vpif.txt    | 35 ++++++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
index 9c7510b..543f6f3 100644
--- a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
+++ b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
@@ -28,19 +28,27 @@ I2C-connected TVP5147 decoder:
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
+			vpif_output_ch0: endpoint at 0 {
+				reg = <0>;
+				bus-width = <8>;
+				remote-endpoint = <&composite_out>;
+			};
+		};
 	};
 
 [ ... ]
@@ -53,13 +61,28 @@ I2C-connected TVP5147 decoder:
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
