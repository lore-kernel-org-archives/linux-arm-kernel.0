From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 22 Jul 2015 22:05:45 +0800
Subject: [PATCH v3 5/5] arm64: dts: mediatek: add xHCI & usb phy for mt8173
In-Reply-To: <1437573945-31586-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1437573945-31586-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1437573945-31586-6-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add xHCI and phy drivers for MT8173-EVB

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 15 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 31 +++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index f433c21..202b2b9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -13,6 +13,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "mt8173.dtsi"
 
 / {
@@ -32,6 +33,15 @@
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
@@ -211,3 +221,8 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb {
+	vusb33-supply = <&mt6397_vusb_reg>;
+	vbus-supply = <&usb_p1_vbus>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 0696f8f..aa1ecc7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/mt8173-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/mt8173-power.h>
 #include <dt-bindings/reset-controller/mt8173-resets.h>
 #include "mt8173-pinfunc.h"
 
@@ -393,6 +394,36 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		usb: usb30 at 11270000 {
+			compatible = "mediatek,mt8173-xhci";
+			reg = <0 0x11270000 0 0x4000>,
+			      <0 0x11280000 0 0x0800>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+			clocks = <&topckgen CLK_TOP_USB30_SEL>,
+				 <&pericfg CLK_PERI_USB0>,
+				 <&pericfg CLK_PERI_USB1>;
+			clock-names = "sys_mac",
+				      "wakeup_deb_p0",
+				      "wakeup_deb_p1";
+			phys = <&u3phy 0>, <&u3phy 1>;
+			phy-names = "phy-0", "phy-1";
+			usb3-lpm-capable;
+			mediatek,usb-wakeup = <&pericfg>;
+			mediatek,wakeup-src = <1>;
+			mediatek,u2port-num = <2>;
+			status = "okay";
+		};
+
+		u3phy: usb-phy at 11290000 {
+			compatible = "mediatek,mt8173-u3phy";
+			reg = <0 0x11290000 0 0x3000>;
+			clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
+			clock-names = "u3phya_ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
 	};
 };
 
-- 
1.8.1.1.dirty
