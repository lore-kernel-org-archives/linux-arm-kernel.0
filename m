From: mihailescu2m@gmail.com (memeka)
Date: Fri, 20 Oct 2017 23:19:34 +1030
Subject: [PATCH] ARM: dts: exynos: add cpu perf counters to Exynos54xx boards
Message-ID: <1508503774-2328-1-git-send-email-mihailescu2m@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marian Mihailescu <mihailescu2m@gmail.com>

Enable support for ARM Performance Monitoring Units available in Cortex-A7
and Cortex-A15 CPU cores for Exynos54xx SoCs (5410, 5420 and 5422/5800).

Exynos5410 currently has only Cortex-A7 nodes defined in the device tree,
so the Cortex-A15 PMU is defined in the exynos5420 device tree file.

Tested with perf on Odroid XU4 (Exynos5422):
armv7_cortex_a7 PMU driver: 5 counters available
armv7_cortex_a15 PMU driver: 7 counters available

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
Signed-off-by: Willy Wolff <willy.mh.wolff@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/exynos54xx.dtsi | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 02d2f89..468059e 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -695,6 +695,19 @@
 			iommus = <&sysmmu_jpeg1>;
 		};
 
+		arm-a15-pmu {
+			compatible = "arm,cortex-a15-pmu";
+			interrupt-parent = <&combiner>;
+			interrupts = <1 2>,
+				<7 0>,
+				<16 6>,
+				<19 2>;
+			interrupt-affinity = <&cpu4>,
+				<&cpu5>,
+				<&cpu6>,
+				<&cpu7>;
+		};
+
 		pmu_system_controller: system-controller at 10040000 {
 			compatible = "samsung,exynos5420-pmu", "syscon";
 			reg = <0x10040000 0x5000>;
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 8ca4fef..8e007a4 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -79,6 +79,19 @@
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		arm-a7-pmu {
+			compatible = "arm,cortex-a7-pmu";
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-affinity = <&cpu0>,
+				<&cpu1>,
+				<&cpu2>,
+				<&cpu3>;
+		};
+
 		sss: sss at 10830000 {
 			compatible = "samsung,exynos4210-secss";
 			reg = <0x10830000 0x300>;
-- 
2.7.4
