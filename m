From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Feb 2015 16:41:01 -0800
Subject: [PATCH] ARM: shmobile: Remove redundant cpu_disable implementation
Message-ID: <1423874461-2405-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default only the non-boot CPUs can be hotplugged if the
smp_operations structure doesn't have the cpu_disable function
pointer set. r8a7779_cpu_disable() implements the same logic,
only non-boot CPUs can be hotplugged, so it's redundant to
override the default behavior.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-shmobile/smp-r8a7779.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 3f761f839043..b45206f93ddf 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -124,19 +124,12 @@ static int r8a7779_cpu_kill(unsigned int cpu)
 
 	return 0;
 }
-
-static int r8a7779_cpu_disable(unsigned int cpu)
-{
-	/* only CPU1->3 have power domains, do not allow hotplug of CPU0 */
-	return cpu == 0 ? -EPERM : 0;
-}
 #endif /* CONFIG_HOTPLUG_CPU */
 
 struct smp_operations r8a7779_smp_ops  __initdata = {
 	.smp_prepare_cpus	= r8a7779_smp_prepare_cpus,
 	.smp_boot_secondary	= r8a7779_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable		= r8a7779_cpu_disable,
 	.cpu_die		= shmobile_smp_scu_cpu_die,
 	.cpu_kill		= r8a7779_cpu_kill,
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
