From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 05 Nov 2016 17:33:47 +0530
Subject: [PATCH v7 2/2] ARM: EXYNOS: refactoring of mach-exynos to enable
 chipid driver
In-Reply-To: <1478347427-28409-1-git-send-email-pankaj.dubey@samsung.com>
References: <1478347427-28409-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1478347427-28409-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables chipid driver for ARCH_EXYNOS and refactors
machine code for using chipid driver for identification of
SoC ID and SoC rev.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                 |  1 +
 arch/arm/mach-exynos/common.h                | 92 ----------------------------
 arch/arm/mach-exynos/exynos.c                | 31 ----------
 arch/arm/mach-exynos/firmware.c              | 10 +--
 arch/arm/mach-exynos/include/mach/map.h      | 21 -------
 arch/arm/mach-exynos/platsmp.c               | 22 ++++---
 arch/arm/mach-exynos/pm.c                    | 41 ++++++++-----
 arch/arm/plat-samsung/cpu.c                  | 14 -----
 arch/arm/plat-samsung/include/plat/cpu.h     |  2 -
 arch/arm/plat-samsung/include/plat/map-s5p.h |  2 -
 10 files changed, 47 insertions(+), 189 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/map.h

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b085855..a76c679 100644
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
index d19064b..9d76cf8 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -14,97 +14,6 @@
 
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
 extern u32 cp15_save_diag;
 extern u32 cp15_save_power;
 
@@ -161,7 +70,6 @@ extern struct cpuidle_exynos_data cpuidle_coupled_exynos_data;
 
 extern void exynos_set_delayed_reset_assertion(bool enable);
 
-extern unsigned int samsung_rev(void);
 extern void exynos_core_restart(u32 core_id);
 extern int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr);
 extern int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr);
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index fa08ef9..942131e 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -23,9 +23,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-#include <plat/cpu.h>
-
 #include "common.h"
 
 static struct platform_device exynos_cpuidle = {
@@ -67,37 +64,9 @@ static void __init exynos_init_late(void)
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
 static void __init exynos_init_io(void)
 {
 	debug_ll_io_init();
-
-	of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
-
-	/* detect cpu id and rev. */
-	s5p_init_cpu(S5P_VA_CHIPID);
 }
 
 /*
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index fd6da54..a9f8504e 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -44,7 +44,7 @@ static int exynos_do_idle(unsigned long mode)
 		writel_relaxed(virt_to_phys(exynos_cpu_resume_ns),
 			       sysram_ns_base_addr + 0x24);
 		writel_relaxed(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
-		if (soc_is_exynos3250()) {
+		if (of_machine_is_compatible("samsung,exynos3250")) {
 			flush_cache_all();
 			exynos_smc(SMC_CMD_SAVE, OP_TYPE_CORE,
 				   SMC_POWERSTATE_IDLE, 0);
@@ -65,7 +65,7 @@ static int exynos_cpu_boot(int cpu)
 	 * Exynos3250 doesn't need to send smc command for secondary CPU boot
 	 * because Exynos3250 removes WFE in secure mode.
 	 */
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		return 0;
 
 	/*
@@ -73,7 +73,7 @@ static int exynos_cpu_boot(int cpu)
 	 * But, Exynos4212 has only one secondary CPU so second parameter
 	 * isn't used for informing secure firmware about CPU id.
 	 */
-	if (soc_is_exynos4212())
+	if (of_machine_is_compatible("samsung,exynos4212"))
 		cpu = 0;
 
 	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
@@ -94,7 +94,7 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 	 * additional offset for every CPU, with Exynos4412 being the only
 	 * exception.
 	 */
-	if (soc_is_exynos4412())
+	if (of_machine_is_compatible("samsung,exynos4412"))
 		boot_reg += 4 * cpu;
 
 	writel_relaxed(boot_addr, boot_reg);
@@ -110,7 +110,7 @@ static int exynos_get_cpu_boot_addr(int cpu, unsigned long *boot_addr)
 
 	boot_reg = sysram_ns_base_addr + 0x1c;
 
-	if (soc_is_exynos4412())
+	if (of_machine_is_compatible("samsung,exynos4412"))
 		boot_reg += 4 * cpu;
 
 	*boot_addr = readl_relaxed(boot_reg);
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
deleted file mode 100644
index 0eef407..0000000
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_MAP_H
-#define __ASM_ARCH_MAP_H __FILE__
-
-#include <plat/map-base.h>
-
-#include <plat/map-s5p.h>
-
-#define EXYNOS_PA_CHIPID		0x10000000
-
-#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 553d0d9..884e885 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/sys_soc.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
@@ -27,8 +28,6 @@
 #include <asm/smp_scu.h>
 #include <asm/firmware.h>
 
-#include <mach/map.h>
-
 #include "common.h"
 
 extern void exynos4_secondary_startup(void);
@@ -93,7 +92,8 @@ void exynos_cpu_power_down(int cpu)
 {
 	u32 core_conf;
 
-	if (cpu == 0 && (soc_is_exynos5420() || soc_is_exynos5800())) {
+	if (cpu == 0 && (of_machine_is_compatible("samsung,exynos5420") ||
+			of_machine_is_compatible("samsung,exynos5800"))) {
 		/*
 		 * Bypass power down for CPU0 during suspend. Check for
 		 * the SYS_PWR_REG value to decide if we are suspending
@@ -120,7 +120,7 @@ void exynos_cpu_power_up(int cpu)
 {
 	u32 core_conf = S5P_CORE_LOCAL_PWR_EN;
 
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		core_conf |= S5P_CORE_AUTOWAKEUP_EN;
 
 	pmu_raw_writel(core_conf,
@@ -168,9 +168,14 @@ int exynos_cluster_power_state(int cluster)
 		S5P_CORE_LOCAL_PWR_EN);
 }
 
+static struct soc_device_attribute exynos4210_rev11[] = {
+	{ .soc_id = "EXYNOS4210", .revision = "11", },
+	{ },
+};
+
 static void __iomem *cpu_boot_reg_base(void)
 {
-	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
+	if (soc_device_match(exynos4210_rev11))
 		return pmu_base_addr + S5P_INFORM5;
 	return sysram_base_addr;
 }
@@ -182,9 +187,10 @@ static inline void __iomem *cpu_boot_reg(int cpu)
 	boot_reg = cpu_boot_reg_base();
 	if (!boot_reg)
 		return IOMEM_ERR_PTR(-ENODEV);
-	if (soc_is_exynos4412())
+	if (of_machine_is_compatible("samsung,exynos4412"))
 		boot_reg += 4*cpu;
-	else if (soc_is_exynos5420() || soc_is_exynos5800())
+	else if (of_machine_is_compatible("samsung,exynos5420") ||
+			of_machine_is_compatible("samsung,exynos5800"))
 		boot_reg += 4;
 	return boot_reg;
 }
@@ -356,7 +362,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		call_firmware_op(cpu_boot, core_id);
 
-		if (soc_is_exynos3250())
+		if (of_machine_is_compatible("samsung,exynos3250"))
 			dsb_sev();
 		else
 			arch_send_wakeup_ipi_mask(cpumask_of(cpu));
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 60e6827..430b3e2 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/sys_soc.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
 
@@ -29,20 +30,30 @@
 
 #include "common.h"
 
+static struct soc_device_attribute exynos4210_rev11[] = {
+	{ .soc_id = "EXYNOS4210", .revision = "11", },
+	{ },
+};
+
+static struct soc_device_attribute exynos4210_rev10[] = {
+	{ .soc_id = "EXYNOS4210", .revision = "10", },
+	{ },
+};
+
 static inline void __iomem *exynos_boot_vector_addr(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
+	if (soc_device_match(exynos4210_rev11))
 		return pmu_base_addr + S5P_INFORM7;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
+	else if (soc_device_match(exynos4210_rev10))
 		return sysram_base_addr + 0x24;
 	return pmu_base_addr + S5P_INFORM0;
 }
 
 static inline void __iomem *exynos_boot_vector_flag(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
+	if (soc_device_match(exynos4210_rev11))
 		return pmu_base_addr + S5P_INFORM6;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
+	else if (soc_device_match(exynos4210_rev10))
 		return sysram_base_addr + 0x20;
 	return pmu_base_addr + S5P_INFORM1;
 }
@@ -122,11 +133,13 @@ int exynos_pm_central_resume(void)
 }
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
-static void exynos_set_wakeupmask(long mask)
+static void exynos_set_wakeupmask(void)
 {
-	pmu_raw_writel(mask, S5P_WAKEUP_MASK);
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250")) {
+		pmu_raw_writel(0x40003ffe, S5P_WAKEUP_MASK);
 		pmu_raw_writel(0x0, S5P_WAKEUP_MASK2);
+	} else
+		pmu_raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
 }
 
 static void exynos_cpu_set_boot_vector(long flags)
@@ -140,7 +153,7 @@ static int exynos_aftr_finisher(unsigned long flags)
 {
 	int ret;
 
-	exynos_set_wakeupmask(soc_is_exynos3250() ? 0x40003ffe : 0x0000ff3e);
+	exynos_set_wakeupmask();
 	/* Set value of power down register for aftr mode */
 	exynos_sys_powerdown_conf(SYS_AFTR);
 
@@ -163,7 +176,7 @@ void exynos_enter_aftr(void)
 
 	cpu_pm_enter();
 
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		exynos_set_boot_flag(cpuid, C2_STATE);
 
 	exynos_pm_central_suspend();
@@ -192,7 +205,7 @@ void exynos_enter_aftr(void)
 
 	exynos_pm_central_resume();
 
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		exynos_clear_boot_flag(cpuid, C2_STATE);
 
 	cpu_pm_exit();
@@ -263,7 +276,7 @@ abort:
 		while (exynos_cpu_power_state(1) != S5P_CORE_LOCAL_PWR_EN)
 			cpu_relax();
 
-		if (soc_is_exynos3250()) {
+		if (of_machine_is_compatible("samsung,exynos3250")) {
 			while (!pmu_raw_readl(S5P_PMU_SPARE2) &&
 			       !atomic_read(&cpu1_wakeup))
 				cpu_relax();
@@ -285,7 +298,7 @@ abort:
 
 			call_firmware_op(cpu_boot, 1);
 
-			if (soc_is_exynos3250())
+			if (of_machine_is_compatible("samsung,exynos3250"))
 				dsb_sev();
 			else
 				arch_send_wakeup_ipi_mask(cpumask_of(1));
@@ -297,7 +310,7 @@ fail:
 
 static int exynos_wfi_finisher(unsigned long flags)
 {
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		flush_cache_all();
 	cpu_do_idle();
 
@@ -319,7 +332,7 @@ static int exynos_cpu1_powerdown(void)
 	 */
 	exynos_cpu_power_down(1);
 
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		pmu_raw_writel(0, S5P_PMU_SPARE2);
 
 	ret = cpu_suspend(0, exynos_wfi_finisher);
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
index 512ed1f..d6853f1 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_PLAT_MAP_S5P_H
 #define __ASM_PLAT_MAP_S5P_H __FILE__
 
-#define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
-
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
 #define VA_VIC1			VA_VIC(1)
-- 
2.7.4
