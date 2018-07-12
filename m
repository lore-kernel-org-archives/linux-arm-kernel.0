From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Thu, 12 Jul 2018 17:48:50 +0200
Subject: [PATCH] ARM: STi: at least warn if of_iomap fails
Message-ID: <1531410530-24163-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The call to of_iomap() is unchecked but scu_enable(), which the returned
address is passed on to, assumes a valid mapping. If the mapping is
invalid this could probably lead to undefined system state so at least
a warning should be issued.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 65ebcc115889 ("ARM: sti: Add STiH415 SOC support")
---
Problem was found by an experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies
CONFIG_ARCH_STI=y, CONFIG_SMP=y)

Patch is against 4.18-rc3 (localversion-next is next-20180712)

 arch/arm/mach-sti/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index 231f19e..89ae76f 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -109,6 +109,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 
 	if (np) {
 		scu_base = of_iomap(np, 0);
+		WARN_ON(!scu_base);
 		scu_enable(scu_base);
 		of_node_put(np);
 	}
-- 
2.1.4
