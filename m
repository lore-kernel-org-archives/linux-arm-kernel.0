From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 20 Jan 2017 16:18:41 +0800
Subject: [PATCH v2,
 6/6] dt-bindings: phy-mt65xx-usb: add support for new version phy
In-Reply-To: <1484900321-26933-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1484900321-26933-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1484900321-26933-6-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a new compatible string for "mt2712", and move reference clock
into each port node;

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/phy/phy-mt65xx-usb.txt     |   91 +++++++++++++++++---
 1 file changed, 77 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
index 33a2b1e..1d06604 100644
--- a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
@@ -6,21 +6,27 @@ This binding describes a usb3.0 phy for mt65xx platforms of Medaitek SoC.
 Required properties (controller (parent) node):
  - compatible	: should be one of
 		  "mediatek,mt2701-u3phy"
+		  "mediatek,mt2712-u3phy"
 		  "mediatek,mt8173-u3phy"
- - reg		: offset and length of register for phy, exclude port's
-		  register.
- - clocks	: a list of phandle + clock-specifier pairs, one for each
-		  entry in clock-names
- - clock-names	: must contain
-		  "u3phya_ref": for reference clock of usb3.0 analog phy.
 
 Required nodes	: a sub-node is required for each port the controller
 		  provides. Address range information including the usual
 		  'reg' property is used inside these nodes to describe
 		  the controller's topology.
 
+Optional properties (controller (parent) node):
+ - reg		: offset and length of register shared by multiple ports,
+		  exclude port's private register. It is needed on mt2701
+		  and mt8173, but not on mt2712.
+
 Required properties (port (child) node):
 - reg		: address and length of the register set for the port.
+- clocks	: a list of phandle + clock-specifier pairs, one for each
+		  entry in clock-names
+- clock-names	: must contain
+		  "ref_clk": 48M reference clock for HighSpeed analog phy; and
+			26M reference clock for SuperSpeed analog phy, sometimes is
+			24M, 25M or 27M, depended on platform.
 - #phy-cells	: should be 1 (See second example)
 		  cell after port phandle is phy type from:
 			- PHY_TYPE_USB2
@@ -31,21 +37,31 @@ Example:
 u3phy: usb-phy at 11290000 {
 	compatible = "mediatek,mt8173-u3phy";
 	reg = <0 0x11290000 0 0x800>;
-	clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
-	clock-names = "u3phya_ref";
 	#address-cells = <2>;
 	#size-cells = <2>;
 	ranges;
 	status = "okay";
 
-	phy_port0: port at 11290800 {
-		reg = <0 0x11290800 0 0x800>;
+	u2port0: port at 11290800 {
+		reg = <0 0x11290800 0 0x100>;
+		clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
+		clock-names = "ref_clk";
 		#phy-cells = <1>;
 		status = "okay";
 	};
 
-	phy_port1: port at 11291000 {
-		reg = <0 0x11291000 0 0x800>;
+	u3port0: port at 11290900 {
+		reg = <0 0x11290800 0 0x700>;
+		clocks = <&clk26m>;
+		clock-names = "ref_clk";
+		#phy-cells = <1>;
+		status = "okay";
+	};
+
+	u2port1: port at 11291000 {
+		reg = <0 0x11291000 0 0x100>;
+		clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
+		clock-names = "ref_clk";
 		#phy-cells = <1>;
 		status = "okay";
 	};
@@ -64,7 +80,54 @@ Example:
 
 usb30: usb at 11270000 {
 	...
-	phys = <&phy_port0 PHY_TYPE_USB3>;
-	phy-names = "usb3-0";
+	phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
+	phy-names = "usb2-0", "usb3-0";
 	...
 };
+
+
+Layout differences of banks between mt8173/mt2701 and mt2712
+-------------------------------------------------------------
+mt8173 and mt2701:
+port        offset    bank
+shared      0x0000    SPLLC
+            0x0100    FMREG
+u2 port0    0x0800    U2PHY_COM
+u3 port0    0x0900    U3PHYD
+            0x0a00    U3PHYD_BANK2
+            0x0b00    U3PHYA
+            0x0c00    U3PHYA_DA
+u2 port1    0x1000    U2PHY_COM
+u3 port1    0x1100    U3PHYD
+            0x1200    U3PHYD_BANK2
+            0x1300    U3PHYA
+            0x1400    U3PHYA_DA
+u2 port2    0x1800    U2PHY_COM
+            ...
+
+mt2712:
+port        offset    bank
+u2 port0    0x0000    MISC
+            0x0100    FMREG
+            0x0300    U2PHY_COM
+u3 port0    0x0700    SPLLC
+            0x0800    CHIP
+            0x0900    U3PHYD
+            0x0a00    U3PHYD_BANK2
+            0x0b00    U3PHYA
+            0x0c00    U3PHYA_DA
+u2 port1    0x1000    MISC
+            0x1100    FMREG
+            0x1300    U2PHY_COM
+u3 port1    0x1700    SPLLC
+            0x1800    CHIP
+            0x1900    U3PHYD
+            0x1a00    U3PHYD_BANK2
+            0x1b00    U3PHYA
+            0x1c00    U3PHYA_DA
+u2 port2    0x2000    MISC
+            ...
+
+    SPLLC shared by u3 ports and FMREG shared by u2 ports on
+mt8173/mt2701 are put back into each port; a new bank MISC for
+u2 ports and CHIP for u3 ports are added on mt2712.
-- 
1.7.9.5
