From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed, 11 Jul 2018 13:30:51 +0900
Subject: [PATCH v3 1/2] dt-bindings: regulator: add DT bindings for UniPhier
 regulator
In-Reply-To: <1531283452-9705-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1531283452-9705-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1531283452-9705-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for regulators implemented in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/regulator/uniphier-regulator.txt      | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
new file mode 100644
index 0000000..c9919f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
@@ -0,0 +1,57 @@
+Socionext UniPhier Regulator Controller
+
+This describes the devicetree bindings for regulator controller implemented
+on Socionext UniPhier SoCs.
+
+USB3 Controller
+---------------
+
+This regulator controls VBUS and belongs to USB3 glue layer. Before using
+the regulator, it is necessary to control the clocks and resets to enable
+this layer. These clocks and resets should be described in each property.
+
+Required properties:
+- compatible: Should be
+    "socionext,uniphier-pro4-usb3-regulator" - for Pro4 SoC
+    "socionext,uniphier-pxs2-usb3-regulator" - for PXs2 SoC
+    "socionext,uniphier-ld20-usb3-regulator" - for LD20 SoC
+    "socionext,uniphier-pxs3-usb3-regulator" - for PXs3 SoC
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
+See Documentation/devicetree/bindings/regulator/regulator.txt
+for more details about the regulator properties.
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
+		usb_vbus0: regulators at 100 {
+			compatible = "socionext,uniphier-ld20-usb3-regulator";
+			reg = <0x100 0x10>;
+			clock-names = "link";
+			clocks = <&sys_clk 14>;
+			reset-names = "link";
+			resets = <&sys_rst 14>;
+		};
+
+		phy {
+			...
+			phy-supply = <&usb_vbus0>;
+		};
+		...
+	};
-- 
2.7.4
