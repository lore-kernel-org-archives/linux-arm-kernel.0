From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 31 Jul 2015 21:03:53 +0800
Subject: [PATCH v4 2/5] dt-bindings: Add a binding for Mediatek xHCI host
 controller
In-Reply-To: <1438347836-29060-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1438347836-29060-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1438347836-29060-3-git-send-email-chunfeng.yun@mediatek.com>
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
index 0000000..364be5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
@@ -0,0 +1,51 @@
+MT65XX xhci
+
+The device node for Mediatek SOC usb3.0 host controller
+
+Required properties:
+ - compatible : Supports "mediatek,mt8173-xhci"
+ - reg : Specifies physical base address and size of the registers,
+	the first one for MAC, the second for IPPC
+ - interrupts : Interrupt mode, number and trigger mode
+ - power-domains : To enable usb's mtcmos
+ - vusb33-supply : Regulator of usb avdd3.3v
+ - clocks : Must support all clocks that xhci needs
+ - clock-names : Should be "sys_mac" for sys and mac clocks, and
+	"wakeup_deb_p0", "wakeup_deb_p1" for wakeup debounce control
+	clocks
+ - phys : List of PHY specifiers (used by generic PHY framework).
+ - phy-names : Must be "usb-phy0", "usb-phy1",.., "usb-phyN", based on
+	the number of PHYs as specified in @phys property.
+ - usb3-lpm-capable : Supports USB3 LPM
+ - mediatek,usb-wakeup : To access usb wakeup control register
+ - mediatek,wakeup-src : 1: Ip sleep wakeup mode; 2: line state wakeup
+	mode; others means don't enable wakeup source of usb
+ - mediatek,u2port-num : The number should not greater than the number
+	of phys
+
+Optional properties:
+ - vbus-supply : Reference to the VBUS regulator;
+
+Example:
+usb: usb at 11270000 {
+	compatible = "mediatek,mt8173-xhci";
+	reg = <0 0x11270000 0 0x4000>,
+	      <0 0x11280000 0 0x0800>;
+	interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
+	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+	clocks = <&topckgen CLK_TOP_USB30_SEL>,
+		 <&pericfg CLK_PERI_USB0>,
+		 <&pericfg CLK_PERI_USB1>;
+	clock-names = "sys_mac",
+		      "wakeup_deb_p0",
+		      "wakeup_deb_p1";
+	phys = <&u3phy 0>, <&u3phy 1>;
+	phy-names = "usb-phy0", "usb-phy1";
+	vusb33-supply = <&mt6397_vusb_reg>;
+	vbus-supply = <&usb_p1_vbus>;
+	usb3-lpm-capable;
+	mediatek,usb-wakeup = <&pericfg>;
+	mediatek,wakeup-src = <1>;
+	mediatek,u2port-num = <2>;
+	status = "okay";
+};
-- 
1.8.1.1.dirty
