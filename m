From: robherring2@gmail.com (Rob Herring)
Date: Fri, 29 Apr 2011 21:08:15 -0500
Subject: [PATCH 08/10] ARM: ux500: use common scu_init_cpus
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
Message-ID: <1304129297-6614-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert ux500 to use common scu_init_cpus function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-ux500/platsmp.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 88f30b8..7b19f9d 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -69,22 +69,7 @@ static void __init wakeup_secondary(void)
  */
 void __init smp_init_cpus(void)
 {
-	void __iomem *scu_base = scu_base_addr();
-	unsigned int i, ncores;
-
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
-
-	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "U8500: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	scu_init_cpus(scu_base_addr());
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
-- 
1.7.1
