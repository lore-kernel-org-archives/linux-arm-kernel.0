From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 May 2016 21:06:05 +0200
Subject: [PATCH v2 20/22] ARM: dts: exynos: Move common Exynos5410/542x/5800
 nodes to new DTSI
In-Reply-To: <1462734367-5619-1-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
Message-ID: <1462734367-5619-21-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5410/542x/5800 are very similar designs. Create new new
DTSI with common nodes to remove DTS duplication. Although currently
only MCT and SysRAM are shared but in future more nodes will be added to
common file.

The patch should not have functional impact.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410.dtsi | 55 ++++---------------------------
 arch/arm/boot/dts/exynos5420.dtsi | 54 ++++---------------------------
 arch/arm/boot/dts/exynos54xx.dtsi | 68 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos54xx.dtsi

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 62dc3b4aef93..850343d3c2af 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -13,8 +13,7 @@
  * published by the Free Software Foundation.
  */
 
-#include "skeleton.dtsi"
-#include "exynos5.dtsi"
+#include "exynos54xx.dtsi"
 #include "exynos-syscon-restart.dtsi"
 #include <dt-bindings/clock/exynos5410.h>
 
@@ -73,53 +72,6 @@
 			reg = <0x10040000 0x5000>;
 		};
 
-		mct: mct at 101C0000 {
-			compatible = "samsung,exynos4210-mct";
-			reg = <0x101C0000 0xB00>;
-			interrupt-parent = <&interrupt_map>;
-			interrupts = <0>, <1>, <2>, <3>,
-				<4>, <5>, <6>, <7>,
-				<8>, <9>, <10>, <11>;
-			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
-			clock-names = "fin_pll", "mct";
-
-			interrupt_map: interrupt-map {
-				#interrupt-cells = <1>;
-				#address-cells = <0>;
-				#size-cells = <0>;
-				interrupt-map = <0 &combiner 23 3>,
-						<1 &combiner 23 4>,
-						<2 &combiner 25 2>,
-						<3 &combiner 25 3>,
-						<4 &gic 0 120 0>,
-						<5 &gic 0 121 0>,
-						<6 &gic 0 122 0>,
-						<7 &gic 0 123 0>,
-						<8 &gic 0 128 0>,
-						<9 &gic 0 129 0>,
-						<10 &gic 0 130 0>,
-						<11 &gic 0 131 0>;
-			};
-		};
-
-		sysram at 02020000 {
-			compatible = "mmio-sram";
-			reg = <0x02020000 0x54000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x02020000 0x54000>;
-
-			smp-sysram at 0 {
-				compatible = "samsung,exynos4210-sysram";
-				reg = <0x0 0x1000>;
-			};
-
-			smp-sysram at 53000 {
-				compatible = "samsung,exynos4210-sysram-ns";
-				reg = <0x53000 0x1000>;
-			};
-		};
-
 		clock: clock-controller at 10010000 {
 			compatible = "samsung,exynos5410-clock";
 			reg = <0x10010000 0x30000>;
@@ -194,6 +146,11 @@
 	};
 };
 
+&mct {
+	clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
+	clock-names = "fin_pll", "mct";
+};
+
 &pwm {
 	clocks = <&clock CLK_PWM>;
 	clock-names = "timers";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index ac39e3b8b0e1..750571f838f2 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -13,9 +13,8 @@
  * published by the Free Software Foundation.
  */
 
+#include "exynos54xx.dtsi"
 #include <dt-bindings/clock/exynos5420.h>
-#include "exynos5.dtsi"
-
 #include <dt-bindings/clock/exynos-audss-clk.h>
 
 / {
@@ -185,24 +184,6 @@
 			};
 		};
 
-		sysram at 02020000 {
-			compatible = "mmio-sram";
-			reg = <0x02020000 0x54000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x02020000 0x54000>;
-
-			smp-sysram at 0 {
-				compatible = "samsung,exynos4210-sysram";
-				reg = <0x0 0x1000>;
-			};
-
-			smp-sysram at 53000 {
-				compatible = "samsung,exynos4210-sysram-ns";
-				reg = <0x53000 0x1000>;
-			};
-		};
-
 		clock: clock-controller at 10010000 {
 			compatible = "samsung,exynos5420-clock";
 			reg = <0x10010000 0x30000>;
@@ -265,34 +246,6 @@
 			status = "disabled";
 		};
 
-		mct: mct at 101C0000 {
-			compatible = "samsung,exynos4210-mct";
-			reg = <0x101C0000 0xB00>;
-			interrupt-parent = <&mct_map>;
-			interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>,
-					<8>, <9>, <10>, <11>;
-			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
-			clock-names = "fin_pll", "mct";
-
-			mct_map: mct-map {
-				#interrupt-cells = <1>;
-				#address-cells = <0>;
-				#size-cells = <0>;
-				interrupt-map = <0 &combiner 23 3>,
-						<1 &combiner 23 4>,
-						<2 &combiner 25 2>,
-						<3 &combiner 25 3>,
-						<4 &gic 0 120 0>,
-						<5 &gic 0 121 0>,
-						<6 &gic 0 122 0>,
-						<7 &gic 0 123 0>,
-						<8 &gic 0 128 0>,
-						<9 &gic 0 129 0>,
-						<10 &gic 0 130 0>,
-						<11 &gic 0 131 0>;
-			};
-		};
-
 		gsc_pd: power-domain at 10044000 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044000 0x20>;
@@ -1194,6 +1147,11 @@
 	iommu-names = "m0", "m1";
 };
 
+&mct {
+	clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
+	clock-names = "fin_pll", "mct";
+};
+
 &pwm {
 	clocks = <&clock CLK_PWM>;
 	clock-names = "timers";
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
new file mode 100644
index 000000000000..9ce625bd79c1
--- /dev/null
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -0,0 +1,68 @@
+/*
+ * Samsung's Exynos54xx SoC series common device tree source
+ *
+ * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2016 Krzysztof Kozlowski
+ *
+ * Device nodes common for Samsung Exynos5410/5420/5422/5800. Specific
+ * Exynos 54xx SoCs should include this file and customize it further
+ * (e.g. with clocks).
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "skeleton.dtsi"
+#include "exynos5.dtsi"
+
+/ {
+	compatible = "samsung,exynos5";
+
+	soc: soc {
+		sysram at 02020000 {
+			compatible = "mmio-sram";
+			reg = <0x02020000 0x54000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x02020000 0x54000>;
+
+			smp-sysram at 0 {
+				compatible = "samsung,exynos4210-sysram";
+				reg = <0x0 0x1000>;
+			};
+
+			smp-sysram at 53000 {
+				compatible = "samsung,exynos4210-sysram-ns";
+				reg = <0x53000 0x1000>;
+			};
+		};
+
+		mct: mct at 101C0000 {
+			compatible = "samsung,exynos4210-mct";
+			reg = <0x101C0000 0xB00>;
+			interrupt-parent = <&mct_map>;
+			interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>,
+					<8>, <9>, <10>, <11>;
+
+			mct_map: mct-map {
+				#interrupt-cells = <1>;
+				#address-cells = <0>;
+				#size-cells = <0>;
+				interrupt-map = <0 &combiner 23 3>,
+						<1 &combiner 23 4>,
+						<2 &combiner 25 2>,
+						<3 &combiner 25 3>,
+						<4 &gic 0 120 0>,
+						<5 &gic 0 121 0>,
+						<6 &gic 0 122 0>,
+						<7 &gic 0 123 0>,
+						<8 &gic 0 128 0>,
+						<9 &gic 0 129 0>,
+						<10 &gic 0 130 0>,
+						<11 &gic 0 131 0>;
+			};
+		};
+	};
+};
-- 
2.5.0
