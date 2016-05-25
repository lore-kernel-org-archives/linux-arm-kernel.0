From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 25 May 2016 13:28:24 +0530
Subject: [PATCH v6 2/2] ARM: EXYNOS: refactoring of mach-exynos to enable
 chipid driver
In-Reply-To: <1464163104-8163-1-git-send-email-pankaj.dubey@samsung.com>
References: <1464163104-8163-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1464163104-8163-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables chipid driver for ARCH_EXYNOS and refactors
machine code for using chipid driver for identification of
SoC ID and SoC rev.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                 |  1 +
 arch/arm/mach-exynos/common.h                | 53 ++++++++++++----------------
 arch/arm/mach-exynos/exynos.c                | 49 +++++--------------------
 arch/arm/mach-exynos/include/mach/map.h      |  2 --
 arch/arm/mach-exynos/platsmp.c               |  2 +-
 arch/arm/mach-exynos/pm.c                    |  8 ++---
 arch/arm/plat-samsung/cpu.c                  | 14 --------
 arch/arm/plat-samsung/include/plat/cpu.h     |  2 --
 arch/arm/plat-samsung/include/plat/map-s5p.h |  1 -
 9 files changed, 37 insertions(+), 95 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 20dcf6e..f93c790 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -16,6 +16,7 @@ menuconfig ARCH_EXYNOS
 	select ARM_AMBA
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_CHIPID
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
 	select EXYNOS_SROM
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 5365bf1..566ad2b 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -13,39 +13,26 @@
 #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
 
 #include <linux/platform_data/cpuidle-exynos.h>
+#include <linux/soc/samsung/exynos-soc.h>
 
-#define EXYNOS3250_SOC_ID	0xE3472000
-#define EXYNOS3_SOC_MASK	0xFFFFF000
-
-#define EXYNOS4210_CPU_ID	0x43210000
-#define EXYNOS4212_CPU_ID	0x43220000
-#define EXYNOS4412_CPU_ID	0xE4412200
-#define EXYNOS4_CPU_MASK	0xFFFE0000
-
-#define EXYNOS5250_SOC_ID	0x43520000
-#define EXYNOS5410_SOC_ID	0xE5410000
-#define EXYNOS5420_SOC_ID	0xE5420000
-#define EXYNOS5440_SOC_ID	0xE5440000
-#define EXYNOS5800_SOC_ID	0xE5422000
-#define EXYNOS5_SOC_MASK	0xFFFFF000
-
-extern unsigned long samsung_cpu_id;
+static inline u32 exynos_product_id(void);
 
 #define IS_SAMSUNG_CPU(name, id, mask)		\
 static inline int is_samsung_##name(void)	\
 {						\
-	return ((samsung_cpu_id & mask) == (id & mask));	\
+	u32 product_id = exynos_product_id();	\
+	return ((product_id & mask) == (id));	\
 }
 
-IS_SAMSUNG_CPU(exynos3250, EXYNOS3250_SOC_ID, EXYNOS3_SOC_MASK)
-IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5410, EXYNOS5410_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
+IS_SAMSUNG_CPU(exynos3250, EXYNOS3250_SOC_ID, EXYNOS_SOC_MASK)
+IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_SOC_ID, EXYNOS_SOC_MASK)
+IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_SOC_ID, EXYNOS_SOC_MASK)
+IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_SOC_ID, EXYNOS_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5410, EXYNOS5410_SOC_ID, EXYNOS_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS_SOC_MASK)
 
 #if defined(CONFIG_SOC_EXYNOS3250)
 # define soc_is_exynos3250()	is_samsung_exynos3250()
@@ -71,10 +58,6 @@ IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_exynos4412()	0
 #endif
 
-#define EXYNOS4210_REV_0	(0x0)
-#define EXYNOS4210_REV_1_0	(0x10)
-#define EXYNOS4210_REV_1_1	(0x11)
-
 #if defined(CONFIG_SOC_EXYNOS5250)
 # define soc_is_exynos5250()	is_samsung_exynos5250()
 #else
@@ -172,6 +155,16 @@ extern void exynos_core_restart(u32 core_id);
 extern int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr);
 extern int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr);
 
+static inline u32 exynos_product_id(void)
+{
+	return exynos_soc_info.product_id;
+}
+
+static inline u32 exynos_revision(void)
+{
+	return exynos_soc_info.revision;
+}
+
 static inline void pmu_raw_writel(u32 val, u32 offset)
 {
 	__raw_writel(val, pmu_base_addr + offset);
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index f977eea..89d7254 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -92,50 +92,11 @@ static void __init exynos_init_late(void)
 	exynos_pm_init();
 }
 
-static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
-					int depth, void *data)
-{
-	struct map_desc iodesc;
-	const __be32 *reg;
-	int len;
-
-	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid") &&
-		!of_flat_dt_is_compatible(node, "samsung,exynos5440-clock"))
-		return 0;
-
-	reg = of_get_flat_dt_prop(node, "reg", &len);
-	if (reg == NULL || len != (sizeof(unsigned long) * 2))
-		return 0;
-
-	iodesc.pfn = __phys_to_pfn(be32_to_cpu(reg[0]));
-	iodesc.length = be32_to_cpu(reg[1]) - 1;
-	iodesc.virtual = (unsigned long)S5P_VA_CHIPID;
-	iodesc.type = MT_DEVICE;
-	iotable_init(&iodesc, 1);
-	return 1;
-}
-
-/*
- * exynos_map_io
- *
- * register the standard cpu IO areas
- */
-static void __init exynos_map_io(void)
-{
-	if (soc_is_exynos4())
-		iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
-}
-
 static void __init exynos_init_io(void)
 {
 	debug_ll_io_init();
-
-	of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
-
-	/* detect cpu id and rev. */
-	s5p_init_cpu(S5P_VA_CHIPID);
-
-	exynos_map_io();
+	if (soc_is_exynos4())
+		iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
 }
 
 /*
@@ -187,6 +148,8 @@ static void exynos_map_pmu(void)
 
 static void __init exynos_init_irq(void)
 {
+	int ret;
+
 	irqchip_init();
 	/*
 	 * Since platsmp.c needs pmu base address by the time
@@ -194,6 +157,10 @@ static void __init exynos_init_irq(void)
 	 * init_irq
 	 */
 	exynos_map_pmu();
+
+	ret = exynos_chipid_early_init(NULL);
+	if (ret)
+		pr_warn("Exynos chipid early initialization failed\n");
 }
 
 static const struct of_device_id exynos_cpufreq_matches[] = {
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index c48ba4f..15548ef 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -16,8 +16,6 @@
 
 #include <plat/map-s5p.h>
 
-#define EXYNOS_PA_CHIPID		0x10000000
-
 #define EXYNOS4_PA_CMU			0x10030000
 
 #define EXYNOS4_PA_DMC0			0x10400000
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 85c3be6..a45528d 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -170,7 +170,7 @@ int exynos_cluster_power_state(int cluster)
 
 static void __iomem *cpu_boot_reg_base(void)
 {
-	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
+	if (soc_is_exynos4210() && exynos_revision() == EXYNOS4210_REV_1_1)
 		return pmu_base_addr + S5P_INFORM5;
 	return sysram_base_addr;
 }
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index c43b776..cd120ac 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -32,18 +32,18 @@
 
 static inline void __iomem *exynos_boot_vector_addr(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
+	if (exynos_revision() == EXYNOS4210_REV_1_1)
 		return pmu_base_addr + S5P_INFORM7;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
+	else if (exynos_revision() == EXYNOS4210_REV_1_0)
 		return sysram_base_addr + 0x24;
 	return pmu_base_addr + S5P_INFORM0;
 }
 
 static inline void __iomem *exynos_boot_vector_flag(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
+	if (exynos_revision() == EXYNOS4210_REV_1_1)
 		return pmu_base_addr + S5P_INFORM6;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
+	else if (exynos_revision() == EXYNOS4210_REV_1_0)
 		return sysram_base_addr + 0x20;
 	return pmu_base_addr + S5P_INFORM1;
 }
diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
index 71333bb..02d95fd 100644
--- a/arch/arm/plat-samsung/cpu.c
+++ b/arch/arm/plat-samsung/cpu.c
@@ -21,12 +21,6 @@
 unsigned long samsung_cpu_id;
 static unsigned int samsung_cpu_rev;
 
-unsigned int samsung_rev(void)
-{
-	return samsung_cpu_rev;
-}
-EXPORT_SYMBOL(samsung_rev);
-
 void __init s3c64xx_init_cpu(void)
 {
 	samsung_cpu_id = __raw_readl(S3C_VA_SYS + 0x118);
@@ -43,11 +37,3 @@ void __init s3c64xx_init_cpu(void)
 
 	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
 }
-
-void __init s5p_init_cpu(void __iomem *cpuid_addr)
-{
-	samsung_cpu_id = __raw_readl(cpuid_addr);
-	samsung_cpu_rev = samsung_cpu_id & 0xFF;
-
-	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
-}
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 61d14f3..fa7d0d6 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -114,8 +114,6 @@ extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
 
 extern void s3c64xx_init_cpu(void);
 
-extern unsigned int samsung_rev(void);
-
 extern void s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 
 extern void s3c24xx_init_clocks(int xtal);
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index b63aeeb..3708ae5 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -13,7 +13,6 @@
 #ifndef __ASM_PLAT_MAP_S5P_H
 #define __ASM_PLAT_MAP_S5P_H __FILE__
 
-#define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
 #define S5P_VA_CMU		S3C_ADDR(0x02100000)
 
 #define S5P_VA_DMC0		S3C_ADDR(0x02440000)
-- 
2.4.5
