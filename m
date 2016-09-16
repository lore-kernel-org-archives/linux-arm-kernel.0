From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 21:42:51 +0200
Subject: [PATCH 10/10] ARM: dts: exynos: Fix invalid GIC interrupt flags in
 exynos5440
In-Reply-To: <1474054971-16831-1-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
Message-ID: <1474054971-16831-11-git-send-email-krzk@kernel.org>
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
 arch/arm/boot/dts/exynos5440.dtsi | 48 ++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index e6bffd13cedd..20f600225121 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -10,6 +10,7 @@
 */
 
 #include <dt-bindings/clock/exynos5440.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	compatible = "samsung,exynos5440", "samsung,exynos5";
@@ -91,7 +92,7 @@
 	cpufreq at 160000 {
 		compatible = "samsung,exynos5440-cpufreq";
 		reg = <0x160000 0x1000>;
-		interrupts = <0 57 0>;
+		interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
 		operating-points = <
 				/* KHz	  uV */
 				1500000 1100000
@@ -108,7 +109,7 @@
 	serial_0: serial@B0000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0xB0000 0x1000>;
-		interrupts = <0 2 0>;
+		interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>, <&clock CLK_B_125>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
@@ -116,7 +117,7 @@
 	serial_1: serial at C0000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0xC0000 0x1000>;
-		interrupts = <0 3 0>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>, <&clock CLK_B_125>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
@@ -124,7 +125,7 @@
 	spi_0: spi at D0000 {
 		compatible = "samsung,exynos5440-spi";
 		reg = <0xD0000 0x100>;
-		interrupts = <0 4 0>;
+		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		samsung,spi-src-clk = <0>;
@@ -136,8 +137,14 @@
 	pin_ctrl: pinctrl at E0000 {
 		compatible = "samsung,exynos5440-pinctrl";
 		reg = <0xE0000 0x1000>;
-		interrupts = <0 37 0>, <0 38 0>, <0 39 0>, <0 40 0>,
-			     <0 41 0>, <0 42 0>, <0 43 0>, <0 44 0>;
+		interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 38 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 42 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 43 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 44 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		#gpio-cells = <2>;
@@ -162,7 +169,7 @@
 	i2c at F0000 {
 		compatible = "samsung,exynos5440-i2c";
 		reg = <0xF0000 0x1000>;
-		interrupts = <0 5 0>;
+		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&clock CLK_B_125>;
@@ -172,7 +179,7 @@
 	i2c at 100000 {
 		compatible = "samsung,exynos5440-i2c";
 		reg = <0x100000 0x1000>;
-		interrupts = <0 6 0>;
+		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&clock CLK_B_125>;
@@ -182,7 +189,7 @@
 	watchdog at 110000 {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x110000 0x1000>;
-		interrupts = <0 1 0>;
+		interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "watchdog";
 	};
@@ -209,7 +216,8 @@
 	rtc at 130000 {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x130000 0x1000>;
-		interrupts = <0 17 0>, <0 16 0>;
+		interrupts = <0 17 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "rtc";
 	};
@@ -217,7 +225,7 @@
 	tmuctrl_0: tmuctrl at 160118 {
 		compatible = "samsung,exynos5440-tmu";
 		reg = <0x160118 0x230>, <0x160368 0x10>;
-		interrupts = <0 58 0>;
+		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "tmu_apbif";
 		#include "exynos5440-tmu-sensor-conf.dtsi"
@@ -226,7 +234,7 @@
 	tmuctrl_1: tmuctrl at 16011C {
 		compatible = "samsung,exynos5440-tmu";
 		reg = <0x16011C 0x230>, <0x160368 0x10>;
-		interrupts = <0 58 0>;
+		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "tmu_apbif";
 		#include "exynos5440-tmu-sensor-conf.dtsi"
@@ -235,7 +243,7 @@
 	tmuctrl_2: tmuctrl at 160120 {
 		compatible = "samsung,exynos5440-tmu";
 		reg = <0x160120 0x230>, <0x160368 0x10>;
-		interrupts = <0 58 0>;
+		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "tmu_apbif";
 		#include "exynos5440-tmu-sensor-conf.dtsi"
@@ -259,7 +267,7 @@
 	sata at 210000 {
 		compatible = "snps,exynos5440-ahci";
 		reg = <0x210000 0x10000>;
-		interrupts = <0 30 0>;
+		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SATA>;
 		clock-names = "sata";
 	};
@@ -267,7 +275,7 @@
 	ohci at 220000 {
 		compatible = "samsung,exynos5440-ohci";
 		reg = <0x220000 0x1000>;
-		interrupts = <0 29 0>;
+		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_USB>;
 		clock-names = "usbhost";
 	};
@@ -275,7 +283,7 @@
 	ehci at 221000 {
 		compatible = "samsung,exynos5440-ehci";
 		reg = <0x221000 0x1000>;
-		interrupts = <0 29 0>;
+		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_USB>;
 		clock-names = "usbhost";
 	};
@@ -285,7 +293,9 @@
 		reg = <0x290000 0x1000
 			0x270000 0x1000
 			0x271000 0x40>;
-		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
+		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 21 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_PR0_250_O>, <&clock CLK_PB0_250_O>;
 		clock-names = "pcie", "pcie_bus";
 		#address-cells = <3>;
@@ -306,7 +316,9 @@
 		reg = <0x2a0000 0x1000
 			0x272000 0x1000
 			0x271040 0x40>;
-		interrupts = <0 23 0>, <0 24 0>, <0 25 0>;
+		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 24 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_PR1_250_O>, <&clock CLK_PB0_250_O>;
 		clock-names = "pcie", "pcie_bus";
 		#address-cells = <3>;
-- 
2.7.4
