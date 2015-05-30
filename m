From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sat, 30 May 2015 08:54:08 +0100
Subject: [PATCH v2 4/4] ARM: dts: stm32f429: Adopt STM32F4 clock driver
In-Reply-To: <1432972448-10332-1-git-send-email-daniel.thompson@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <1432972448-10332-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1432972448-10332-5-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New bindings and driver have been created for STM32F42xxx series parts.
This patch integrates these changes.

Note: Earlier device tree blobs (those without st,stm32f42xxx
      compatibles for the rcc) could still be used to boot basic
      systems. Such systems rely on the bootloader to configure the
      clock gates for vital periperhals.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/boot/dts/stm32f429-disco.dts |  4 ++
 arch/arm/boot/dts/stm32f429.dtsi      | 79 +++++++++++------------------------
 2 files changed, 28 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 17cbb83..97028da 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -66,6 +66,10 @@
 	};
 };
 
+&clk_hse {
+	clock-frequency = <8000000>;
+};
+
 &usart1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index ef6d382..748b886 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -49,48 +49,10 @@
 
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
+			clock-frequency = <0>;
 		};
 	};
 
@@ -99,7 +61,7 @@
 			compatible = "st,stm32-timer";
 			reg = <0x40000000 0x400>;
 			interrupts = <28>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 128>;
 			status = "disabled";
 		};
 
@@ -107,7 +69,7 @@
 			compatible = "st,stm32-timer";
 			reg = <0x40000400 0x400>;
 			interrupts = <29>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 129>;
 			status = "disabled";
 		};
 
@@ -115,7 +77,7 @@
 			compatible = "st,stm32-timer";
 			reg = <0x40000800 0x400>;
 			interrupts = <30>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 130>;
 			status = "disabled";
 		};
 
@@ -123,7 +85,7 @@
 			compatible = "st,stm32-timer";
 			reg = <0x40000c00 0x400>;
 			interrupts = <50>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 131>;
 			status = "disabled";
 		};
 
@@ -131,7 +93,7 @@
 			compatible = "st,stm32-timer";
 			reg = <0x40001000 0x400>;
 			interrupts = <54>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 132>;
 			status = "disabled";
 		};
 
@@ -139,7 +101,7 @@
 			compatible = "st,stm32-timer";
 			reg = <0x40001400 0x400>;
 			interrupts = <55>;
-			clocks = <&clk_pmtr1>;
+			clocks = <&rcc 0 133>;
 			status = "disabled";
 		};
 
@@ -147,7 +109,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40004400 0x400>;
 			interrupts = <38>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 145>;
 			status = "disabled";
 		};
 
@@ -155,7 +117,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40004800 0x400>;
 			interrupts = <39>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 146>;
 			status = "disabled";
 		};
 
@@ -163,7 +125,7 @@
 			compatible = "st,stm32-uart";
 			reg = <0x40004c00 0x400>;
 			interrupts = <52>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 147>;
 			status = "disabled";
 		};
 
@@ -171,7 +133,7 @@
 			compatible = "st,stm32-uart";
 			reg = <0x40005000 0x400>;
 			interrupts = <53>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 148>;
 			status = "disabled";
 		};
 
@@ -179,7 +141,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40007800 0x400>;
 			interrupts = <82>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 158>;
 			status = "disabled";
 		};
 
@@ -187,7 +149,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40007c00 0x400>;
 			interrupts = <83>;
-			clocks = <&clk_pclk1>;
+			clocks = <&rcc 0 159>;
 			status = "disabled";
 		};
 
@@ -195,7 +157,7 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40011000 0x400>;
 			interrupts = <37>;
-			clocks = <&clk_pclk2>;
+			clocks = <&rcc 0 164>;
 			status = "disabled";
 		};
 
@@ -203,13 +165,20 @@
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40011400 0x400>;
 			interrupts = <71>;
-			clocks = <&clk_pclk2>;
+			clocks = <&rcc 0 165>;
 			status = "disabled";
 		};
+
+		rcc: rcc at 40023810 {
+			#clock-cells = <2>;
+			compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
+			reg = <0x40023800 0x400>;
+			clocks = <&clk_hse>;
+		};
 	};
 };
 
 &systick {
-	clocks = <&clk_systick>;
+	clocks = <&rcc 1 0>;
 	status = "okay";
 };
-- 
2.1.0
