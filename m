From: chunfeng.yun@mediatek.com (chunfeng.yun at mediatek.com)
Date: Wed, 27 May 2015 19:48:03 +0800
Subject: [PATCH 6/6] arm64: dts: mediatek: add xHCI & usb phy for mt8173
In-Reply-To: <1432727283-20303-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1432727283-20303-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1432727283-20303-7-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 24 ++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index b1560c9..3adcdbf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -13,6 +13,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "mt8173.dtsi"
 
 / {
@@ -31,6 +32,15 @@
 	};
 
 	chosen { };
+
+	usb_p1_vbus: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 130 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &pwrap {
@@ -257,6 +267,10 @@
 	};
 };
 
+&u3phy {
+	reg-p1-vbus-supply = <&usb_p1_vbus>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 512e4eb..cd36bf3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -259,6 +259,30 @@
 			status = "disabled";
 		};
 
+		usb: usb30 at 11270000 {
+			compatible = "mediatek,mt8173-xhci", "generic-xhci";
+			reg = <0 0x11270000 0 0x1000>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
+			usb-phy = <&u3phy>;
+			usb3-lpm-capable;
+		};
+
+		u3phy: usb-phy at 11271000 {
+			compatible = "mediatek,mt8173-u3phy";
+			reg = <0 0x11271000 0 0x3000>,
+			      <0 0x11280000 0 0x20000>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+			reg-vusb33-supply = <&mt6397_vusb_reg>;
+			clocks = <&pericfg CLK_PERI_USB0>,
+				 <&pericfg CLK_PERI_USB1>,
+				 <&topckgen CLK_TOP_USB30_SEL>,
+				 <&apmixedsys CLK_APMIXED_REF2USB_TX>;
+			clock-names = "wakeup_deb_p0",
+				      "wakeup_deb_p1",
+				      "sys_mac",
+				      "u3phya_ref";
+		};
+
 		mmsys: mmsys at 14000000 {
 			compatible = "mediatek,mt8173-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
-- 
1.8.1.1.dirty
