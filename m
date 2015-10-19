From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Mon, 19 Oct 2015 14:21:15 +0800
Subject: [PATCH v11 3/3] arm64: dts: mediatek: add xHCI & usb phy for mt8173
In-Reply-To: <1445235675-29312-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1445235675-29312-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1445235675-29312-4-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add xHCI and phy drivers for MT8173-EVB

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 16 +++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 42 +++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 4be66ca..d039a1c 100644
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
+	usb_p1_vbus: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 130 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &i2c1 {
@@ -390,3 +400,9 @@
 &uart0 {
 	status = "okay";
 };
+
+&usb30 {
+	vusb33-supply = <&mt6397_vusb_reg>;
+	vbus-supply = <&usb_p1_vbus>;
+	mediatek,wakeup-src = <1>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d18ee42..46f5f50 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/mt8173-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt8173-power.h>
 #include <dt-bindings/reset-controller/mt8173-resets.h>
 #include "mt8173-pinfunc.h"
@@ -487,6 +488,47 @@
 			clock-names = "source", "hclk";
 			status = "disabled";
 		};
+
+		usb30: usb at 11270000 {
+			compatible = "mediatek,mt8173-xhci";
+			reg = <0 0x11270000 0 0x1000>,
+			      <0 0x11280700 0 0x0100>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+			clocks = <&topckgen CLK_TOP_USB30_SEL>,
+				 <&pericfg CLK_PERI_USB0>,
+				 <&pericfg CLK_PERI_USB1>;
+			clock-names = "sys_ck",
+				      "wakeup_deb_p0",
+				      "wakeup_deb_p1";
+			phys = <&phy_port0 PHY_TYPE_USB3>,
+			       <&phy_port1 PHY_TYPE_USB2>;
+			mediatek,syscon-wakeup = <&pericfg>;
+			status = "okay";
+		};
+
+		u3phy: usb-phy at 11290000 {
+			compatible = "mediatek,mt8173-u3phy";
+			reg = <0 0x11290000 0 0x800>;
+			clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
+			clock-names = "u3phya_ref";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "okay";
+
+			phy_port0: port at 11290800 {
+				reg = <0 0x11290800 0 0x800>;
+				#phy-cells = <1>;
+				status = "okay";
+			};
+
+			phy_port1: port at 11291000 {
+				reg = <0 0x11291000 0 0x800>;
+				#phy-cells = <1>;
+				status = "okay";
+			};
+		};
 	};
 };
 
-- 
1.8.1.1.dirty
