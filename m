From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Jun 2013 12:28:48 +0900
Subject: [PATCH] ARM: shmobile: sh7372 build fix for SUSPEND=n && CPU_IDLE=n
Message-ID: <20130617032848.21337.29264.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move the code using cpu_resume() into a function being
wrappend in #ifdef CONFIG_SUSPEND || CONFIG_CPU_IDLE.

This fixes a build error triggered by ap4evb_defconfig.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to renesas-next-20130613

 arch/arm/mach-shmobile/pm-sh7372.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2013-06-17 12:03:18.000000000 +0900
@@ -351,6 +351,9 @@ static void sh7372_enter_a4s_common(int
 
 static void sh7372_pm_setup_smfram(void)
 {
+	/* pass physical address of cpu_resume() to assembly resume code */
+	sh7372_cpu_resume = virt_to_phys(cpu_resume);
+
 	memcpy((void *)SMFRAM, sh7372_resume_core_standby_sysc, 0x100);
 }
 #else
@@ -524,9 +527,6 @@ void __init sh7372_pm_init(void)
 	/* do not convert A3SM, A3SP, A3SG, A4R power down into A4S */
 	__raw_writel(0, PDNSEL);
 
-	/* pass physical address of cpu_resume() to assembly resume code */
-	sh7372_cpu_resume = virt_to_phys(cpu_resume);
-
 	sh7372_pm_setup_smfram();
 
 	sh7372_suspend_init();
