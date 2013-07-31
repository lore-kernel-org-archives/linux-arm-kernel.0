From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 31 Jul 2013 16:08:09 +0900
Subject: [PATCH 07/07] ARM: shmobile: Use shared SCU CPU Hotplug code on
 r8a7779
In-Reply-To: <20130731070702.14444.64961.sendpatchset@w520>
References: <20130731070702.14444.64961.sendpatchset@w520>
Message-ID: <20130731070809.14444.98907.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the r8a7779 specific CPU Hotplug code to make use of
the recently introduced shared SCU functions. The r8a7779
power domain hardware requires special power down handling
at ->kill() time.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-r8a7779.c |   41 +++-------------------------------
 1 file changed, 4 insertions(+), 37 deletions(-)

--- 0004/arch/arm/mach-shmobile/smp-r8a7779.c
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2013-07-31 12:12:26.000000000 +0900
@@ -122,47 +122,14 @@ static void __init r8a7779_smp_prepare_c
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static int r8a7779_scu_psr_core_disabled(int cpu)
-{
-	unsigned long mask = 3 << (cpu * 8);
-
-	if ((__raw_readl(shmobile_scu_base + 8) & mask) == mask)
-		return 1;
-
-	return 0;
-}
-
 static int r8a7779_cpu_kill(unsigned int cpu)
 {
-	int k;
-
-	/* this function is running on another CPU than the offline target,
-	 * here we need wait for shutdown code in platform_cpu_die() to
-	 * finish before asking SoC-specific code to power off the CPU core.
-	 */
-	for (k = 0; k < 1000; k++) {
-		if (r8a7779_scu_psr_core_disabled(cpu))
-			return r8a7779_platform_cpu_kill(cpu);
-
-		mdelay(1);
-	}
+	if (shmobile_smp_scu_cpu_kill(cpu))
+		return r8a7779_platform_cpu_kill(cpu);
 
 	return 0;
 }
 
-static void r8a7779_cpu_die(unsigned int cpu)
-{
-	dsb();
-	flush_cache_all();
-
-	/* disable cache coherency */
-	scu_power_mode(shmobile_scu_base, SCU_PM_POWEROFF);
-
-	/* Endless loop until power off from r8a7779_cpu_kill() */
-	while (1)
-		cpu_do_idle();
-}
-
 static int r8a7779_cpu_disable(unsigned int cpu)
 {
 	/* only CPU1->3 have power domains, do not allow hotplug of CPU0 */
@@ -174,8 +141,8 @@ struct smp_operations r8a7779_smp_ops  _
 	.smp_prepare_cpus	= r8a7779_smp_prepare_cpus,
 	.smp_boot_secondary	= r8a7779_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_kill		= r8a7779_cpu_kill,
-	.cpu_die		= r8a7779_cpu_die,
 	.cpu_disable		= r8a7779_cpu_disable,
+	.cpu_die		= shmobile_smp_scu_cpu_die,
+	.cpu_kill		= r8a7779_cpu_kill,
 #endif
 };
