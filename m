From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 Feb 2011 17:22:57 +0900
Subject: [PATCH 01/11] ARM: EXYNOS4: Add EXYNOS4 CPU initialization support
In-Reply-To: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
References: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1297671787-10571-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds EXYNOS4 CPU support files in mach-exynos4,
and basically they are moved from mach-s5pv310 so that it
can support Samsung's new CPU name, EXYNOS4.
The EXYNOS4 ingegrates a ARM Cortex A9 multi-core.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/{mach-s5pv310 => mach-exynos4}/cpu.c      |   87 ++++++------
 arch/arm/{mach-s5pv310 => mach-exynos4}/cpufreq.c  |  100 +++++++-------
 arch/arm/{mach-s5pv310 => mach-exynos4}/dma.c      |   50 ++++---
 arch/arm/{mach-s5pv310 => mach-exynos4}/gpiolib.c  |  154 ++++++++++----------
 arch/arm/{mach-s5pv310 => mach-exynos4}/headsmp.S  |    6 +-
 arch/arm/{mach-s5pv310 => mach-exynos4}/hotplug.c  |    2 +-
 .../include/mach/debug-macro.S                     |    6 +-
 .../include/mach/dma.h                             |    0
 .../include/mach/entry-macro.S                     |    4 +-
 arch/arm/mach-exynos4/include/mach/gpio.h          |  135 +++++++++++++++++
 .../include/mach/hardware.h                        |    8 +-
 .../include/mach/io.h                              |    8 +-
 arch/arm/mach-exynos4/include/mach/map.h           |  144 ++++++++++++++++++
 .../include/mach/memory.h                          |    8 +-
 arch/arm/mach-exynos4/include/mach/regs-gpio.h     |   42 ++++++
 .../include/mach/regs-mem.h                        |    6 +-
 .../include/mach/regs-pmu.h                        |    8 +-
 .../include/mach/regs-sysmmu.h                     |    6 +-
 .../include/mach/smp.h                             |    2 +-
 .../include/mach/sysmmu.h                          |   18 +-
 .../include/mach/system.h                          |    8 +-
 .../include/mach/timex.h                           |    8 +-
 .../include/mach/uncompress.h                      |    8 +-
 .../include/mach/vmalloc.h                         |    8 +-
 arch/arm/{mach-s5pv310 => mach-exynos4}/init.c     |   10 +-
 arch/arm/{mach-s5pv310 => mach-exynos4}/platsmp.c  |   12 +-
 .../{mach-s5pv310 => mach-exynos4}/setup-i2c0.c    |    4 +-
 arch/arm/mach-s5pv310/include/mach/gpio.h          |  135 -----------------
 arch/arm/mach-s5pv310/include/mach/map.h           |  144 ------------------
 arch/arm/mach-s5pv310/include/mach/regs-gpio.h     |   42 ------
 arch/arm/plat-s5p/cpu.c                            |   25 ++--
 arch/arm/plat-s5p/include/plat/exynos4.h           |   34 +++++
 arch/arm/plat-s5p/include/plat/s5pv310.h           |   34 -----
 33 files changed, 637 insertions(+), 629 deletions(-)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/cpu.c (67%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/cpufreq.c (82%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/dma.c (74%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/gpiolib.c (58%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/headsmp.S (85%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/hotplug.c (98%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/debug-macro.S (86%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/dma.h (100%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/entry-macro.S (95%)
 create mode 100644 arch/arm/mach-exynos4/include/mach/gpio.h
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/hardware.h (67%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/io.h (76%)
 create mode 100644 arch/arm/mach-exynos4/include/mach/map.h
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/memory.h (71%)
 create mode 100644 arch/arm/mach-exynos4/include/mach/regs-gpio.h
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/regs-mem.h (74%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/regs-pmu.h (77%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/regs-sysmmu.h (79%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/smp.h (85%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/sysmmu.h (85%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/system.h (69%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/timex.h (81%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/uncompress.h (80%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/vmalloc.h (72%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/init.c (73%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/platsmp.c (92%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/setup-i2c0.c (87%)
 delete mode 100644 arch/arm/mach-s5pv310/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-s5pv310/include/mach/map.h
 delete mode 100644 arch/arm/mach-s5pv310/include/mach/regs-gpio.h
 create mode 100644 arch/arm/plat-s5p/include/plat/exynos4.h
 delete mode 100644 arch/arm/plat-s5p/include/plat/s5pv310.h

diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-exynos4/cpu.c
similarity index 67%
rename from arch/arm/mach-s5pv310/cpu.c
rename to arch/arm/mach-exynos4/cpu.c
index 0db0fb6..b0ec6d3 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -1,7 +1,7 @@
-/* linux/arch/arm/mach-s5pv310/cpu.c
+/* linux/arch/arm/mach-exynos4/cpu.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -19,7 +19,7 @@
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
-#include <plat/s5pv310.h>
+#include <plat/exynos4.h>
 #include <plat/sdhci.h>
 
 #include <mach/regs-irq.h>
@@ -29,55 +29,55 @@ extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
 extern void combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq);
 
 /* Initial IO mappings */
-static struct map_desc s5pv310_iodesc[] __initdata = {
+static struct map_desc exynos4_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S5P_VA_SYSRAM,
-		.pfn		= __phys_to_pfn(S5PV310_PA_SYSRAM),
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_CMU,
-		.pfn		= __phys_to_pfn(S5PV310_PA_CMU),
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_CMU),
 		.length		= SZ_128K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_PMU,
-		.pfn		= __phys_to_pfn(S5PV310_PA_PMU),
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_PMU),
 		.length		= SZ_64K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
-		.pfn		= __phys_to_pfn(S5PV310_PA_COMBINER),
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_COMBINER),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_COREPERI_BASE,
-		.pfn		= __phys_to_pfn(S5PV310_PA_COREPERI),
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_COREPERI),
 		.length		= SZ_8K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_L2CC,
-		.pfn		= __phys_to_pfn(S5PV310_PA_L2CC),
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_L2CC),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_GPIO1,
-		.pfn		= __phys_to_pfn(S5PV310_PA_GPIO1),
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO1),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_GPIO2,
-		.pfn		= __phys_to_pfn(S5PV310_PA_GPIO2),
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO2),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_GPIO3,
-		.pfn		= __phys_to_pfn(S5PV310_PA_GPIO3),
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO3),
 		.length		= SZ_256,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_DMC0,
-		.pfn		= __phys_to_pfn(S5PV310_PA_DMC0),
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_DMC0),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
@@ -87,13 +87,13 @@ static struct map_desc s5pv310_iodesc[] __initdata = {
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5P_VA_SROMC,
-		.pfn		= __phys_to_pfn(S5PV310_PA_SROMC),
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_SROMC),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	},
 };
 
-static void s5pv310_idle(void)
+static void exynos4_idle(void)
 {
 	if (!need_resched())
 		cpu_do_idle();
@@ -101,32 +101,33 @@ static void s5pv310_idle(void)
 	local_irq_enable();
 }
 
-/* s5pv310_map_io
+/*
+ * exynos4_map_io
  *
  * register the standard cpu IO areas
-*/
-void __init s5pv310_map_io(void)
+ */
+void __init exynos4_map_io(void)
 {
-	iotable_init(s5pv310_iodesc, ARRAY_SIZE(s5pv310_iodesc));
+	iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
 
 	/* initialize device information early */
-	s5pv310_default_sdhci0();
-	s5pv310_default_sdhci1();
-	s5pv310_default_sdhci2();
-	s5pv310_default_sdhci3();
+	exynos4_default_sdhci0();
+	exynos4_default_sdhci1();
+	exynos4_default_sdhci2();
+	exynos4_default_sdhci3();
 }
 
-void __init s5pv310_init_clocks(int xtal)
+void __init exynos4_init_clocks(int xtal)
 {
 	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
 
 	s3c24xx_register_baseclocks(xtal);
 	s5p_register_clocks(xtal);
-	s5pv310_register_clocks();
-	s5pv310_setup_clocks();
+	exynos4_register_clocks();
+	exynos4_setup_clocks();
 }
 
-void __init s5pv310_init_irq(void)
+void __init exynos4_init_irq(void)
 {
 	int irq;
 
@@ -148,29 +149,29 @@ void __init s5pv310_init_irq(void)
 	}
 
 	/* The parameters of s5p_init_irq() are for VIC init.
-	 * Theses parameters should be NULL and 0 because S5PV310
+	 * Theses parameters should be NULL and 0 because EXYNOS4
 	 * uses GIC instead of VIC.
 	 */
 	s5p_init_irq(NULL, 0);
 }
 
-struct sysdev_class s5pv310_sysclass = {
-	.name	= "s5pv310-core",
+struct sysdev_class exynos4_sysclass = {
+	.name	= "exynos4-core",
 };
 
-static struct sys_device s5pv310_sysdev = {
-	.cls	= &s5pv310_sysclass,
+static struct sys_device exynos4_sysdev = {
+	.cls	= &exynos4_sysclass,
 };
 
-static int __init s5pv310_core_init(void)
+static int __init exynos4_core_init(void)
 {
-	return sysdev_class_register(&s5pv310_sysclass);
+	return sysdev_class_register(&exynos4_sysclass);
 }
 
-core_initcall(s5pv310_core_init);
+core_initcall(exynos4_core_init);
 
 #ifdef CONFIG_CACHE_L2X0
-static int __init s5pv310_l2x0_cache_init(void)
+static int __init exynos4_l2x0_cache_init(void)
 {
 	/* TAG, Data Latency Control: 2cycle */
 	__raw_writel(0x110, S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
@@ -188,15 +189,15 @@ static int __init s5pv310_l2x0_cache_init(void)
 	return 0;
 }
 
-early_initcall(s5pv310_l2x0_cache_init);
+early_initcall(exynos4_l2x0_cache_init);
 #endif
 
-int __init s5pv310_init(void)
+int __init exynos4_init(void)
 {
-	printk(KERN_INFO "S5PV310: Initializing architecture\n");
+	printk(KERN_INFO "EXYNOS4: Initializing architecture\n");
 
 	/* set idle function */
-	pm_idle = s5pv310_idle;
+	pm_idle = exynos4_idle;
 
-	return sysdev_register(&s5pv310_sysdev);
+	return sysdev_register(&exynos4_sysdev);
 }
diff --git a/arch/arm/mach-s5pv310/cpufreq.c b/arch/arm/mach-exynos4/cpufreq.c
similarity index 82%
rename from arch/arm/mach-s5pv310/cpufreq.c
rename to arch/arm/mach-exynos4/cpufreq.c
index b04cbc7..174f080 100644
--- a/arch/arm/mach-s5pv310/cpufreq.c
+++ b/arch/arm/mach-exynos4/cpufreq.c
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/cpufreq.c
+/* linux/arch/arm/mach-exynos4/cpufreq.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * S5PV310 - CPU frequency scaling support
+ * EXYNOS4 - CPU frequency scaling support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -39,7 +39,7 @@ static struct regulator *int_regulator;
 static struct cpufreq_freqs freqs;
 static unsigned int memtype;
 
-enum s5pv310_memory_type {
+enum exynos4_memory_type {
 	DDR2 = 4,
 	LPDDR2,
 	DDR3,
@@ -49,7 +49,7 @@ enum cpufreq_level_index {
 	L0, L1, L2, L3, CPUFREQ_LEVEL_END,
 };
 
-static struct cpufreq_frequency_table s5pv310_freq_table[] = {
+static struct cpufreq_frequency_table exynos4_freq_table[] = {
 	{L0, 1000*1000},
 	{L1, 800*1000},
 	{L2, 400*1000},
@@ -160,7 +160,7 @@ struct cpufreq_voltage_table {
 	unsigned int	int_volt;
 };
 
-static struct cpufreq_voltage_table s5pv310_volt_table[CPUFREQ_LEVEL_END] = {
+static struct cpufreq_voltage_table exynos4_volt_table[CPUFREQ_LEVEL_END] = {
 	{
 		.index		= L0,
 		.arm_volt	= 1200000,
@@ -180,7 +180,7 @@ static struct cpufreq_voltage_table s5pv310_volt_table[CPUFREQ_LEVEL_END] = {
 	},
 };
 
-static unsigned int s5pv310_apll_pms_table[CPUFREQ_LEVEL_END] = {
+static unsigned int exynos4_apll_pms_table[CPUFREQ_LEVEL_END] = {
 	/* APLL FOUT L0: 1000MHz */
 	((250 << 16) | (6 << 8) | 1),
 
@@ -194,17 +194,17 @@ static unsigned int s5pv310_apll_pms_table[CPUFREQ_LEVEL_END] = {
 	((200 << 16) | (6 << 8) | 4),
 };
 
-int s5pv310_verify_speed(struct cpufreq_policy *policy)
+int exynos4_verify_speed(struct cpufreq_policy *policy)
 {
-	return cpufreq_frequency_table_verify(policy, s5pv310_freq_table);
+	return cpufreq_frequency_table_verify(policy, exynos4_freq_table);
 }
 
-unsigned int s5pv310_getspeed(unsigned int cpu)
+unsigned int exynos4_getspeed(unsigned int cpu)
 {
 	return clk_get_rate(cpu_clk) / 1000;
 }
 
-void s5pv310_set_clkdiv(unsigned int div_index)
+void exynos4_set_clkdiv(unsigned int div_index)
 {
 	unsigned int tmp;
 
@@ -321,7 +321,7 @@ void s5pv310_set_clkdiv(unsigned int div_index)
 	} while (tmp & 0x11);
 }
 
-static void s5pv310_set_apll(unsigned int index)
+static void exynos4_set_apll(unsigned int index)
 {
 	unsigned int tmp;
 
@@ -340,7 +340,7 @@ static void s5pv310_set_apll(unsigned int index)
 	/* 3. Change PLL PMS values */
 	tmp = __raw_readl(S5P_APLL_CON0);
 	tmp &= ~((0x3ff << 16) | (0x3f << 8) | (0x7 << 0));
-	tmp |= s5pv310_apll_pms_table[index];
+	tmp |= exynos4_apll_pms_table[index];
 	__raw_writel(tmp, S5P_APLL_CON0);
 
 	/* 4. wait_lock_time */
@@ -357,77 +357,77 @@ static void s5pv310_set_apll(unsigned int index)
 	} while (tmp != (0x1 << S5P_CLKSRC_CPU_MUXCORE_SHIFT));
 }
 
-static void s5pv310_set_frequency(unsigned int old_index, unsigned int new_index)
+static void exynos4_set_frequency(unsigned int old_index, unsigned int new_index)
 {
 	unsigned int tmp;
 
 	if (old_index > new_index) {
 		/* The frequency changing to L0 needs to change apll */
-		if (freqs.new == s5pv310_freq_table[L0].frequency) {
+		if (freqs.new == exynos4_freq_table[L0].frequency) {
 			/* 1. Change the system clock divider values */
-			s5pv310_set_clkdiv(new_index);
+			exynos4_set_clkdiv(new_index);
 
 			/* 2. Change the apll m,p,s value */
-			s5pv310_set_apll(new_index);
+			exynos4_set_apll(new_index);
 		} else {
 			/* 1. Change the system clock divider values */
-			s5pv310_set_clkdiv(new_index);
+			exynos4_set_clkdiv(new_index);
 
 			/* 2. Change just s value in apll m,p,s value */
 			tmp = __raw_readl(S5P_APLL_CON0);
 			tmp &= ~(0x7 << 0);
-			tmp |= (s5pv310_apll_pms_table[new_index] & 0x7);
+			tmp |= (exynos4_apll_pms_table[new_index] & 0x7);
 			__raw_writel(tmp, S5P_APLL_CON0);
 		}
 	}
 
 	else if (old_index < new_index) {
 		/* The frequency changing from L0 needs to change apll */
-		if (freqs.old == s5pv310_freq_table[L0].frequency) {
+		if (freqs.old == exynos4_freq_table[L0].frequency) {
 			/* 1. Change the apll m,p,s value */
-			s5pv310_set_apll(new_index);
+			exynos4_set_apll(new_index);
 
 			/* 2. Change the system clock divider values */
-			s5pv310_set_clkdiv(new_index);
+			exynos4_set_clkdiv(new_index);
 		} else {
 			/* 1. Change just s value in apll m,p,s value */
 			tmp = __raw_readl(S5P_APLL_CON0);
 			tmp &= ~(0x7 << 0);
-			tmp |= (s5pv310_apll_pms_table[new_index] & 0x7);
+			tmp |= (exynos4_apll_pms_table[new_index] & 0x7);
 			__raw_writel(tmp, S5P_APLL_CON0);
 
 			/* 2. Change the system clock divider values */
-			s5pv310_set_clkdiv(new_index);
+			exynos4_set_clkdiv(new_index);
 		}
 	}
 }
 
-static int s5pv310_target(struct cpufreq_policy *policy,
+static int exynos4_target(struct cpufreq_policy *policy,
 			  unsigned int target_freq,
 			  unsigned int relation)
 {
 	unsigned int index, old_index;
 	unsigned int arm_volt, int_volt;
 
-	freqs.old = s5pv310_getspeed(policy->cpu);
+	freqs.old = exynos4_getspeed(policy->cpu);
 
-	if (cpufreq_frequency_table_target(policy, s5pv310_freq_table,
+	if (cpufreq_frequency_table_target(policy, exynos4_freq_table,
 					   freqs.old, relation, &old_index))
 		return -EINVAL;
 
-	if (cpufreq_frequency_table_target(policy, s5pv310_freq_table,
+	if (cpufreq_frequency_table_target(policy, exynos4_freq_table,
 					   target_freq, relation, &index))
 		return -EINVAL;
 
-	freqs.new = s5pv310_freq_table[index].frequency;
+	freqs.new = exynos4_freq_table[index].frequency;
 	freqs.cpu = policy->cpu;
 
 	if (freqs.new == freqs.old)
 		return 0;
 
 	/* get the voltage value */
-	arm_volt = s5pv310_volt_table[index].arm_volt;
-	int_volt = s5pv310_volt_table[index].int_volt;
+	arm_volt = exynos4_volt_table[index].arm_volt;
+	int_volt = exynos4_volt_table[index].int_volt;
 
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
@@ -441,7 +441,7 @@ static int s5pv310_target(struct cpufreq_policy *policy,
 	}
 
 	/* Clock Configuration Procedure */
-	s5pv310_set_frequency(old_index, index);
+	exynos4_set_frequency(old_index, index);
 
 	/* control regulator */
 	if (freqs.new < freqs.old) {
@@ -458,52 +458,52 @@ static int s5pv310_target(struct cpufreq_policy *policy,
 }
 
 #ifdef CONFIG_PM
-static int s5pv310_cpufreq_suspend(struct cpufreq_policy *policy,
+static int exynos4_cpufreq_suspend(struct cpufreq_policy *policy,
 				   pm_message_t pmsg)
 {
 	return 0;
 }
 
-static int s5pv310_cpufreq_resume(struct cpufreq_policy *policy)
+static int exynos4_cpufreq_resume(struct cpufreq_policy *policy)
 {
 	return 0;
 }
 #endif
 
-static int s5pv310_cpufreq_cpu_init(struct cpufreq_policy *policy)
+static int exynos4_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	policy->cur = policy->min = policy->max = s5pv310_getspeed(policy->cpu);
+	policy->cur = policy->min = policy->max = exynos4_getspeed(policy->cpu);
 
-	cpufreq_frequency_table_get_attr(s5pv310_freq_table, policy->cpu);
+	cpufreq_frequency_table_get_attr(exynos4_freq_table, policy->cpu);
 
 	/* set the transition latency value */
 	policy->cpuinfo.transition_latency = 100000;
 
 	/*
-	 * S5PV310 multi-core processors has 2 cores
+	 * EXYNOS4 multi-core processors has 2 cores
 	 * that the frequency cannot be set independently.
 	 * Each cpu is bound to the same speed.
 	 * So the affected cpu is all of the cpus.
 	 */
 	cpumask_setall(policy->cpus);
 
-	return cpufreq_frequency_table_cpuinfo(policy, s5pv310_freq_table);
+	return cpufreq_frequency_table_cpuinfo(policy, exynos4_freq_table);
 }
 
-static struct cpufreq_driver s5pv310_driver = {
+static struct cpufreq_driver exynos4_driver = {
 	.flags		= CPUFREQ_STICKY,
-	.verify		= s5pv310_verify_speed,
-	.target		= s5pv310_target,
-	.get		= s5pv310_getspeed,
-	.init		= s5pv310_cpufreq_cpu_init,
-	.name		= "s5pv310_cpufreq",
+	.verify		= exynos4_verify_speed,
+	.target		= exynos4_target,
+	.get		= exynos4_getspeed,
+	.init		= exynos4_cpufreq_cpu_init,
+	.name		= "exynos4_cpufreq",
 #ifdef CONFIG_PM
-	.suspend	= s5pv310_cpufreq_suspend,
-	.resume		= s5pv310_cpufreq_resume,
+	.suspend	= exynos4_cpufreq_suspend,
+	.resume		= exynos4_cpufreq_resume,
 #endif
 };
 
-static int __init s5pv310_cpufreq_init(void)
+static int __init exynos4_cpufreq_init(void)
 {
 	cpu_clk = clk_get(NULL, "armclk");
 	if (IS_ERR(cpu_clk))
@@ -550,7 +550,7 @@ static int __init s5pv310_cpufreq_init(void)
 		printk(KERN_DEBUG "%s: memtype= 0x%x\n", __func__, memtype);
 	}
 
-	return cpufreq_register_driver(&s5pv310_driver);
+	return cpufreq_register_driver(&exynos4_driver);
 
 out:
 	if (!IS_ERR(cpu_clk))
@@ -577,4 +577,4 @@ out:
 
 	return -EINVAL;
 }
-late_initcall(s5pv310_cpufreq_init);
+late_initcall(exynos4_cpufreq_init);
diff --git a/arch/arm/mach-s5pv310/dma.c b/arch/arm/mach-exynos4/dma.c
similarity index 74%
rename from arch/arm/mach-s5pv310/dma.c
rename to arch/arm/mach-exynos4/dma.c
index 20066c7..564bb53 100644
--- a/arch/arm/mach-s5pv310/dma.c
+++ b/arch/arm/mach-exynos4/dma.c
@@ -1,4 +1,8 @@
-/*
+/* linux/arch/arm/mach-exynos4/dma.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
  * Copyright (C) 2010 Samsung Electronics Co. Ltd.
  *	Jaswinder Singh <jassi.brar@samsung.com>
  *
@@ -30,10 +34,10 @@
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-static struct resource s5pv310_pdma0_resource[] = {
+static struct resource exynos4_pdma0_resource[] = {
 	[0] = {
-		.start	= S5PV310_PA_PDMA0,
-		.end	= S5PV310_PA_PDMA0 + SZ_4K,
+		.start	= EXYNOS4_PA_PDMA0,
+		.end	= EXYNOS4_PA_PDMA0 + SZ_4K,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -43,7 +47,7 @@ static struct resource s5pv310_pdma0_resource[] = {
 	},
 };
 
-static struct s3c_pl330_platdata s5pv310_pdma0_pdata = {
+static struct s3c_pl330_platdata exynos4_pdma0_pdata = {
 	.peri = {
 		[0] = DMACH_PCM0_RX,
 		[1] = DMACH_PCM0_TX,
@@ -80,22 +84,22 @@ static struct s3c_pl330_platdata s5pv310_pdma0_pdata = {
 	},
 };
 
-static struct platform_device s5pv310_device_pdma0 = {
+static struct platform_device exynos4_device_pdma0 = {
 	.name		= "s3c-pl330",
 	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s5pv310_pdma0_resource),
-	.resource	= s5pv310_pdma0_resource,
+	.num_resources	= ARRAY_SIZE(exynos4_pdma0_resource),
+	.resource	= exynos4_pdma0_resource,
 	.dev		= {
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &s5pv310_pdma0_pdata,
+		.platform_data = &exynos4_pdma0_pdata,
 	},
 };
 
-static struct resource s5pv310_pdma1_resource[] = {
+static struct resource exynos4_pdma1_resource[] = {
 	[0] = {
-		.start	= S5PV310_PA_PDMA1,
-		.end	= S5PV310_PA_PDMA1 + SZ_4K,
+		.start	= EXYNOS4_PA_PDMA1,
+		.end	= EXYNOS4_PA_PDMA1 + SZ_4K,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -105,7 +109,7 @@ static struct resource s5pv310_pdma1_resource[] = {
 	},
 };
 
-static struct s3c_pl330_platdata s5pv310_pdma1_pdata = {
+static struct s3c_pl330_platdata exynos4_pdma1_pdata = {
 	.peri = {
 		[0] = DMACH_PCM0_RX,
 		[1] = DMACH_PCM0_TX,
@@ -142,27 +146,27 @@ static struct s3c_pl330_platdata s5pv310_pdma1_pdata = {
 	},
 };
 
-static struct platform_device s5pv310_device_pdma1 = {
+static struct platform_device exynos4_device_pdma1 = {
 	.name		= "s3c-pl330",
 	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s5pv310_pdma1_resource),
-	.resource	= s5pv310_pdma1_resource,
+	.num_resources	= ARRAY_SIZE(exynos4_pdma1_resource),
+	.resource	= exynos4_pdma1_resource,
 	.dev		= {
 		.dma_mask = &dma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &s5pv310_pdma1_pdata,
+		.platform_data = &exynos4_pdma1_pdata,
 	},
 };
 
-static struct platform_device *s5pv310_dmacs[] __initdata = {
-	&s5pv310_device_pdma0,
-	&s5pv310_device_pdma1,
+static struct platform_device *exynos4_dmacs[] __initdata = {
+	&exynos4_device_pdma0,
+	&exynos4_device_pdma1,
 };
 
-static int __init s5pv310_dma_init(void)
+static int __init exynos4_dma_init(void)
 {
-	platform_add_devices(s5pv310_dmacs, ARRAY_SIZE(s5pv310_dmacs));
+	platform_add_devices(exynos4_dmacs, ARRAY_SIZE(exynos4_dmacs));
 
 	return 0;
 }
-arch_initcall(s5pv310_dma_init);
+arch_initcall(exynos4_dma_init);
diff --git a/arch/arm/mach-s5pv310/gpiolib.c b/arch/arm/mach-exynos4/gpiolib.c
similarity index 58%
rename from arch/arm/mach-s5pv310/gpiolib.c
rename to arch/arm/mach-exynos4/gpiolib.c
index 55217b8..c46fdc5 100644
--- a/arch/arm/mach-s5pv310/gpiolib.c
+++ b/arch/arm/mach-exynos4/gpiolib.c
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/gpiolib.c
+/* linux/arch/arm/mach-exynos4/gpiolib.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * S5PV310 - GPIOlib support
+ * EXYNOS4 - GPIOlib support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -43,159 +43,159 @@ static struct s3c_gpio_cfg gpio_cfg_noint = {
  * Note: The initialization of 'base' member of s3c_gpio_chip structure
  * uses the above macro and depends on the banks being listed in order here.
  */
-static struct s3c_gpio_chip s5pv310_gpio_part1_4bit[] = {
+static struct s3c_gpio_chip exynos4_gpio_part1_4bit[] = {
 	{
 		.chip	= {
-			.base	= S5PV310_GPA0(0),
-			.ngpio	= S5PV310_GPIO_A0_NR,
+			.base	= EXYNOS4_GPA0(0),
+			.ngpio	= EXYNOS4_GPIO_A0_NR,
 			.label	= "GPA0",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPA1(0),
-			.ngpio	= S5PV310_GPIO_A1_NR,
+			.base	= EXYNOS4_GPA1(0),
+			.ngpio	= EXYNOS4_GPIO_A1_NR,
 			.label	= "GPA1",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPB(0),
-			.ngpio	= S5PV310_GPIO_B_NR,
+			.base	= EXYNOS4_GPB(0),
+			.ngpio	= EXYNOS4_GPIO_B_NR,
 			.label	= "GPB",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPC0(0),
-			.ngpio	= S5PV310_GPIO_C0_NR,
+			.base	= EXYNOS4_GPC0(0),
+			.ngpio	= EXYNOS4_GPIO_C0_NR,
 			.label	= "GPC0",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPC1(0),
-			.ngpio	= S5PV310_GPIO_C1_NR,
+			.base	= EXYNOS4_GPC1(0),
+			.ngpio	= EXYNOS4_GPIO_C1_NR,
 			.label	= "GPC1",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPD0(0),
-			.ngpio	= S5PV310_GPIO_D0_NR,
+			.base	= EXYNOS4_GPD0(0),
+			.ngpio	= EXYNOS4_GPIO_D0_NR,
 			.label	= "GPD0",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPD1(0),
-			.ngpio	= S5PV310_GPIO_D1_NR,
+			.base	= EXYNOS4_GPD1(0),
+			.ngpio	= EXYNOS4_GPIO_D1_NR,
 			.label	= "GPD1",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPE0(0),
-			.ngpio	= S5PV310_GPIO_E0_NR,
+			.base	= EXYNOS4_GPE0(0),
+			.ngpio	= EXYNOS4_GPIO_E0_NR,
 			.label	= "GPE0",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPE1(0),
-			.ngpio	= S5PV310_GPIO_E1_NR,
+			.base	= EXYNOS4_GPE1(0),
+			.ngpio	= EXYNOS4_GPIO_E1_NR,
 			.label	= "GPE1",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPE2(0),
-			.ngpio	= S5PV310_GPIO_E2_NR,
+			.base	= EXYNOS4_GPE2(0),
+			.ngpio	= EXYNOS4_GPIO_E2_NR,
 			.label	= "GPE2",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPE3(0),
-			.ngpio	= S5PV310_GPIO_E3_NR,
+			.base	= EXYNOS4_GPE3(0),
+			.ngpio	= EXYNOS4_GPIO_E3_NR,
 			.label	= "GPE3",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPE4(0),
-			.ngpio	= S5PV310_GPIO_E4_NR,
+			.base	= EXYNOS4_GPE4(0),
+			.ngpio	= EXYNOS4_GPIO_E4_NR,
 			.label	= "GPE4",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPF0(0),
-			.ngpio	= S5PV310_GPIO_F0_NR,
+			.base	= EXYNOS4_GPF0(0),
+			.ngpio	= EXYNOS4_GPIO_F0_NR,
 			.label	= "GPF0",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPF1(0),
-			.ngpio	= S5PV310_GPIO_F1_NR,
+			.base	= EXYNOS4_GPF1(0),
+			.ngpio	= EXYNOS4_GPIO_F1_NR,
 			.label	= "GPF1",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPF2(0),
-			.ngpio	= S5PV310_GPIO_F2_NR,
+			.base	= EXYNOS4_GPF2(0),
+			.ngpio	= EXYNOS4_GPIO_F2_NR,
 			.label	= "GPF2",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPF3(0),
-			.ngpio	= S5PV310_GPIO_F3_NR,
+			.base	= EXYNOS4_GPF3(0),
+			.ngpio	= EXYNOS4_GPIO_F3_NR,
 			.label	= "GPF3",
 		},
 	},
 };
 
-static struct s3c_gpio_chip s5pv310_gpio_part2_4bit[] = {
+static struct s3c_gpio_chip exynos4_gpio_part2_4bit[] = {
 	{
 		.chip	= {
-			.base	= S5PV310_GPJ0(0),
-			.ngpio	= S5PV310_GPIO_J0_NR,
+			.base	= EXYNOS4_GPJ0(0),
+			.ngpio	= EXYNOS4_GPIO_J0_NR,
 			.label	= "GPJ0",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPJ1(0),
-			.ngpio	= S5PV310_GPIO_J1_NR,
+			.base	= EXYNOS4_GPJ1(0),
+			.ngpio	= EXYNOS4_GPIO_J1_NR,
 			.label	= "GPJ1",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPK0(0),
-			.ngpio	= S5PV310_GPIO_K0_NR,
+			.base	= EXYNOS4_GPK0(0),
+			.ngpio	= EXYNOS4_GPIO_K0_NR,
 			.label	= "GPK0",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPK1(0),
-			.ngpio	= S5PV310_GPIO_K1_NR,
+			.base	= EXYNOS4_GPK1(0),
+			.ngpio	= EXYNOS4_GPIO_K1_NR,
 			.label	= "GPK1",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPK2(0),
-			.ngpio	= S5PV310_GPIO_K2_NR,
+			.base	= EXYNOS4_GPK2(0),
+			.ngpio	= EXYNOS4_GPIO_K2_NR,
 			.label	= "GPK2",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPK3(0),
-			.ngpio	= S5PV310_GPIO_K3_NR,
+			.base	= EXYNOS4_GPK3(0),
+			.ngpio	= EXYNOS4_GPIO_K3_NR,
 			.label	= "GPK3",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPL0(0),
-			.ngpio	= S5PV310_GPIO_L0_NR,
+			.base	= EXYNOS4_GPL0(0),
+			.ngpio	= EXYNOS4_GPIO_L0_NR,
 			.label	= "GPL0",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPL1(0),
-			.ngpio	= S5PV310_GPIO_L1_NR,
+			.base	= EXYNOS4_GPL1(0),
+			.ngpio	= EXYNOS4_GPIO_L1_NR,
 			.label	= "GPL1",
 		},
 	}, {
 		.chip	= {
-			.base	= S5PV310_GPL2(0),
-			.ngpio	= S5PV310_GPIO_L2_NR,
+			.base	= EXYNOS4_GPL2(0),
+			.ngpio	= EXYNOS4_GPIO_L2_NR,
 			.label	= "GPL2",
 		},
 	}, {
@@ -203,8 +203,8 @@ static struct s3c_gpio_chip s5pv310_gpio_part2_4bit[] = {
 		.config	= &gpio_cfg_noint,
 		.irq_base = IRQ_EINT(0),
 		.chip	= {
-			.base	= S5PV310_GPX0(0),
-			.ngpio	= S5PV310_GPIO_X0_NR,
+			.base	= EXYNOS4_GPX0(0),
+			.ngpio	= EXYNOS4_GPIO_X0_NR,
 			.label	= "GPX0",
 			.to_irq	= samsung_gpiolib_to_irq,
 		},
@@ -213,8 +213,8 @@ static struct s3c_gpio_chip s5pv310_gpio_part2_4bit[] = {
 		.config	= &gpio_cfg_noint,
 		.irq_base = IRQ_EINT(8),
 		.chip	= {
-			.base	= S5PV310_GPX1(0),
-			.ngpio	= S5PV310_GPIO_X1_NR,
+			.base	= EXYNOS4_GPX1(0),
+			.ngpio	= EXYNOS4_GPIO_X1_NR,
 			.label	= "GPX1",
 			.to_irq	= samsung_gpiolib_to_irq,
 		},
@@ -223,8 +223,8 @@ static struct s3c_gpio_chip s5pv310_gpio_part2_4bit[] = {
 		.config	= &gpio_cfg_noint,
 		.irq_base = IRQ_EINT(16),
 		.chip	= {
-			.base	= S5PV310_GPX2(0),
-			.ngpio	= S5PV310_GPIO_X2_NR,
+			.base	= EXYNOS4_GPX2(0),
+			.ngpio	= EXYNOS4_GPIO_X2_NR,
 			.label	= "GPX2",
 			.to_irq	= samsung_gpiolib_to_irq,
 		},
@@ -233,25 +233,25 @@ static struct s3c_gpio_chip s5pv310_gpio_part2_4bit[] = {
 		.config	= &gpio_cfg_noint,
 		.irq_base = IRQ_EINT(24),
 		.chip	= {
-			.base	= S5PV310_GPX3(0),
-			.ngpio	= S5PV310_GPIO_X3_NR,
+			.base	= EXYNOS4_GPX3(0),
+			.ngpio	= EXYNOS4_GPIO_X3_NR,
 			.label	= "GPX3",
 			.to_irq	= samsung_gpiolib_to_irq,
 		},
 	},
 };
 
-static struct s3c_gpio_chip s5pv310_gpio_part3_4bit[] = {
+static struct s3c_gpio_chip exynos4_gpio_part3_4bit[] = {
 	{
 		.chip	= {
-			.base	= S5PV310_GPZ(0),
-			.ngpio	= S5PV310_GPIO_Z_NR,
+			.base	= EXYNOS4_GPZ(0),
+			.ngpio	= EXYNOS4_GPIO_Z_NR,
 			.label	= "GPZ",
 		},
 	},
 };
 
-static __init int s5pv310_gpiolib_init(void)
+static __init int exynos4_gpiolib_init(void)
 {
 	struct s3c_gpio_chip *chip;
 	int i;
@@ -259,8 +259,8 @@ static __init int s5pv310_gpiolib_init(void)
 
 	/* GPIO part 1 */
 
-	chip = s5pv310_gpio_part1_4bit;
-	nr_chips = ARRAY_SIZE(s5pv310_gpio_part1_4bit);
+	chip = exynos4_gpio_part1_4bit;
+	nr_chips = ARRAY_SIZE(exynos4_gpio_part1_4bit);
 
 	for (i = 0; i < nr_chips; i++, chip++) {
 		if (chip->config == NULL)
@@ -269,12 +269,12 @@ static __init int s5pv310_gpiolib_init(void)
 			chip->base = S5P_VA_GPIO1 + (i) * 0x20;
 	}
 
-	samsung_gpiolib_add_4bit_chips(s5pv310_gpio_part1_4bit, nr_chips);
+	samsung_gpiolib_add_4bit_chips(exynos4_gpio_part1_4bit, nr_chips);
 
 	/* GPIO part 2 */
 
-	chip = s5pv310_gpio_part2_4bit;
-	nr_chips = ARRAY_SIZE(s5pv310_gpio_part2_4bit);
+	chip = exynos4_gpio_part2_4bit;
+	nr_chips = ARRAY_SIZE(exynos4_gpio_part2_4bit);
 
 	for (i = 0; i < nr_chips; i++, chip++) {
 		if (chip->config == NULL)
@@ -283,12 +283,12 @@ static __init int s5pv310_gpiolib_init(void)
 			chip->base = S5P_VA_GPIO2 + (i) * 0x20;
 	}
 
-	samsung_gpiolib_add_4bit_chips(s5pv310_gpio_part2_4bit, nr_chips);
+	samsung_gpiolib_add_4bit_chips(exynos4_gpio_part2_4bit, nr_chips);
 
 	/* GPIO part 3 */
 
-	chip = s5pv310_gpio_part3_4bit;
-	nr_chips = ARRAY_SIZE(s5pv310_gpio_part3_4bit);
+	chip = exynos4_gpio_part3_4bit;
+	nr_chips = ARRAY_SIZE(exynos4_gpio_part3_4bit);
 
 	for (i = 0; i < nr_chips; i++, chip++) {
 		if (chip->config == NULL)
@@ -297,8 +297,8 @@ static __init int s5pv310_gpiolib_init(void)
 			chip->base = S5P_VA_GPIO3 + (i) * 0x20;
 	}
 
-	samsung_gpiolib_add_4bit_chips(s5pv310_gpio_part3_4bit, nr_chips);
+	samsung_gpiolib_add_4bit_chips(exynos4_gpio_part3_4bit, nr_chips);
 
 	return 0;
 }
-core_initcall(s5pv310_gpiolib_init);
+core_initcall(exynos4_gpiolib_init);
diff --git a/arch/arm/mach-s5pv310/headsmp.S b/arch/arm/mach-exynos4/headsmp.S
similarity index 85%
rename from arch/arm/mach-s5pv310/headsmp.S
rename to arch/arm/mach-exynos4/headsmp.S
index 164b7b0..6c6cfc5 100644
--- a/arch/arm/mach-s5pv310/headsmp.S
+++ b/arch/arm/mach-exynos4/headsmp.S
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/mach-s5pv310/headsmp.S
+ *  linux/arch/arm/mach-exynos4/headsmp.S
  *
  *  Cloned from linux/arch/arm/mach-realview/headsmp.S
  *
@@ -16,11 +16,11 @@
 	__INIT
 
 /*
- * s5pv310 specific entry point for secondary CPUs.  This provides
+ * exynos4 specific entry point for secondary CPUs.  This provides
  * a "holding pen" into which all secondary cores are held until we're
  * ready for them to initialise.
  */
-ENTRY(s5pv310_secondary_startup)
+ENTRY(exynos4_secondary_startup)
 	mrc	p15, 0, r0, c0, c0, 5
 	and	r0, r0, #15
 	adr	r4, 1f
diff --git a/arch/arm/mach-s5pv310/hotplug.c b/arch/arm/mach-exynos4/hotplug.c
similarity index 98%
rename from arch/arm/mach-s5pv310/hotplug.c
rename to arch/arm/mach-exynos4/hotplug.c
index c24235c..4c42f9c 100644
--- a/arch/arm/mach-s5pv310/hotplug.c
+++ b/arch/arm/mach-exynos4/hotplug.c
@@ -1,4 +1,4 @@
-/* linux arch/arm/mach-s5pv310/hotplug.c
+/* linux arch/arm/mach-exynos4/hotplug.c
  *
  *  Cloned from linux/arch/arm/mach-realview/hotplug.c
  *
diff --git a/arch/arm/mach-s5pv310/include/mach/debug-macro.S b/arch/arm/mach-exynos4/include/mach/debug-macro.S
similarity index 86%
rename from arch/arm/mach-s5pv310/include/mach/debug-macro.S
rename to arch/arm/mach-exynos4/include/mach/debug-macro.S
index b0d920c..58bbd04 100644
--- a/arch/arm/mach-s5pv310/include/mach/debug-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/debug-macro.S
@@ -1,7 +1,7 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/debug-macro.S
+/* linux/arch/arm/mach-exynos4/include/mach/debug-macro.S
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Based on arch/arm/mach-s3c6400/include/mach/debug-macro.S
  *
diff --git a/arch/arm/mach-s5pv310/include/mach/dma.h b/arch/arm/mach-exynos4/include/mach/dma.h
similarity index 100%
rename from arch/arm/mach-s5pv310/include/mach/dma.h
rename to arch/arm/mach-exynos4/include/mach/dma.h
diff --git a/arch/arm/mach-s5pv310/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
similarity index 95%
rename from arch/arm/mach-s5pv310/include/mach/entry-macro.S
rename to arch/arm/mach-exynos4/include/mach/entry-macro.S
index e600e1d..d8f38c2 100644
--- a/arch/arm/mach-s5pv310/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -1,8 +1,8 @@
-/* arch/arm/mach-s5pv310/include/mach/entry-macro.S
+/* arch/arm/mach-exynos4/include/mach/entry-macro.S
  *
  * Cloned from arch/arm/mach-realview/include/mach/entry-macro.S
  *
- * Low-level IRQ helper macros for S5PV310 platforms
+ * Low-level IRQ helper macros for EXYNOS4 platforms
  *
  * This file is licensed under  the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
diff --git a/arch/arm/mach-exynos4/include/mach/gpio.h b/arch/arm/mach-exynos4/include/mach/gpio.h
new file mode 100644
index 0000000..1608299
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/gpio.h
@@ -0,0 +1,135 @@
+/* linux/arch/arm/mach-exynos4/include/mach/gpio.h
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * EXYNOS4 - GPIO lib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_GPIO_H
+#define __ASM_ARCH_GPIO_H __FILE__
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
+
+/* Practically, GPIO banks upto GPZ are the configurable gpio banks */
+
+/* GPIO bank sizes */
+#define EXYNOS4_GPIO_A0_NR	(8)
+#define EXYNOS4_GPIO_A1_NR	(6)
+#define EXYNOS4_GPIO_B_NR	(8)
+#define EXYNOS4_GPIO_C0_NR	(5)
+#define EXYNOS4_GPIO_C1_NR	(5)
+#define EXYNOS4_GPIO_D0_NR	(4)
+#define EXYNOS4_GPIO_D1_NR	(4)
+#define EXYNOS4_GPIO_E0_NR	(5)
+#define EXYNOS4_GPIO_E1_NR	(8)
+#define EXYNOS4_GPIO_E2_NR	(6)
+#define EXYNOS4_GPIO_E3_NR	(8)
+#define EXYNOS4_GPIO_E4_NR	(8)
+#define EXYNOS4_GPIO_F0_NR	(8)
+#define EXYNOS4_GPIO_F1_NR	(8)
+#define EXYNOS4_GPIO_F2_NR	(8)
+#define EXYNOS4_GPIO_F3_NR	(6)
+#define EXYNOS4_GPIO_J0_NR	(8)
+#define EXYNOS4_GPIO_J1_NR	(5)
+#define EXYNOS4_GPIO_K0_NR	(7)
+#define EXYNOS4_GPIO_K1_NR	(7)
+#define EXYNOS4_GPIO_K2_NR	(7)
+#define EXYNOS4_GPIO_K3_NR	(7)
+#define EXYNOS4_GPIO_L0_NR	(8)
+#define EXYNOS4_GPIO_L1_NR	(3)
+#define EXYNOS4_GPIO_L2_NR	(8)
+#define EXYNOS4_GPIO_X0_NR	(8)
+#define EXYNOS4_GPIO_X1_NR	(8)
+#define EXYNOS4_GPIO_X2_NR	(8)
+#define EXYNOS4_GPIO_X3_NR	(8)
+#define EXYNOS4_GPIO_Z_NR	(7)
+
+/* GPIO bank numbers */
+
+#define EXYNOS4_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
+
+enum s5p_gpio_number {
+	EXYNOS4_GPIO_A0_START	= 0,
+	EXYNOS4_GPIO_A1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_A0),
+	EXYNOS4_GPIO_B_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_A1),
+	EXYNOS4_GPIO_C0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_B),
+	EXYNOS4_GPIO_C1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_C0),
+	EXYNOS4_GPIO_D0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_C1),
+	EXYNOS4_GPIO_D1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_D0),
+	EXYNOS4_GPIO_E0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_D1),
+	EXYNOS4_GPIO_E1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_E0),
+	EXYNOS4_GPIO_E2_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_E1),
+	EXYNOS4_GPIO_E3_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_E2),
+	EXYNOS4_GPIO_E4_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_E3),
+	EXYNOS4_GPIO_F0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_E4),
+	EXYNOS4_GPIO_F1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_F0),
+	EXYNOS4_GPIO_F2_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_F1),
+	EXYNOS4_GPIO_F3_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_F2),
+	EXYNOS4_GPIO_J0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_F3),
+	EXYNOS4_GPIO_J1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_J0),
+	EXYNOS4_GPIO_K0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_J1),
+	EXYNOS4_GPIO_K1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_K0),
+	EXYNOS4_GPIO_K2_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_K1),
+	EXYNOS4_GPIO_K3_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_K2),
+	EXYNOS4_GPIO_L0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_K3),
+	EXYNOS4_GPIO_L1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_L0),
+	EXYNOS4_GPIO_L2_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_L1),
+	EXYNOS4_GPIO_X0_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_L2),
+	EXYNOS4_GPIO_X1_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_X0),
+	EXYNOS4_GPIO_X2_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_X1),
+	EXYNOS4_GPIO_X3_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_X2),
+	EXYNOS4_GPIO_Z_START	= EXYNOS4_GPIO_NEXT(EXYNOS4_GPIO_X3),
+};
+
+/* EXYNOS4 GPIO number definitions */
+#define EXYNOS4_GPA0(_nr)	(EXYNOS4_GPIO_A0_START + (_nr))
+#define EXYNOS4_GPA1(_nr)	(EXYNOS4_GPIO_A1_START + (_nr))
+#define EXYNOS4_GPB(_nr)	(EXYNOS4_GPIO_B_START + (_nr))
+#define EXYNOS4_GPC0(_nr)	(EXYNOS4_GPIO_C0_START + (_nr))
+#define EXYNOS4_GPC1(_nr)	(EXYNOS4_GPIO_C1_START + (_nr))
+#define EXYNOS4_GPD0(_nr)	(EXYNOS4_GPIO_D0_START + (_nr))
+#define EXYNOS4_GPD1(_nr)	(EXYNOS4_GPIO_D1_START + (_nr))
+#define EXYNOS4_GPE0(_nr)	(EXYNOS4_GPIO_E0_START + (_nr))
+#define EXYNOS4_GPE1(_nr)	(EXYNOS4_GPIO_E1_START + (_nr))
+#define EXYNOS4_GPE2(_nr)	(EXYNOS4_GPIO_E2_START + (_nr))
+#define EXYNOS4_GPE3(_nr)	(EXYNOS4_GPIO_E3_START + (_nr))
+#define EXYNOS4_GPE4(_nr)	(EXYNOS4_GPIO_E4_START + (_nr))
+#define EXYNOS4_GPF0(_nr)	(EXYNOS4_GPIO_F0_START + (_nr))
+#define EXYNOS4_GPF1(_nr)	(EXYNOS4_GPIO_F1_START + (_nr))
+#define EXYNOS4_GPF2(_nr)	(EXYNOS4_GPIO_F2_START + (_nr))
+#define EXYNOS4_GPF3(_nr)	(EXYNOS4_GPIO_F3_START + (_nr))
+#define EXYNOS4_GPJ0(_nr)	(EXYNOS4_GPIO_J0_START + (_nr))
+#define EXYNOS4_GPJ1(_nr)	(EXYNOS4_GPIO_J1_START + (_nr))
+#define EXYNOS4_GPK0(_nr)	(EXYNOS4_GPIO_K0_START + (_nr))
+#define EXYNOS4_GPK1(_nr)	(EXYNOS4_GPIO_K1_START + (_nr))
+#define EXYNOS4_GPK2(_nr)	(EXYNOS4_GPIO_K2_START + (_nr))
+#define EXYNOS4_GPK3(_nr)	(EXYNOS4_GPIO_K3_START + (_nr))
+#define EXYNOS4_GPL0(_nr)	(EXYNOS4_GPIO_L0_START + (_nr))
+#define EXYNOS4_GPL1(_nr)	(EXYNOS4_GPIO_L1_START + (_nr))
+#define EXYNOS4_GPL2(_nr)	(EXYNOS4_GPIO_L2_START + (_nr))
+#define EXYNOS4_GPX0(_nr)	(EXYNOS4_GPIO_X0_START + (_nr))
+#define EXYNOS4_GPX1(_nr)	(EXYNOS4_GPIO_X1_START + (_nr))
+#define EXYNOS4_GPX2(_nr)	(EXYNOS4_GPIO_X2_START + (_nr))
+#define EXYNOS4_GPX3(_nr)	(EXYNOS4_GPIO_X3_START + (_nr))
+#define EXYNOS4_GPZ(_nr)	(EXYNOS4_GPIO_Z_START + (_nr))
+
+/* the end of the EXYNOS4 specific gpios */
+#define EXYNOS4_GPIO_END	(EXYNOS4_GPZ(EXYNOS4_GPIO_Z_NR) + 1)
+#define S3C_GPIO_END		EXYNOS4_GPIO_END
+
+/* define the number of gpios we need to the one after the GPZ() range */
+#define ARCH_NR_GPIOS		(EXYNOS4_GPZ(EXYNOS4_GPIO_Z_NR) +	\
+				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
+
+#include <asm-generic/gpio.h>
+
+#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/hardware.h b/arch/arm/mach-exynos4/include/mach/hardware.h
similarity index 67%
rename from arch/arm/mach-s5pv310/include/mach/hardware.h
rename to arch/arm/mach-exynos4/include/mach/hardware.h
index 28ff988..5109eb2 100644
--- a/arch/arm/mach-s5pv310/include/mach/hardware.h
+++ b/arch/arm/mach-exynos4/include/mach/hardware.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/hardware.h
+/* linux/arch/arm/mach-exynos4/include/mach/hardware.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5PV310 - Hardware support
+ * EXYNOS4 - Hardware support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5pv310/include/mach/io.h b/arch/arm/mach-exynos4/include/mach/io.h
similarity index 76%
rename from arch/arm/mach-s5pv310/include/mach/io.h
rename to arch/arm/mach-exynos4/include/mach/io.h
index 8a7f912..d5478d2 100644
--- a/arch/arm/mach-s5pv310/include/mach/io.h
+++ b/arch/arm/mach-exynos4/include/mach/io.h
@@ -1,13 +1,13 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/io.h
+/* linux/arch/arm/mach-exynos4/include/mach/io.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Copyright 2008-2010 Ben Dooks <ben-linux@fluff.org>
  *
  * Based on arch/arm/mach-s5p6442/include/mach/io.h
  *
- * Default IO routines for S5PV310
+ * Default IO routines for EXYNOS4
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
new file mode 100644
index 0000000..80a41e0
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -0,0 +1,144 @@
+/* linux/arch/arm/mach-exynos4/include/mach/map.h
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS4 - Memory map definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_MAP_H
+#define __ASM_ARCH_MAP_H __FILE__
+
+#include <plat/map-base.h>
+
+/*
+ * EXYNOS4 UART offset is 0x10000 but the older S5P SoCs are 0x400.
+ * So need to define it, and here is to avoid redefinition warning.
+ */
+#define S3C_UART_OFFSET			(0x10000)
+
+#include <plat/map-s5p.h>
+
+#define EXYNOS4_PA_SYSRAM		0x02020000
+
+#define EXYNOS4_PA_I2S0			0x03830000
+#define EXYNOS4_PA_I2S1			0xE3100000
+#define EXYNOS4_PA_I2S2			0xE2A00000
+
+#define EXYNOS4_PA_PCM0			0x03840000
+#define EXYNOS4_PA_PCM1			0x13980000
+#define EXYNOS4_PA_PCM2			0x13990000
+
+#define EXYNOS4_PA_SROM_BANK(x)		(0x04000000 + ((x) * 0x01000000))
+
+#define EXYNOS4_PA_ONENAND		0x0C000000
+#define EXYNOS4_PA_ONENAND_DMA		0x0C600000
+
+#define EXYNOS4_PA_CHIPID		0x10000000
+
+#define EXYNOS4_PA_SYSCON		0x10010000
+#define EXYNOS4_PA_PMU			0x10020000
+#define EXYNOS4_PA_CMU			0x10030000
+
+#define EXYNOS4_PA_WATCHDOG		0x10060000
+#define EXYNOS4_PA_RTC			0x10070000
+
+#define EXYNOS4_PA_DMC0			0x10400000
+
+#define EXYNOS4_PA_COMBINER		0x10448000
+
+#define EXYNOS4_PA_COREPERI		0x10500000
+#define EXYNOS4_PA_GIC_CPU		0x10500100
+#define EXYNOS4_PA_TWD			0x10500600
+#define EXYNOS4_PA_GIC_DIST		0x10501000
+#define EXYNOS4_PA_L2CC			0x10502000
+
+#define EXYNOS4_PA_MDMA			0x10810000
+#define EXYNOS4_PA_PDMA0		0x12680000
+#define EXYNOS4_PA_PDMA1		0x12690000
+
+#define EXYNOS4_PA_SYSMMU_MDMA		0x10A40000
+#define EXYNOS4_PA_SYSMMU_SSS		0x10A50000
+#define EXYNOS4_PA_SYSMMU_FIMC0		0x11A20000
+#define EXYNOS4_PA_SYSMMU_FIMC1		0x11A30000
+#define EXYNOS4_PA_SYSMMU_FIMC2		0x11A40000
+#define EXYNOS4_PA_SYSMMU_FIMC3		0x11A50000
+#define EXYNOS4_PA_SYSMMU_JPEG		0x11A60000
+#define EXYNOS4_PA_SYSMMU_FIMD0		0x11E20000
+#define EXYNOS4_PA_SYSMMU_FIMD1		0x12220000
+#define EXYNOS4_PA_SYSMMU_PCIe		0x12620000
+#define EXYNOS4_PA_SYSMMU_G2D		0x12A20000
+#define EXYNOS4_PA_SYSMMU_ROTATOR	0x12A30000
+#define EXYNOS4_PA_SYSMMU_MDMA2		0x12A40000
+#define EXYNOS4_PA_SYSMMU_TV		0x12E20000
+#define EXYNOS4_PA_SYSMMU_MFC_L		0x13620000
+#define EXYNOS4_PA_SYSMMU_MFC_R		0x13630000
+
+#define EXYNOS4_PA_GPIO1		0x11400000
+#define EXYNOS4_PA_GPIO2		0x11000000
+#define EXYNOS4_PA_GPIO3		0x03860000
+
+#define EXYNOS4_PA_MIPI_CSIS0		0x11880000
+#define EXYNOS4_PA_MIPI_CSIS1		0x11890000
+
+#define EXYNOS4_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
+
+#define EXYNOS4_PA_SROMC		0x12570000
+
+#define EXYNOS4_PA_UART			0x13800000
+
+#define EXYNOS4_PA_IIC(x)		(0x13860000 + ((x) * 0x10000))
+
+#define EXYNOS4_PA_AC97			0x139A0000
+
+#define EXYNOS4_PA_TIMER		0x139D0000
+
+#define EXYNOS4_PA_SDRAM		0x40000000
+
+#define EXYNOS4_PA_SPDIF		0xE1100000
+
+/* Compatibiltiy Defines */
+
+#define S3C_PA_HSMMC0			EXYNOS4_PA_HSMMC(0)
+#define S3C_PA_HSMMC1			EXYNOS4_PA_HSMMC(1)
+#define S3C_PA_HSMMC2			EXYNOS4_PA_HSMMC(2)
+#define S3C_PA_HSMMC3			EXYNOS4_PA_HSMMC(3)
+#define S3C_PA_IIC			EXYNOS4_PA_IIC(0)
+#define S3C_PA_IIC1			EXYNOS4_PA_IIC(1)
+#define S3C_PA_IIC2			EXYNOS4_PA_IIC(2)
+#define S3C_PA_IIC3			EXYNOS4_PA_IIC(3)
+#define S3C_PA_IIC4			EXYNOS4_PA_IIC(4)
+#define S3C_PA_IIC5			EXYNOS4_PA_IIC(5)
+#define S3C_PA_IIC6			EXYNOS4_PA_IIC(6)
+#define S3C_PA_IIC7			EXYNOS4_PA_IIC(7)
+#define S3C_PA_RTC			EXYNOS4_PA_RTC
+#define S3C_PA_WDT			EXYNOS4_PA_WATCHDOG
+
+#define S5P_PA_CHIPID			EXYNOS4_PA_CHIPID
+#define S5P_PA_MIPI_CSIS0		EXYNOS4_PA_MIPI_CSIS0
+#define S5P_PA_MIPI_CSIS1		EXYNOS4_PA_MIPI_CSIS1
+#define S5P_PA_ONENAND			EXYNOS4_PA_ONENAND
+#define S5P_PA_ONENAND_DMA		EXYNOS4_PA_ONENAND_DMA
+#define S5P_PA_SDRAM			EXYNOS4_PA_SDRAM
+#define S5P_PA_SROMC			EXYNOS4_PA_SROMC
+#define S5P_PA_SYSCON			EXYNOS4_PA_SYSCON
+#define S5P_PA_TIMER			EXYNOS4_PA_TIMER
+
+/* UART */
+
+#define S3C_PA_UART			EXYNOS4_PA_UART
+
+#define S5P_PA_UART(x)			(S3C_PA_UART + ((x) * S3C_UART_OFFSET))
+#define S5P_PA_UART0			S5P_PA_UART(0)
+#define S5P_PA_UART1			S5P_PA_UART(1)
+#define S5P_PA_UART2			S5P_PA_UART(2)
+#define S5P_PA_UART3			S5P_PA_UART(3)
+#define S5P_PA_UART4			S5P_PA_UART(4)
+
+#define S5P_SZ_UART			SZ_256
+
+#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/memory.h b/arch/arm/mach-exynos4/include/mach/memory.h
similarity index 71%
rename from arch/arm/mach-s5pv310/include/mach/memory.h
rename to arch/arm/mach-exynos4/include/mach/memory.h
index 1dffb48..39b47d0 100644
--- a/arch/arm/mach-s5pv310/include/mach/memory.h
+++ b/arch/arm/mach-exynos4/include/mach/memory.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/memory.h
+/* linux/arch/arm/mach-exynos4/include/mach/memory.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5PV310 - Memory definitions
+ * EXYNOS4 - Memory definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-exynos4/include/mach/regs-gpio.h b/arch/arm/mach-exynos4/include/mach/regs-gpio.h
new file mode 100644
index 0000000..1401b21
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/regs-gpio.h
@@ -0,0 +1,42 @@
+/* linux/arch/arm/mach-exynos4/include/mach/regs-gpio.h
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * EXYNOS4 - GPIO (including EINT) register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_GPIO_H
+#define __ASM_ARCH_REGS_GPIO_H __FILE__
+
+#include <mach/map.h>
+#include <mach/irqs.h>
+
+#define EXYNOS4_EINT40CON		(S5P_VA_GPIO2 + 0xE00)
+#define S5P_EINT_CON(x)			(EXYNOS4_EINT40CON + ((x) * 0x4))
+
+#define EXYNOS4_EINT40FLTCON0		(S5P_VA_GPIO2 + 0xE80)
+#define S5P_EINT_FLTCON(x)		(EXYNOS4_EINT40FLTCON0 + ((x) * 0x4))
+
+#define EXYNOS4_EINT40MASK		(S5P_VA_GPIO2 + 0xF00)
+#define S5P_EINT_MASK(x)		(EXYNOS4_EINT40MASK + ((x) * 0x4))
+
+#define EXYNOS4_EINT40PEND		(S5P_VA_GPIO2 + 0xF40)
+#define S5P_EINT_PEND(x)		(EXYNOS4_EINT40PEND + ((x) * 0x4))
+
+#define EINT_REG_NR(x)			(EINT_OFFSET(x) >> 3)
+
+#define eint_irq_to_bit(irq)		(1 << (EINT_OFFSET(irq) & 0x7))
+
+#define EINT_MODE			S3C_GPIO_SFN(0xf)
+
+#define EINT_GPIO_0(x)			EXYNOS4_GPX0(x)
+#define EINT_GPIO_1(x)			EXYNOS4_GPX1(x)
+#define EINT_GPIO_2(x)			EXYNOS4_GPX2(x)
+#define EINT_GPIO_3(x)			EXYNOS4_GPX3(x)
+
+#endif /* __ASM_ARCH_REGS_GPIO_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-mem.h b/arch/arm/mach-exynos4/include/mach/regs-mem.h
similarity index 74%
rename from arch/arm/mach-s5pv310/include/mach/regs-mem.h
rename to arch/arm/mach-exynos4/include/mach/regs-mem.h
index 8342271..0368b5a 100644
--- a/arch/arm/mach-s5pv310/include/mach/regs-mem.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-mem.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/regs-mem.h
+/* linux/arch/arm/mach-exynos4/include/mach/regs-mem.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * S5PV310 - SROMC and DMC register definitions
+ * EXYNOS4 - SROMC and DMC register definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-pmu.h b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
similarity index 77%
rename from arch/arm/mach-s5pv310/include/mach/regs-pmu.h
rename to arch/arm/mach-exynos4/include/mach/regs-pmu.h
index fb333d0..2ddd617 100644
--- a/arch/arm/mach-s5pv310/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/regs-pmu.h
+/* linux/arch/arm/mach-exynos4/include/mach/regs-pmu.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * S5PV310 - Power management unit definition
+ * EXYNOS4 - Power management unit definition
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -18,7 +18,7 @@
 #define S5P_PMUREG(x)			(S5P_VA_PMU + (x))
 
 #define S5P_PMU_CAM_CONF		S5P_PMUREG(0x3C00)
-#define S5P_PMU_TV_CONF		S5P_PMUREG(0x3C20)
+#define S5P_PMU_TV_CONF			S5P_PMUREG(0x3C20)
 #define S5P_PMU_MFC_CONF		S5P_PMUREG(0x3C40)
 #define S5P_PMU_G3D_CONF		S5P_PMUREG(0x3C60)
 #define S5P_PMU_LCD0_CONF		S5P_PMUREG(0x3C80)
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-sysmmu.h b/arch/arm/mach-exynos4/include/mach/regs-sysmmu.h
similarity index 79%
rename from arch/arm/mach-s5pv310/include/mach/regs-sysmmu.h
rename to arch/arm/mach-exynos4/include/mach/regs-sysmmu.h
index 0b28e81..b6aef86 100644
--- a/arch/arm/mach-s5pv310/include/mach/regs-sysmmu.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-sysmmu.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/regs-sysmmu.h
+/* linux/arch/arm/mach-exynos4/include/mach/regs-sysmmu.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * S5PV310 - System MMU register
+ * EXYNOS4 - System MMU register
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5pv310/include/mach/smp.h b/arch/arm/mach-exynos4/include/mach/smp.h
similarity index 85%
rename from arch/arm/mach-s5pv310/include/mach/smp.h
rename to arch/arm/mach-exynos4/include/mach/smp.h
index 393ccbd..a463dce 100644
--- a/arch/arm/mach-s5pv310/include/mach/smp.h
+++ b/arch/arm/mach-exynos4/include/mach/smp.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/smp.h
+/* linux/arch/arm/mach-exynos4/include/mach/smp.h
  *
  * Cloned from arch/arm/mach-realview/include/mach/smp.h
 */
diff --git a/arch/arm/mach-s5pv310/include/mach/sysmmu.h b/arch/arm/mach-exynos4/include/mach/sysmmu.h
similarity index 85%
rename from arch/arm/mach-s5pv310/include/mach/sysmmu.h
rename to arch/arm/mach-exynos4/include/mach/sysmmu.h
index 598fc5c..1428ada 100644
--- a/arch/arm/mach-s5pv310/include/mach/sysmmu.h
+++ b/arch/arm/mach-exynos4/include/mach/sysmmu.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/sysmmu.h
+/* linux/arch/arm/mach-exynos4/include/mach/sysmmu.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * Samsung sysmmu driver for S5PV310
+ * Samsung sysmmu driver for EXYNOS4
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -13,10 +13,10 @@
 #ifndef __ASM_ARM_ARCH_SYSMMU_H
 #define __ASM_ARM_ARCH_SYSMMU_H __FILE__
 
-#define S5PV310_SYSMMU_TOTAL_IPNUM	16
-#define S5P_SYSMMU_TOTAL_IPNUM		S5PV310_SYSMMU_TOTAL_IPNUM
+#define EXYNOS4_SYSMMU_TOTAL_IPNUM	16
+#define S5P_SYSMMU_TOTAL_IPNUM		EXYNOS4_SYSMMU_TOTAL_IPNUM
 
-enum s5pv310_sysmmu_ips {
+enum exynos4_sysmmu_ips {
 	SYSMMU_MDMA,
 	SYSMMU_SSS,
 	SYSMMU_FIMC0,
@@ -35,7 +35,7 @@ enum s5pv310_sysmmu_ips {
 	SYSMMU_MFC_R,
 };
 
-static char *sysmmu_ips_name[S5PV310_SYSMMU_TOTAL_IPNUM] = {
+static char *sysmmu_ips_name[EXYNOS4_SYSMMU_TOTAL_IPNUM] = {
 	"SYSMMU_MDMA"	,
 	"SYSMMU_SSS"	,
 	"SYSMMU_FIMC0"	,
@@ -54,7 +54,7 @@ static char *sysmmu_ips_name[S5PV310_SYSMMU_TOTAL_IPNUM] = {
 	"SYSMMU_MFC_R"	,
 };
 
-typedef enum s5pv310_sysmmu_ips sysmmu_ips;
+typedef enum exynos4_sysmmu_ips sysmmu_ips;
 
 struct sysmmu_tt_info {
 	unsigned long *pgd;
diff --git a/arch/arm/mach-s5pv310/include/mach/system.h b/arch/arm/mach-exynos4/include/mach/system.h
similarity index 69%
rename from arch/arm/mach-s5pv310/include/mach/system.h
rename to arch/arm/mach-exynos4/include/mach/system.h
index d10c009..5e3220c 100644
--- a/arch/arm/mach-s5pv310/include/mach/system.h
+++ b/arch/arm/mach-exynos4/include/mach/system.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/system.h
+/* linux/arch/arm/mach-exynos4/include/mach/system.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5PV310 - system support header
+ * EXYNOS4 - system support header
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5pv310/include/mach/timex.h b/arch/arm/mach-exynos4/include/mach/timex.h
similarity index 81%
rename from arch/arm/mach-s5pv310/include/mach/timex.h
rename to arch/arm/mach-exynos4/include/mach/timex.h
index bd2359b..6d13875 100644
--- a/arch/arm/mach-s5pv310/include/mach/timex.h
+++ b/arch/arm/mach-exynos4/include/mach/timex.h
@@ -1,14 +1,14 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/timex.h
+/* linux/arch/arm/mach-exynos4/include/mach/timex.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Copyright (c) 2003-2010 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * Based on arch/arm/mach-s5p6442/include/mach/timex.h
  *
- * S5PV310 - time parameters
+ * EXYNOS4 - time parameters
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5pv310/include/mach/uncompress.h b/arch/arm/mach-exynos4/include/mach/uncompress.h
similarity index 80%
rename from arch/arm/mach-s5pv310/include/mach/uncompress.h
rename to arch/arm/mach-exynos4/include/mach/uncompress.h
index 59593c1..21d97bc 100644
--- a/arch/arm/mach-s5pv310/include/mach/uncompress.h
+++ b/arch/arm/mach-exynos4/include/mach/uncompress.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/uncompress.h
+/* linux/arch/arm/mach-exynos4/include/mach/uncompress.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5PV310 - uncompress code
+ * EXYNOS4 - uncompress code
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5pv310/include/mach/vmalloc.h b/arch/arm/mach-exynos4/include/mach/vmalloc.h
similarity index 72%
rename from arch/arm/mach-s5pv310/include/mach/vmalloc.h
rename to arch/arm/mach-exynos4/include/mach/vmalloc.h
index 65759fb..284330e 100644
--- a/arch/arm/mach-s5pv310/include/mach/vmalloc.h
+++ b/arch/arm/mach-exynos4/include/mach/vmalloc.h
@@ -1,7 +1,7 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/vmalloc.h
+/* linux/arch/arm/mach-exynos4/include/mach/vmalloc.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
  *
@@ -11,7 +11,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * S5PV310 vmalloc definition
+ * EXYNOS4 vmalloc definition
 */
 
 #ifndef __ASM_ARCH_VMALLOC_H
diff --git a/arch/arm/mach-s5pv310/init.c b/arch/arm/mach-exynos4/init.c
similarity index 73%
rename from arch/arm/mach-s5pv310/init.c
rename to arch/arm/mach-exynos4/init.c
index 182dcf4..cf91f50 100644
--- a/arch/arm/mach-s5pv310/init.c
+++ b/arch/arm/mach-exynos4/init.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s5pv310/init.c
+/* linux/arch/arm/mach-exynos4/init.c
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
@@ -14,7 +14,7 @@
 #include <plat/devs.h>
 #include <plat/regs-serial.h>
 
-static struct s3c24xx_uart_clksrc s5pv310_serial_clocks[] = {
+static struct s3c24xx_uart_clksrc exynos4_serial_clocks[] = {
 	[0] = {
 		.name		= "uclk1",
 		.divisor	= 1,
@@ -24,7 +24,7 @@ static struct s3c24xx_uart_clksrc s5pv310_serial_clocks[] = {
 };
 
 /* uart registration process */
-void __init s5pv310_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+void __init exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
 	struct s3c2410_uartcfg *tcfg = cfg;
 	u32 ucnt;
@@ -32,8 +32,8 @@ void __init s5pv310_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
 		if (!tcfg->clocks) {
 			tcfg->has_fracval = 1;
-			tcfg->clocks = s5pv310_serial_clocks;
-			tcfg->clocks_size = ARRAY_SIZE(s5pv310_serial_clocks);
+			tcfg->clocks = exynos4_serial_clocks;
+			tcfg->clocks_size = ARRAY_SIZE(exynos4_serial_clocks);
 		}
 	}
 
diff --git a/arch/arm/mach-s5pv310/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
similarity index 92%
rename from arch/arm/mach-s5pv310/platsmp.c
rename to arch/arm/mach-exynos4/platsmp.c
index 34093b0..6d35878 100644
--- a/arch/arm/mach-s5pv310/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -1,7 +1,7 @@
-/* linux/arch/arm/mach-s5pv310/platsmp.c
+/* linux/arch/arm/mach-exynos4/platsmp.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Cloned from linux/arch/arm/mach-vexpress/platsmp.c
  *
@@ -28,7 +28,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
 
-extern void s5pv310_secondary_startup(void);
+extern void exynos4_secondary_startup(void);
 
 /*
  * control for which core is the next to come out of the secondary
@@ -139,7 +139,7 @@ void __init smp_init_cpus(void)
 	/* sanity check */
 	if (ncores > NR_CPUS) {
 		printk(KERN_WARNING
-		       "S5PV310: no. of cores (%d) greater than configured "
+		       "EXYNOS4: no. of cores (%d) greater than configured "
 		       "maximum of %d - clipping\n",
 		       ncores, NR_CPUS);
 		ncores = NR_CPUS;
@@ -168,5 +168,5 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	__raw_writel(BSYM(virt_to_phys(s5pv310_secondary_startup)), S5P_VA_SYSRAM);
+	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), S5P_VA_SYSRAM);
 }
diff --git a/arch/arm/mach-s5pv310/setup-i2c0.c b/arch/arm/mach-exynos4/setup-i2c0.c
similarity index 87%
rename from arch/arm/mach-s5pv310/setup-i2c0.c
rename to arch/arm/mach-exynos4/setup-i2c0.c
index f47f8f3..d395bd1 100644
--- a/arch/arm/mach-s5pv310/setup-i2c0.c
+++ b/arch/arm/mach-exynos4/setup-i2c0.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-s5pv310/setup-i2c0.c
+ * linux/arch/arm/mach-exynos4/setup-i2c0.c
  *
  * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
@@ -21,6 +21,6 @@ struct platform_device; /* don't need the contents */
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(S5PV310_GPD1(0), 2,
+	s3c_gpio_cfgall_range(EXYNOS4_GPD1(0), 2,
 			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv310/include/mach/gpio.h b/arch/arm/mach-s5pv310/include/mach/gpio.h
deleted file mode 100644
index 20cb80c..0000000
--- a/arch/arm/mach-s5pv310/include/mach/gpio.h
+++ /dev/null
@@ -1,135 +0,0 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/gpio.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5PV310 - GPIO lib support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H __FILE__
-
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
-#define gpio_to_irq	__gpio_to_irq
-
-/* Practically, GPIO banks upto GPZ are the configurable gpio banks */
-
-/* GPIO bank sizes */
-#define S5PV310_GPIO_A0_NR	(8)
-#define S5PV310_GPIO_A1_NR	(6)
-#define S5PV310_GPIO_B_NR	(8)
-#define S5PV310_GPIO_C0_NR	(5)
-#define S5PV310_GPIO_C1_NR	(5)
-#define S5PV310_GPIO_D0_NR	(4)
-#define S5PV310_GPIO_D1_NR	(4)
-#define S5PV310_GPIO_E0_NR	(5)
-#define S5PV310_GPIO_E1_NR	(8)
-#define S5PV310_GPIO_E2_NR	(6)
-#define S5PV310_GPIO_E3_NR	(8)
-#define S5PV310_GPIO_E4_NR	(8)
-#define S5PV310_GPIO_F0_NR	(8)
-#define S5PV310_GPIO_F1_NR	(8)
-#define S5PV310_GPIO_F2_NR	(8)
-#define S5PV310_GPIO_F3_NR	(6)
-#define S5PV310_GPIO_J0_NR	(8)
-#define S5PV310_GPIO_J1_NR	(5)
-#define S5PV310_GPIO_K0_NR	(7)
-#define S5PV310_GPIO_K1_NR	(7)
-#define S5PV310_GPIO_K2_NR	(7)
-#define S5PV310_GPIO_K3_NR	(7)
-#define S5PV310_GPIO_L0_NR	(8)
-#define S5PV310_GPIO_L1_NR	(3)
-#define S5PV310_GPIO_L2_NR	(8)
-#define S5PV310_GPIO_X0_NR	(8)
-#define S5PV310_GPIO_X1_NR	(8)
-#define S5PV310_GPIO_X2_NR	(8)
-#define S5PV310_GPIO_X3_NR	(8)
-#define S5PV310_GPIO_Z_NR	(7)
-
-/* GPIO bank numbers */
-
-#define S5PV310_GPIO_NEXT(__gpio) \
-	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
-
-enum s5p_gpio_number {
-	S5PV310_GPIO_A0_START	= 0,
-	S5PV310_GPIO_A1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_A0),
-	S5PV310_GPIO_B_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_A1),
-	S5PV310_GPIO_C0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_B),
-	S5PV310_GPIO_C1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_C0),
-	S5PV310_GPIO_D0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_C1),
-	S5PV310_GPIO_D1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_D0),
-	S5PV310_GPIO_E0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_D1),
-	S5PV310_GPIO_E1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_E0),
-	S5PV310_GPIO_E2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_E1),
-	S5PV310_GPIO_E3_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_E2),
-	S5PV310_GPIO_E4_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_E3),
-	S5PV310_GPIO_F0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_E4),
-	S5PV310_GPIO_F1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_F0),
-	S5PV310_GPIO_F2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_F1),
-	S5PV310_GPIO_F3_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_F2),
-	S5PV310_GPIO_J0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_F3),
-	S5PV310_GPIO_J1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_J0),
-	S5PV310_GPIO_K0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_J1),
-	S5PV310_GPIO_K1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_K0),
-	S5PV310_GPIO_K2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_K1),
-	S5PV310_GPIO_K3_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_K2),
-	S5PV310_GPIO_L0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_K3),
-	S5PV310_GPIO_L1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_L0),
-	S5PV310_GPIO_L2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_L1),
-	S5PV310_GPIO_X0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_L2),
-	S5PV310_GPIO_X1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X0),
-	S5PV310_GPIO_X2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X1),
-	S5PV310_GPIO_X3_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X2),
-	S5PV310_GPIO_Z_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X3),
-};
-
-/* S5PV310 GPIO number definitions */
-#define S5PV310_GPA0(_nr)	(S5PV310_GPIO_A0_START + (_nr))
-#define S5PV310_GPA1(_nr)	(S5PV310_GPIO_A1_START + (_nr))
-#define S5PV310_GPB(_nr)	(S5PV310_GPIO_B_START + (_nr))
-#define S5PV310_GPC0(_nr)	(S5PV310_GPIO_C0_START + (_nr))
-#define S5PV310_GPC1(_nr)	(S5PV310_GPIO_C1_START + (_nr))
-#define S5PV310_GPD0(_nr)	(S5PV310_GPIO_D0_START + (_nr))
-#define S5PV310_GPD1(_nr)	(S5PV310_GPIO_D1_START + (_nr))
-#define S5PV310_GPE0(_nr)	(S5PV310_GPIO_E0_START + (_nr))
-#define S5PV310_GPE1(_nr)	(S5PV310_GPIO_E1_START + (_nr))
-#define S5PV310_GPE2(_nr)	(S5PV310_GPIO_E2_START + (_nr))
-#define S5PV310_GPE3(_nr)	(S5PV310_GPIO_E3_START + (_nr))
-#define S5PV310_GPE4(_nr)	(S5PV310_GPIO_E4_START + (_nr))
-#define S5PV310_GPF0(_nr)	(S5PV310_GPIO_F0_START + (_nr))
-#define S5PV310_GPF1(_nr)	(S5PV310_GPIO_F1_START + (_nr))
-#define S5PV310_GPF2(_nr)	(S5PV310_GPIO_F2_START + (_nr))
-#define S5PV310_GPF3(_nr)	(S5PV310_GPIO_F3_START + (_nr))
-#define S5PV310_GPJ0(_nr)	(S5PV310_GPIO_J0_START + (_nr))
-#define S5PV310_GPJ1(_nr)	(S5PV310_GPIO_J1_START + (_nr))
-#define S5PV310_GPK0(_nr)	(S5PV310_GPIO_K0_START + (_nr))
-#define S5PV310_GPK1(_nr)	(S5PV310_GPIO_K1_START + (_nr))
-#define S5PV310_GPK2(_nr)	(S5PV310_GPIO_K2_START + (_nr))
-#define S5PV310_GPK3(_nr)	(S5PV310_GPIO_K3_START + (_nr))
-#define S5PV310_GPL0(_nr)	(S5PV310_GPIO_L0_START + (_nr))
-#define S5PV310_GPL1(_nr)	(S5PV310_GPIO_L1_START + (_nr))
-#define S5PV310_GPL2(_nr)	(S5PV310_GPIO_L2_START + (_nr))
-#define S5PV310_GPX0(_nr)	(S5PV310_GPIO_X0_START + (_nr))
-#define S5PV310_GPX1(_nr)	(S5PV310_GPIO_X1_START + (_nr))
-#define S5PV310_GPX2(_nr)	(S5PV310_GPIO_X2_START + (_nr))
-#define S5PV310_GPX3(_nr)	(S5PV310_GPIO_X3_START + (_nr))
-#define S5PV310_GPZ(_nr)	(S5PV310_GPIO_Z_START + (_nr))
-
-/* the end of the S5PV310 specific gpios */
-#define S5PV310_GPIO_END	(S5PV310_GPZ(S5PV310_GPIO_Z_NR) + 1)
-#define S3C_GPIO_END		S5PV310_GPIO_END
-
-/* define the number of gpios we need to the one after the GPZ() range */
-#define ARCH_NR_GPIOS		(S5PV310_GPZ(S5PV310_GPIO_Z_NR) +	\
-				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
-
-#include <asm-generic/gpio.h>
-
-#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
deleted file mode 100644
index 901657f..0000000
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ /dev/null
@@ -1,144 +0,0 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/map.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5PV310 - Memory map definitions
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
-/*
- * S5PV310 UART offset is 0x10000 but the older S5P SoCs are 0x400.
- * So need to define it, and here is to avoid redefinition warning.
- */
-#define S3C_UART_OFFSET			(0x10000)
-
-#include <plat/map-s5p.h>
-
-#define S5PV310_PA_SYSRAM		0x02025000
-
-#define S5PV310_PA_I2S0			0x03830000
-#define S5PV310_PA_I2S1			0xE3100000
-#define S5PV310_PA_I2S2			0xE2A00000
-
-#define S5PV310_PA_PCM0			0x03840000
-#define S5PV310_PA_PCM1			0x13980000
-#define S5PV310_PA_PCM2			0x13990000
-
-#define S5PV310_PA_SROM_BANK(x)		(0x04000000 + ((x) * 0x01000000))
-
-#define S5PC210_PA_ONENAND		0x0C000000
-#define S5PC210_PA_ONENAND_DMA		0x0C600000
-
-#define S5PV310_PA_CHIPID		0x10000000
-
-#define S5PV310_PA_SYSCON		0x10010000
-#define S5PV310_PA_PMU			0x10020000
-#define S5PV310_PA_CMU			0x10030000
-
-#define S5PV310_PA_WATCHDOG		0x10060000
-#define S5PV310_PA_RTC			0x10070000
-
-#define S5PV310_PA_DMC0			0x10400000
-
-#define S5PV310_PA_COMBINER		0x10448000
-
-#define S5PV310_PA_COREPERI		0x10500000
-#define S5PV310_PA_GIC_CPU		0x10500100
-#define S5PV310_PA_TWD			0x10500600
-#define S5PV310_PA_GIC_DIST		0x10501000
-#define S5PV310_PA_L2CC			0x10502000
-
-#define S5PV310_PA_MDMA			0x10810000
-#define S5PV310_PA_PDMA0		0x12680000
-#define S5PV310_PA_PDMA1		0x12690000
-
-#define S5PV310_PA_SYSMMU_MDMA		0x10A40000
-#define S5PV310_PA_SYSMMU_SSS		0x10A50000
-#define S5PV310_PA_SYSMMU_FIMC0		0x11A20000
-#define S5PV310_PA_SYSMMU_FIMC1		0x11A30000
-#define S5PV310_PA_SYSMMU_FIMC2		0x11A40000
-#define S5PV310_PA_SYSMMU_FIMC3		0x11A50000
-#define S5PV310_PA_SYSMMU_JPEG		0x11A60000
-#define S5PV310_PA_SYSMMU_FIMD0		0x11E20000
-#define S5PV310_PA_SYSMMU_FIMD1		0x12220000
-#define S5PV310_PA_SYSMMU_PCIe		0x12620000
-#define S5PV310_PA_SYSMMU_G2D		0x12A20000
-#define S5PV310_PA_SYSMMU_ROTATOR	0x12A30000
-#define S5PV310_PA_SYSMMU_MDMA2		0x12A40000
-#define S5PV310_PA_SYSMMU_TV		0x12E20000
-#define S5PV310_PA_SYSMMU_MFC_L		0x13620000
-#define S5PV310_PA_SYSMMU_MFC_R		0x13630000
-
-#define S5PV310_PA_GPIO1		0x11400000
-#define S5PV310_PA_GPIO2		0x11000000
-#define S5PV310_PA_GPIO3		0x03860000
-
-#define S5PV310_PA_MIPI_CSIS0		0x11880000
-#define S5PV310_PA_MIPI_CSIS1		0x11890000
-
-#define S5PV310_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
-
-#define S5PV310_PA_SROMC		0x12570000
-
-#define S5PV310_PA_UART			0x13800000
-
-#define S5PV310_PA_IIC(x)		(0x13860000 + ((x) * 0x10000))
-
-#define S5PV310_PA_AC97			0x139A0000
-
-#define S5PV310_PA_TIMER		0x139D0000
-
-#define S5PV310_PA_SDRAM		0x40000000
-
-#define S5PV310_PA_SPDIF		0xE1100000
-
-/* Compatibiltiy Defines */
-
-#define S3C_PA_HSMMC0			S5PV310_PA_HSMMC(0)
-#define S3C_PA_HSMMC1			S5PV310_PA_HSMMC(1)
-#define S3C_PA_HSMMC2			S5PV310_PA_HSMMC(2)
-#define S3C_PA_HSMMC3			S5PV310_PA_HSMMC(3)
-#define S3C_PA_IIC			S5PV310_PA_IIC(0)
-#define S3C_PA_IIC1			S5PV310_PA_IIC(1)
-#define S3C_PA_IIC2			S5PV310_PA_IIC(2)
-#define S3C_PA_IIC3			S5PV310_PA_IIC(3)
-#define S3C_PA_IIC4			S5PV310_PA_IIC(4)
-#define S3C_PA_IIC5			S5PV310_PA_IIC(5)
-#define S3C_PA_IIC6			S5PV310_PA_IIC(6)
-#define S3C_PA_IIC7			S5PV310_PA_IIC(7)
-#define S3C_PA_RTC			S5PV310_PA_RTC
-#define S3C_PA_WDT			S5PV310_PA_WATCHDOG
-
-#define S5P_PA_CHIPID			S5PV310_PA_CHIPID
-#define S5P_PA_MIPI_CSIS0		S5PV310_PA_MIPI_CSIS0
-#define S5P_PA_MIPI_CSIS1		S5PV310_PA_MIPI_CSIS1
-#define S5P_PA_ONENAND			S5PC210_PA_ONENAND
-#define S5P_PA_ONENAND_DMA		S5PC210_PA_ONENAND_DMA
-#define S5P_PA_SDRAM			S5PV310_PA_SDRAM
-#define S5P_PA_SROMC			S5PV310_PA_SROMC
-#define S5P_PA_SYSCON			S5PV310_PA_SYSCON
-#define S5P_PA_TIMER			S5PV310_PA_TIMER
-
-/* UART */
-
-#define S3C_PA_UART			S5PV310_PA_UART
-
-#define S5P_PA_UART(x)			(S3C_PA_UART + ((x) * S3C_UART_OFFSET))
-#define S5P_PA_UART0			S5P_PA_UART(0)
-#define S5P_PA_UART1			S5P_PA_UART(1)
-#define S5P_PA_UART2			S5P_PA_UART(2)
-#define S5P_PA_UART3			S5P_PA_UART(3)
-#define S5P_PA_UART4			S5P_PA_UART(4)
-
-#define S5P_SZ_UART			SZ_256
-
-#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-gpio.h b/arch/arm/mach-s5pv310/include/mach/regs-gpio.h
deleted file mode 100644
index 82e9e0c..0000000
--- a/arch/arm/mach-s5pv310/include/mach/regs-gpio.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/regs-gpio.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * S5PV310 - GPIO (including EINT) register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_REGS_GPIO_H
-#define __ASM_ARCH_REGS_GPIO_H __FILE__
-
-#include <mach/map.h>
-#include <mach/irqs.h>
-
-#define S5PV310_EINT40CON		(S5P_VA_GPIO2 + 0xE00)
-#define S5P_EINT_CON(x)			(S5PV310_EINT40CON + ((x) * 0x4))
-
-#define S5PV310_EINT40FLTCON0		(S5P_VA_GPIO2 + 0xE80)
-#define S5P_EINT_FLTCON(x)		(S5PV310_EINT40FLTCON0 + ((x) * 0x4))
-
-#define S5PV310_EINT40MASK		(S5P_VA_GPIO2 + 0xF00)
-#define S5P_EINT_MASK(x)		(S5PV310_EINT40MASK + ((x) * 0x4))
-
-#define S5PV310_EINT40PEND		(S5P_VA_GPIO2 + 0xF40)
-#define S5P_EINT_PEND(x)		(S5PV310_EINT40PEND + ((x) * 0x4))
-
-#define EINT_REG_NR(x)			(EINT_OFFSET(x) >> 3)
-
-#define eint_irq_to_bit(irq)		(1 << (EINT_OFFSET(irq) & 0x7))
-
-#define EINT_MODE			S3C_GPIO_SFN(0xf)
-
-#define EINT_GPIO_0(x)			S5PV310_GPX0(x)
-#define EINT_GPIO_1(x)			S5PV310_GPX1(x)
-#define EINT_GPIO_2(x)			S5PV310_GPX2(x)
-#define EINT_GPIO_3(x)			S5PV310_GPX3(x)
-
-#endif /* __ASM_ARCH_REGS_GPIO_H */
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index 047d31c..c3bfe9b 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -1,7 +1,7 @@
 /* linux/arch/arm/plat-s5p/cpu.c
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * S5P CPU Support
  *
@@ -12,17 +12,20 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <mach/map.h>
+
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+
+#include <mach/map.h>
 #include <mach/regs-clock.h>
+
 #include <plat/cpu.h>
 #include <plat/s5p6440.h>
 #include <plat/s5p6442.h>
 #include <plat/s5p6450.h>
 #include <plat/s5pc100.h>
 #include <plat/s5pv210.h>
-#include <plat/s5pv310.h>
+#include <plat/exynos4.h>
 
 /* table of supported CPUs */
 
@@ -31,7 +34,7 @@ static const char name_s5p6442[] = "S5P6442";
 static const char name_s5p6450[] = "S5P6450";
 static const char name_s5pc100[] = "S5PC100";
 static const char name_s5pv210[] = "S5PV210/S5PC110";
-static const char name_s5pv310[] = "S5PV310";
+static const char name_exynos4210[] = "EXYNOS4210";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
@@ -75,13 +78,13 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= s5pv210_init,
 		.name		= name_s5pv210,
 	}, {
-		.idcode		= 0x43200000,
+		.idcode		= 0x43210000,
 		.idmask		= 0xfffff000,
-		.map_io		= s5pv310_map_io,
-		.init_clocks	= s5pv310_init_clocks,
-		.init_uarts	= s5pv310_init_uarts,
-		.init		= s5pv310_init,
-		.name		= name_s5pv310,
+		.map_io		= exynos4_map_io,
+		.init_clocks	= exynos4_init_clocks,
+		.init_uarts	= exynos4_init_uarts,
+		.init		= exynos4_init,
+		.name		= name_exynos4210,
 	},
 };
 
diff --git a/arch/arm/plat-s5p/include/plat/exynos4.h b/arch/arm/plat-s5p/include/plat/exynos4.h
new file mode 100644
index 0000000..907caab
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/exynos4.h
@@ -0,0 +1,34 @@
+/* linux/arch/arm/plat-s5p/include/plat/exynos4.h
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Header file for exynos4 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* Common init code for EXYNOS4 related SoCs */
+
+extern void exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+extern void exynos4_register_clocks(void);
+extern void exynos4_setup_clocks(void);
+
+#ifdef CONFIG_CPU_EXYNOS4210
+
+extern  int exynos4_init(void);
+extern void exynos4_init_irq(void);
+extern void exynos4_map_io(void);
+extern void exynos4_init_clocks(int xtal);
+extern struct sys_timer exynos4_timer;
+
+#define exynos4_init_uarts exynos4_common_init_uarts
+
+#else
+#define exynos4_init_clocks NULL
+#define exynos4_init_uarts NULL
+#define exynos4_map_io NULL
+#define exynos4_init NULL
+#endif
diff --git a/arch/arm/plat-s5p/include/plat/s5pv310.h b/arch/arm/plat-s5p/include/plat/s5pv310.h
deleted file mode 100644
index 769c991..0000000
--- a/arch/arm/plat-s5p/include/plat/s5pv310.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* linux/arch/arm/plat-s5p/include/plat/s5pv310.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Header file for s5pv310 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* Common init code for S5PV310 related SoCs */
-
-extern void s5pv310_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-extern void s5pv310_register_clocks(void);
-extern void s5pv310_setup_clocks(void);
-
-#ifdef CONFIG_CPU_S5PV310
-
-extern  int s5pv310_init(void);
-extern void s5pv310_init_irq(void);
-extern void s5pv310_map_io(void);
-extern void s5pv310_init_clocks(int xtal);
-extern struct sys_timer s5pv310_timer;
-
-#define s5pv310_init_uarts s5pv310_common_init_uarts
-
-#else
-#define s5pv310_init_clocks NULL
-#define s5pv310_init_uarts NULL
-#define s5pv310_map_io NULL
-#define s5pv310_init NULL
-#endif
-- 
1.7.1
