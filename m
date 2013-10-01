From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:35:51 +0900
Subject: [PATCH 12/14] ARM: shmobile: Remove shmobile_smp_scu_boot_secondary()
In-Reply-To: <cover.1380532277.git.horms+renesas@verge.net.au>
References: <cover.1380532277.git.horms+renesas@verge.net.au>
Message-ID: <e4550216ef8245b1c9892239a2121a7b15ac2e91.1380532277.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove shmobile_smp_scu_boot_secondary() since
it is no longer used. CPU boot vector setup is
instead handled by CPU notifiers.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h | 2 --
 arch/arm/mach-shmobile/platsmp-scu.c         | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 3460bb1..e319805 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -18,8 +18,6 @@ extern int shmobile_smp_cpu_disable(unsigned int cpu);
 extern void shmobile_invalidate_start(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
-extern int shmobile_smp_scu_boot_secondary(unsigned int cpu,
-					   struct task_struct *idle);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
 extern int shmobile_smp_scu_cpu_kill(unsigned int cpu);
 extern void shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus);
diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
index 49ae8df..673ad6e 100644
--- a/arch/arm/mach-shmobile/platsmp-scu.c
+++ b/arch/arm/mach-shmobile/platsmp-scu.c
@@ -51,14 +51,6 @@ void __init shmobile_smp_scu_prepare_cpus(unsigned int max_cpus)
 	register_cpu_notifier(&shmobile_smp_scu_notifier);
 }
 
-int shmobile_smp_scu_boot_secondary(unsigned int cpu, struct task_struct *idle)
-{
-	/* For this particular CPU register SCU boot vector */
-	shmobile_smp_hook(cpu, virt_to_phys(shmobile_boot_scu),
-			  (unsigned long)shmobile_scu_base);
-	return 0;
-}
-
 #ifdef CONFIG_HOTPLUG_CPU
 void shmobile_smp_scu_cpu_die(unsigned int cpu)
 {
-- 
1.8.4
