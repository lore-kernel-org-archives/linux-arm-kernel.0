From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Sat, 9 Dec 2017 16:45:31 +0800
Subject: [PATCH 2/7] dt-bindings: soc: mediatek: add bindings document for USB
 wakeup
In-Reply-To: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1512809136-2779-3-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds bindings document for the SSUSB-SPM glue layer driver found
in MediaTek SoCs which is used to support usb remote wakeup.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../bindings/soc/mediatek/usb-wakeup.txt           | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/usb-wakeup.txt

diff --git a/Documentation/devicetree/bindings/soc/mediatek/usb-wakeup.txt b/Documentation/devicetree/bindings/soc/mediatek/usb-wakeup.txt
new file mode 100644
index 0000000..313d927
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/usb-wakeup.txt
@@ -0,0 +1,77 @@
+MediaTek USB Wakeup binding
+-----------------------------
+
+The SSUSB-SPM glue layer is used to control some signals of USB
+wakeup, such as IP-SLEEP, LINE-STATE, IDDIG etc, which are mutually
+exclusive.
+
+Required properties (controller (parent) node):
+- compatible: Should be one of:
+	- "mediatek,<soc-model>-uwk","mediatek,usb-wk-v1"
+		soc-model is the name of SoC, supports one of:
+		- mt8173, mt8176
+	- "mediatek,<soc-model>-uwk","mediatek,usb-wk-v2"
+		soc-model is the name of SoC, supports one of:
+		- mt2712
+
+- mediatek,wkc: must contain a syscon phandle, such as pericfg controller
+- #address-cells : should be '1'
+- #size-cells : should be '1'
+
+Required nodes: a sub-node is required for each glue layer provided for
+	each SSUSB IP. Address range information including the usual 'reg'
+	property is used inside these nodes to describe the controller's
+	topology.
+
+Required properties (glue layer (child) node):
+- reg: address and length of the register set within the syscon which is
+	assigned to @mediatek,wkc.
+- #mediatek,uwk-cells: should be 1 (see the second example), cell after
+	glue layer phandle is wakeup type from:
+		- MTU_WK_IP_SLEEP
+		- MTU_WK_LINE_STATE
+	The wakeup types defined in
+		- include/dt-bindings/soc/mediatek,usb-wakeup.h
+
+
+Example:
+
+usb_wakeup: uwk at 0 {
+	compatible = "mediatek,mt2712-uwk","mediatek,usb-wk-v2";
+	mediatek,wkc = <&pericfg>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	status = "okay";
+
+	usb_wk0: uwk at 510 {
+		reg = <0x510 0x4>;
+		#mediatek,uwk-cells = <1>;
+		status = "okay";
+	};
+
+	usb_wk1: uwk at 514 {
+		reg = <0x514 0x4>;
+		#mediatek,uwk-cells = <1>;
+		status = "okay";
+	};
+};
+
+
+Specifying wakeup control of devices
+---------------------------------
+
+Device nodes should specify the configuration required in their
+"mediatek,uwks" property, containing a phandle to the glue layer
+node and a wakeup type, because each USB controller has just one
+glue layer for wakeup, so only one phandle is supported;
+
+Example:
+
+#include <dt-bindings/soc/mediatek,usb-wakeup.h>
+
+usb_host1: xhci at 112c0000 {
+	...
+	mediatek,uwks = <&usb_wk2 MTU_WK_IP_SLEEP>;
+	...
+};
+
-- 
1.9.1
