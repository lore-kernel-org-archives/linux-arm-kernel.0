From: chirantan@chromium.org (Chirantan Ekbote)
Date: Thu, 15 May 2014 14:07:59 -0700
Subject: [PATCH] arm: dts: exynos5: Remove multi core timer
Message-ID: <1400188079-21832-1-git-send-email-chirantan@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The multi core timer and the ARM architected timer are two different
interfaces to the same underlying hardware timer.  This causes some
strange timing issues when they are both enabled at the same time so
remove the mct from the device tree and keep only the architected
timer.

Cc: Olof Johansson <olof@lixom.net>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
 arch/arm/boot/dts/exynos5250.dtsi | 24 ------------------------
 arch/arm/boot/dts/exynos5420.dtsi | 30 ------------------------------
 2 files changed, 54 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3742331..60cd945 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -110,30 +110,6 @@
 		clock-frequency = <24000000>;
 	};
 
-	mct at 101C0000 {
-		compatible = "samsung,exynos4210-mct";
-		reg = <0x101C0000 0x800>;
-		interrupt-controller;
-		#interrups-cells = <2>;
-		interrupt-parent = <&mct_map>;
-		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
-			     <4 0>, <5 0>;
-		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
-		clock-names = "fin_pll", "mct";
-
-		mct_map: mct-map {
-			#interrupt-cells = <2>;
-			#address-cells = <0>;
-			#size-cells = <0>;
-			interrupt-map = <0x0 0 &combiner 23 3>,
-					<0x1 0 &combiner 23 4>,
-					<0x2 0 &combiner 25 2>,
-					<0x3 0 &combiner 25 3>,
-					<0x4 0 &gic 0 120 0>,
-					<0x5 0 &gic 0 121 0>;
-		};
-	};
-
 	pmu {
 		compatible = "arm,cortex-a15-pmu";
 		interrupt-parent = <&combiner>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c3a9a66..3c38c6d 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -169,36 +169,6 @@
 		status = "disabled";
 	};
 
-	mct at 101C0000 {
-		compatible = "samsung,exynos4210-mct";
-		reg = <0x101C0000 0x800>;
-		interrupt-controller;
-		#interrups-cells = <1>;
-		interrupt-parent = <&mct_map>;
-		interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>,
-				<8>, <9>, <10>, <11>;
-		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
-		clock-names = "fin_pll", "mct";
-
-		mct_map: mct-map {
-			#interrupt-cells = <1>;
-			#address-cells = <0>;
-			#size-cells = <0>;
-			interrupt-map = <0 &combiner 23 3>,
-					<1 &combiner 23 4>,
-					<2 &combiner 25 2>,
-					<3 &combiner 25 3>,
-					<4 &gic 0 120 0>,
-					<5 &gic 0 121 0>,
-					<6 &gic 0 122 0>,
-					<7 &gic 0 123 0>,
-					<8 &gic 0 128 0>,
-					<9 &gic 0 129 0>,
-					<10 &gic 0 130 0>,
-					<11 &gic 0 131 0>;
-		};
-	};
-
 	gsc_pd: power-domain at 10044000 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
-- 
1.9.1.423.g4596e3a
