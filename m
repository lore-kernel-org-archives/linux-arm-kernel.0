From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 15 May 2016 22:13:53 +0200
Subject: [PATCH v4 12/22] ARM: dts: exynos: Include common exynos5 in
 exynos5410.dtsi
In-Reply-To: <1463343243-26429-1-git-send-email-krzk@kernel.org>
References: <1463343243-26429-1-git-send-email-krzk@kernel.org>
Message-ID: <1463343243-26429-13-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos5.dtsi is used for common nodes shared between Exynos5250 and
Exynos542x. Since Exynos5410 is very similar to Exynos5420 it can
include the common file as well to remove duplication and make
everything more consistent.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos5410-smdk5410.dts |   6 +-
 arch/arm/boot/dts/exynos5410.dtsi         | 103 ++++++++++--------------------
 2 files changed, 35 insertions(+), 74 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index 0f6429e1b75c..777fcf2edd79 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -102,14 +102,14 @@
 	};
 };
 
-&uart0 {
+&serial_0 {
 	status = "okay";
 };
 
-&uart1 {
+&serial_1 {
 	status = "okay";
 };
 
-&uart2 {
+&serial_2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 8de8c644f42e..c8f2e4881667 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -14,6 +14,7 @@
  */
 
 #include "skeleton.dtsi"
+#include "exynos5.dtsi"
 #include "exynos-syscon-restart.dtsi"
 #include <dt-bindings/clock/exynos5410.h>
 
@@ -26,9 +27,6 @@
 		pinctrl1 = &pinctrl_1;
 		pinctrl2 = &pinctrl_2;
 		pinctrl3 = &pinctrl_3;
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
 	};
 
 	cpus {
@@ -70,49 +68,6 @@
 		#size-cells = <1>;
 		ranges;
 
-		combiner: interrupt-controller at 10440000 {
-			compatible = "samsung,exynos4210-combiner";
-			#interrupt-cells = <2>;
-			interrupt-controller;
-			samsung,combiner-nr = <32>;
-			reg = <0x10440000 0x1000>;
-			interrupts =	<0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
-					<0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
-					<0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
-					<0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
-					<0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
-					<0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
-					<0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
-					<0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
-		};
-
-		gic: interrupt-controller at 10481000 {
-			compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg =	<0x10481000 0x1000>,
-				<0x10482000 0x1000>,
-				<0x10484000 0x2000>,
-				<0x10486000 0x2000>;
-			interrupts = <1 9 0xf04>;
-		};
-
-		chipid at 10000000 {
-			compatible = "samsung,exynos4210-chipid";
-			reg = <0x10000000 0x100>;
-		};
-
-		sromc: memory-controller at 12250000 {
-			compatible = "samsung,exynos4210-srom";
-			reg = <0x12250000 0x14>;
-			#address-cells = <2>;
-			#size-cells = <1>;
-			ranges = <0 0 0x04000000 0x20000
-				  1 0 0x05000000 0x20000
-				  2 0 0x06000000 0x20000
-				  3 0 0x07000000 0x20000>;
-		};
-
 		pmu_system_controller: system-controller at 10040000 {
 			compatible = "samsung,exynos5410-pmu", "syscon";
 			reg = <0x10040000 0x5000>;
@@ -236,34 +191,40 @@
 			reg = <0x03860000 0x1000>;
 			interrupts = <0 47 0>;
 		};
+	};
+};
 
-		uart0: serial at 12C00000 {
-			compatible = "samsung,exynos4210-uart";
-			reg = <0x12C00000 0x100>;
-			interrupts = <0 51 0>;
-			clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
-			clock-names = "uart", "clk_uart_baud0";
-			status = "disabled";
-		};
+&pwm {
+	clocks = <&clock CLK_PWM>;
+	clock-names = "timers";
+};
 
-		uart1: serial at 12C10000 {
-			compatible = "samsung,exynos4210-uart";
-			reg = <0x12C10000 0x100>;
-			interrupts = <0 52 0>;
-			clocks = <&clock CLK_UART1>, <&clock CLK_SCLK_UART1>;
-			clock-names = "uart", "clk_uart_baud0";
-			status = "disabled";
-		};
+&serial_0 {
+	clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
+	clock-names = "uart", "clk_uart_baud0";
+};
 
-		uart2: serial at 12C20000 {
-			compatible = "samsung,exynos4210-uart";
-			reg = <0x12C20000 0x100>;
-			interrupts = <0 53 0>;
-			clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
-			clock-names = "uart", "clk_uart_baud0";
-			status = "disabled";
-		};
-	};
+&serial_1 {
+	clocks = <&clock CLK_UART1>, <&clock CLK_SCLK_UART1>;
+	clock-names = "uart", "clk_uart_baud0";
+};
+
+&serial_2 {
+	clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
+	clock-names = "uart", "clk_uart_baud0";
+};
+
+&serial_3 {
+	status = "disabled";
+};
+
+&sromc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	ranges = <0 0 0x04000000 0x20000
+		  1 0 0x05000000 0x20000
+		  2 0 0x06000000 0x20000
+		  3 0 0x07000000 0x20000>;
 };
 
 #include "exynos5410-pinctrl.dtsi"
-- 
2.5.0
