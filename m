From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 23 Jul 2013 12:32:43 +0100
Subject: [PATCH 4/5] ARM: highbank: remove redundant smp_init_cpus definition
In-Reply-To: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1374579164-30255-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

arm_dt_init_cpu_maps is called before smp_init_cpus, which sets the
cpu_possible_mask appropriately. Since highbank_smp_init_cpus does
nothing extra, it can be removed.

Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/mach-highbank/platsmp.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/mach-highbank/platsmp.c b/arch/arm/mach-highbank/platsmp.c
index 32d75cf5..25b0bae 100644
--- a/arch/arm/mach-highbank/platsmp.c
+++ b/arch/arm/mach-highbank/platsmp.c
@@ -31,27 +31,6 @@ static int highbank_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system.
- */
-static void __init highbank_smp_init_cpus(void)
-{
-	unsigned int i, ncores = 4;
-
-	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "highbank: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-}
-
 static void __init highbank_smp_prepare_cpus(unsigned int max_cpus)
 {
 	if (scu_base_addr)
@@ -59,7 +38,6 @@ static void __init highbank_smp_prepare_cpus(unsigned int max_cpus)
 }
 
 struct smp_operations highbank_smp_ops __initdata = {
-	.smp_init_cpus		= highbank_smp_init_cpus,
 	.smp_prepare_cpus	= highbank_smp_prepare_cpus,
 	.smp_boot_secondary	= highbank_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.8.1.2
