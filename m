From: chanho61.park@samsung.com (Chanho Park)
Date: Fri, 27 Jul 2012 17:08:29 +0900
Subject: [PATCHv2 3/3] ARM: EXYNOS: Enable PMUs for exynos4/5
In-Reply-To: <1343376509-5881-1-git-send-email-chanho61.park@samsung.com>
References: <1343376509-5881-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1343376509-5881-4-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch define irq numbers of ARM performance monitoring unit for exynos4/5.
The number of CPU cores and PMU irq numbers are vary according to soc types.
So we need to identify each soc type using soc_is_xxx function and define the
pmu irqs dynamically. In case of exynos4412, there are 4 cpu cores and pmus.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c            |   65 ++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/irqs.h |    8 +++-
 arch/arm/plat-samsung/devs.c             |    3 +-
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 499791a..4271df0 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -30,11 +30,13 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 #include <asm/cacheflush.h>
+#include <asm/pmu.h>
 
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
 #include <mach/regs-gpio.h>
 #include <mach/pmu.h>
+#include <mach/irqs.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -1065,3 +1067,66 @@ static int __init exynos_init_irq_eint(void)
 	return 0;
 }
 arch_initcall(exynos_init_irq_eint);
+
+#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
+static struct resource exynos42xx_pmu_resource[] = {
+	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU),
+	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU1),
+};
+
+static struct platform_device exynos42xx_device_pmu = {
+	.name		= "arm-pmu",
+	.id		= ARM_PMU_DEVICE_CPU,
+	.num_resources	= ARRAY_SIZE(exynos42xx_pmu_resource),
+	.resource	= exynos42xx_pmu_resource,
+};
+#endif
+
+#if defined(CONFIG_SOC_EXYNOS4412)
+static struct resource exynos44xx_pmu_resource[] = {
+	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU),
+	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU1),
+	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU2),
+	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU3),
+};
+
+static struct platform_device exynos44xx_device_pmu = {
+	.name		= "arm-pmu",
+	.id		= ARM_PMU_DEVICE_CPU,
+	.num_resources	= ARRAY_SIZE(exynos44xx_pmu_resource),
+	.resource	= exynos44xx_pmu_resource,
+};
+#endif
+
+#if defined(CONFIG_SOC_EXYNOS5250)
+static struct resource exynos52xx_pmu_resource[] = {
+	DEFINE_RES_IRQ(EXYNOS5_IRQ_PMU),
+	DEFINE_RES_IRQ(EXYNOS5_IRQ_PMU_CPU1),
+};
+
+static struct platform_device exynos52xx_device_pmu = {
+	.name		= "arm-pmu",
+	.id		= ARM_PMU_DEVICE_CPU,
+	.num_resources	= ARRAY_SIZE(exynos52xx_pmu_resource),
+	.resource	= exynos52xx_pmu_resource,
+};
+#endif
+
+static int __init exynos_armpmu_init(void)
+{
+#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
+	if (soc_is_exynos4210() || soc_is_exynos4212())
+		platform_device_register(&exynos42xx_device_pmu);
+#endif
+#if defined(CONFIG_SOC_EXYNOS4412)
+	if (soc_is_exynos4412())
+		platform_device_register(&exynos44xx_device_pmu);
+#endif
+#if defined(CONFIG_SOC_EXYNOS5250)
+	if (soc_is_exynos5250())
+		platform_device_register(&exynos52xx_device_pmu);
+#endif
+
+	return 0;
+}
+arch_initcall(exynos_armpmu_init);
diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index 12b4f48..f4e9257 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -128,7 +128,7 @@
 #define EXYNOS4_IRQ_ADC1		IRQ_SPI(107)
 #define EXYNOS4_IRQ_PEN1		IRQ_SPI(108)
 #define EXYNOS4_IRQ_KEYPAD		IRQ_SPI(109)
-#define EXYNOS4_IRQ_PMU			IRQ_SPI(110)
+#define EXYNOS4_IRQ_POWER_PMU		IRQ_SPI(110)
 #define EXYNOS4_IRQ_GPS			IRQ_SPI(111)
 #define EXYNOS4_IRQ_INTFEEDCTRL_SSS	IRQ_SPI(112)
 #define EXYNOS4_IRQ_SLIMBUS		IRQ_SPI(113)
@@ -136,6 +136,11 @@
 #define EXYNOS4_IRQ_TSI			IRQ_SPI(115)
 #define EXYNOS4_IRQ_SATA		IRQ_SPI(116)
 
+#define EXYNOS4_IRQ_PMU			COMBINER_IRQ(2, 2)
+#define EXYNOS4_IRQ_PMU_CPU1		COMBINER_IRQ(3, 2)
+#define EXYNOS4_IRQ_PMU_CPU2		COMBINER_IRQ(18, 2)
+#define EXYNOS4_IRQ_PMU_CPU3		COMBINER_IRQ(19, 2)
+
 #define EXYNOS4_IRQ_SYSMMU_MDMA0_0	COMBINER_IRQ(4, 0)
 #define EXYNOS4_IRQ_SYSMMU_SSS_0	COMBINER_IRQ(4, 1)
 #define EXYNOS4_IRQ_SYSMMU_FIMC0_0	COMBINER_IRQ(4, 2)
@@ -231,7 +236,6 @@
 #define IRQ_TC				EXYNOS4_IRQ_PEN0
 
 #define IRQ_KEYPAD			EXYNOS4_IRQ_KEYPAD
-#define IRQ_PMU				EXYNOS4_IRQ_PMU
 
 #define IRQ_FIMD0_FIFO			EXYNOS4_IRQ_FIMD0_FIFO
 #define IRQ_FIMD0_VSYNC			EXYNOS4_IRQ_FIMD0_VSYNC
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 74e31ce..31bb023 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1098,7 +1098,7 @@ struct platform_device s5p_device_onenand = {
 
 /* PMU */
 
-#ifdef CONFIG_PLAT_S5P
+#if defined(CONFIG_PLAT_S5P) && !defined(CONFIG_ARCH_EXYNOS)
 static struct resource s5p_pmu_resource[] = {
 	DEFINE_RES_IRQ(IRQ_PMU)
 };
@@ -1113,6 +1113,7 @@ static struct platform_device s5p_device_pmu = {
 static int __init s5p_pmu_init(void)
 {
 	platform_device_register(&s5p_device_pmu);
+
 	return 0;
 }
 arch_initcall(s5p_pmu_init);
-- 
1.7.9.5
