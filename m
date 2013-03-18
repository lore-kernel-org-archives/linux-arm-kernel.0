From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:47:07 +0900
Subject: [PATCH 15/43] ARM: shmobile: Update EMEV2 to use scu_power_mode()
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-16-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the SMP code for EMEV2 to make use of the
shared SCU function scu_power_mode() together with
the early setup code in shmobile_secondary_vector_scu.

With this patch in place the secondary CPUs modify the
SCU setting during early boot instead of letting other
CPUs deal with the coherency setting before boot. In
other words, we used to setup coherency before boot
in emev2_boot_secondary() but that bit is now instead
handled by the code in shmobile_secondary_vector_scu.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-emev2.c |   42 +++++++-----------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index bc8e071..8225c16 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -28,27 +28,9 @@
 #include <mach/emev2.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
-#include <asm/cacheflush.h>
 
 #define EMEV2_SCU_BASE 0x1e000000
 
-static DEFINE_SPINLOCK(scu_lock);
-
-static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
-{
-	unsigned long tmp;
-
-	/* we assume this code is running on a different cpu
-	 * than the one that is changing coherency setting */
-	spin_lock(&scu_lock);
-	tmp = readl(shmobile_scu_base + 8);
-	tmp &= ~clr;
-	tmp |= set;
-	writel(tmp, shmobile_scu_base + 8);
-	spin_unlock(&scu_lock);
-
-}
-
 static void __cpuinit emev2_secondary_init(unsigned int cpu)
 {
 	gic_secondary_init(0);
@@ -56,36 +38,28 @@ static void __cpuinit emev2_secondary_init(unsigned int cpu)
 
 static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	cpu = cpu_logical_map(cpu);
-
-	/* enable cache coherency */
-	modify_scu_cpu_psr(0, 3 << (cpu * 8));
-
-	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu_logical_map(cpu)));
 	return 0;
 }
 
 static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int cpu = cpu_logical_map(0);
-
 	scu_enable(shmobile_scu_base);
 
-	/* Tell ROM loader about our vector (in headsmp.S) */
-	emev2_set_boot_vector(__pa(shmobile_secondary_vector));
+	/* Tell ROM loader about our vector (in headsmp-scu.S) */
+	emev2_set_boot_vector(__pa(shmobile_secondary_vector_scu));
 
-	/* enable cache coherency on CPU0 */
-	modify_scu_cpu_psr(0, 3 << (cpu * 8));
+	/* enable cache coherency on booting CPU */
+	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
 }
 
 static void __init emev2_smp_init_cpus(void)
 {
 	unsigned int ncores;
 
-	if (!shmobile_scu_base) {
-		shmobile_scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
-		emev2_clock_init(); /* need ioremapped SMU */
-	}
+	/* setup EMEV2 specific SCU base */
+	shmobile_scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
+	emev2_clock_init(); /* need ioremapped SMU */
 
 	ncores = shmobile_scu_base ? scu_get_core_count(shmobile_scu_base) : 1;
 
-- 
1.7.10.4
