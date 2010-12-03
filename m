From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:25:42 +0000
Subject: [PATCH 20/22] ARM: CPU hotplug: remove bug checks in
	platform_cpu_die()
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POcCM-0007sH-WF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_cpu_die() is entered from the CPU's own idle thread, which
can not be migrated to other CPUs.  Moreover, the 'cpu' argument
comes from the thread info, which will always be the 'current'
CPU.  So remove this useless bug check.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap-hotplug.c |    8 --------
 arch/arm/mach-realview/hotplug.c   |   10 ----------
 arch/arm/mach-s5pv310/hotplug.c    |   10 ----------
 arch/arm/mach-tegra/hotplug.c      |   10 ----------
 arch/arm/mach-ux500/hotplug.c      |   10 ----------
 5 files changed, 0 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index ace979d..4976b93 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -32,14 +32,6 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
-	unsigned int this_cpu = hard_smp_processor_id();
-
-	if (cpu != this_cpu) {
-		pr_crit("platform_cpu_die running on %u, should be %u\n",
-			   this_cpu, cpu);
-		BUG();
-	}
-
 	flush_cache_all();
 	dsb();
 
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index 7d58c16..e06572e 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -102,16 +102,6 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
-#ifdef DEBUG
-	unsigned int this_cpu = hard_smp_processor_id();
-
-	if (cpu != this_cpu) {
-		printk(KERN_CRIT "Eek! platform_cpu_die running on %u, should be %u\n",
-			   this_cpu, cpu);
-		BUG();
-	}
-#endif
-
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
diff --git a/arch/arm/mach-s5pv310/hotplug.c b/arch/arm/mach-s5pv310/hotplug.c
index d7be70a..ea951ef 100644
--- a/arch/arm/mach-s5pv310/hotplug.c
+++ b/arch/arm/mach-s5pv310/hotplug.c
@@ -105,16 +105,6 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
-#ifdef DEBUG
-	unsigned int this_cpu = hard_smp_processor_id();
-
-	if (cpu != this_cpu) {
-		printk(KERN_CRIT "Eek! platform_cpu_die running on %u, should be %u\n",
-			   this_cpu, cpu);
-		BUG();
-	}
-#endif
-
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index ecaa41c..a5eeb91 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -101,16 +101,6 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
-#ifdef DEBUG
-	unsigned int this_cpu = hard_smp_processor_id();
-
-	if (cpu != this_cpu) {
-		printk(KERN_CRIT "Eek! platform_cpu_die running on %u, should be %u\n",
-			   this_cpu, cpu);
-		BUG();
-	}
-#endif
-
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index 7a4890b..dd8037e 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -45,16 +45,6 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
-#ifdef DEBUG
-	unsigned int this_cpu = hard_smp_processor_id();
-
-	if (cpu != this_cpu) {
-		printk(KERN_CRIT "Eek! platform_cpu_die running on %u, should be %u\n",
-			   this_cpu, cpu);
-		BUG();
-	}
-#endif
-
 	/* directly enter low power state, skipping secure registers */
 	platform_do_lowpower(cpu);
 }
-- 
1.6.2.5
