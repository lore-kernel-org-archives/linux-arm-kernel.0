From: chanho61.park@samsung.com (Chanho Park)
Date: Mon, 08 Oct 2012 11:17:08 +0900
Subject: [PATCH v4 3/5] ARM: EXYNOS: Enable PMUs for exynos4
In-Reply-To: <1349662630-11607-1-git-send-email-chanho61.park@samsung.com>
References: <1349662630-11607-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1349662630-11607-4-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines irq numbers of ARM performance monitoring unit for exynos4.
Firs of all, we need to fix IRQ_PMU correctly and to split pmu initialization
of exynos from plat-samsung for easily defining it.

The number of CPU cores and PMU irq numbers are vary according to soc types.
So, we need to identify each soc type using soc_is_xxx function and to define
the pmu irqs dynamically. For example, the exynos4412 has 4 cpu cores and pmus.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c            |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/irqs.h |    8 ++++++--
 arch/arm/plat-samsung/devs.c             |    2 +-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index fdd582a..5183426 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -35,6 +35,7 @@
 #include <mach/regs-pmu.h>
 #include <mach/regs-gpio.h>
 #include <mach/pmu.h>
+#include <mach/irqs.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -1093,3 +1094,30 @@ static int __init exynos_init_irq_eint(void)
 	return 0;
 }
 arch_initcall(exynos_init_irq_eint);
+
+static struct resource exynos4_pmu_resource[] = {
+	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU),
+	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU1),
+#if defined(CONFIG_SOC_EXYNOS4412)
+	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU2),
+	DEFINE_RES_IRQ(EXYNOS4_IRQ_PMU_CPU3),
+#endif
+};
+
+static struct platform_device exynos4_device_pmu = {
+	.name		= "arm-pmu",
+	.num_resources	= ARRAY_SIZE(exynos4_pmu_resource),
+	.resource	= exynos4_pmu_resource,
+};
+
+static int __init exynos_armpmu_init(void)
+{
+	if (!of_have_populated_dt()) {
+		if (soc_is_exynos4210() || soc_is_exynos4212())
+			exynos4_device_pmu.num_resources = 2;
+		platform_device_register(&exynos4_device_pmu);
+	}
+
+	return 0;
+}
+arch_initcall(exynos_armpmu_init);
diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index 3a83546..c67a54e 100644
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
@@ -232,7 +237,6 @@
 #define IRQ_TC				EXYNOS4_IRQ_PEN0
 
 #define IRQ_KEYPAD			EXYNOS4_IRQ_KEYPAD
-#define IRQ_PMU				EXYNOS4_IRQ_PMU
 
 #define IRQ_FIMD0_FIFO			EXYNOS4_IRQ_FIMD0_FIFO
 #define IRQ_FIMD0_VSYNC			EXYNOS4_IRQ_FIMD0_VSYNC
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 03f654d..ace76b4 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1125,7 +1125,7 @@ struct platform_device s5p_device_onenand = {
 
 /* PMU */
 
-#ifdef CONFIG_PLAT_S5P
+#if defined(CONFIG_PLAT_S5P) && !defined(CONFIG_ARCH_EXYNOS)
 static struct resource s5p_pmu_resource[] = {
 	DEFINE_RES_IRQ(IRQ_PMU)
 };
-- 
1.7.9.5
