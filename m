From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:13:49 +0900
Subject: [PATCH 03/05] ARM: shmobile: Remove unused shmobile_smp_init_cpus()
In-Reply-To: <20130807221321.22251.22774.sendpatchset@w520>
References: <20130807221321.22251.22774.sendpatchset@w520>
Message-ID: <20130807221349.22251.44228.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove shmobile_smp_init_cpus() since all SMP platforms in
mach-shmobile now rely on DT for CPU core description instead
of for instance determining number of cores from the SCU.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    1 -
 arch/arm/mach-shmobile/platsmp.c             |   15 ---------------
 2 files changed, 16 deletions(-)

--- 0003/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-08-07 13:42:20.000000000 +0900
@@ -40,7 +40,6 @@ static inline int shmobile_cpuidle_init(
 #endif
 
 extern void __iomem *shmobile_scu_base;
-extern void shmobile_smp_init_cpus(unsigned int ncores);
 
 static inline void __init shmobile_init_late(void)
 {
--- 0003/arch/arm/mach-shmobile/platsmp.c
+++ work/arch/arm/mach-shmobile/platsmp.c	2013-08-07 14:29:34.000000000 +0900
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
