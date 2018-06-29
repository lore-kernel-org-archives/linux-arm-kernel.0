From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 29 Jun 2018 17:11:30 +0900
Subject: [PATCH 1/2] dt-bindings: reset: uniphier: add USB3 controller reset
 support
In-Reply-To: <1530259891-18822-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1530259891-18822-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1530259891-18822-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for reset control of USB3 controller implemented in
UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/reset/uniphier-reset.txt   | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
index 93efed6..f21d81c 100644
--- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -118,3 +118,48 @@ Example:
 
 		other nodes ...
 	};
+
+
+USB3 controller reset
+---------------------
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
+			clock-names = "link";
+			resets = <&sys_rst 14>;
+		};
+
+		other nodes ...
+	};
-- 
2.7.4
