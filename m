From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 Nov 2012 12:10:11 +0900
Subject: [PATCH 3/4] Revert "ARM: shmobile: r8a7779: Replace
 modify_scu_cpu_psr with scu_power_mode"
In-Reply-To: <1352776212-3211-1-git-send-email-horms@verge.net.au>
References: <1352776212-3211-1-git-send-email-horms@verge.net.au>
Message-ID: <1352776212-3211-4-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit cdc7594e5c5f7509a86b205edeedc58d72dd3999.

The code changes the flags of the wrong cpus - which breaks the whole
bootup of secondary CPUs.

Cc: Bastian Hecht <hechtb@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7779.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 9def0f2..2ce6af9 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -61,6 +61,9 @@ static void __iomem *scu_base_addr(void)
 	return (void __iomem *)0xf0000000;
 }
 
+static DEFINE_SPINLOCK(scu_lock);
+static unsigned long tmp;
+
 #ifdef CONFIG_HAVE_ARM_TWD
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, 0xf0000600, 29);
 
@@ -70,6 +73,20 @@ void __init r8a7779_register_twd(void)
 }
 #endif
 
+static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
+{
+	void __iomem *scu_base = scu_base_addr();
+
+	spin_lock(&scu_lock);
+	tmp = __raw_readl(scu_base + 8);
+	tmp &= ~clr;
+	tmp |= set;
+	spin_unlock(&scu_lock);
+
+	/* disable cache coherency after releasing the lock */
+	__raw_writel(tmp, scu_base + 8);
+}
+
 static unsigned int __init r8a7779_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
@@ -85,7 +102,7 @@ static int r8a7779_platform_cpu_kill(unsigned int cpu)
 	cpu = cpu_logical_map(cpu);
 
 	/* disable cache coherency */
-	scu_power_mode(scu_base_addr(), 3);
+	modify_scu_cpu_psr(3 << (cpu * 8), 0);
 
 	if (cpu < ARRAY_SIZE(r8a7779_ch_cpu))
 		ch = r8a7779_ch_cpu[cpu];
@@ -128,7 +145,7 @@ static int __cpuinit r8a7779_boot_secondary(unsigned int cpu, struct task_struct
 	cpu = cpu_logical_map(cpu);
 
 	/* enable cache coherency */
-	scu_power_mode(scu_base_addr(), 0);
+	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 
 	if (cpu < ARRAY_SIZE(r8a7779_ch_cpu))
 		ch = r8a7779_ch_cpu[cpu];
@@ -141,13 +158,15 @@ static int __cpuinit r8a7779_boot_secondary(unsigned int cpu, struct task_struct
 
 static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 {
+	int cpu = cpu_logical_map(0);
+
 	scu_enable(scu_base_addr());
 
 	/* Map the reset vector (in headsmp.S) */
 	__raw_writel(__pa(shmobile_secondary_vector), AVECR);
 
 	/* enable cache coherency on CPU0 */
-	scu_power_mode(scu_base_addr(), 0);
+	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 
 	r8a7779_pm_init();
 
-- 
1.7.10.4
