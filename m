From: bruherrera@gmail.com (Bruno Herrera)
Date: Tue, 21 Jun 2016 23:25:48 -0300
Subject: [PATCH 2/3] ARM: dts: STM32 Add USB FS host mode support
In-Reply-To: <1466562349-5043-1-git-send-email-bruherrera@gmail.com>
References: <1466562349-5043-1-git-send-email-bruherrera@gmail.com>
Message-ID: <1466562349-5043-2-git-send-email-bruherrera@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32f429.dtsi      | 33 ++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/stm32f469-disco.dts | 30 ++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 0140807..8e0114b 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -75,6 +75,16 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	/* This turns on vbus for otg for host mode (dwc2) */
+	vcc5v_otg: vcc5v-otg-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpioc 4 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbotg_pwren_h>;
+		regulator-name = "vcc5_host1";
+		regulator-always-on;
+	};
 };
 
 &clk_hse {
@@ -86,3 +96,23 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&usbotg_hs {
+	compatible = "st,stm32-fsotg", "snps,dwc2";
+	dr_mode = "host";
+	pinctrl-0 = <&usbotg_fs_pins_b>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pinctrl {
+	usb-host {
+		usbotg_pwren_h: usbotg-pwren-h {
+			pins {
+				pinmux = <STM32F429_PC4_FUNC_GPIO>;
+				bias-disable;
+				drive-push-pull;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 35df462..cb33aa2 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -176,7 +176,7 @@
 			reg = <0x40013800 0x400>;
 		};
 
-		pin-controller {
+		pinctrl: pin-controller {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stm32f429-pinctrl";
@@ -284,6 +284,28 @@
 				};
 			};
 
+			usbotg_fs_pins_a: usbotg_fs at 0 {
+				pins {
+					pinmux = <STM32F429_PA10_FUNC_OTG_FS_ID>,
+						 <STM32F429_PA11_FUNC_OTG_FS_DM>,
+						 <STM32F429_PA12_FUNC_OTG_FS_DP>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			usbotg_fs_pins_b: usbotg_fs at 1 {
+				pins {
+					pinmux = <STM32F429_PB12_FUNC_OTG_HS_ID>,
+						 <STM32F429_PB14_FUNC_OTG_HS_DM>,
+						 <STM32F429_PB15_FUNC_OTG_HS_DP>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
 			usbotg_hs_pins_a: usbotg_hs at 0 {
 				pins {
 					pinmux = <STM32F429_PH4_FUNC_OTG_HS_ULPI_NXT>,
@@ -388,6 +410,15 @@
 			status = "disabled";
 		};
 
+		usbotg_fs: usb at 50000000 {
+			compatible = "st,stm32-fsotg", "snps,dwc2";
+			reg = <0x50000000 0x40000>;
+			interrupts = <67>;
+			clocks = <&rcc 0 39>;
+			clock-names = "otg";
+			status = "disabled";
+		};
+
 		rng: rng at 50060800 {
 			compatible = "st,stm32-rng";
 			reg = <0x50060800 0x400>;
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 83ee90d..46e5279 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -64,6 +64,17 @@
 	aliases {
 		serial0 = &usart3;
 	};
+
+	/* This turns on vbus for otg for host mode (dwc2) */
+	vcc5v_otg: vcc5v-otg-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpiob 2 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbotg_pwren_h>;
+		regulator-name = "vcc5_host1";
+		regulator-always-on;
+	};
 };
 
 &clk_hse {
@@ -73,3 +84,22 @@
 &usart3 {
 	status = "okay";
 };
+
+&usbotg_fs {
+	dr_mode = "host";
+	pinctrl-0 = <&usbotg_fs_pins_a>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pinctrl {
+	usb-host {
+		usbotg_pwren_h: usbotg-pwren-h {
+			pins {
+				pinmux = <STM32F429_PB2_FUNC_GPIO>;
+				bias-disable;
+				drive-push-pull;
+			};
+		};
+	};
+};
-- 
2.7.4 (Apple Git-66)
