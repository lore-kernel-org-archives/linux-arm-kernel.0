From: magnus.damm@gmail.com (Magnus Damm)
Date: Sat, 14 Sep 2013 22:47:02 +0900
Subject: [PATCH 05/05] ARM: shmobile: Remove shmobile_smp_scu_boot_secondary()
In-Reply-To: <20130914134616.19258.27110.sendpatchset@w520>
References: <20130914134616.19258.27110.sendpatchset@w520>
Message-ID: <20130914134702.19258.11610.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove shmobile_smp_scu_boot_secondary() since
it is no longer used. CPU boot vector setup is
instead handled by CPU notifiers.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    2 --
 arch/arm/mach-shmobile/platsmp-scu.c         |    8 --------
 2 files changed, 10 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-09-14 19:38:47.000000000 +0900
@@ -18,8 +18,6 @@ extern int shmobile_smp_cpu_disable(unsi
 extern void shmobile_invalidate_start(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
-extern int shmobile_smp_scu_boot_secondary(unsigned int cpu,
-					   struct task_struct *idle);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
 extern int shmobile_smp_scu_cpu_kill(unsigned int cpu);
 extern void shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus);
--- 0004/arch/arm/mach-shmobile/platsmp-scu.c
+++ work/arch/arm/mach-shmobile/platsmp-scu.c	2013-09-14 19:39:01.000000000 +0900
@@ -59,14 +59,6 @@ void __init shmobile_smp_scu_prepare_cpu
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
