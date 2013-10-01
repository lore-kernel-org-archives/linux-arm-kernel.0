From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:35:35 +0900
Subject: [PATCH 03/14] ARM: shmobile: Remove unused shmobile_smp_init_cpus()
In-Reply-To: <cover.1380532277.git.horms+renesas@verge.net.au>
References: <cover.1380532277.git.horms+renesas@verge.net.au>
Message-ID: <c4e1e64d2b6a921a57629ede635f81f5d2882543.1380532277.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove shmobile_smp_init_cpus() since all SMP platforms in
mach-shmobile now rely on DT for CPU core description instead
of for instance determining number of cores from the SCU.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h |  1 -
 arch/arm/mach-shmobile/platsmp.c             | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 1ed155e..26eaff1 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -40,7 +40,6 @@ static inline int shmobile_cpuidle_init(void) { return 0; }
 #endif
 
 extern void __iomem *shmobile_scu_base;
-extern void shmobile_smp_init_cpus(unsigned int ncores);
 
 static inline void __init shmobile_init_late(void)
 {
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 3741562..9ebc246 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -11,25 +11,10 @@
  * published by the Free Software Foundation.
  */
 #include <linux/init.h>
-#include <linux/smp.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <mach/common.h>
 
-void __init shmobile_smp_init_cpus(unsigned int ncores)
-{
-	unsigned int i;
-
-	if (ncores > nr_cpu_ids) {
-		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
-			ncores, nr_cpu_ids);
-		ncores = nr_cpu_ids;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-}
-
 extern unsigned long shmobile_smp_fn[];
 extern unsigned long shmobile_smp_arg[];
 extern unsigned long shmobile_smp_mpidr[];
-- 
1.8.4
