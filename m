From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:39 +0900
Subject: [PATCH 29/43] ARM: shmobile: Update r8a7779 to use scu_power_mode()
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-30-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the SMP code for R8A7779 to make use of the
shared SCU function scu_power_mode() together with
the early setup code in shmobile_secondary_vector_scu.

With this patch in place the secondary CPUs modify the
SCU setting during early boot instead of letting other
CPUs deal with the coherency setting before boot. In
other words, we used to setup coherency before boot
in r8a7779_boot_secondary() but that bit is now instead
handled by the code in shmobile_secondary_vector_scu.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7779.c |   32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 63c8db9..bdd3809 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -58,9 +58,6 @@ static struct r8a7779_pm_ch *r8a7779_ch_cpu[4] = {
 	[3] = &r8a7779_ch_cpu3,
 };
 
-static DEFINE_SPINLOCK(scu_lock);
-static unsigned long tmp;
-
 #ifdef CONFIG_HAVE_ARM_TWD
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, R8A7779_SCU_BASE + 0x600, 29);
 void __init r8a7779_register_twd(void)
@@ -79,20 +76,6 @@ static int r8a7779_scu_psr_core_disabled(int cpu)
 	return 0;
 }
 
-static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
-{
-	void __iomem *scu_base = shmobile_scu_base;
-
-	spin_lock(&scu_lock);
-	tmp = __raw_readl(scu_base + 8);
-	tmp &= ~clr;
-	tmp |= set;
-	spin_unlock(&scu_lock);
-
-	/* disable cache coherency after releasing the lock */
-	__raw_writel(tmp, scu_base + 8);
-}
-
 static int r8a7779_platform_cpu_kill(unsigned int cpu)
 {
 	struct r8a7779_pm_ch *ch = NULL;
@@ -133,7 +116,7 @@ static void __maybe_unused r8a7779_cpu_die(unsigned int cpu)
 	flush_cache_all();
 
 	/* disable cache coherency */
-	modify_scu_cpu_psr(3 << (cpu * 8), 0);
+	scu_power_mode(shmobile_scu_base, SCU_PM_POWEROFF);
 
 	/* Endless loop until power off from r8a7779_cpu_kill() */
 	while (1)
@@ -158,9 +141,6 @@ static int __cpuinit r8a7779_boot_secondary(unsigned int cpu, struct task_struct
 
 	cpu = cpu_logical_map(cpu);
 
-	/* enable cache coherency */
-	modify_scu_cpu_psr(0, 3 << (cpu * 8));
-
 	if (cpu < ARRAY_SIZE(r8a7779_ch_cpu))
 		ch = r8a7779_ch_cpu[cpu];
 
@@ -172,15 +152,13 @@ static int __cpuinit r8a7779_boot_secondary(unsigned int cpu, struct task_struct
 
 static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int cpu = cpu_logical_map(0);
-
 	scu_enable(shmobile_scu_base);
 
-	/* Map the reset vector (in headsmp.S) */
-	__raw_writel(__pa(shmobile_secondary_vector), AVECR);
+	/* Map the reset vector (in headsmp-scu.S) */
+	__raw_writel(__pa(shmobile_secondary_vector_scu), AVECR);
 
-	/* enable cache coherency on CPU0 */
-	modify_scu_cpu_psr(0, 3 << (cpu * 8));
+	/* enable cache coherency on booting CPU */
+	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
 
 	r8a7779_pm_init();
 
-- 
1.7.10.4
