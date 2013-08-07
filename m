From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:39:35 +0900
Subject: [GIT PULL 9/9] ARM: shmobile: Per-CPU SMP boot / sleep code for SCU
 SoCs
In-Reply-To: <cover.1375841380.git.horms+renesas@verge.net.au>
References: <cover.1375841380.git.horms+renesas@verge.net.au>
Message-ID: <1d33a354bbb618ba578bb372ebc18fe58457f6f3.1375841380.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Hook in the per-CPU boot and sleep code in the shared
mach-shmobile SCU code. CPUs may be kept in the asm
routine until ->boot_secondary() when the per-CPU
boot vector is installed. At the end of ->die() the
asm sleep routine is invoked.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-scu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
index 7a0c066..c96f501 100644
--- a/arch/arm/mach-shmobile/platsmp-scu.c
+++ b/arch/arm/mach-shmobile/platsmp-scu.c
@@ -18,8 +18,9 @@
 
 void __init shmobile_smp_scu_prepare_cpus(unsigned int max_cpus)
 {
-	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
-	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
+	/* install boot code shared by all CPUs */
+	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
+	shmobile_boot_arg = MPIDR_HWID_BITMASK;
 
 	/* enable SCU and cache coherency on booting CPU */
 	scu_enable(shmobile_scu_base);
@@ -28,22 +29,26 @@ void __init shmobile_smp_scu_prepare_cpus(unsigned int max_cpus)
 
 int shmobile_smp_scu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	/* do nothing for now */
+	/* For this particular CPU register SCU boot vector */
+	shmobile_smp_hook(cpu, virt_to_phys(shmobile_boot_scu),
+			  (unsigned long)shmobile_scu_base);
 	return 0;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 void shmobile_smp_scu_cpu_die(unsigned int cpu)
 {
+	/* For this particular CPU deregister boot vector */
+	shmobile_smp_hook(cpu, 0, 0);
+
 	dsb();
 	flush_cache_all();
 
 	/* disable cache coherency */
 	scu_power_mode(shmobile_scu_base, SCU_PM_POWEROFF);
 
-	/* Endless loop until reset */
-	while (1)
-		cpu_do_idle();
+	/* jump to shared mach-shmobile sleep / reset code */
+	shmobile_smp_sleep();
 }
 
 static int shmobile_smp_scu_psr_core_disabled(int cpu)
-- 
1.8.3.2
