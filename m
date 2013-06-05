From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:45:53 +0900
Subject: [PATCH] ARM: shmobile: Rework sh7372 sleep code to use virt_to_phys()
Message-ID: <20130605074553.16962.7736.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Instead of having a hard coded virt-to-phys address
conversion code in sleep-sh7372.S, rework the code
to do the conversion in C using virt_to_phys().

This removes the need for PLAT_PHYS_OFFSET which
in turn is needed for ARCH_MULTIPLATFORM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Tested with A3SM Suspend-to-RAM on Mackerel.

 arch/arm/mach-shmobile/include/mach/sh7372.h |    2 ++
 arch/arm/mach-shmobile/pm-sh7372.c           |    3 +++
 arch/arm/mach-shmobile/sleep-sh7372.S        |    5 ++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2013-06-05 16:40:41.000000000 +0900
@@ -75,6 +75,8 @@ extern void sh7372_intcs_resume(void);
 extern void sh7372_intca_suspend(void);
 extern void sh7372_intca_resume(void);
 
+extern unsigned long sh7372_cpu_resume;
+
 #ifdef CONFIG_PM
 extern void __init sh7372_init_pm_domains(void);
 #else
--- 0001/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2013-06-05 16:40:41.000000000 +0900
@@ -524,6 +524,9 @@ void __init sh7372_pm_init(void)
 	/* do not convert A3SM, A3SP, A3SG, A4R power down into A4S */
 	__raw_writel(0, PDNSEL);
 
+	/* pass physical address of cpu_resume() to assembly resume code */
+	sh7372_cpu_resume = virt_to_phys(cpu_resume);
+
 	sh7372_pm_setup_smfram();
 
 	sh7372_suspend_init();
--- 0001/arch/arm/mach-shmobile/sleep-sh7372.S
+++ work/arch/arm/mach-shmobile/sleep-sh7372.S	2013-06-05 16:41:01.000000000 +0900
@@ -40,7 +40,10 @@
 	.global sh7372_resume_core_standby_sysc
 sh7372_resume_core_standby_sysc:
 	ldr     pc, 1f
-1:	.long   cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
+
+	.globl	sh7372_cpu_resume
+sh7372_cpu_resume:
+1:	.space	4
 
 #define SPDCR 0xe6180008
 
