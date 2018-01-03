From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 3 Jan 2018 16:53:21 +0800
Subject: [v2 PATCH 5/6] dt-bindings: usb: mtk-xhci: update USB wakeup
 properties
In-Reply-To: <41c6b0f2e959c07eff261060e57fd180a750071a.1514967463.git.chunfeng.yun@mediatek.com>
References: <41c6b0f2e959c07eff261060e57fd180a750071a.1514967463.git.chunfeng.yun@mediatek.com>
Message-ID: <7c7f69a3981b5117f7c8cc14b19c3459a50403ef.1514967463.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two arguments in "mediatek,syscon-wakeup" to support multi
wakeup glue layer between SSUSB and SPM, and use standard property
"wakeup-source" to replace the private "mediatek,wakeup-src"

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.txt        | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
index 3059596..5842868 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
@@ -35,10 +35,14 @@ Required properties:
  - phys : a list of phandle + phy specifier pairs
 
 Optional properties:
- - mediatek,wakeup-src : 1: ip sleep wakeup mode; 2: line state wakeup
-	mode;
- - mediatek,syscon-wakeup : phandle to syscon used to access USB wakeup
-	control register, it depends on "mediatek,wakeup-src".
+ - wakeup-source : enable USB remote wakeup;
+ - mediatek,syscon-wakeup : phandle to syscon used to access the register
+	of the USB wakeup glue layer between xHCI and SPM; it depends on
+	"wakeup-source", and has two arguments:
+	- the first one : register base address of the glue layer in syscon;
+	- the second one : hardware version of the glue layer
+		- 1 : used by mt8173 etc
+		- 2 : used by mt2712 etc
  - mediatek,u3p-dis-msk : mask to disable u3ports, bit0 for u3port0,
 	bit1 for u3port1, ... etc;
  - vbus-supply : reference to the VBUS regulator;
@@ -64,8 +68,8 @@ usb30: usb at 11270000 {
 	vusb33-supply = <&mt6397_vusb_reg>;
 	vbus-supply = <&usb_p1_vbus>;
 	usb3-lpm-capable;
-	mediatek,syscon-wakeup = <&pericfg>;
-	mediatek,wakeup-src = <1>;
+	mediatek,syscon-wakeup = <&pericfg 0x400 1>;
+	wakeup-source;
 };
 
 2nd: dual-role mode with xHCI driver
-- 
1.9.1
