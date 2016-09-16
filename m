From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 21:42:50 +0200
Subject: [PATCH 09/10] ARM: dts: exynos: Fix invalid GIC interrupt flags in
 exynos5260
In-Reply-To: <1474054971-16831-1-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
Message-ID: <1474054971-16831-10-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interrupt of type IRQ_TYPE_NONE is not allowed for GIC interrupts and
generates an error:
	genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)

The GIC requires shared interrupts to be edge rising or level high.
Platform declares support for both.  Choose level high everywhere.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Alban Browaeys <alban.browaeys@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5260.dtsi | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index a86a4898d077..b0848a3d3d88 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -10,6 +10,7 @@
 */
 
 #include <dt-bindings/clock/exynos5260-clk.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	compatible = "samsung,exynos5260", "samsung,exynos5";
@@ -181,10 +182,18 @@
 			reg = <0x100B0000 0x1000>;
 			clocks = <&fin_pll>, <&clock_peri PERI_CLK_MCT>;
 			clock-names = "fin_pll", "mct";
-			interrupts = <0 104 0>, <0 105 0>, <0 106 0>,
-					<0 107 0>, <0 122 0>, <0 123 0>,
-					<0 124 0>, <0 125 0>, <0 126 0>,
-					<0 127 0>, <0 128 0>, <0 129 0>;
+			interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 127 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 129 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		cci: cci at 10F00000 {
@@ -210,25 +219,25 @@
 		pinctrl_0: pinctrl at 11600000 {
 			compatible = "samsung,exynos5260-pinctrl";
 			reg = <0x11600000 0x1000>;
-			interrupts = <0 79 0>;
+			interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <0 32 0>;
+				interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
 		pinctrl_1: pinctrl at 12290000 {
 			compatible = "samsung,exynos5260-pinctrl";
 			reg = <0x12290000 0x1000>;
-			interrupts = <0 157 0>;
+			interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_2: pinctrl at 128B0000 {
 			compatible = "samsung,exynos5260-pinctrl";
 			reg = <0x128B0000 0x1000>;
-			interrupts = <0 243 0>;
+			interrupts = <0 243 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pmu_system_controller: system-controller at 10D50000 {
@@ -239,7 +248,7 @@
 		uart0: serial at 12C00000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12C00000 0x100>;
-			interrupts = <0 146 0>;
+			interrupts = <0 146 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peri PERI_CLK_UART0>, <&clock_peri PERI_SCLK_UART0>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -248,7 +257,7 @@
 		uart1: serial at 12C10000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12C10000 0x100>;
-			interrupts = <0 147 0>;
+			interrupts = <0 147 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peri PERI_CLK_UART1>, <&clock_peri PERI_SCLK_UART1>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -257,7 +266,7 @@
 		uart2: serial at 12C20000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12C20000 0x100>;
-			interrupts = <0 148 0>;
+			interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peri PERI_CLK_UART2>, <&clock_peri PERI_SCLK_UART2>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -266,7 +275,7 @@
 		uart3: serial at 12860000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12860000 0x100>;
-			interrupts = <0 145 0>;
+			interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_aud AUD_CLK_AUD_UART>, <&clock_aud AUD_SCLK_AUD_UART>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -275,7 +284,7 @@
 		mmc_0: mmc at 12140000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12140000 0x2000>;
-			interrupts = <0 156 0>;
+			interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC0>, <&clock_top TOP_SCLK_MMC0>;
@@ -287,7 +296,7 @@
 		mmc_1: mmc at 12150000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12150000 0x2000>;
-			interrupts = <0 158 0>;
+			interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC1>, <&clock_top TOP_SCLK_MMC1>;
@@ -299,7 +308,7 @@
 		mmc_2: mmc at 12160000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12160000 0x2000>;
-			interrupts = <0 159 0>;
+			interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC2>, <&clock_top TOP_SCLK_MMC2>;
-- 
2.7.4
