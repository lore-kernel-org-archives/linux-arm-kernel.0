From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 25 Jun 2013 17:27:46 +0800
Subject: [PATCH 02/11] ARM: tegra: add a flag for
 tegra_disable_clean_inv_dcache to do LoUIS or ALL
In-Reply-To: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
Message-ID: <1372152475-18617-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a flag for tegra_disable_clean_inv_dcache to flush cache as LoUIS
or ALL. After this patch, the v7_flush_dcache_louis is used for CPU hotplug
and CPU suspend in CPU power down (e.g. CPU idle power-down mode) case. And
the v7_flush_dcache_all is used for CPU cluster power down (e.g. suspend to
LP2 mode).

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/hotplug.c       | 2 +-
 arch/arm/mach-tegra/sleep-tegra20.S | 1 +
 arch/arm/mach-tegra/sleep-tegra30.S | 1 +
 arch/arm/mach-tegra/sleep.S         | 7 ++++++-
 arch/arm/mach-tegra/sleep.h         | 6 +++++-
 5 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index a52c10e..4687ec0 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -37,7 +37,7 @@ int tegra_cpu_kill(unsigned cpu)
 void __ref tegra_cpu_die(unsigned int cpu)
 {
 	/* Clean L1 data cache */
-	tegra_disable_clean_inv_dcache();
+	tegra_disable_clean_inv_dcache(TEGRA_FLUSH_CACHE_LOUIS);
 
 	/* Shut down the current CPU. */
 	tegra_hotplug_shutdown();
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index e3f2417..f87721d 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -191,6 +191,7 @@ ENTRY(tegra20_sleep_cpu_secondary_finish)
 	mrc	p15, 0, r11, c1, c0, 1  @ save actlr before exiting coherency
 
 	/* Flush and disable the L1 data cache */
+	mov	r0, #TEGRA_FLUSH_CACHE_LOUIS
 	bl	tegra_disable_clean_inv_dcache
 
 	mov32	r0, TEGRA_PMC_VIRT + PMC_SCRATCH41
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 5877f26..6744161 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -137,6 +137,7 @@ ENTRY(tegra30_sleep_cpu_secondary_finish)
 	mov	r7, lr
 
 	/* Flush and disable the L1 data cache */
+	mov 	r0, #TEGRA_FLUSH_CACHE_LOUIS
 	bl	tegra_disable_clean_inv_dcache
 
 	/* Powergate this CPU. */
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 9daaef2..6d6600d 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -56,7 +56,9 @@ ENTRY(tegra_disable_clean_inv_dcache)
 	isb
 
 	/* Flush the D-cache */
-	bl	v7_flush_dcache_louis
+	cmp	r0, #TEGRA_FLUSH_CACHE_ALL
+	blne	v7_flush_dcache_louis
+	bleq	v7_flush_dcache_all
 
 	/* Trun off coherency */
 	exit_smp r4, r5
@@ -73,9 +75,12 @@ ENDPROC(tegra_disable_clean_inv_dcache)
  * tegra?_tear_down_cpu
  */
 ENTRY(tegra_sleep_cpu_finish)
+	mov	r4, r0
 	/* Flush and disable the L1 data cache */
+	mov	r0, #TEGRA_FLUSH_CACHE_ALL
 	bl	tegra_disable_clean_inv_dcache
 
+	mov	r0, r4
 	mov32	r6, tegra_tear_down_cpu
 	ldr	r1, [r6]
 	add	r1, r1, r0
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 98b7da6..f0df3a4 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -41,6 +41,10 @@
 #define CPU_NOT_RESETTABLE	0
 #endif
 
+/* flag of tegra_disable_clean_inv_dcache to do LoUIS or all */
+#define TEGRA_FLUSH_CACHE_LOUIS	0x10
+#define TEGRA_FLUSH_CACHE_ALL	0x20
+
 #ifdef __ASSEMBLY__
 /* returns the offset of the flow controller halt register for a cpu */
 .macro cpu_to_halt_reg rd, rcpu
@@ -144,7 +148,7 @@ void tegra_pen_lock(void);
 void tegra_pen_unlock(void);
 void tegra_resume(void);
 int tegra_sleep_cpu_finish(unsigned long);
-void tegra_disable_clean_inv_dcache(void);
+void tegra_disable_clean_inv_dcache(u32 flag);
 
 #ifdef CONFIG_HOTPLUG_CPU
 void tegra20_hotplug_shutdown(void);
-- 
1.8.3.1
