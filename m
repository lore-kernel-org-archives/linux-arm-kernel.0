From: robherring2@gmail.com (Rob Herring)
Date: Sun, 30 Dec 2012 10:15:05 -0600
Subject: [PATCH 4/6] ARM: highbank: fix secondary boot and hotplug
In-Reply-To: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
References: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
Message-ID: <1356884107-30991-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With commit 384a290 (ARM: gic: use a private mapping for CPU target
interfaces), wake-up IPIs now go to all cores as the gic cpu interface
numbering may not follow core numbering. This broke secondary boot on
highbank since the boot address was already set for all secondary cores,
this caused all cores to boot before the kernel was ready.

Fix this by moving the setting of the jump address to
highbank_boot_secondary instead of highbank_smp_prepare_cpus and
highbank_cpu_die. Also, clear the address when we boot. This prevents
cores from booting before they are actually triggered and is also necessary
to get suspend/resume to work.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-highbank/hotplug.c |    2 +-
 arch/arm/mach-highbank/platsmp.c |   12 +-----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-highbank/hotplug.c b/arch/arm/mach-highbank/hotplug.c
index 7b60fac..f30c528 100644
--- a/arch/arm/mach-highbank/hotplug.c
+++ b/arch/arm/mach-highbank/hotplug.c
@@ -30,7 +30,7 @@ void __ref highbank_cpu_die(unsigned int cpu)
 {
 	flush_cache_all();
 
-	highbank_set_cpu_jump(cpu, secondary_startup);
+	highbank_set_cpu_jump(cpu, phys_to_virt(0));
 	highbank_set_core_pwr();
 
 	cpu_do_idle();
diff --git a/arch/arm/mach-highbank/platsmp.c b/arch/arm/mach-highbank/platsmp.c
index 1129957..4ecc864 100644
--- a/arch/arm/mach-highbank/platsmp.c
+++ b/arch/arm/mach-highbank/platsmp.c
@@ -32,6 +32,7 @@ static void __cpuinit highbank_secondary_init(unsigned int cpu)
 
 static int __cpuinit highbank_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+	highbank_set_cpu_jump(cpu, secondary_startup);
 	gic_raise_softirq(cpumask_of(cpu), 0);
 	return 0;
 }
@@ -61,19 +62,8 @@ static void __init highbank_smp_init_cpus(void)
 
 static void __init highbank_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
-
 	if (scu_base_addr)
 		scu_enable(scu_base_addr);
-
-	/*
-	 * Write the address of secondary startup into the jump table
-	 * The cores are in wfi and wait until they receive a soft interrupt
-	 * and a non-zero value to jump to. Then the secondary CPU branches
-	 * to this address.
-	 */
-	for (i = 1; i < max_cpus; i++)
-		highbank_set_cpu_jump(i, secondary_startup);
 }
 
 struct smp_operations highbank_smp_ops __initdata = {
-- 
1.7.10.4
