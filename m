From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Aug 2011 22:25:48 +0900
Subject: [PATCH 1/5] ARM: EXYNOS4: Add support new EXYNOS4212 SoC
In-Reply-To: <1314192352-14911-1-git-send-email-kgene.kim@samsung.com>
References: <1314192352-14911-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1314192352-14911-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Samsung EXYNOS4212 SoC support.
The EXYNOS4212 integrates a ARM Cortex A9 multi-core.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig            |    5 +++++
 arch/arm/mach-exynos4/Makefile           |    6 ++++--
 arch/arm/mach-exynos4/cpu.c              |    6 +++++-
 arch/arm/plat-s5p/cpu.c                  |    9 +++++++++
 arch/arm/plat-s5p/include/plat/exynos4.h |    3 +--
 arch/arm/plat-samsung/include/plat/cpu.h |    8 ++++++++
 6 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index bee8f77..0b40289 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -15,6 +15,11 @@ config CPU_EXYNOS4210
 	help
 	  Enable EXYNOS4210 CPU support
 
+config SOC_EXYNOS4212
+	bool
+	help
+	  Enable EXYNOS4212 SoC support
+
 config EXYNOS4_MCT
 	bool
 	default y
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index e3e93ea..4624457 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -12,8 +12,10 @@ obj-				:=
 
 # Core support for EXYNOS4 system
 
-obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
-obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
+obj-$(CONFIG_ARCH_EXYNOS4)	+= cpu.o init.o clock.o irq-combiner.o
+obj-$(CONFIG_ARCH_EXYNOS4)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
+obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
+obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 0d281bb..1e1a7a9 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -241,7 +241,11 @@ static int __init exynos4_l2x0_cache_init(void)
 {
 	/* TAG, Data Latency Control: 2cycle */
 	__raw_writel(0x110, S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
-	__raw_writel(0x110, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
+
+	if (soc_is_exynos4210())
+		__raw_writel(0x110, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
+	else if (soc_is_exynos4212())
+		__raw_writel(0x120, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
 
 	/* L2X0 Prefetch Control */
 	__raw_writel(0x30000007, S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index 04392c7..909507b 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -33,6 +33,7 @@ static const char name_s5p6450[] = "S5P6450";
 static const char name_s5pc100[] = "S5PC100";
 static const char name_s5pv210[] = "S5PV210/S5PC110";
 static const char name_exynos4210[] = "EXYNOS4210";
+static const char name_exynos4212[] = "EXYNOS4212";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
@@ -75,6 +76,14 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init_uarts	= exynos4_init_uarts,
 		.init		= exynos4_init,
 		.name		= name_exynos4210,
+	}, {
+		.idcode		= EXYNOS4212_CPU_ID,
+		.idmask		= EXYNOS4_CPU_MASK,
+		.map_io		= exynos4_map_io,
+		.init_clocks	= exynos4_init_clocks,
+		.init_uarts	= exynos4_init_uarts,
+		.init		= exynos4_init,
+		.name		= name_exynos4212,
 	},
 };
 
diff --git a/arch/arm/plat-s5p/include/plat/exynos4.h b/arch/arm/plat-s5p/include/plat/exynos4.h
index 907caab..4aed130 100644
--- a/arch/arm/plat-s5p/include/plat/exynos4.h
+++ b/arch/arm/plat-s5p/include/plat/exynos4.h
@@ -16,8 +16,7 @@ extern void exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void exynos4_register_clocks(void);
 extern void exynos4_setup_clocks(void);
 
-#ifdef CONFIG_CPU_EXYNOS4210
-
+#ifdef CONFIG_ARCH_EXYNOS4
 extern  int exynos4_init(void);
 extern void exynos4_init_irq(void);
 extern void exynos4_map_io(void);
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 6fdd5ef..aa1f69b 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -39,6 +39,7 @@ extern unsigned long samsung_cpu_id;
 #define S5PV210_CPU_MASK	0xFFFFF000
 
 #define EXYNOS4210_CPU_ID	0x43210000
+#define EXYNOS4212_CPU_ID	0x43220000
 #define EXYNOS4_CPU_MASK	0xFFFE0000
 
 #define IS_SAMSUNG_CPU(name, id, mask)		\
@@ -54,6 +55,7 @@ IS_SAMSUNG_CPU(s5p6450, S5P6450_CPU_ID, S5P64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s5pc100, S5PC100_CPU_ID, S5PC100_CPU_MASK)
 IS_SAMSUNG_CPU(s5pv210, S5PV210_CPU_ID, S5PV210_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
+IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
 
 #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
     defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2440) || \
@@ -100,6 +102,12 @@ IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
 # define soc_is_exynos4210()	0
 #endif
 
+#if defined(CONFIG_SOC_EXYNOS4212)
+# define soc_is_exynos4212()	is_samsung_exynos4212()
+#else
+# define soc_is_exynos4212()	0
+#endif
+
 #define EXYNOS4210_REV_0	(0x0)
 #define EXYNOS4210_REV_1_0	(0x10)
 #define EXYNOS4210_REV_1_1	(0x11)
-- 
1.7.1
