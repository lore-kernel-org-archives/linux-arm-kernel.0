From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 18 Feb 2015 18:04:17 +0100
Subject: [PATCH] ARM: smp_scu: add helper setting possible CPUs
Message-ID: <1424279057-21518-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We had code for this duplicated (it was in 5 different arch-s), so add
a helper doing that.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/include/asm/smp_scu.h   |  2 ++
 arch/arm/kernel/smp_scu.c        | 20 ++++++++++++++++++++
 arch/arm/mach-exynos/platsmp.c   | 27 +++++++++------------------
 arch/arm/mach-realview/platsmp.c | 16 ++++------------
 arch/arm/mach-spear/platsmp.c    | 11 +----------
 arch/arm/mach-ux500/platsmp.c    | 16 ++++------------
 6 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index bfe163c..1468d3f 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -25,12 +25,14 @@ static inline unsigned long scu_a9_get_base(void)
 
 #ifdef CONFIG_HAVE_ARM_SCU
 unsigned int scu_get_core_count(void __iomem *);
+void scu_set_cpu_possible(void __iomem *scu_base);
 int scu_power_mode(void __iomem *, unsigned int);
 #else
 static inline unsigned int scu_get_core_count(void __iomem *scu_base)
 {
 	return 0;
 }
+static inline void scu_set_cpu_possible(void __iomem *scu_base) {}
 static inline int scu_power_mode(void __iomem *scu_base, unsigned int mode)
 {
 	return -EINVAL;
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 72f9241..752007f 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -35,6 +35,26 @@ unsigned int __init scu_get_core_count(void __iomem *scu_base)
 }
 
 /*
+ * Set possible CPUs based on cores info from SCU
+ */
+void scu_set_cpu_possible(void __iomem *scu_base)
+{
+	unsigned int i, ncores;
+
+	ncores = scu_get_core_count(scu_base);
+
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+
+/*
  * Enable the SCU
  */
 void scu_enable(void __iomem *scu_base)
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 7a1ebfe..7c693dd 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -376,26 +376,17 @@ fail:
 static void __init exynos_smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
-	unsigned int i, ncores;
 
-	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
-		ncores = scu_base ? scu_get_core_count(scu_base) : 1;
-	else
-		/*
-		 * CPU Nodes are passed thru DT and set_cpu_possible
-		 * is set by "arm_dt_init_cpu_maps".
-		 */
-		return;
-
-	/* sanity check */
-	if (ncores > nr_cpu_ids) {
-		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
-			ncores, nr_cpu_ids);
-		ncores = nr_cpu_ids;
+	/*
+	 * On non-Cortex A9 CPU Nodes are passed thru DT and set_cpu_possible
+	 * is set by "arm_dt_init_cpu_maps".
+	 */
+	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9) {
+		if (scu_base)
+			scu_set_cpu_possible(scu_base);
+		else
+			set_cpu_possible(0, true);
 	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
 }
 
 static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 98e3052..56438c0 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -45,19 +45,11 @@ static void __iomem *scu_base_addr(void)
 static void __init realview_smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
-	unsigned int i, ncores;
 
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
-
-	/* sanity check */
-	if (ncores > nr_cpu_ids) {
-		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
-			ncores, nr_cpu_ids);
-		ncores = nr_cpu_ids;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	if (scu_base)
+		scu_set_cpu_possible(scu_base);
+	else
+		set_cpu_possible(0, true);
 }
 
 static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
index fd42977..2faea99 100644
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -95,16 +95,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
  */
 static void __init spear13xx_smp_init_cpus(void)
 {
-	unsigned int i, ncores = scu_get_core_count(scu_base);
-
-	if (ncores > nr_cpu_ids) {
-		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
-			ncores, nr_cpu_ids);
-		ncores = nr_cpu_ids;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	scu_set_cpu_possible(scu_base);
 }
 
 static void __init spear13xx_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index a44967f..47b7dec 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -136,19 +136,11 @@ static void __init wakeup_secondary(void)
 static void __init ux500_smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
-	unsigned int i, ncores;
 
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
-
-	/* sanity check */
-	if (ncores > nr_cpu_ids) {
-		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
-			ncores, nr_cpu_ids);
-		ncores = nr_cpu_ids;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	if (scu_base)
+		scu_set_cpu_possible(scu_base);
+	else
+		set_cpu_possible(0, true);
 }
 
 static void __init ux500_smp_prepare_cpus(unsigned int max_cpus)
-- 
1.8.4.5
