From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 22 May 2015 21:41:13 +0100
Subject: [RFC PATCH 3/3] ARM: dts: stm32f429: Adopt STM32F4 clock driver
In-Reply-To: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1432327273-6810-4-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New bindings and driver have been created for STM32F42xxx series parts.
This patch integrates these changes.

Note: Earlier device tree blobs (those without st,stm32f42xxx
      compatibles for the rcc) could still be used to boot basic
      systems. Such systems rely on the bootloader to configure the
      clocks for vital periperhals.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/boot/dts/stm32f429.dtsi | 83 +++++++++++++---------------------------
 1 file changed, 26 insertions(+), 57 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index aa3b3e3..6da8d7f 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -50,48 +50,10 @@
 
 / {
 	clocks {
-		clk_sysclk: clk-sysclk {
+		clk_hse: clk-hse {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
-			clock-frequency = <168000000>;
-		};
-
-		clk_hclk: clk-hclk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <168000000>;
-		};
-
-		clk_pclk1: clk-pclk1 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <42000000>;
-		};
-
-		clk_pclk2: clk-pclk2 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <84000000>;
-		};
-
-		clk_pmtr1: clk-pmtr1 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <84000000>;
-		};
-
-		clk_pmtr2: clk-pmtr2 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <168000000>;
-		};
-
-		clk_systick: clk-systick {
-			compatible = "fixed-factor-clock";
-			clocks = <&clk_hclk>;
-			#clock-cells = <0>;
-			clock-div = <8>;
-			clock-mult = <1>;
+			clock-frequency = <8000000>;
 		};
 	};
 
@@ -101,7 +63,7 @@
 			reg = <0x40000000 0x400>;
 			interrupts = <28>;
 			resets = <&rcc STM32F4_APB1_RESET(TIM2)>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 128>;
 			status = "disabled";
 		};
 
@@ -110,7 +72,7 @@
 			reg = <0x40000400 0x400>;
 			interrupts = <29>;
 			resets = <&rcc STM32F4_APB1_RESET(TIM3)>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 129>;
 			status = "disabled";
 		};
 
@@ -119,7 +81,7 @@
 			reg = <0x40000800 0x400>;
 			interrupts = <30>;
 			resets = <&rcc STM32F4_APB1_RESET(TIM4)>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 130>;
 			status = "disabled";
 		};
 
@@ -128,7 +90,7 @@
 			reg = <0x40000c00 0x400>;
 			interrupts = <50>;
 			resets = <&rcc STM32F4_APB1_RESET(TIM5)>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 131>;
 			status = "disabled";
 		};
 
@@ -137,7 +99,7 @@
 			reg = <0x40001000 0x400>;
 			interrupts = <54>;
 			resets = <&rcc STM32F4_APB1_RESET(TIM6)>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 132>;
 			status = "disabled";
 		};
 
@@ -146,7 +108,7 @@
 			reg = <0x40001400 0x400>;
 			interrupts = <55>;
 			resets = <&rcc STM32F4_APB1_RESET(TIM7)>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 133>;
 			status = "disabled";
 		};
 
@@ -154,7 +116,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40004400 0x400>;
 			interrupts = <38>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 145>;
 			status = "disabled";
 		};
 
@@ -162,7 +124,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40004800 0x400>;
 			interrupts = <39>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 146>;
 			status = "disabled";
 		};
 
@@ -170,7 +132,7 @@
 			compatible = "st,stm32-uart";
 			reg = <0x40004c00 0x400>;
 			interrupts = <52>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 147>;
 			status = "disabled";
 		};
 
@@ -178,7 +140,7 @@
 			compatible = "st,stm32-uart";
 			reg = <0x40005000 0x400>;
 			interrupts = <53>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 148>;
 			status = "disabled";
 		};
 
@@ -186,7 +148,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40007800 0x400>;
 			interrupts = <82>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 158>;
 			status = "disabled";
 		};
 
@@ -194,7 +156,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40007c00 0x400>;
 			interrupts = <83>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 159>;
 			status = "disabled";
 		};
 
@@ -202,7 +164,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40011000 0x400>;
 			interrupts = <37>;
-			clocks = <&clk_pclk2>;
+			clocks = <&rcc 0 164>;
 			status = "disabled";
 		};
 
@@ -210,19 +172,26 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40011400 0x400>;
 			interrupts = <71>;
-			clocks = <&clk_pclk2>;
+			clocks = <&rcc 0 165>;
 			status = "disabled";
 		};
 
 		rcc: rcc at 40023810 {
 			#reset-cells = <1>;
-			compatible = "st,stm32-rcc";
+			compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
 			reg = <0x40023800 0x400>;
-		};
+			clocks = <&clk_hse>;
+			#clock-cells = <2>;
+		};
+#if 0
+	of_property_read_string_index(dev, "reg-names", "gates");
+	index = of_property_read_string_index(dev, "reg-names", "gates");
+	of_iomap(np, index);
+#endif
 	};
 };
 
 &systick {
-	clocks = <&clk_systick>;
+	clocks = <&rcc 1 0>;
 	status = "okay";
 };
-- 
2.1.0
