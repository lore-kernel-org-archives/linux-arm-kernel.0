From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 02 Jul 2013 18:28:14 +0900
Subject: [PATCH 06/08] ARM: shmobile: Use DT for SMP on EMEV2 and KZM9D
In-Reply-To: <20130702092725.32066.54861.sendpatchset@w520>
References: <20130702092725.32066.54861.sendpatchset@w520>
Message-ID: <20130702092814.32066.30138.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rework the EMEV2 SMP code to rely on DT for CPU information
instead of reading out number of CPU cores from the SCU.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-emev2.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2013-07-02 15:09:53.000000000 +0900
@@ -38,9 +38,12 @@ static int __cpuinit emev2_boot_secondar
 
 static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
 {
+	/* setup EMEV2 specific SCU base, enable */
+	shmobile_scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
 	scu_enable(shmobile_scu_base);
 
 	/* Tell ROM loader about our vector (in headsmp-scu.S, headsmp.S) */
+	emev2_clock_init(); /* need ioremapped SMU */
 	emev2_set_boot_vector(__pa(shmobile_boot_vector));
 	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
 	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
@@ -49,21 +52,7 @@ static void __init emev2_smp_prepare_cpu
 	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
 }
 
-static void __init emev2_smp_init_cpus(void)
-{
-	unsigned int ncores;
-
-	/* setup EMEV2 specific SCU base */
-	shmobile_scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
-	emev2_clock_init(); /* need ioremapped SMU */
-
-	ncores = shmobile_scu_base ? scu_get_core_count(shmobile_scu_base) : 1;
-
-	shmobile_smp_init_cpus(ncores);
-}
-
 struct smp_operations emev2_smp_ops __initdata = {
-	.smp_init_cpus		= emev2_smp_init_cpus,
 	.smp_prepare_cpus	= emev2_smp_prepare_cpus,
 	.smp_boot_secondary	= emev2_boot_secondary,
 };
