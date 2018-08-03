From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri,  3 Aug 2018 18:54:04 +0900
Subject: [PATCH v2 3/4] dt-bindings: phy: add DT bindings for UniPhier USB2
 PHY driver
In-Reply-To: <1533290045-18969-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1533290045-18969-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1533290045-18969-4-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for PHY interface built into USB2 controller
implemented on Socionext UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/phy/uniphier-usb2-phy.txt  | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
new file mode 100644
index 0000000..b43b282
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
@@ -0,0 +1,45 @@
+Socionext UniPhier USB2 PHY
+
+This describes the devicetree bindings for PHY interface built into
+USB2 controller implemented on Socionext UniPhier SoCs.
+
+Pro4 SoC has both USB2 and USB3 host controllers, however, this USB3
+controller doesn't include its own High-Speed PHY. This needs to specify
+USB2 PHY instead of USB3 HS-PHY.
+
+Required properties:
+- compatible: Should contain one of the following:
+    "socionext,uniphier-pro4-usb2-phy" - for Pro4 SoC
+    "socionext,uniphier-ld11-usb2-phy" - for LD11 SoC
+
+Sub-nodes:
+Each PHY should be represented as a sub-node.
+
+Sub-nodes required properties:
+- #phy-cells: Should be 0.
+- reg: The number of the PHY.
+
+Sub-nodes optional properties:
+- vbus-supply: A phandle to the regulator for USB VBUS.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties.
+
+Example:
+	soc-glue at 5f800000 {
+		...
+		usb-phy {
+			compatible = "socionext,uniphier-ld11-usb2-phy";
+			usb_phy0: phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+			...
+		};
+	};
+
+	usb at 5a800100 {
+		compatible = "socionext,uniphier-ehci", "generic-ehci";
+		...
+		phy-names = "usb";
+		phys = <&usb_phy0>;
+	};
-- 
2.7.4
