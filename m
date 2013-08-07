From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:39:33 +0900
Subject: [GIT PULL 7/9] ARM: shmobile: Use shared SCU CPU Hotplug code on
 r8a7779
In-Reply-To: <cover.1375841380.git.horms+renesas@verge.net.au>
References: <cover.1375841380.git.horms+renesas@verge.net.au>
Message-ID: <e9e7c4fbf468e205387b21463dddacfe44da2d9a.1375841380.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the r8a7779 specific CPU Hotplug code to make use of
the recently introduced shared SCU functions. The r8a7779
power domain hardware requires special power down handling
at ->kill() time.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7779.c | 41 ++++--------------------------------
 1 file changed, 4 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 1963d0d..c159964 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -122,47 +122,14 @@ static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
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
@@ -174,8 +141,8 @@ struct smp_operations r8a7779_smp_ops  __initdata = {
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
-- 
1.8.3.2
