From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 15:52:43 +0200
Subject: [PATCH 3/8] ARM: dts: exynos4x12: Move MCT node to exynos4x12.dtsi
In-Reply-To: <1377006768-23174-1-git-send-email-t.figa@samsung.com>
References: <1377006768-23174-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377006768-23174-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For MCT block compatible with "samsung,exynos4412-mct", that uses PPI
interrupts for local timers, only one local interrupt needs to be
specified, since it is a per-processor interrupt.

This allows moving MCT node of Exynos4x12 SoCs back to common
exynos4x12.dtsi, since they have the same set of interrupts to be
specified, which was the only difference.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4212.dtsi | 20 --------------------
 arch/arm/boot/dts/exynos4412.dtsi | 24 ------------------------
 arch/arm/boot/dts/exynos4x12.dtsi | 20 ++++++++++++++++++++
 3 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 028752e..443b8a2 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -34,24 +34,4 @@
 			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
 			     <0 107 0>, <0 108 0>;
 	};
-
-	mct at 10050000 {
-		compatible = "samsung,exynos4412-mct";
-		reg = <0x10050000 0x800>;
-		interrupt-parent = <&mct_map>;
-		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
-			     <4 0>, <5 0>;
-
-		mct_map: mct-map {
-			#interrupt-cells = <2>;
-			#address-cells = <0>;
-			#size-cells = <0>;
-			interrupt-map = <0x0 0 &gic 0 57 0>,
-					<0x1 0 &combiner 12 5>,
-					<0x2 0 &combiner 12 6>,
-					<0x3 0 &combiner 12 7>,
-					<0x4 0 &gic 1 12 0>,
-					<0x5 0 &gic 1 12 0>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 85d2c26..1388ce0 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -35,30 +35,6 @@
 			     <0 107 0>, <0 108 0>, <0 48 0>, <0 42 0>;
 	};
 
-	mct at 10050000 {
-		compatible = "samsung,exynos4412-mct";
-		reg = <0x10050000 0x800>;
-		interrupt-parent = <&mct_map>;
-		interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
-			     <4 0>, <5 0>, <6 0>, <7 0>;
-		clocks = <&clock 3>, <&clock 344>;
-		clock-names = "fin_pll", "mct";
-
-		mct_map: mct-map {
-			#interrupt-cells = <2>;
-			#address-cells = <0>;
-			#size-cells = <0>;
-			interrupt-map = <0x0 0 &gic 0 57 0>,
-					<0x1 0 &combiner 12 5>,
-					<0x2 0 &combiner 12 6>,
-					<0x3 0 &combiner 12 7>,
-					<0x4 0 &gic 1 12 0>,
-					<0x5 0 &gic 1 12 0>,
-					<0x6 0 &gic 1 12 0>,
-					<0x7 0 &gic 1 12 0>;
-		};
-	};
-
 	mshc at 12550000 {
 		compatible = "samsung,exynos4412-dw-mshc";
 		reg = <0x12550000 0x1000>;
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index ad531fe..5012bc8 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -41,6 +41,26 @@
 		#clock-cells = <1>;
 	};
 
+	mct at 10050000 {
+		compatible = "samsung,exynos4412-mct";
+		reg = <0x10050000 0x800>;
+		interrupt-parent = <&mct_map>;
+		interrupts = <0 0>, <1 0>, <2 0>, <3 0>, <4 0>;
+		clocks = <&clock 3>, <&clock 344>;
+		clock-names = "fin_pll", "mct";
+
+		mct_map: mct-map {
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <0x0 0 &gic 0 57 0>,
+					<0x1 0 &combiner 12 5>,
+					<0x2 0 &combiner 12 6>,
+					<0x3 0 &combiner 12 7>,
+					<0x4 0 &gic 1 12 0>;
+		};
+	};
+
 	pinctrl_0: pinctrl at 11400000 {
 		compatible = "samsung,exynos4x12-pinctrl";
 		reg = <0x11400000 0x1000>;
-- 
1.8.3.2
