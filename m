From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Mon, 19 Oct 2015 14:21:13 +0800
Subject: [PATCH v11 1/3] dt-bindings: Add a binding for Mediatek xHCI host
 controller
In-Reply-To: <1445235675-29312-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1445235675-29312-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1445235675-29312-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a DT binding documentation of xHCI host controller for the
MT8173 SoC from Mediatek.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/usb/mt8173-xhci.txt        | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt

diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
new file mode 100644
index 0000000..3c0ac97
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
@@ -0,0 +1,51 @@
+MT8173 xHCI
+
+The device node for Mediatek SOC USB3.0 host controller
+
+Required properties:
+ - compatible : should contain "mediatek,mt8173-xhci"
+ - reg : specifies physical base address and size of the registers,
+	the first one for MAC, the second for IPPC
+ - interrupts : interrupt used by the controller
+ - power-domains : a phandle to USB power domain node to control USB's
+	mtcmos
+ - vusb33-supply : regulator of USB avdd3.3v
+
+ - clocks : a list of phandle + clock-specifier pairs, one for each
+	entry in clock-names
+ - clock-names : must contain
+	"sys_ck": for clock of xHCI MAC
+	"wakeup_deb_p0": for USB wakeup debounce clock of port0
+	"wakeup_deb_p0": for USB wakeup debounce clock of port1
+
+ - phys : a list of phandle + phy specifier pairs
+ - usb3-lpm-capable : supports USB3.0 LPM
+
+Optional properties:
+ - mediatek,wakeup-src : 1: ip sleep wakeup mode; 2: line state wakeup
+	mode;
+ - mediatek,syscon-wakeup : phandle to syscon used to access USB wakeup
+	control register, it depends on "mediatek,wakeup-src".
+ - vbus-supply : reference to the VBUS regulator;
+
+Example:
+usb30: usb at 11270000 {
+	compatible = "mediatek,mt8173-xhci";
+	reg = <0 0x11270000 0 0x1000>,
+	      <0 0x11280700 0 0x0100>;
+	interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
+	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+	clocks = <&topckgen CLK_TOP_USB30_SEL>,
+		 <&pericfg CLK_PERI_USB0>,
+		 <&pericfg CLK_PERI_USB1>;
+	clock-names = "sys_ck",
+		      "wakeup_deb_p0",
+		      "wakeup_deb_p1";
+	phys = <&phy_port0 PHY_TYPE_USB3>,
+	       <&phy_port1 PHY_TYPE_USB2>;
+	vusb33-supply = <&mt6397_vusb_reg>;
+	vbus-supply = <&usb_p1_vbus>;
+	usb3-lpm-capable;
+	mediatek,syscon-wakeup = <&pericfg>;
+	mediatek,wakeup-src = <1>;
+};
-- 
1.8.1.1.dirty
