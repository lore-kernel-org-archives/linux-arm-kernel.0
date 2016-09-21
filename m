From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 21 Sep 2016 13:54:37 +0800
Subject: [RESEND PATCH v6, 5/5] arm64: dts: mediatek: add USB3 DRD driver
In-Reply-To: <1474437277-27201-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1474437277-27201-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1474437277-27201-6-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB3 DRD driver is added for MT8173-EVB, and xHCI driver
becomes its subnode

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |   46 +++++++++++++++++++++++++--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    |   29 +++++++++++++----
 2 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 7453a47..682dfd7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -34,6 +34,11 @@
 
 	chosen { };
 
+	extcon_usb: extcon_iddig {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
+	};
+
 	usb_p1_vbus: regulator at 0 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_vbus";
@@ -42,6 +47,16 @@
 		gpio = <&pio 130 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	usb_p0_vbus: regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 };
 
 &i2c1 {
@@ -205,6 +220,20 @@
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 	};
+
+	usb_id_pins_float: usb_iddig_pull_up {
+		pins_iddig {
+			pinmux = <MT8173_PIN_16_IDDIG__FUNC_IDDIG>;
+			bias-pull-up;
+		};
+	};
+
+	usb_id_pins_ground: usb_iddig_pull_down {
+		pins_iddig {
+			pinmux = <MT8173_PIN_16_IDDIG__FUNC_IDDIG>;
+			bias-pull-down;
+		};
+	};
 };
 
 &pwm0 {
@@ -431,12 +460,25 @@
 	status = "okay";
 };
 
+&ssusb {
+	vusb33-supply = <&mt6397_vusb_reg>;
+	vbus-supply = <&usb_p0_vbus>;
+	extcon = <&extcon_usb>;
+	dr_mode = "otg";
+	mediatek,enable-wakeup;
+	pinctrl-names = "default", "id_float", "id_ground";
+	pinctrl-0 = <&usb_id_pins_float>;
+	pinctrl-1 = <&usb_id_pins_float>;
+	pinctrl-2 = <&usb_id_pins_ground>;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
 
-&usb30 {
+&usb_host {
 	vusb33-supply = <&mt6397_vusb_reg>;
 	vbus-supply = <&usb_p1_vbus>;
-	mediatek,wakeup-src = <1>;
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 10f638f..925948a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -668,11 +668,14 @@
 			status = "disabled";
 		};
 
-		usb30: usb at 11270000 {
-			compatible = "mediatek,mt8173-xhci";
-			reg = <0 0x11270000 0 0x1000>,
+		ssusb: usb at 11271000 {
+			compatible = "mediatek,mt8173-mtu3";
+			reg = <0 0x11271000 0 0x3000>,
 			      <0 0x11280700 0 0x0100>;
-			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>;
+			phys = <&phy_port0 PHY_TYPE_USB3>,
+			       <&phy_port1 PHY_TYPE_USB2>;
 			power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
 			clocks = <&topckgen CLK_TOP_USB30_SEL>,
 				 <&pericfg CLK_PERI_USB0>,
@@ -680,10 +683,22 @@
 			clock-names = "sys_ck",
 				      "wakeup_deb_p0",
 				      "wakeup_deb_p1";
-			phys = <&phy_port0 PHY_TYPE_USB3>,
-			       <&phy_port1 PHY_TYPE_USB2>;
 			mediatek,syscon-wakeup = <&pericfg>;
-			status = "okay";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			usb_host: xhci at 11270000 {
+				compatible = "mediatek,mt8173-xhci";
+				reg = <0 0x11270000 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
+				power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+				clocks = <&topckgen CLK_TOP_USB30_SEL>;
+				clock-names = "sys_ck";
+				status = "disabled";
+			};
 		};
 
 		u3phy: usb-phy at 11290000 {
-- 
1.7.9.5
