From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 21:42:44 +0200
Subject: [PATCH 03/10] ARM: dts: exynos: Fix invalid GIC interrupt flags in
 exynos4x12
In-Reply-To: <1474054971-16831-1-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
Message-ID: <1474054971-16831-4-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interrupt of type IRQ_TYPE_NONE is not allowed for GIC interrupts and
generates an error:
	genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)

The GIC requires shared interrupts to be edge rising or level high.
Platform declares support for both.  Choose level high everywhere, also
for one private interrupt.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Alban Browaeys <alban.browaeys@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 20 ++++++++++---
 arch/arm/boot/dts/exynos4x12.dtsi         | 48 ++++++++++++++++++++-----------
 2 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
index 856b29254374..d579accc95db 100644
--- a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
@@ -579,8 +579,14 @@
 
 			interrupt-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
-				     <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>;
+			interrupts = <0 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 17 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 19 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 20 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 21 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 22 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 23 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 		};
 
@@ -590,8 +596,14 @@
 
 			interrupt-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
-				     <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
+			interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 25 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 27 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 28 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 29 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 31 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 		};
 
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 3394bdcf10ae..2f52b685daf9 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -88,11 +88,11 @@
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = <0 &gic 0 57 0>,
+			interrupt-map = <0 &gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
 					<1 &combiner 12 5>,
 					<2 &combiner 12 6>,
 					<3 &combiner 12 7>,
-					<4 &gic 1 12 0>;
+					<4 &gic 1 12 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
 
@@ -112,7 +112,7 @@
 	g2d: g2d at 10800000 {
 		compatible = "samsung,exynos4212-g2d";
 		reg = <0x10800000 0x1000>;
-		interrupts = <0 89 0>;
+		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
 		clock-names = "sclk_fimg2d", "fimg2d";
 		iommus = <&sysmmu_g2d>;
@@ -127,7 +127,7 @@
 		fimc_lite_0: fimc-lite at 12390000 {
 			compatible = "samsung,exynos4212-fimc-lite";
 			reg = <0x12390000 0x1000>;
-			interrupts = <0 105 0>;
+			interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE0>;
 			clock-names = "flite";
@@ -138,7 +138,7 @@
 		fimc_lite_1: fimc-lite at 123A0000 {
 			compatible = "samsung,exynos4212-fimc-lite";
 			reg = <0x123A0000 0x1000>;
-			interrupts = <0 106 0>;
+			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE1>;
 			clock-names = "flite";
@@ -149,7 +149,8 @@
 		fimc_is: fimc-is at 12000000 {
 			compatible = "samsung,exynos4212-fimc-is", "simple-bus";
 			reg = <0x12000000 0x260000>;
-			interrupts = <0 90 0>, <0 95 0>;
+			interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 95 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE0>,
 				 <&clock CLK_FIMC_LITE1>, <&clock CLK_PPMUISPX>,
@@ -200,7 +201,7 @@
 	mshc_0: mmc at 12550000 {
 		compatible = "samsung,exynos4412-dw-mshc";
 		reg = <0x12550000 0x1000>;
-		interrupts = <0 77 0>;
+		interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		fifo-depth = <0x80>;
@@ -461,11 +462,26 @@
 };
 
 &combiner {
-	interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
-		     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
-		     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
-		     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
-		     <0 107 0>, <0 108 0>, <0 48 0>, <0 42 0>;
+	interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 1 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 2 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 3 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 4 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 5 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 6 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 7 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 8 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 9 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 10 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 11 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 12 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 13 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 14 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 15 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 107 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 108 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 48 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 42 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &exynos_usbphy {
@@ -529,18 +545,18 @@
 &pinctrl_0 {
 	compatible = "samsung,exynos4x12-pinctrl";
 	reg = <0x11400000 0x1000>;
-	interrupts = <0 47 0>;
+	interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &pinctrl_1 {
 	compatible = "samsung,exynos4x12-pinctrl";
 	reg = <0x11000000 0x1000>;
-	interrupts = <0 46 0>;
+	interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
 
 	wakup_eint: wakeup-interrupt-controller {
 		compatible = "samsung,exynos4210-wakeup-eint";
 		interrupt-parent = <&gic>;
-		interrupts = <0 32 0>;
+		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
 
@@ -554,7 +570,7 @@
 &pinctrl_3 {
 	compatible = "samsung,exynos4x12-pinctrl";
 	reg = <0x106E0000 0x1000>;
-	interrupts = <0 72 0>;
+	interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &pmu_system_controller {
-- 
2.7.4
