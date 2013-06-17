From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 17 Jun 2013 17:12:37 +0900
Subject: [PATCH 04/15] ARM: shmobile: Rework sh7372 sleep code to use
 virt_to_phys()
In-Reply-To: <1371456768-1084-1-git-send-email-horms+renesas@verge.net.au>
References: <1371456768-1084-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371456768-1084-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Instead of having a hard coded virt-to-phys address
conversion code in sleep-sh7372.S, rework the code
to do the conversion in C using virt_to_phys().

This removes the need for PLAT_PHYS_OFFSET which
in turn is needed for ARCH_MULTIPLATFORM.

Signed-off-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: squashed in build fix posted as
 "ARM: shmobile: sh7372 build fix for SUSPEND=n && CPU_IDLE=n"]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/sh7372.h |    2 ++
 arch/arm/mach-shmobile/pm-sh7372.c           |    3 +++
 arch/arm/mach-shmobile/sleep-sh7372.S        |    5 ++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index e882717..854a9f0 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -75,6 +75,8 @@ extern void sh7372_intcs_resume(void);
 extern void sh7372_intca_suspend(void);
 extern void sh7372_intca_resume(void);
 
+extern unsigned long sh7372_cpu_resume;
+
 #ifdef CONFIG_PM
 extern void __init sh7372_init_pm_domains(void);
 #else
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index dec9293..0de75fd 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -351,6 +351,9 @@ static void sh7372_enter_a4s_common(int pllc0_on)
 
 static void sh7372_pm_setup_smfram(void)
 {
+	/* pass physical address of cpu_resume() to assembly resume code */
+	sh7372_cpu_resume = virt_to_phys(cpu_resume);
+
 	memcpy((void *)SMFRAM, sh7372_resume_core_standby_sysc, 0x100);
 }
 #else
diff --git a/arch/arm/mach-shmobile/sleep-sh7372.S b/arch/arm/mach-shmobile/sleep-sh7372.S
index a9df53b..53f4840 100644
--- a/arch/arm/mach-shmobile/sleep-sh7372.S
+++ b/arch/arm/mach-shmobile/sleep-sh7372.S
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
 
-- 
1.7.10.4
