From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 3 Jan 2013 14:43:00 +0800
Subject: [PATCH V2 2/2] ARM: tegra: moving the clock gating procedure to
 tegra_cpu_kill
In-Reply-To: <1357195380-5494-1-git-send-email-josephl@nvidia.com>
References: <1357195380-5494-1-git-send-email-josephl@nvidia.com>
Message-ID: <1357195380-5494-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tegra_cpu_die was be executed by the CPU itslf. So the clock gating
procedure won't be executed after the CPU hardware shutdown code. Moving
the clock gating procedure to tegra_cpu_kill that will be run by another
CPU after the CPU died.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* remove the redundant cpu_logical_map call in tegra_cpu_die when moving
  the clock gating code to tegra_cpu_kill
---
 arch/arm/mach-tegra/common.h  |  1 +
 arch/arm/mach-tegra/hotplug.c | 17 +++++++++++------
 arch/arm/mach-tegra/platsmp.c |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
index 02f71b4..32f8eb3 100644
--- a/arch/arm/mach-tegra/common.h
+++ b/arch/arm/mach-tegra/common.h
@@ -1,4 +1,5 @@
 extern struct smp_operations tegra_smp_ops;
 
+extern int tegra_cpu_kill(unsigned int cpu);
 extern void tegra_cpu_die(unsigned int cpu);
 extern int tegra_cpu_disable(unsigned int cpu);
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index ad95041..a599f6e 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -19,6 +19,17 @@
 
 static void (*tegra_hotplug_shutdown)(void);
 
+int tegra_cpu_kill(unsigned cpu)
+{
+	cpu = cpu_logical_map(cpu);
+
+	/* Clock gate the CPU */
+	tegra_wait_cpu_in_reset(cpu);
+	tegra_disable_cpu_clock(cpu);
+
+	return 1;
+}
+
 /*
  * platform-specific code to shutdown a CPU
  *
@@ -26,18 +37,12 @@ static void (*tegra_hotplug_shutdown)(void);
  */
 void __ref tegra_cpu_die(unsigned int cpu)
 {
-	cpu = cpu_logical_map(cpu);
-
 	/* Clean L1 data cache */
 	tegra_disable_clean_inv_dcache();
 
 	/* Shut down the current CPU. */
 	tegra_hotplug_shutdown();
 
-	/* Clock gate the CPU */
-	tegra_wait_cpu_in_reset(cpu);
-	tegra_disable_cpu_clock(cpu);
-
 	/* Should never return here. */
 	BUG();
 }
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index dec6704..cdf5faa 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -175,6 +175,7 @@ struct smp_operations tegra_smp_ops __initdata = {
 	.smp_secondary_init	= tegra_secondary_init,
 	.smp_boot_secondary	= tegra_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= tegra_cpu_kill,
 	.cpu_die		= tegra_cpu_die,
 	.cpu_disable		= tegra_cpu_disable,
 #endif
-- 
1.8.0.3
