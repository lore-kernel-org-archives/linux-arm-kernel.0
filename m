From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 19 May 2011 15:26:20 +0900
Subject: [PATCH] ARM: mach-shmobile: sh73a0 twd_base fix
Message-ID: <20110519062620.27921.52669.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Fix the case of too late twd_base initialization for SMP
on sh73a0 which bas been broken because sh73a0 specific
smp_prepare_cpu() and percpu_timer_setup() changed order
in the commits:

05c74a6cbcfb416286a947668ba32f63d99fe74a
c413521eb4e2d7ffd5ce432a144708d479054bd3

Without this fix the sh73a0 SMP kernel panics on boot.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-sh73a0.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2011-05-19 14:50:24.000000000 +0900
@@ -59,6 +59,11 @@ unsigned int __init sh73a0_get_core_coun
 {
 	void __iomem *scu_base = scu_base_addr();
 
+#ifdef CONFIG_HAVE_ARM_TWD
+	/* twd_base needs to be initialized before percpu_timer_setup() */
+	twd_base = (void __iomem *)0xf0000600;
+#endif
+
 	return scu_get_core_count(scu_base);
 }
 
@@ -82,10 +87,6 @@ int __cpuinit sh73a0_boot_secondary(unsi
 
 void __init sh73a0_smp_prepare_cpus(void)
 {
-#ifdef CONFIG_HAVE_ARM_TWD
-	twd_base = (void __iomem *)0xf0000600;
-#endif
-
 	scu_enable(scu_base_addr());
 
 	/* Map the reset vector (in headsmp.S) */
