From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 29 Feb 2016 11:34:39 +0100
Subject: [PATCH] ARM: dts: stm32429i-eval: Add USB HS host mode support
Message-ID: <1456742079-8648-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USB HS support in host mode only.
This port supports OTG mode, but the device more is not working
properly as of now.
Once the device mode fixed, the node will be updated to support OTG.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 16 ++++++++++++++++
 arch/arm/boot/dts/stm32f429.dtsi     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 1ae57fa..76a10d3 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -81,6 +81,13 @@
 			gpios = <&gpiog 12 1>;
 		};
 	};
+
+	usbotg_hs_phy: usbphy {
+		#phy-cells = <0>;
+		compatible = "usb-nop-xceiv";
+		clocks = <&rcc 0 30>;
+		clock-names = "main_clk";
+	};
 };
 
 &clk_hse {
@@ -92,3 +99,12 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&usbotg_hs {
+	dr_mode = "host";
+	phys = <&usbotg_hs_phy>;
+	phy-names = "usb2-phy";
+	pinctrl-0 = <&usbotg_hs_pins_a>;
+	pinctrl-names = "default";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 598362e..ee82756 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -278,6 +278,26 @@
 					bias-disable;
 				};
 			};
+
+			usbotg_hs_pins_a: usbotg_hs at 0 {
+				pins {
+					pinmux = <STM32F429_PH4_FUNC_OTG_HS_ULPI_NXT>,
+						 <STM32F429_PI11_FUNC_OTG_HS_ULPI_DIR>,
+						 <STM32F429_PC0_FUNC_OTG_HS_ULPI_STP>,
+						 <STM32F429_PA5_FUNC_OTG_HS_ULPI_CK>,
+						 <STM32F429_PA3_FUNC_OTG_HS_ULPI_D0>,
+						 <STM32F429_PB0_FUNC_OTG_HS_ULPI_D1>,
+						 <STM32F429_PB1_FUNC_OTG_HS_ULPI_D2>,
+						 <STM32F429_PB10_FUNC_OTG_HS_ULPI_D3>,
+						 <STM32F429_PB11_FUNC_OTG_HS_ULPI_D4>,
+						 <STM32F429_PB12_FUNC_OTG_HS_ULPI_D5>,
+						 <STM32F429_PB13_FUNC_OTG_HS_ULPI_D6>,
+						 <STM32F429_PB5_FUNC_OTG_HS_ULPI_D7>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
 		};
 
 		rcc: rcc at 40023810 {
@@ -318,6 +338,16 @@
 			st,mem2mem;
 		};
 
+		usbotg_hs: usb at 40040000 {
+			compatible = "snps,dwc2";
+			dma-ranges;
+			reg = <0x40040000 0x40000>;
+			interrupts = <77>;
+			clocks = <&rcc 0 29>;
+			clock-names = "otg";
+			status = "disabled";
+		};
+
 		rng: rng at 50060800 {
 			compatible = "st,stm32-rng";
 			reg = <0x50060800 0x400>;
-- 
1.9.1
