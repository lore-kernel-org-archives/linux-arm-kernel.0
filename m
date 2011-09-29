From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Sep 2011 17:12:49 +0900
Subject: [PATCH 1/5] ARM: EXYNOS4: Add support new EXYNOS4412 SoC
Message-ID: <009401cc7e7f$93c59e50$bb50daf0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds Samsung EXYNOS4412 SoC support.
The EXYNOS4412 integrates a ARM Cortex A9 quad-core.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig            |    5 +++++
 arch/arm/mach-exynos4/cpu.c              |    4 ++--
 arch/arm/plat-s5p/cpu.c                  |    9 +++++++++
 arch/arm/plat-samsung/include/plat/cpu.h |    8 ++++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index d0491c2..bf3e21d 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -20,6 +20,11 @@ config SOC_EXYNOS4212
 	help
 	  Enable EXYNOS4212 SoC support
 
+config SOC_EXYNOS4412
+	bool
+	help
+	  Enable EXYNOS4412 SoC support
+
 config EXYNOS4_MCT
 	bool
 	default y
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 9d5a171..74d50d1 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -193,7 +193,7 @@ void __init exynos4_init_clocks(int xtal)
 
 	if (soc_is_exynos4210())
 		exynos4210_register_clocks();
-	else if (soc_is_exynos4212())
+	else if (soc_is_exynos4212() || soc_is_exynos4412())
 		exynos4212_register_clocks();
 
 	exynos4_register_clocks();
@@ -257,7 +257,7 @@ static int __init exynos4_l2x0_cache_init(void)
 
 	if (soc_is_exynos4210())
 		__raw_writel(0x110, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
-	else if (soc_is_exynos4212())
+	else if (soc_is_exynos4212() || soc_is_exynos4412())
 		__raw_writel(0x120, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
 
 	/* L2X0 Prefetch Control */
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index 909507b..7b0a28f 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -34,6 +34,7 @@ static const char name_s5pc100[] = "S5PC100";
 static const char name_s5pv210[] = "S5PV210/S5PC110";
 static const char name_exynos4210[] = "EXYNOS4210";
 static const char name_exynos4212[] = "EXYNOS4212";
+static const char name_exynos4412[] = "EXYNOS4412";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
@@ -84,6 +85,14 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init_uarts	= exynos4_init_uarts,
 		.init		= exynos4_init,
 		.name		= name_exynos4212,
+	}, {
+		.idcode		= EXYNOS4412_CPU_ID,
+		.idmask		= EXYNOS4_CPU_MASK,
+		.map_io		= exynos4_map_io,
+		.init_clocks	= exynos4_init_clocks,
+		.init_uarts	= exynos4_init_uarts,
+		.init		= exynos4_init,
+		.name		= name_exynos4412,
 	},
 };
 
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 1bbbbb4..54f370f 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -40,6 +40,7 @@ extern unsigned long samsung_cpu_id;
 
 #define EXYNOS4210_CPU_ID	0x43210000
 #define EXYNOS4212_CPU_ID	0x43220000
+#define EXYNOS4412_CPU_ID	0xE4412200
 #define EXYNOS4_CPU_MASK	0xFFFE0000
 
 #define IS_SAMSUNG_CPU(name, id, mask)		\
@@ -56,6 +57,7 @@ IS_SAMSUNG_CPU(s5pc100, S5PC100_CPU_ID, S5PC100_CPU_MASK)
 IS_SAMSUNG_CPU(s5pv210, S5PV210_CPU_ID, S5PV210_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
+IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
 
 #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
     defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2440) || \
@@ -108,6 +110,12 @@ IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
 # define soc_is_exynos4212()	0
 #endif
 
+#if defined(CONFIG_SOC_EXYNOS4412)
+# define soc_is_exynos4412()	is_samsung_exynos4412()
+#else
+# define soc_is_exynos4412()	0
+#endif
+
 #define EXYNOS4210_REV_0	(0x0)
 #define EXYNOS4210_REV_1_0	(0x10)
 #define EXYNOS4210_REV_1_1	(0x11)
-- 
1.7.1
