From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 Nov 2012 12:10:09 +0900
Subject: [PATCH 1/4] Revert "ARM: shmobile: emev2: Replace modify_scu_cpu_psr
 with scu_power_mode"
In-Reply-To: <1352776212-3211-1-git-send-email-horms@verge.net.au>
References: <1352776212-3211-1-git-send-email-horms@verge.net.au>
Message-ID: <1352776212-3211-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 865d90f80384d62e6fbe835159cb674dec32ccb5.

The code changes the flags of the wrong cpus - which breaks the whole
bootup of secondary CPUs.

Cc: Bastian Hecht <hechtb@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/smp-emev2.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 535426c..f674562 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -32,8 +32,24 @@
 
 #define EMEV2_SCU_BASE 0x1e000000
 
+static DEFINE_SPINLOCK(scu_lock);
 static void __iomem *scu_base;
 
+static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
+{
+	unsigned long tmp;
+
+	/* we assume this code is running on a different cpu
+	 * than the one that is changing coherency setting */
+	spin_lock(&scu_lock);
+	tmp = readl(scu_base + 8);
+	tmp &= ~clr;
+	tmp |= set;
+	writel(tmp, scu_base + 8);
+	spin_unlock(&scu_lock);
+
+}
+
 static unsigned int __init emev2_get_core_count(void)
 {
 	if (!scu_base) {
@@ -79,7 +95,7 @@ static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *
 	cpu = cpu_logical_map(cpu);
 
 	/* enable cache coherency */
-	scu_power_mode(scu_base, 0);
+	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 
 	/* Tell ROM loader about our vector (in headsmp.S) */
 	emev2_set_boot_vector(__pa(shmobile_secondary_vector));
@@ -90,10 +106,12 @@ static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *
 
 static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
 {
+	int cpu = cpu_logical_map(0);
+
 	scu_enable(scu_base);
 
 	/* enable cache coherency on CPU0 */
-	scu_power_mode(scu_base, 0);
+	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 }
 
 static void __init emev2_smp_init_cpus(void)
-- 
1.7.10.4
