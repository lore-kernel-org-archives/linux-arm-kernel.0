From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 21 Sep 2016 13:54:34 +0800
Subject: [RESEND PATCH v6,
 2/5] dt-bindings: mt8173-mtu3: add devicetree bindings
In-Reply-To: <1474437277-27201-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1474437277-27201-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1474437277-27201-3-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a DT binding doc for MediaTek USB3 DRD driver

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/mt8173-mtu3.txt        |   87 ++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mt8173-mtu3.txt

diff --git a/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt b/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
new file mode 100644
index 0000000..e049d19
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
@@ -0,0 +1,87 @@
+The device node for Mediatek USB3.0 DRD controller
+
+Required properties:
+ - compatible : should be "mediatek,mt8173-mtu3"
+ - reg : specifies physical base address and size of the registers
+ - reg-names: should be "mac" for device IP and "ippc" for IP port control
+ - interrupts : interrupt used by the device IP
+ - power-domains : a phandle to USB power domain node to control USB's
+	mtcmos
+ - vusb33-supply : regulator of USB avdd3.3v
+ - clocks : a list of phandle + clock-specifier pairs, one for each
+	entry in clock-names
+ - clock-names : must contain "sys_ck" for clock of controller;
+	"wakeup_deb_p0" and "wakeup_deb_p1" are optional, they are
+	depends on "mediatek,enable-wakeup"
+ - phys : a list of phandle + phy specifier pairs
+ - dr_mode : should be one of "host", "peripheral" or "otg",
+	refer to usb/generic.txt
+
+Optional properties:
+ - #address-cells, #size-cells : should be '2' if the device has sub-nodes
+	with 'reg' property
+ - ranges : allows valid 1:1 translation between child's address space and
+	parent's address space
+ - extcon : external connector for vbus and idpin changes detection, needed
+	when supports dual-role mode.
+ - vbus-supply : reference to the VBUS regulator, needed when supports
+	dual-role mode.
+ - pinctl-names : a pinctrl state named "default" must be defined,
+	"id_float" and "id_ground" are optinal which depends on
+	"mediatek,enable-manual-drd"
+ - pinctrl-0 : pin control group
+	See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
+
+ - maximum-speed : valid arguments are "super-speed", "high-speed" and
+	"full-speed"; refer to usb/generic.txt
+ - enable-manual-drd : supports manual dual-role switch via debugfs; usually
+	used when receptacle is TYPE-A and also wants to support dual-role
+	mode.
+ - mediatek,enable-wakeup : supports ip sleep wakeup used by host mode
+ - mediatek,syscon-wakeup : phandle to syscon used to access USB wakeup
+	control register, it depends on "mediatek,enable-wakeup".
+
+Sub-nodes:
+The xhci should be added as subnode to mtu3 as shown in the following example
+if host mode is enabled. The DT binding details of xhci can be found in:
+Documentation/devicetree/bindings/usb/mt8173-xhci.txt
+
+Example:
+ssusb: usb at 11271000 {
+	compatible = "mediatek,mt8173-mtu3";
+	reg = <0 0x11271000 0 0x3000>,
+	      <0 0x11280700 0 0x0100>;
+	reg-names = "mac", "ippc";
+	interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>;
+	phys = <&phy_port0 PHY_TYPE_USB3>,
+	       <&phy_port1 PHY_TYPE_USB2>;
+	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+	clocks = <&topckgen CLK_TOP_USB30_SEL>,
+		 <&pericfg CLK_PERI_USB0>,
+		 <&pericfg CLK_PERI_USB1>;
+	clock-names = "sys_ck",
+		      "wakeup_deb_p0",
+		      "wakeup_deb_p1";
+	vusb33-supply = <&mt6397_vusb_reg>;
+	vbus-supply = <&usb_p0_vbus>;
+	extcon = <&extcon_usb>;
+	dr_mode = "otg";
+	mediatek,enable-wakeup;
+	mediatek,syscon-wakeup = <&pericfg>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+	status = "disabled";
+
+	usb_host: xhci at 11270000 {
+		compatible = "mediatek,mt8173-xhci";
+		reg = <0 0x11270000 0 0x1000>;
+		reg-names = "mac";
+		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
+		power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+		clocks = <&topckgen CLK_TOP_USB30_SEL>;
+		clock-names = "sys_ck";
+		vusb33-supply = <&mt6397_vusb_reg>;
+		status = "disabled";
+	};
+};
-- 
1.7.9.5
