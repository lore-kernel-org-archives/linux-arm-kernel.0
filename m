From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 31 May 2016 13:52:38 +0800
Subject: [PATCH v2,
 1/5] dt-bindings: mt8173-xhci: support host side of dual-role mode
In-Reply-To: <1464673962-11506-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1464673962-11506-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1464673962-11506-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some resources, such as IPPC register etc, shared with device
driver are moved into common glue layer when xHCI driver is the
host side of dual-role mode and they should be changed as optional
properties if they are required ones before. For clarity, add
a new part of binding to support host side of dual-role mode.

Additionally add optional properties of pinctrl for host only mode

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/usb/mt8173-xhci.txt        |   48 ++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
index b3a7ffa..542e3fa 100644
--- a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
@@ -2,6 +2,14 @@ MT8173 xHCI
 
 The device node for Mediatek SOC USB3.0 host controller
 
+There are two scenarios: the first one only supports xHCI driver;
+the second one supports dual-role mode, and the host is based on xHCI
+driver. Take account of backward compatibility, we divide bindings
+into two parts.
+
+1st: only supports xHCI driver
+------------------------------------------------------------------------
+
 Required properties:
  - compatible : should contain "mediatek,mt8173-xhci"
  - reg : specifies physical base address and size of the registers,
@@ -27,6 +35,9 @@ Optional properties:
 	control register, it depends on "mediatek,wakeup-src".
  - vbus-supply : reference to the VBUS regulator;
  - usb3-lpm-capable : supports USB3.0 LPM
+ - pinctl-names : a pinctrl state named "default" must be defined
+ - pinctrl-0 : pin control group
+	See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
 
 Example:
 usb30: usb at 11270000 {
@@ -49,3 +60,40 @@ usb30: usb at 11270000 {
 	mediatek,syscon-wakeup = <&pericfg>;
 	mediatek,wakeup-src = <1>;
 };
+
+2nd: dual-role mode with xHCI driver
+------------------------------------------------------------------------
+
+In the case, xhci is added as subnode to mtu3. An example and the DT binding
+details of mtu3 can be found in:
+Documentation/devicetree/bindings/usb/mtu3.txt
+
+Required properties:
+ - compatible : should contain "mediatek,mt8173-xhci"
+ - reg : specifies physical base address and size of the registers,
+	should be only for xHCI IP registers
+ - interrupts : interrupt used by the host controller
+ - power-domains : a phandle to USB power domain node to control USB's
+	mtcmos
+ - vusb33-supply : regulator of USB avdd3.3v
+
+ - clocks : a list of phandle + clock-specifier pairs, one for each
+	entry in clock-names
+ - clock-names : must be
+	"sys_ck": for clock of xHCI MAC
+
+Optional properties:
+ - vbus-supply : reference to the VBUS regulator;
+ - usb3-lpm-capable : supports USB3.0 LPM
+
+Example:
+usb30: usb at 11270000 {
+	compatible = "mediatek,mt8173-xhci";
+	reg = <0 0x11270000 0 0x1000>;
+	interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
+	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+	clocks = <&topckgen CLK_TOP_USB30_SEL>;
+	clock-names = "sys_ck";
+	vusb33-supply = <&mt6397_vusb_reg>;
+	usb3-lpm-capable;
+};
-- 
1.7.9.5
