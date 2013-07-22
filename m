From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 16:36:18 +0900
Subject: [PATCH 06/11] ARM: shmobile: Use DT for SMP on EMEV2 and KZM9D
In-Reply-To: <cover.1374478037.git.horms+renesas@verge.net.au>
References: <cover.1374478037.git.horms+renesas@verge.net.au>
Message-ID: <683101a66203149da96e93fb8c0740c726bc114f.1374478037.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rework the EMEV2 SMP code to rely on DT for CPU information
instead of reading out number of CPU cores from the SCU.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-emev2.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 80991b3..9787165 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -38,9 +38,12 @@ static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *
 
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
@@ -49,21 +52,7 @@ static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
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
-- 
1.8.2.1
