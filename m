From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 30 Mar 2017 18:47:06 +0530
Subject: [PATCH v9 12/12] ARM: EXYNOS: refactor of mach-exynos to use chipid
 information
In-Reply-To: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
References: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170330131444epcas5p45051cf7e6ec7a993c2c9f84254b89a19@epcas5p4.samsung.com>
Message-ID: <1490879826-16754-13-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since now we have chipid driver in place and all dependencies of
soc_is_exynosMMMM macros have been address, lets remove all such
macros. Also remove static mapping of chipid SFR in exynos.c and
related helper functions.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/common.h                | 97 ----------------------------
 arch/arm/mach-exynos/exynos.c                | 44 +++----------
 arch/arm/mach-exynos/platsmp.c               |  2 +-
 arch/arm/plat-samsung/cpu.c                  | 14 ----
 arch/arm/plat-samsung/include/plat/cpu.h     |  2 -
 arch/arm/plat-samsung/include/plat/map-s5p.h |  2 -
 6 files changed, 11 insertions(+), 150 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 9424a8a..9d76cf8 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -14,102 +14,6 @@
 
 #include <linux/platform_data/cpuidle-exynos.h>
 
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
-
-#define IS_SAMSUNG_CPU(name, id, mask)		\
-static inline int is_samsung_##name(void)	\
-{						\
-	return ((samsung_cpu_id & mask) == (id & mask));	\
-}
-
-IS_SAMSUNG_CPU(exynos3250, EXYNOS3250_SOC_ID, EXYNOS3_SOC_MASK)
-IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5410, EXYNOS5410_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
-
-#if defined(CONFIG_SOC_EXYNOS3250)
-# define soc_is_exynos3250()	is_samsung_exynos3250()
-#else
-# define soc_is_exynos3250()	0
-#endif
-
-#if defined(CONFIG_CPU_EXYNOS4210)
-# define soc_is_exynos4210()	is_samsung_exynos4210()
-#else
-# define soc_is_exynos4210()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS4212)
-# define soc_is_exynos4212()	is_samsung_exynos4212()
-#else
-# define soc_is_exynos4212()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS4412)
-# define soc_is_exynos4412()	is_samsung_exynos4412()
-#else
-# define soc_is_exynos4412()	0
-#endif
-
-#define EXYNOS4210_REV_0	(0x0)
-#define EXYNOS4210_REV_1_0	(0x10)
-#define EXYNOS4210_REV_1_1	(0x11)
-
-#if defined(CONFIG_SOC_EXYNOS5250)
-# define soc_is_exynos5250()	is_samsung_exynos5250()
-#else
-# define soc_is_exynos5250()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5410)
-# define soc_is_exynos5410()	is_samsung_exynos5410()
-#else
-# define soc_is_exynos5410()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5420)
-# define soc_is_exynos5420()	is_samsung_exynos5420()
-#else
-# define soc_is_exynos5420()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5440)
-# define soc_is_exynos5440()	is_samsung_exynos5440()
-#else
-# define soc_is_exynos5440()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5800)
-# define soc_is_exynos5800()	is_samsung_exynos5800()
-#else
-# define soc_is_exynos5800()	0
-#endif
-
-#define soc_is_exynos4() (soc_is_exynos4210() || soc_is_exynos4212() || \
-			  soc_is_exynos4412())
-#define soc_is_exynos5() (soc_is_exynos5250() || soc_is_exynos5410() || \
-			  soc_is_exynos5420() || soc_is_exynos5800())
-
 extern u32 cp15_save_diag;
 extern u32 cp15_save_power;
 
@@ -166,7 +70,6 @@ extern struct cpuidle_exynos_data cpuidle_coupled_exynos_data;
 
 extern void exynos_set_delayed_reset_assertion(bool enable);
 
-extern unsigned int samsung_rev(void);
 extern void exynos_core_restart(u32 core_id);
 extern int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr);
 extern int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr);
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index c404c15..6543c6c 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -24,7 +24,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/map.h>
-#include <plat/cpu.h>
 
 #include "common.h"
 
@@ -76,50 +75,27 @@ static void __init exynos_init_late(void)
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
 /*
  * exynos_map_io
  *
  * register the standard cpu IO areas
  */
-static void __init exynos_map_io(void)
+static int __init exynos_fdt_map_scu(unsigned long node, const char *uname,
+		int depth, void *data)
 {
-	if (soc_is_exynos4())
-		iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
+	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210") &&
+			!of_flat_dt_is_compatible(node, "samsung,exynos4212") &&
+			!of_flat_dt_is_compatible(node, "samsung,exynos4412"))
+		return 0;
+
+	iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
+	return 1;
 }
 
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
+	of_scan_flat_dt(exynos_fdt_map_scu, NULL);
 }
 
 /*
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index af9332c..c44acc8 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -510,7 +510,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		call_firmware_op(cpu_boot, core_id);
 
-		if (soc_is_exynos3250())
+		if (of_machine_is_compatible("samsung,exynos3250"))
 			dsb_sev();
 		else
 			arch_send_wakeup_ipi_mask(cpumask_of(cpu));
diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
index a107b3a..e58f0f6 100644
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
 	samsung_cpu_id = readl_relaxed(S3C_VA_SYS + 0x118);
@@ -43,11 +37,3 @@ void __init s3c64xx_init_cpu(void)
 
 	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
 }
-
-void __init s5p_init_cpu(const void __iomem *cpuid_addr)
-{
-	samsung_cpu_id = readl_relaxed(cpuid_addr);
-	samsung_cpu_rev = samsung_cpu_id & 0xFF;
-
-	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
-}
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index b7b702a..913c176 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -115,8 +115,6 @@ extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
 extern void s3c64xx_init_cpu(void);
 extern void s5p_init_cpu(const void __iomem *cpuid_addr);
 
-extern unsigned int samsung_rev(void);
-
 extern void s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 
 extern void s3c24xx_init_clocks(int xtal);
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index 0fe2828..8a31d4b 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_PLAT_MAP_S5P_H
 #define __ASM_PLAT_MAP_S5P_H __FILE__
 
-#define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
-
 #define S5P_VA_COREPERI_BASE	S3C_ADDR(0x02800000)
 #define S5P_VA_COREPERI(x)	(S5P_VA_COREPERI_BASE + (x))
 #define S5P_VA_SCU		S5P_VA_COREPERI(0x0)
-- 
2.7.4
