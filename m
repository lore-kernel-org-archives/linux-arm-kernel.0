From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 15 Nov 2018 16:11:36 +0100
Subject: [PATCH 7/9] ARM: SAMSUNG: remove samsung_rev()
In-Reply-To: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20181115151238epcas2p1dd0da525c3cd2a7a4d153ced264b5b8f@epcas2p1.samsung.com>
Message-ID: <1542294698-17470-8-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Add soc_dev_is_exynos4210_rev11() helper.

* Convert exynos_boot_vector_{addr,flag}() to use chipid driver.

* Remove no longer needed samsung_rev() & co.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/common.h            |  6 +-----
 arch/arm/mach-exynos/exynos.c            |  6 ++++++
 arch/arm/mach-exynos/pm.c                |  8 ++++----
 arch/arm/plat-samsung/cpu.c              | 10 ----------
 arch/arm/plat-samsung/include/plat/cpu.h |  2 --
 5 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 1dfd434..322d6eb 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -13,14 +13,11 @@
 #include <linux/platform_data/cpuidle-exynos.h>
 
 extern bool soc_dev_is_exynos3250(void);
+extern bool soc_dev_is_exynos4210_rev10(void);
 extern bool soc_dev_is_exynos4210_rev11(void);
 extern bool soc_dev_is_exynos4412(void);
 extern bool soc_dev_is_exynos542x(void);
 
-#define EXYNOS4210_REV_0	(0x0)
-#define EXYNOS4210_REV_1_0	(0x10)
-#define EXYNOS4210_REV_1_1	(0x11)
-
 extern u32 cp15_save_diag;
 extern u32 cp15_save_power;
 
@@ -81,7 +78,6 @@ static inline void exynos_scu_enable(void) { }
 
 extern void exynos_set_delayed_reset_assertion(bool enable);
 
-extern unsigned int samsung_rev(void);
 extern void exynos_core_restart(u32 core_id);
 extern int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr);
 extern int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr);
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 463e457..ca367b7 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -29,6 +29,11 @@
 	{ /* sentinel */ }
 };
 
+static const struct soc_device_attribute exynos4210_rev10_soc_id[] = {
+	{ .soc_id = "EXYNOS4210", .revision = "10" },
+	{ /* sentinel */ }
+};
+
 static const struct soc_device_attribute exynos4210_rev11_soc_id[] = {
 	{ .soc_id = "EXYNOS4210", .revision = "11" },
 	{ /* sentinel */ }
@@ -59,6 +64,7 @@
 }
 
 SOC_DEV_IS_EXYNOS(3250);
+SOC_DEV_IS_EXYNOS(4210_rev10);
 SOC_DEV_IS_EXYNOS(4210_rev11);
 SOC_DEV_IS_EXYNOS(4412);
 SOC_DEV_IS_EXYNOS(542x);
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 88c1bce..0109dc4 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -26,18 +26,18 @@
 
 static inline void __iomem *exynos_boot_vector_addr(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
+	if (soc_dev_is_exynos4210_rev11())
 		return pmu_base_addr + S5P_INFORM7;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
+	else if (soc_dev_is_exynos4210_rev10())
 		return sysram_base_addr + 0x24;
 	return pmu_base_addr + S5P_INFORM0;
 }
 
 static inline void __iomem *exynos_boot_vector_flag(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
+	if (soc_dev_is_exynos4210_rev11())
 		return pmu_base_addr + S5P_INFORM6;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
+	else if (soc_dev_is_exynos4210_rev10())
 		return sysram_base_addr + 0x20;
 	return pmu_base_addr + S5P_INFORM1;
 }
diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
index e1ba88b..c633a24 100644
--- a/arch/arm/plat-samsung/cpu.c
+++ b/arch/arm/plat-samsung/cpu.c
@@ -14,13 +14,6 @@
 #include <plat/cpu.h>
 
 unsigned long samsung_cpu_id;
-static unsigned int samsung_cpu_rev;
-
-unsigned int samsung_rev(void)
-{
-	return samsung_cpu_rev;
-}
-EXPORT_SYMBOL(samsung_rev);
 
 void __init s3c64xx_init_cpu(void)
 {
@@ -34,15 +27,12 @@ void __init s3c64xx_init_cpu(void)
 		samsung_cpu_id = readl_relaxed(S3C_VA_SYS + 0xA1C);
 	}
 
-	samsung_cpu_rev = 0;
-
 	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
 }
 
 void __init s5p_init_cpu(const void __iomem *cpuid_addr)
 {
 	samsung_cpu_id = readl_relaxed(cpuid_addr);
-	samsung_cpu_rev = samsung_cpu_id & 0xFF;
 
 	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
 }
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index fadcddb..02d7f99 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -111,8 +111,6 @@ extern void s3c_init_cpu(unsigned long idcode,
 extern void s3c64xx_init_cpu(void);
 extern void s5p_init_cpu(const void __iomem *cpuid_addr);
 
-extern unsigned int samsung_rev(void);
-
 extern void s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 
 extern void s3c24xx_init_clocks(int xtal);
-- 
1.9.1
