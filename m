From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 3 Jan 2013 14:42:59 +0800
Subject: [PATCH V2 1/2] ARM: tegra: update the cache maintenance order for CPU
 shutdown
Message-ID: <1357195380-5494-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updating the cache maintenance order before CPU shutdown when doing CPU
hotplug.
The old order:
* clean L1 by flush_cache_all
* exit SMP
* CPU shutdown
Adapt to:
* disable L1 data cache by clear C bit
* clean L1 by v7_flush_dcache_louis
* exit SMP
* CPU shutdown

For CPU hotplug case, it's no need to do "flush_cache_all". And we should
disable L1 data cache before clean L1 data cache. Then leaving the SMP
coherency.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change
---
 arch/arm/mach-tegra/hotplug.c       | 4 ++--
 arch/arm/mach-tegra/sleep-tegra20.S | 3 ---
 arch/arm/mach-tegra/sleep-tegra30.S | 3 ---
 arch/arm/mach-tegra/sleep.S         | 4 +++-
 arch/arm/mach-tegra/sleep.h         | 1 +
 5 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index 2faea56..ad95041 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -28,8 +28,8 @@ void __ref tegra_cpu_die(unsigned int cpu)
 {
 	cpu = cpu_logical_map(cpu);
 
-	/* Flush the L1 data cache. */
-	flush_cache_all();
+	/* Clean L1 data cache */
+	tegra_disable_clean_inv_dcache();
 
 	/* Shut down the current CPU. */
 	tegra_hotplug_shutdown();
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index 72ce709..ad2ca07 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -33,9 +33,6 @@
  * should never return
  */
 ENTRY(tegra20_hotplug_shutdown)
-	/* Turn off SMP coherency */
-	exit_smp r4, r5
-
 	/* Put this CPU down */
 	cpu_id	r0
 	bl	tegra20_cpu_shutdown
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 562a8e7..63a15bd 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -32,9 +32,6 @@
  * Should never return.
  */
 ENTRY(tegra30_hotplug_shutdown)
-	/* Turn off SMP coherency */
-	exit_smp r4, r5
-
 	/* Powergate this CPU */
 	mov	r0, #TEGRA30_POWER_HOTPLUG_SHUTDOWN
 	bl	tegra30_cpu_shutdown
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 26afa7c..addae35 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -34,7 +34,7 @@
 #include "flowctrl.h"
 #include "sleep.h"
 
-#ifdef CONFIG_PM_SLEEP
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PM_SLEEP)
 /*
  * tegra_disable_clean_inv_dcache
  *
@@ -60,7 +60,9 @@ ENTRY(tegra_disable_clean_inv_dcache)
 
 	ldmfd	sp!, {r0, r4-r5, r7, r9-r11, pc}
 ENDPROC(tegra_disable_clean_inv_dcache)
+#endif
 
+#ifdef CONFIG_PM_SLEEP
 /*
  * tegra_sleep_cpu_finish(unsigned long v2p)
  *
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 9821ee7..56505c3 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -106,6 +106,7 @@ exit_l2_resume:
 #else
 void tegra_resume(void);
 int tegra_sleep_cpu_finish(unsigned long);
+void tegra_disable_clean_inv_dcache(void);
 
 #ifdef CONFIG_HOTPLUG_CPU
 void tegra20_hotplug_init(void);
-- 
1.8.0.3
