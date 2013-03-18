From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:41 +0900
Subject: [PATCH 31/43] ARM: shmobile: Rearrange r8a7779 cpu hotplug code
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-32-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the r8a7779 SMP code and CPU Hotplug in particular
to follow the same style as sh73a0. This means dropping
__maybe_unused for #ifdef CONFIG_HOTPLUG_CPU.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7779.c |   96 +++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index bdd3809..ea4535a 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -66,16 +66,6 @@ void __init r8a7779_register_twd(void)
 }
 #endif
 
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
 static int r8a7779_platform_cpu_kill(unsigned int cpu)
 {
 	struct r8a7779_pm_ch *ch = NULL;
@@ -92,43 +82,6 @@ static int r8a7779_platform_cpu_kill(unsigned int cpu)
 	return ret ? ret : 1;
 }
 
-static int __maybe_unused r8a7779_cpu_kill(unsigned int cpu)
-{
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
-
-	return 0;
-}
-
-static void __maybe_unused r8a7779_cpu_die(unsigned int cpu)
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
-static int __maybe_unused r8a7779_cpu_disable(unsigned int cpu)
-{
-	/* only CPU1->3 have power domains, do not allow hotplug of CPU0 */
-	return cpu == 0 ? -EPERM : 0;
-}
-
 static void __cpuinit r8a7779_secondary_init(unsigned int cpu)
 {
 	gic_secondary_init(0);
@@ -176,6 +129,55 @@ static void __init r8a7779_smp_init_cpus(void)
 	shmobile_smp_init_cpus(scu_get_core_count(shmobile_scu_base));
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int r8a7779_scu_psr_core_disabled(int cpu)
+{
+	unsigned long mask = 3 << (cpu * 8);
+
+	if ((__raw_readl(shmobile_scu_base + 8) & mask) == mask)
+		return 1;
+
+	return 0;
+}
+
+static int r8a7779_cpu_kill(unsigned int cpu)
+{
+	int k;
+
+	/* this function is running on another CPU than the offline target,
+	 * here we need wait for shutdown code in platform_cpu_die() to
+	 * finish before asking SoC-specific code to power off the CPU core.
+	 */
+	for (k = 0; k < 1000; k++) {
+		if (r8a7779_scu_psr_core_disabled(cpu))
+			return r8a7779_platform_cpu_kill(cpu);
+
+		mdelay(1);
+	}
+
+	return 0;
+}
+
+static void r8a7779_cpu_die(unsigned int cpu)
+{
+	dsb();
+	flush_cache_all();
+
+	/* disable cache coherency */
+	scu_power_mode(shmobile_scu_base, SCU_PM_POWEROFF);
+
+	/* Endless loop until power off from r8a7779_cpu_kill() */
+	while (1)
+		cpu_do_idle();
+}
+
+static int r8a7779_cpu_disable(unsigned int cpu)
+{
+	/* only CPU1->3 have power domains, do not allow hotplug of CPU0 */
+	return cpu == 0 ? -EPERM : 0;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 struct smp_operations r8a7779_smp_ops  __initdata = {
 	.smp_init_cpus		= r8a7779_smp_init_cpus,
 	.smp_prepare_cpus	= r8a7779_smp_prepare_cpus,
-- 
1.7.10.4
