From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Mon, 6 Feb 2017 17:29:01 +0800
Subject: [PATCH v2 6/6] dt-bindings: mt8173-mtu3: add reference clock
In-Reply-To: <1486373341-4399-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1486373341-4399-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1486373341-4399-6-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the reference clock comes from 26M oscillator directly
on mt8173, and it is a fixed-clock in DTS which always turned
on, we ignore it before. But on some platforms, it comes
from PLL, and need be controlled, so here add it, no matter
it is a fixed-clock or not.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/usb/mt8173-mtu3.txt        |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt b/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
index e049d19..8c976cd 100644
--- a/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
+++ b/Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
@@ -10,7 +10,7 @@ Required properties:
  - vusb33-supply : regulator of USB avdd3.3v
  - clocks : a list of phandle + clock-specifier pairs, one for each
 	entry in clock-names
- - clock-names : must contain "sys_ck" for clock of controller;
+ - clock-names : must contain "sys_ck" and "ref_ck" for clock of controller;
 	"wakeup_deb_p0" and "wakeup_deb_p1" are optional, they are
 	depends on "mediatek,enable-wakeup"
  - phys : a list of phandle + phy specifier pairs
@@ -56,10 +56,10 @@ ssusb: usb at 11271000 {
 	phys = <&phy_port0 PHY_TYPE_USB3>,
 	       <&phy_port1 PHY_TYPE_USB2>;
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
-	clocks = <&topckgen CLK_TOP_USB30_SEL>,
+	clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>,
 		 <&pericfg CLK_PERI_USB0>,
 		 <&pericfg CLK_PERI_USB1>;
-	clock-names = "sys_ck",
+	clock-names = "sys_ck", "ref_ck",
 		      "wakeup_deb_p0",
 		      "wakeup_deb_p1";
 	vusb33-supply = <&mt6397_vusb_reg>;
@@ -79,8 +79,8 @@ ssusb: usb at 11271000 {
 		reg-names = "mac";
 		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
 		power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
-		clocks = <&topckgen CLK_TOP_USB30_SEL>;
-		clock-names = "sys_ck";
+		clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
+		clock-names = "sys_ck", "ref_ck";
 		vusb33-supply = <&mt6397_vusb_reg>;
 		status = "disabled";
 	};
-- 
1.7.9.5
