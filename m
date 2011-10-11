From: msalter@redhat.com (Mark Salter)
Date: Tue, 11 Oct 2011 09:31:04 -0400
Subject: [PATCH] arm: fix handling of nr_cpus
Message-ID: <1318339864-32396-1-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code duplicates the setup of the cpu_possible bitmap in the
platform smp_init_cpus() function. Unfortunately, all of those places
have the same bug where the nr_cpus kernel parameter is ignored. This patch
consolidates the duplicated code in one place and fixes it to honor the
nr_cpus parameter. This is accomplished by having smp_init_cpus() return
the platform specific number of cores so that the caller (setup_arch) can
set up the cpu_possible bitmap correctly for all platforms.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm/include/asm/smp.h                        |    5 ++-
 arch/arm/kernel/setup.c                           |   24 +++++++++++++++++++-
 arch/arm/mach-exynos4/platsmp.c                   |   24 ++------------------
 arch/arm/mach-msm/platsmp.c                       |   14 +++--------
 arch/arm/mach-omap2/omap-smp.c                    |   24 ++------------------
 arch/arm/mach-realview/platsmp.c                  |   23 ++-----------------
 arch/arm/mach-shmobile/platsmp.c                  |   10 ++------
 arch/arm/mach-tegra/platsmp.c                     |   19 ++--------------
 arch/arm/mach-ux500/platsmp.c                     |   23 ++-----------------
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   11 +++------
 arch/arm/mach-vexpress/include/mach/motherboard.h |    2 +-
 arch/arm/mach-vexpress/platsmp.c                  |    8 +-----
 12 files changed, 54 insertions(+), 133 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index e42d96a..e9c38a9 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -33,9 +33,10 @@ extern void show_ipi_list(struct seq_file *, int);
 asmlinkage void do_IPI(int ipinr, struct pt_regs *regs);
 
 /*
- * Setup the set of possible CPUs (via set_cpu_possible)
+ * Early platform SMP init.
+ * Returns the number of cores.
  */
-extern void smp_init_cpus(void);
+extern int smp_init_cpus(void);
 
 
 /*
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e514c76..5df2722 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -913,8 +913,28 @@ void __init setup_arch(char **cmdline_p)
 	unflatten_device_tree();
 
 #ifdef CONFIG_SMP
-	if (is_smp())
-		smp_init_cpus();
+	/*
+	 * Initialise the CPU possible map early - this describes the CPUs
+	 * which may be present or become present in the system.
+	 */
+	if (is_smp()) {
+		int i, ncores;
+
+		ncores = smp_init_cpus();
+
+		if (ncores > NR_CPUS) {
+			printk(KERN_WARNING
+			       "Number of cores (%d) greater than configured "
+			       "maximum of %d - clipping\n",
+			       ncores, NR_CPUS);
+			ncores = NR_CPUS;
+		}
+		if (ncores > nr_cpu_ids)
+			ncores = nr_cpu_ids;
+
+		for (i = 0; i < ncores; i++)
+			set_cpu_possible(i, true);
+	}
 #endif
 	reserve_crashkernel();
 
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index df6ef1b..70b3e99 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -180,31 +180,13 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return pen_release != -1 ? -ENOSYS : 0;
 }
 
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system.
- */
-
-void __init smp_init_cpus(void)
+int __init smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
-	unsigned int i, ncores;
-
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
-
-	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "EXYNOS4: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
 
 	set_smp_cross_call(gic_raise_softirq);
+
+	return scu_base ? scu_get_core_count(scu_base) : 1;
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 1a1af9e..b59f8b5 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -147,19 +147,13 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 }
 
 /*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system. The msm8x60
- * does not support the ARM SCU, so just set the possible cpu mask to
- * NR_CPUS.
+ * The msm8x60 does not support the ARM SCU, so just return NR_CPUS.
  */
-void __init smp_init_cpus(void)
+int __init smp_init_cpus(void)
 {
-	unsigned int i, ncores = get_core_count();
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-
         set_smp_cross_call(gic_raise_softirq);
+
+	return get_core_count();
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index ce65e93..deaf25a 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -94,33 +94,15 @@ static void __init wakeup_secondary(void)
 	mb();
 }
 
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system.
- */
-void __init smp_init_cpus(void)
+int __init smp_init_cpus(void)
 {
-	unsigned int i, ncores;
-
 	/* Never released */
 	scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
 	BUG_ON(!scu_base);
 
-	ncores = scu_get_core_count(scu_base);
-
-	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "OMAP4: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-
 	set_smp_cross_call(gic_raise_softirq);
+
+	return scu_get_core_count(scu_base);
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 4ae943b..b6309c0 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -40,30 +40,13 @@ static void __iomem *scu_base_addr(void)
 		return (void __iomem *)0;
 }
 
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system.
- */
-void __init smp_init_cpus(void)
+int __init smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
-	unsigned int i, ncores;
-
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
-
-	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "Realview: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
 
 	set_smp_cross_call(gic_raise_softirq);
+
+	return scu_base ? scu_get_core_count(scu_base) : 1;
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 66f9806..b9338e8 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -51,15 +51,11 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return -ENOSYS;
 }
 
-void __init smp_init_cpus(void)
+int __init smp_init_cpus(void)
 {
-	unsigned int ncores = shmobile_smp_get_core_count();
-	unsigned int i;
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-
 	set_smp_cross_call(gic_raise_softirq);
+
+	return shmobile_smp_get_core_count();
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 0886cbc..bcd8f72 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -106,24 +106,11 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system.
- */
-void __init smp_init_cpus(void)
+int __init smp_init_cpus(void)
 {
-	unsigned int i, ncores = scu_get_core_count(scu_base);
-
-	if (ncores > NR_CPUS) {
-		printk(KERN_ERR "Tegra: no. of cores (%u) greater than configured (%u), clipping\n",
-			ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-
 	set_smp_cross_call(gic_raise_softirq);
+
+	return scu_get_core_count(scu_base);
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index a33df5f..c3491af 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -144,30 +144,13 @@ static void __init wakeup_secondary(void)
 	mb();
 }
 
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system.
- */
-void __init smp_init_cpus(void)
+int __init smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
-	unsigned int i, ncores;
-
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
-
-	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "U8500: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
 
 	set_smp_cross_call(gic_raise_softirq);
+
+	return scu_base ? scu_get_core_count(scu_base) : 1;
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index bfd32f5..21006af 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -217,14 +217,11 @@ static void __init ct_ca9x4_init(void)
 }
 
 #ifdef CONFIG_SMP
-static void ct_ca9x4_init_cpu_map(void)
+static int ct_ca9x4_smp_init_cpus(void)
 {
-	int i, ncores = scu_get_core_count(MMIO_P2V(A9_MPCORE_SCU));
-
-	for (i = 0; i < ncores; ++i)
-		set_cpu_possible(i, true);
-
 	set_smp_cross_call(gic_raise_softirq);
+
+	return scu_get_core_count(MMIO_P2V(A9_MPCORE_SCU));
 }
 
 static void ct_ca9x4_smp_enable(unsigned int max_cpus)
@@ -241,7 +238,7 @@ struct ct_desc ct_ca9x4_desc __initdata = {
 	.init_irq	= ct_ca9x4_init_irq,
 	.init_tile	= ct_ca9x4_init,
 #ifdef CONFIG_SMP
-	.init_cpu_map	= ct_ca9x4_init_cpu_map,
+	.smp_init_cpus	= ct_ca9x4_smp_init_cpus,
 	.smp_enable	= ct_ca9x4_smp_enable,
 #endif
 };
diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index 0a3a375..2920ac7 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -133,7 +133,7 @@ struct ct_desc {
 	void			(*init_irq)(void);
 	void			(*init_tile)(void);
 #ifdef CONFIG_SMP
-	void			(*init_cpu_map)(void);
+	int			(*smp_init_cpus)(void);
 	void			(*smp_enable)(unsigned int);
 #endif
 };
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 2b5f7ac..e713c7e 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -22,13 +22,9 @@
 
 extern void versatile_secondary_startup(void);
 
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system.
- */
-void __init smp_init_cpus(void)
+int __init smp_init_cpus(void)
 {
-	ct_desc->init_cpu_map();
+	return ct_desc->smp_init_cpus();
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
-- 
1.7.6.4
