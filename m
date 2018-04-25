From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 25 Apr 2018 15:45:28 +0800
Subject: [PATCH 1/2] dt-bindings: add MediaTek XS-PHY binding
In-Reply-To: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1524642329-12255-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT binding documentation of XS-PHY for MediaTek SoCs
with USB3.1 GEN2 controller

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  127 ++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
new file mode 100644
index 0000000..23c51a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
@@ -0,0 +1,127 @@
+MediaTek XS-PHY binding
+--------------------------
+
+The XS-PHY controller supports physical layer functionality for USB3.1
+GEN2 controller on MediaTek SoCs.
+
+Required properties (controller (parent) node):
+ - compatible	: should be "mediatek,<soc-model>-xsphy", "mediatek,xsphy",
+ 		  soc-model is the name of SoC, such as mt2712 etc;
+		  when using "mediatek,xsphy" compatible string, you need SoC specific
+		  ones in addition.
+
+Required nodes	: a sub-node is required for each port the controller
+		  provides. Address range information including the usual
+		  'reg' property is used inside these nodes to describe
+		  the controller's topology.
+
+Optional properties (controller (parent) node):
+ - reg		: offset and length of register shared by multiple U3 ports,
+		  exclude port's private register, if only U2 ports provided,
+		  shouldn't use the property.
+ - mediatek,src-ref-clk-mhz	: u32, frequency of reference clock for slew rate
+		  calibrate
+ - mediatek,src-coef	: u32, coefficient for slew rate calibrate, depends on
+		  SoC process
+
+Required properties (port (child) node):
+- reg		: address and length of the register set for the port.
+- clocks	: a list of phandle + clock-specifier pairs, one for each
+		  entry in clock-names
+- clock-names	: must contain
+		  "ref": 48M reference clock for HighSpeed analog phy; and 26M
+			reference clock for SuperSpeedPlus analog phy, sometimes is
+			24M, 25M or 27M, depended on platform.
+- #phy-cells	: should be 1 (See second example)
+		  cell after port phandle is phy type from:
+			- PHY_TYPE_USB2
+			- PHY_TYPE_USB3
+
+The following optional properties are only for debug or HQA test
+Optional properties (PHY_TYPE_USB2 port (child) node):
+- mediatek,eye-src	: u32, the value of slew rate calibrate
+- mediatek,eye-vrt	: u32, the selection of VRT reference voltage
+- mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage
+- mediatek,efuse-intr	: u32, the selection of Internal Resistor
+
+Optional properties (PHY_TYPE_USB3 port (child) node):
+- mediatek,efuse-intr	: u32, the selection of Internal Resistor
+- mediatek,efuse-tx-imp	: u32, the selection of TX Impedance
+- mediatek,efuse-rx-imp	: u32, the selection of RX Impedance
+
+Example:
+
+u3phy: usb-phy at 11c40000 {
+	compatible = "mediatek,mt36xx-xsphy", "mediatek,xsphy";
+	reg = <0 0x11c43000 0 0x0200>;
+	mediatek,src-ref-clk-mhz = <26>;
+	mediatek,src-coef = <17>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+	status = "disabled";
+
+	u2port0: usb-phy at 11c40000 {
+		reg = <0 0x11c40000 0 0x0400>;
+		clocks = <&clk48m>;
+		clock-names = "ref";
+		mediatek,eye-src = <4>;
+		#phy-cells = <1>;
+		status = "okay";
+	};
+
+	u3port0: usb-phy at 11c43000 {
+		reg = <0 0x11c43400 0 0x0500>;
+		clocks = <&clk26m>;
+		clock-names = "ref";
+		mediatek,efuse-intr = <28>;
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
+ssusb: usb at 112a0000 {
+	...
+	phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
+	phy-names = "usb2-0", "usb3-0";
+	...
+};
+
+
+Banks layout of xsphy
+-------------------------------------------------------------
+port        offset    bank
+u2 port0    0x0000    MISC
+            0x0100    FMREG
+            0x0300    U2PHY_COM
+u2 port1    0x1000    MISC
+            0x1100    FMREG
+            0x1300    U2PHY_COM
+u2 port2    0x2000    MISC
+            ...
+u31 common  0x3000    DIG_GLB
+            0x3100    PHYA_GLB
+u31 port0   0x3400    DIG_LN_TOP
+            0x3500    DIG_LN_TX0
+            0x3600    DIG_LN_RX0
+            0x3700    DIG_LN_DAIF
+            0x3800    PHYA_LN
+u31 port1   0x3a00    DIG_LN_TOP
+            0x3b00    DIG_LN_TX0
+            0x3c00    DIG_LN_RX0
+            0x3d00    DIG_LN_DAIF
+            0x3e00    PHYA_LN
+            ...
+
+DIG_GLB & PHYA_GLB are shared by U31 ports.
-- 
1.7.9.5
