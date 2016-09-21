From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 21 Sep 2016 13:54:33 +0800
Subject: [RESEND PATCH v6,
 1/5] dt-bindings: mt8173-xhci: support host side of dual-role mode
In-Reply-To: <1474437277-27201-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1474437277-27201-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1474437277-27201-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some resources, such as IPPC register etc, shared with device
driver are moved into common glue layer when xHCI driver is the
host side of dual-role mode and they should be changed as optional
properties if they are required ones before. For clarity, add
a new part of binding to support host side of dual-role mode.

Additionally add optional properties of pinctrl for host only mode

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/mt8173-xhci.txt        |   54 +++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
index b3a7ffa..2a930bd 100644
--- a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
@@ -2,10 +2,18 @@ MT8173 xHCI
 
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
- - reg : specifies physical base address and size of the registers,
-	the first one for MAC, the second for IPPC
+ - reg : specifies physical base address and size of the registers
+ - reg-names: should be "mac" for xHCI MAC and "ippc" for IP port control
  - interrupts : interrupt used by the controller
  - power-domains : a phandle to USB power domain node to control USB's
 	mtcmos
@@ -27,12 +35,16 @@ Optional properties:
 	control register, it depends on "mediatek,wakeup-src".
  - vbus-supply : reference to the VBUS regulator;
  - usb3-lpm-capable : supports USB3.0 LPM
+ - pinctrl-names : a pinctrl state named "default" must be defined
+ - pinctrl-0 : pin control group
+	See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
 
 Example:
 usb30: usb at 11270000 {
 	compatible = "mediatek,mt8173-xhci";
 	reg = <0 0x11270000 0 0x1000>,
 	      <0 0x11280700 0 0x0100>;
+	reg-names = "mac", "ippc";
 	interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
 	clocks = <&topckgen CLK_TOP_USB30_SEL>,
@@ -49,3 +61,41 @@ usb30: usb at 11270000 {
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
+ - reg : specifies physical base address and size of the registers
+ - reg-names: should be "mac" for xHCI MAC
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
+	reg-names = "mac";
+	interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
+	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+	clocks = <&topckgen CLK_TOP_USB30_SEL>;
+	clock-names = "sys_ck";
+	vusb33-supply = <&mt6397_vusb_reg>;
+	usb3-lpm-capable;
+};
-- 
1.7.9.5
