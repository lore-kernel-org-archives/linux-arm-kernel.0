From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 21:42:43 +0200
Subject: [PATCH 02/10] ARM: dts: exynos: Fix invalid GIC interrupt flags in
 exynos4210
In-Reply-To: <1474054971-16831-1-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
Message-ID: <1474054971-16831-3-git-send-email-krzk@kernel.org>
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
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi | 20 +++++++++++++----
 arch/arm/boot/dts/exynos4210.dtsi         | 36 ++++++++++++++++++++-----------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
index 9331c6252eff..152f324f44c7 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
@@ -535,8 +535,14 @@
 
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
 
@@ -546,8 +552,14 @@
 
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
 
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 2d9b02967105..736ab8587ab0 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -109,12 +109,12 @@
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = <0 &gic 0 57 0>,
-					<1 &gic 0 69 0>,
+			interrupt-map = <0 &gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
+					<1 &gic 0 69 IRQ_TYPE_LEVEL_HIGH>,
 					<2 &combiner 12 6>,
 					<3 &combiner 12 7>,
-					<4 &gic 0 42 0>,
-					<5 &gic 0 48 0>;
+					<4 &gic 0 42 IRQ_TYPE_LEVEL_HIGH>,
+					<5 &gic 0 48 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
 
@@ -127,18 +127,18 @@
 	pinctrl_0: pinctrl at 11400000 {
 		compatible = "samsung,exynos4210-pinctrl";
 		reg = <0x11400000 0x1000>;
-		interrupts = <0 47 0>;
+		interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	pinctrl_1: pinctrl at 11000000 {
 		compatible = "samsung,exynos4210-pinctrl";
 		reg = <0x11000000 0x1000>;
-		interrupts = <0 46 0>;
+		interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
 
 		wakup_eint: wakeup-interrupt-controller {
 			compatible = "samsung,exynos4210-wakeup-eint";
 			interrupt-parent = <&gic>;
-			interrupts = <0 32 0>;
+			interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
 
@@ -182,7 +182,7 @@
 	g2d: g2d at 12800000 {
 		compatible = "samsung,s5pv210-g2d";
 		reg = <0x12800000 0x1000>;
-		interrupts = <0 89 0>;
+		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
 		clock-names = "sclk_fimg2d", "fimg2d";
 		power-domains = <&pd_lcd0>;
@@ -424,10 +424,22 @@
 
 &combiner {
 	samsung,combiner-nr = <16>;
-	interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
-		     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
-		     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
-		     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
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
+		     <0 15 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &mdma1 {
-- 
2.7.4
