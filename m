From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 5 Dec 2013 14:26:16 -0500 (EST)
Subject: [PATCH] clean up cache handling in platform code
Message-ID: <alpine.LFD.2.10.1312051417560.31246@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a handy macro to replace open coded __cpuc_flush_dcache_area(()
and outer_clean_range() sequences. Let's use it. No functional change.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 58b43e6f92..ddf73bd204 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -64,8 +64,7 @@ static void write_pen_release(int val)
 {
 	pen_release = val;
 	smp_wmb();
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	sync_cache_w(&pen_release);
 }
 
 static void __iomem *scu_base_addr(void)
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 1f24c1fdfe..5b57c17c06 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -92,8 +92,7 @@ static void __init imx_smp_prepare_cpus(unsigned int max_cpus)
 	 * secondary cores when booting them.
 	 */
 	asm("mrc p15, 0, %0, c15, c0, 1" : "=r" (g_diag_reg) : : "cc");
-	__cpuc_flush_dcache_area(&g_diag_reg, sizeof(g_diag_reg));
-	outer_clean_range(__pa(&g_diag_reg), __pa(&g_diag_reg + 1));
+	sync_cache_w(&g_diag_reg);
 }
 
 struct smp_operations  imx_smp_ops __initdata = {
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 3f06edcdd0..f10a1f58fd 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -99,8 +99,7 @@ static int msm_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * "cpu" is Linux's internal ID.
 	 */
 	pen_release = cpu_logical_map(cpu);
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	sync_cache_w(&pen_release);
 
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index 3dbcb1ab6e..e358b0736d 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -106,8 +106,7 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * "cpu" is Linux's internal ID.
 	 */
 	pen_release = cpu_logical_map(cpu);
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	sync_cache_w(&pen_release);
 
 	/*
 	 * Send the secondary CPU SEV, thereby causing the boot monitor to read
diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index dce50d983a..fa2c33ffac 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -31,8 +31,7 @@ static void write_pen_release(int val)
 {
 	pen_release = val;
 	smp_wmb();
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	sync_cache_w(&pen_release);
 }
 
 static DEFINE_SPINLOCK(boot_lock);
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 1f296e796a..a44967f316 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -38,8 +38,7 @@ static void write_pen_release(int val)
 {
 	pen_release = val;
 	smp_wmb();
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	sync_cache_w(&pen_release);
 }
 
 static void __iomem *scu_base_addr(void)
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 39895d892c..53feb90c84 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -27,8 +27,7 @@ static void write_pen_release(int val)
 {
 	pen_release = val;
 	smp_wmb();
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+	sync_cache_w(&pen_release);
 }
 
 static DEFINE_SPINLOCK(boot_lock);
