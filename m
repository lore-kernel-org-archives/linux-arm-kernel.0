From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 10 Jul 2018 10:14:16 +0900
Subject: [PATCH v2 1/2] dt-bindings: reset: uniphier: add USB3 core reset
 support
In-Reply-To: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1531185257-16444-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for reset control of USB3 core implemented in UniPhier SoCs.
The reset control belongs to USB3 glue layer.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/reset/uniphier-reset.txt   | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
index 93efed6..101743d 100644
--- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -118,3 +118,59 @@ Example:
 
 		other nodes ...
 	};
+
+
+USB3 core reset
+---------------
+
+USB3 core reset belongs to USB3 glue layer. Before using the core reset,
+it is necessary to control the clocks and resets to enable this layer.
+These clocks and resets should be described in each property.
+
+Required properties:
+- compatible: Should be
+    "socionext,uniphier-pro4-usb3-reset" - for Pro4 SoC
+    "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC
+    "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC
+    "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC
+- #reset-cells: Should be 1.
+- reg: Specifies offset and length of the register set for the device.
+- clocks: A list of phandles to the clock gate for USB3 glue layer.
+	According to the clock-names, appropriate clocks are required.
+- clock-names: Should contain
+    "gio", "link" - for Pro4 SoC
+    "link"        - for others
+- resets: A list of phandles to the reset control for USB3 glue layer.
+	According to the reset-names, appropriate resets are required.
+- reset-names: Should contain
+    "gio", "link" - for Pro4 SoC
+    "link"        - for others
+
+Example:
+
+	usb-glue at 65b00000 {
+		compatible = "socionext,uniphier-ld20-dwc3-glue",
+			     "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x65b00000 0x400>;
+
+		usb_rst: reset at 0 {
+			compatible = "socionext,uniphier-ld20-usb3-reset";
+			reg = <0x0 0x4>;
+			#reset-cells = <1>;
+			clock-names = "link";
+			clocks = <&sys_clk 14>;
+			reset-names = "link";
+			resets = <&sys_rst 14>;
+		};
+
+		regulator {
+			...
+		};
+
+		phy {
+			...
+		};
+		...
+	};
-- 
2.7.4
