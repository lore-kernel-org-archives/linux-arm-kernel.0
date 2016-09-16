From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 21:42:45 +0200
Subject: [PATCH 04/10] ARM: dts: exynos: Fix invalid GIC interrupt flags in
 exynos4415
In-Reply-To: <1474054971-16831-1-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
Message-ID: <1474054971-16831-5-git-send-email-krzk@kernel.org>
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
 arch/arm/boot/dts/exynos4415-pinctrl.dtsi | 20 +++++--
 arch/arm/boot/dts/exynos4415.dtsi         | 92 ++++++++++++++++++-------------
 2 files changed, 70 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4415-pinctrl.dtsi b/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
index 75af9c56123e..4863147be39a 100644
--- a/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
@@ -358,8 +358,14 @@
 
 		interrupt-controller;
 		interrupt-parent = <&gic>;
-		interrupts = <0 32 0>, <0 33 0>, <0 34 0>, <0 35 0>,
-				<0 36 0>, <0 37 0>, <0 38 0>, <0 39 0>;
+		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 34 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 36 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 38 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 39 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 	};
 
@@ -369,8 +375,14 @@
 
 		interrupt-controller;
 		interrupt-parent = <&gic>;
-		interrupts = <0 40 0>, <0 41 0>, <0 42 0>, <0 43 0>,
-				<0 44 0>, <0 45 0>, <0 46 0>, <0 47 0>;
+		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 42 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 43 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 44 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 45 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 46 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 47 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 	};
 
diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
index 3c40f8a956dd..2ad6b6f9a37b 100644
--- a/arch/arm/boot/dts/exynos4415.dtsi
+++ b/arch/arm/boot/dts/exynos4415.dtsi
@@ -18,6 +18,7 @@
 
 #include <dt-bindings/clock/exynos4415.h>
 #include <dt-bindings/clock/exynos-audss-clk.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	compatible = "samsung,exynos4415";
@@ -105,7 +106,7 @@
 		pinctrl_2: pinctrl at 03860000 {
 			compatible = "samsung,exynos4415-pinctrl";
 			reg = <0x03860000 0x1000>;
-			interrupts = <0 242 0>;
+			interrupts = <0 242 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		chipid at 10000000 {
@@ -180,15 +181,21 @@
 		rtc: rtc at 10070000 {
 			compatible = "samsung,s3c6410-rtc";
 			reg = <0x10070000 0x100>;
-			interrupts = <0 73 0>, <0 74 0>;
+			interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>, <0 74 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		mct at 10050000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x10050000 0x800>;
-			interrupts = <0 218 0>, <0 219 0>, <0 220 0>, <0 221 0>,
-				     <0 223 0>, <0 226 0>, <0 227 0>, <0 228 0>;
+			interrupts = <0 218 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 220 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 221 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 223 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 226 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 227 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 228 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_FIN_PLL>, <&cmu CLK_MCT>;
 			clock-names = "fin_pll", "mct";
 		};
@@ -227,26 +234,28 @@
 		pinctrl_1: pinctrl at 11000000 {
 			compatible = "samsung,exynos4415-pinctrl";
 			reg = <0x11000000 0x1000>;
-			interrupts = <0 225 0>;
+			interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <0 48 0>;
+				interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
 		pinctrl_0: pinctrl at 11400000 {
 			compatible = "samsung,exynos4415-pinctrl";
 			reg = <0x11400000 0x1000>;
-			interrupts = <0 240 0>;
+			interrupts = <0 240 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		fimd: fimd at 11C00000 {
 			compatible = "samsung,exynos4415-fimd";
 			reg = <0x11C00000 0x30000>;
 			interrupt-names = "fifo", "vsync", "lcd_sys";
-			interrupts = <0 84 0>, <0 85 0>, <0 86 0>;
+			interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SCLK_FIMD0>, <&cmu CLK_FIMD0>;
 			clock-names = "sclk_fimd", "fimd";
 			samsung,power-domain = <&pd_lcd0>;
@@ -258,7 +267,7 @@
 		dsi_0: dsi at 11C80000 {
 			compatible = "samsung,exynos4415-mipi-dsi";
 			reg = <0x11C80000 0x10000>;
-			interrupts = <0 83 0>;
+			interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
 			samsung,phy-type = <0>;
 			samsung,power-domain = <&pd_lcd0>;
 			phys = <&mipi_phy 1>;
@@ -273,7 +282,8 @@
 		sysmmu_fimd0: sysmmu at 11E20000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11e20000 0x1000>;
-			interrupts = <0 80 0>, <0 81 0>;
+			interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 81 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&cmu CLK_SMMUFIMD0>, <&cmu CLK_FIMD0>;
 			power-domains = <&pd_lcd0>;
@@ -283,7 +293,7 @@
 		hsotg: hsotg at 12480000 {
 			compatible = "samsung,s3c6400-hsotg";
 			reg = <0x12480000 0x20000>;
-			interrupts = <0 141 0>;
+			interrupts = <0 141 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_USBDEVICE>;
 			clock-names = "otg";
 			phys = <&exynos_usbphy 0>;
@@ -294,7 +304,7 @@
 		mshc_0: mshc at 12510000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12510000 0x1000>;
-			interrupts = <0 142 0>;
+			interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SDMMC0>, <&cmu CLK_SCLK_MMC0>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x80>;
@@ -306,7 +316,7 @@
 		mshc_1: mshc at 12520000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12520000 0x1000>;
-			interrupts = <0 143 0>;
+			interrupts = <0 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SDMMC1>, <&cmu CLK_SCLK_MMC1>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x80>;
@@ -318,7 +328,7 @@
 		mshc_2: mshc at 12530000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12530000 0x1000>;
-			interrupts = <0 144 0>;
+			interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SDMMC2>, <&cmu CLK_SCLK_MMC2>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x80>;
@@ -330,7 +340,7 @@
 		ehci: ehci at 12580000 {
 			compatible = "samsung,exynos4210-ehci";
 			reg = <0x12580000 0x100>;
-			interrupts = <0 140 0>;
+			interrupts = <0 140 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_USBHOST>;
 			clock-names = "usbhost";
 			status = "disabled";
@@ -356,7 +366,7 @@
 		ohci: ohci at 12590000 {
 			compatible = "samsung,exynos4210-ohci";
 			reg = <0x12590000 0x100>;
-			interrupts = <0 140 0>;
+			interrupts = <0 140 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_USBHOST>;
 			clock-names = "usbhost";
 			status = "disabled";
@@ -390,7 +400,7 @@
 			pdma0: pdma at 12680000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x12680000 0x1000>;
-				interrupts = <0 138 0>;
+				interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cmu CLK_PDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -401,7 +411,7 @@
 			pdma1: pdma at 12690000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x12690000 0x1000>;
-				interrupts = <0 139 0>;
+				interrupts = <0 139 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cmu CLK_PDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -414,7 +424,7 @@
 			compatible = "samsung,exynos3250-adc",
 				     "samsung,exynos-adc-v2";
 			reg = <0x126C0000 0x100>, <0x10020718 0x4>;
-			interrupts = <0 137 0>;
+			interrupts = <0 137 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "adc", "sclk";
 			clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
 			#io-channel-cells = <1>;
@@ -425,7 +435,7 @@
 		serial_0: serial at 13800000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13800000 0x100>;
-			interrupts = <0 109 0>;
+			interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_UART0>, <&cmu CLK_SCLK_UART0>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -434,7 +444,7 @@
 		serial_1: serial at 13810000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13810000 0x100>;
-			interrupts = <0 110 0>;
+			interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_UART1>, <&cmu CLK_SCLK_UART1>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -443,7 +453,7 @@
 		serial_2: serial at 13820000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13820000 0x100>;
-			interrupts = <0 111 0>;
+			interrupts = <0 111 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_UART2>, <&cmu CLK_SCLK_UART2>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -452,7 +462,7 @@
 		serial_3: serial at 13830000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13830000 0x100>;
-			interrupts = <0 112 0>;
+			interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_UART3>, <&cmu CLK_SCLK_UART3>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -463,7 +473,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13860000 0x100>;
-			interrupts = <0 113 0>;
+			interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C0>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -476,7 +486,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13870000 0x100>;
-			interrupts = <0 114 0>;
+			interrupts = <0 114 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C1>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -489,7 +499,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13880000 0x100>;
-			interrupts = <0 115 0>;
+			interrupts = <0 115 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C2>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -502,7 +512,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13890000 0x100>;
-			interrupts = <0 116 0>;
+			interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C3>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -515,7 +525,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138A0000 0x100>;
-			interrupts = <0 117 0>;
+			interrupts = <0 117 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C4>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -528,7 +538,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138B0000 0x100>;
-			interrupts = <0 118 0>;
+			interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C5>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -541,7 +551,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138C0000 0x100>;
-			interrupts = <0 119 0>;
+			interrupts = <0 119 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C6>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -554,7 +564,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138D0000 0x100>;
-			interrupts = <0 120 0>;
+			interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C7>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -565,7 +575,7 @@
 		spi_0: spi at 13920000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x13920000 0x100>;
-			interrupts = <0 121 0>;
+			interrupts = <0 121 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma0 7>, <&pdma0 6>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
@@ -581,7 +591,7 @@
 		spi_1: spi at 13930000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x13930000 0x100>;
-			interrupts = <0 122 0>;
+			interrupts = <0 122 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma1 7>, <&pdma1 6>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
@@ -597,7 +607,7 @@
 		spi_2: spi at 13940000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x13940000 0x100>;
-			interrupts = <0 123 0>;
+			interrupts = <0 123 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma0 9>, <&pdma0 8>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
@@ -619,7 +629,7 @@
 		i2s0: i2s at 3830000 {
 			compatible = "samsung,s5pv210-i2s";
 			reg = <0x03830000 0x100>;
-			interrupts = <0 124 0>;
+			interrupts = <0 124 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_audss EXYNOS_I2S_BUS>,
 				<&clock_audss EXYNOS_SCLK_I2S>;
 			clock-names = "iis", "i2s_opclk0";
@@ -634,15 +644,21 @@
 		pwm: pwm at 139D0000 {
 			compatible = "samsung,exynos4210-pwm";
 			reg = <0x139D0000 0x1000>;
-			interrupts = <0 104 0>, <0 105 0>, <0 106 0>,
-				     <0 107 0>, <0 108 0>;
+			interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 108 IRQ_TYPE_LEVEL_HIGH>;
 			#pwm-cells = <3>;
 			status = "disabled";
 		};
 
 		pmu {
 			compatible = "arm,cortex-a9-pmu";
-			interrupts = <0 18 0>, <0 19 0>, <0 20 0>, <0 21 0>;
+			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 19 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 20 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 21 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
 };
-- 
2.7.4
