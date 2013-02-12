From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 13 Feb 2013 00:44:57 +0900
Subject: [PATCH 02/06] ARM: shmobile: Remove partial CPU Hotplug from EMEV2
In-Reply-To: <20130212154438.13067.77359.sendpatchset@w520>
References: <20130212154438.13067.77359.sendpatchset@w520>
Message-ID: <20130212154457.13067.95836.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove partial CPU hotplug support from EMEV2 SMP code.

The upstream EMEV2 SMP support code has no CPU shutdown or
reset ability so we cannot reboot the secondary CPU cores.

Regular SMP operation is however still working as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Tested on KZM9D hardware.

 arch/arm/mach-shmobile/smp-emev2.c |   28 ----------------------------
 1 file changed, 28 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2013-02-12 22:44:23.000000000 +0900
@@ -62,29 +62,6 @@ static unsigned int __init emev2_get_cor
 	return scu_base ? scu_get_core_count(scu_base) : 1;
 }
 
-static int emev2_platform_cpu_kill(unsigned int cpu)
-{
-	return 0; /* not supported yet */
-}
-
-static int __maybe_unused emev2_cpu_kill(unsigned int cpu)
-{
-	int k;
-
-	/* this function is running on another CPU than the offline target,
-	 * here we need wait for shutdown code in platform_cpu_die() to
-	 * finish before asking SoC-specific code to power off the CPU core.
-	 */
-	for (k = 0; k < 1000; k++) {
-		if (shmobile_cpu_is_dead(cpu))
-			return emev2_platform_cpu_kill(cpu);
-		mdelay(1);
-	}
-
-	return 0;
-}
-
-
 static void __cpuinit emev2_secondary_init(unsigned int cpu)
 {
 	gic_secondary_init(0);
@@ -126,9 +103,4 @@ struct smp_operations emev2_smp_ops __in
 	.smp_prepare_cpus	= emev2_smp_prepare_cpus,
 	.smp_secondary_init	= emev2_secondary_init,
 	.smp_boot_secondary	= emev2_boot_secondary,
-#ifdef CONFIG_HOTPLUG_CPU
-	.cpu_kill		= emev2_cpu_kill,
-	.cpu_die		= shmobile_cpu_die,
-	.cpu_disable		= shmobile_cpu_disable,
-#endif
 };
