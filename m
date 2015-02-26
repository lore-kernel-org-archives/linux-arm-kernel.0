From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:33 +0900
Subject: [PATCH 4/4] ARM: shmobile: r8a7779: Remove redundant cpu_disable
 implementation
In-Reply-To: <cover.1424931049.git.horms+renesas@verge.net.au>
References: <cover.1424931049.git.horms+renesas@verge.net.au>
Message-ID: <fd9454ab51fa92f43ae5b7a71c42f2ee8417c2a2.1424931049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

By default only the non-boot CPUs can be hotplugged if the
smp_operations structure doesn't have the cpu_disable function
pointer set. r8a7779_cpu_disable() implements the same logic,
only non-boot CPUs can be hotplugged, so it's redundant to
override the default behavior.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7779.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 9fc280e..01f792f 100644
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
2.1.4
