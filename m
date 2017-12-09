From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Sat, 9 Dec 2017 16:45:36 +0800
Subject: [PATCH 7/7] arm64: dts: mt8173: add uwk node and remove unused usb
 property
In-Reply-To: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1512809136-2779-8-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add uwk node for new way of usb remote wakeup instead of old one,
and modify some usb properties according binding documents
of mediatek,mtu3.txt and mediatek,mtk-xhci.txt

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 28 ++++++++++++++++++----------
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 16 +++++-----------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 1c3634f..08a323b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -14,6 +14,7 @@
 
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/soc/mediatek,usb-wakeup.h>
 #include "mt8173.dtsi"
 
 / {
@@ -68,6 +69,20 @@
 		gpio = <&pio 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	usb_wakeup: uwk at 0 {
+		compatible = "mediatek,mt8173-uwk","mediatek,usb-wk-v1";
+		mediatek,wkc = <&pericfg>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		status = "okay";
+
+		usb_wk0: uwk at 400 {
+			reg = <0x400 0x8>;
+			#mediatek,uwk-cells = <1>;
+			status = "okay";
+		};
+	};
 };
 
 &cec {
@@ -268,12 +283,6 @@
 		};
 	};
 
-	usb_id_pins_ground: usb_iddig_pull_down {
-		pins_iddig {
-			pinmux = <MT8173_PIN_16_IDDIG__FUNC_IDDIG>;
-			bias-pull-down;
-		};
-	};
 };
 
 &pwm0 {
@@ -501,15 +510,14 @@
 };
 
 &ssusb {
+	mediatek,uwks = <&usb_wk0 MTU_WK_IP_SLEEP>;
 	vusb33-supply = <&mt6397_vusb_reg>;
 	vbus-supply = <&usb_p0_vbus>;
 	extcon = <&extcon_usb>;
 	dr_mode = "otg";
-	mediatek,enable-wakeup;
-	pinctrl-names = "default", "id_float", "id_ground";
+	wakeup-source;
+	pinctrl-names = "default";
 	pinctrl-0 = <&usb_id_pins_float>;
-	pinctrl-1 = <&usb_id_pins_float>;
-	pinctrl-2 = <&usb_id_pins_ground>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 26396ef..818ead7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -722,7 +722,7 @@
 		};
 
 		ssusb: usb at 11271000 {
-			compatible = "mediatek,mt8173-mtu3";
+			compatible = "mediatek,mt8173-mtu3", "mediatek,mtu3";
 			reg = <0 0x11271000 0 0x3000>,
 			      <0 0x11280700 0 0x0100>;
 			reg-names = "mac", "ippc";
@@ -731,22 +731,16 @@
 			       <&u3port0 PHY_TYPE_USB3>,
 			       <&u2port1 PHY_TYPE_USB2>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
-			clocks = <&topckgen CLK_TOP_USB30_SEL>,
-				 <&clk26m>,
-				 <&pericfg CLK_PERI_USB0>,
-				 <&pericfg CLK_PERI_USB1>;
-			clock-names = "sys_ck",
-				      "ref_ck",
-				      "wakeup_deb_p0",
-				      "wakeup_deb_p1";
-			mediatek,syscon-wakeup = <&pericfg>;
+			clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
+			clock-names = "sys_ck", "ref_ck";
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
 			status = "disabled";
 
 			usb_host: xhci at 11270000 {
-				compatible = "mediatek,mt8173-xhci";
+				compatible = "mediatek,mt8173-xhci",
+					     "mediatek,mtk-xhci";
 				reg = <0 0x11270000 0 0x1000>;
 				reg-names = "mac";
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
-- 
1.9.1
