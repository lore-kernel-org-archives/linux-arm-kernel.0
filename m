From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri,  3 Aug 2018 18:54:02 +0900
Subject: [PATCH v2 1/4] dt-bindings: phy: add DT bindings for UniPhier USB3
 PHY driver
In-Reply-To: <1533290045-18969-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1533290045-18969-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1533290045-18969-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for PHY interface built into USB3 controller
implemented in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/phy/uniphier-usb3-hsphy.txt           | 69 ++++++++++++++++++++++
 .../bindings/phy/uniphier-usb3-ssphy.txt           | 57 ++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt

diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
new file mode 100644
index 0000000..e8d8086
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
@@ -0,0 +1,69 @@
+Socionext UniPhier USB3 High-Speed (HS) PHY
+
+This describes the devicetree bindings for PHY interfaces built into
+USB3 controller implemented on Socionext UniPhier SoCs.
+Although the controller includes High-Speed PHY and Super-Speed PHY,
+this describes about High-Speed PHY.
+
+Required properties:
+- compatible: Should contain one of the following:
+    "socionext,uniphier-pro4-usb3-hsphy" - for Pro4 SoC
+    "socionext,uniphier-pxs2-usb3-hsphy" - for PXs2 SoC
+    "socionext,uniphier-ld20-usb3-hsphy" - for LD20 SoC
+    "socionext,uniphier-pxs3-usb3-hsphy" - for PXs3 SoC
+- reg: Specifies offset and length of the register set for the device.
+- #phy-cells: Should be 0.
+- clocks: A list of phandles to the clock gate for USB3 glue layer.
+	According to the clock-names, appropriate clocks are required.
+- clock-names: Should contain the following:
+    "gio", "link" - for Pro4 SoC
+    "phy", "phy-ext", "link" - for PXs3 SoC, "phy-ext" is optional.
+    "phy", "link" - for others
+- resets: A list of phandles to the reset control for USB3 glue layer.
+	According to the reset-names, appropriate resets are required.
+- reset-names: Should contain the following:
+    "gio", "link" - for Pro4 SoC
+    "phy", "link" - for others
+
+Optional properties:
+- vbus-supply: A phandle to the regulator for USB VBUS.
+- nvmem-cells: Phandles to nvmem cell that contains the trimming data.
+	Available only for HS-PHY implemented on LD20 and PXs3, and
+	if unspecified, default value is used.
+- nvmem-cell-names: Should be the following names, which correspond to
+	each nvmem-cells.
+	All of the 3 parameters associated with the following names are
+	required for each port, if any one is omitted, the trimming data
+	of the port will not be set at all.
+    "rterm", "sel_t", "hs_i" - Each cell name for phy parameters
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties.
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
+		usb_vbus0: regulator {
+			...
+		};
+
+		usb_hsphy0: hs-phy at 200 {
+			compatible = "socionext,uniphier-ld20-usb3-hsphy";
+			reg = <0x200 0x10>;
+			#phy-cells = <0>;
+			clock-names = "link", "phy";
+			clocks = <&sys_clk 14>, <&sys_clk 16>;
+			reset-names = "link", "phy";
+			resets = <&sys_rst 14>, <&sys_rst 16>;
+			vbus-supply = <&usb_vbus0>;
+			nvmem-cell-names = "rterm", "sel_t", "hs_i";
+			nvmem-cells = <&usb_rterm0>, <&usb_sel_t0>,
+				      <&usb_hs_i0>;
+		};
+		...
+	};
diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
new file mode 100644
index 0000000..490b815
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
@@ -0,0 +1,57 @@
+Socionext UniPhier USB3 Super-Speed (SS) PHY
+
+This describes the devicetree bindings for PHY interfaces built into
+USB3 controller implemented on Socionext UniPhier SoCs.
+Although the controller includes High-Speed PHY and Super-Speed PHY,
+this describes about Super-Speed PHY.
+
+Required properties:
+- compatible: Should contain one of the following:
+    "socionext,uniphier-pro4-usb3-ssphy" - for Pro4 SoC
+    "socionext,uniphier-pxs2-usb3-ssphy" - for PXs2 SoC
+    "socionext,uniphier-ld20-usb3-ssphy" - for LD20 SoC
+    "socionext,uniphier-pxs3-usb3-ssphy" - for PXs3 SoC
+- reg: Specifies offset and length of the register set for the device.
+- #phy-cells: Should be 0.
+- clocks: A list of phandles to the clock gate for USB3 glue layer.
+	According to the clock-names, appropriate clocks are required.
+- clock-names:
+    "gio", "link" - for Pro4 SoC
+    "phy", "phy-ext", "link" - for PXs3 SoC, "phy-ext" is optional.
+    "phy", "link" - for others
+- resets: A list of phandles to the reset control for USB3 glue layer.
+	According to the reset-names, appropriate resets are required.
+- reset-names:
+    "gio", "link" - for Pro4 SoC
+    "phy", "link" - for others
+
+Optional properties:
+- vbus-supply: A phandle to the regulator for USB VBUS.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties.
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
+		usb_vbus0: regulator {
+			...
+		};
+
+		usb_ssphy0: ss-phy at 300 {
+			compatible = "socionext,uniphier-ld20-usb3-ssphy";
+			reg = <0x300 0x10>;
+			#phy-cells = <0>;
+			clock-names = "link", "phy";
+			clocks = <&sys_clk 14>, <&sys_clk 16>;
+			reset-names = "link", "phy";
+			resets = <&sys_rst 14>, <&sys_rst 16>;
+			vbus-supply = <&usb_vbus0>;
+		};
+		...
+	};
-- 
2.7.4
