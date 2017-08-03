From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 3 Aug 2017 18:01:07 +0800
Subject: [PATCH 4/4] dt-bindings: phy-mt65xx-usb: supports PCIe,
 SATA and rename file
In-Reply-To: <72854b92d5d86698e5cbb427b1009e346eb15978.1501753328.git.chunfeng.yun@mediatek.com>
References: <72854b92d5d86698e5cbb427b1009e346eb15978.1501753328.git.chunfeng.yun@mediatek.com>
Message-ID: <1501754483-10392-4-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add support for PCIe and SATA, also add some new compatibles.

due to phy-mt65xx-usb.txt holds the bindings for all mediatek SoCs
with T-PHY controller, change the name to phy-mtk-tphy.txt to
reflect that.

Change-Id: I2d9200d4c8768dc301a4c116fe0e9b8179d5911c
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/phy/phy-mt65xx-usb.txt     |  137 -------------------
 .../devicetree/bindings/phy/phy-mtk-tphy.txt       |  144 ++++++++++++++++++++
 2 files changed, 144 insertions(+), 137 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
deleted file mode 100644
index 0acc5a9..0000000
--- a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
+++ /dev/null
@@ -1,137 +0,0 @@
-mt65xx USB3.0 PHY binding
---------------------------
-
-This binding describes a usb3.0 phy for mt65xx platforms of Medaitek SoC.
-
-Required properties (controller (parent) node):
- - compatible	: should be one of
-		  "mediatek,mt2701-u3phy"
-		  "mediatek,mt2712-u3phy"
-		  "mediatek,mt8173-u3phy"
- - clocks	: (deprecated, use port's clocks instead) a list of phandle +
-		  clock-specifier pairs, one for each entry in clock-names
- - clock-names	: (deprecated, use port's one instead) must contain
-		  "u3phya_ref": for reference clock of usb3.0 analog phy.
-
-Required nodes	: a sub-node is required for each port the controller
-		  provides. Address range information including the usual
-		  'reg' property is used inside these nodes to describe
-		  the controller's topology.
-
-Optional properties (controller (parent) node):
- - reg		: offset and length of register shared by multiple ports,
-		  exclude port's private register. It is needed on mt2701
-		  and mt8173, but not on mt2712.
-
-Required properties (port (child) node):
-- reg		: address and length of the register set for the port.
-- clocks	: a list of phandle + clock-specifier pairs, one for each
-		  entry in clock-names
-- clock-names	: must contain
-		  "ref": 48M reference clock for HighSpeed analog phy; and 26M
-			reference clock for SuperSpeed analog phy, sometimes is
-			24M, 25M or 27M, depended on platform.
-- #phy-cells	: should be 1 (See second example)
-		  cell after port phandle is phy type from:
-			- PHY_TYPE_USB2
-			- PHY_TYPE_USB3
-
-Example:
-
-u3phy: usb-phy at 11290000 {
-	compatible = "mediatek,mt8173-u3phy";
-	reg = <0 0x11290000 0 0x800>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-	ranges;
-	status = "okay";
-
-	u2port0: usb-phy at 11290800 {
-		reg = <0 0x11290800 0 0x100>;
-		clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
-		clock-names = "ref";
-		#phy-cells = <1>;
-		status = "okay";
-	};
-
-	u3port0: usb-phy at 11290900 {
-		reg = <0 0x11290800 0 0x700>;
-		clocks = <&clk26m>;
-		clock-names = "ref";
-		#phy-cells = <1>;
-		status = "okay";
-	};
-
-	u2port1: usb-phy at 11291000 {
-		reg = <0 0x11291000 0 0x100>;
-		clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
-		clock-names = "ref";
-		#phy-cells = <1>;
-		status = "okay";
-	};
-};
-
-Specifying phy control of devices
----------------------------------
-
-Device nodes should specify the configuration required in their "phys"
-property, containing a phandle to the phy port node and a device type;
-phy-names for each port are optional.
-
-Example:
-
-#include <dt-bindings/phy/phy.h>
-
-usb30: usb at 11270000 {
-	...
-	phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
-	phy-names = "usb2-0", "usb3-0";
-	...
-};
-
-
-Layout differences of banks between mt8173/mt2701 and mt2712
--------------------------------------------------------------
-mt8173 and mt2701:
-port        offset    bank
-shared      0x0000    SPLLC
-            0x0100    FMREG
-u2 port0    0x0800    U2PHY_COM
-u3 port0    0x0900    U3PHYD
-            0x0a00    U3PHYD_BANK2
-            0x0b00    U3PHYA
-            0x0c00    U3PHYA_DA
-u2 port1    0x1000    U2PHY_COM
-u3 port1    0x1100    U3PHYD
-            0x1200    U3PHYD_BANK2
-            0x1300    U3PHYA
-            0x1400    U3PHYA_DA
-u2 port2    0x1800    U2PHY_COM
-            ...
-
-mt2712:
-port        offset    bank
-u2 port0    0x0000    MISC
-            0x0100    FMREG
-            0x0300    U2PHY_COM
-u3 port0    0x0700    SPLLC
-            0x0800    CHIP
-            0x0900    U3PHYD
-            0x0a00    U3PHYD_BANK2
-            0x0b00    U3PHYA
-            0x0c00    U3PHYA_DA
-u2 port1    0x1000    MISC
-            0x1100    FMREG
-            0x1300    U2PHY_COM
-u3 port1    0x1700    SPLLC
-            0x1800    CHIP
-            0x1900    U3PHYD
-            0x1a00    U3PHYD_BANK2
-            0x1b00    U3PHYA
-            0x1c00    U3PHYA_DA
-u2 port2    0x2000    MISC
-            ...
-
-    SPLLC shared by u3 ports and FMREG shared by u2 ports on
-mt8173/mt2701 are put back into each port; a new bank MISC for
-u2 ports and CHIP for u3 ports are added on mt2712.
diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
new file mode 100644
index 0000000..faf1808
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
@@ -0,0 +1,144 @@
+MediaTek T-PHY binding
+--------------------------
+
+T-phy controller supports physical layer functionality for a number of
+controllers on MediaTek SoCs, such as, USB2.0, USB3.0, PCIe, and SATA.
+
+Required properties (controller (parent) node):
+ - compatible	: should be one of
+		  "mediatek,generic-tphy-v1"
+		  "mediatek,generic-tphy-v2"
+		  "mediatek,mt2701-u3phy" (deprecated)
+		  "mediatek,mt2712-u3phy" (deprecated)
+		  "mediatek,mt8173-u3phy";
+		  make use of "mediatek,generic-tphy-v1" on mt2701 instead and
+		  "mediatek,generic-tphy-v2" on mt2712 instead.
+ - clocks	: (deprecated, use port's clocks instead) a list of phandle +
+		  clock-specifier pairs, one for each entry in clock-names
+ - clock-names	: (deprecated, use port's one instead) must contain
+		  "u3phya_ref": for reference clock of usb3.0 analog phy.
+
+Required nodes	: a sub-node is required for each port the controller
+		  provides. Address range information including the usual
+		  'reg' property is used inside these nodes to describe
+		  the controller's topology.
+
+Optional properties (controller (parent) node):
+ - reg		: offset and length of register shared by multiple ports,
+		  exclude port's private register. It is needed on mt2701
+		  and mt8173, but not on mt2712.
+
+Required properties (port (child) node):
+- reg		: address and length of the register set for the port.
+- clocks	: a list of phandle + clock-specifier pairs, one for each
+		  entry in clock-names
+- clock-names	: must contain
+		  "ref": 48M reference clock for HighSpeed analog phy; and 26M
+			reference clock for SuperSpeed analog phy, sometimes is
+			24M, 25M or 27M, depended on platform.
+- #phy-cells	: should be 1 (See second example)
+		  cell after port phandle is phy type from:
+			- PHY_TYPE_USB2
+			- PHY_TYPE_USB3
+			- PHY_TYPE_PCIE
+			- PHY_TYPE_SATA
+
+Example:
+
+u3phy: usb-phy at 11290000 {
+	compatible = "mediatek,mt8173-u3phy";
+	reg = <0 0x11290000 0 0x800>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+	status = "okay";
+
+	u2port0: usb-phy at 11290800 {
+		reg = <0 0x11290800 0 0x100>;
+		clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
+		clock-names = "ref";
+		#phy-cells = <1>;
+		status = "okay";
+	};
+
+	u3port0: usb-phy at 11290900 {
+		reg = <0 0x11290800 0 0x700>;
+		clocks = <&clk26m>;
+		clock-names = "ref";
+		#phy-cells = <1>;
+		status = "okay";
+	};
+
+	u2port1: usb-phy at 11291000 {
+		reg = <0 0x11291000 0 0x100>;
+		clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
+		clock-names = "ref";
+		#phy-cells = <1>;
+		status = "okay";
+	};
+};
+
+Specifying phy control of devices
+---------------------------------
+
+Device nodes should specify the configuration required in their "phys"
+property, containing a phandle to the phy port node and a device type;
+phy-names for each port are optional.
+
+Example:
+
+#include <dt-bindings/phy/phy.h>
+
+usb30: usb at 11270000 {
+	...
+	phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
+	phy-names = "usb2-0", "usb3-0";
+	...
+};
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
