From: elder@linaro.org (Alex Elder)
Date: Fri, 28 Mar 2014 16:12:56 -0500
Subject: [RFC PATCH 3/7] ARM: realview: use central SMP spin-table routines
In-Reply-To: <1396041180-29897-1-git-send-email-elder@linaro.org>
References: <1396041180-29897-1-git-send-email-elder@linaro.org>
Message-ID: <1396041180-29897-4-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the first of three patches involved replacing the use of smp
operations defined under arch/arm/mach-versatile.  Both realview and
vexpress use the same smp_boot_secondary and smp_secondary_init
functions, and those are equivalent to the common ones now available
in arch/arm/kernel/smp.c.

We can't get rid of the mach-versatile functions yet, so this patch
just switches mach-realview to use the common routines.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/mach-realview/platsmp.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 98e3052..b27dd07 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -21,8 +21,6 @@
 #include <mach/board-pb11mp.h>
 #include <mach/board-pbx.h>
 
-#include <plat/platsmp.h>
-
 #include "core.h"
 
 static void __iomem *scu_base_addr(void)
@@ -71,15 +69,15 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	__raw_writel(virt_to_phys(versatile_secondary_startup),
+	__raw_writel(virt_to_phys(secondary_holding_pen),
 		     __io_address(REALVIEW_SYS_FLAGSSET));
 }
 
 struct smp_operations realview_smp_ops __initdata = {
 	.smp_init_cpus		= realview_smp_init_cpus,
 	.smp_prepare_cpus	= realview_smp_prepare_cpus,
-	.smp_secondary_init	= versatile_secondary_init,
-	.smp_boot_secondary	= versatile_boot_secondary,
+	.smp_secondary_init	= smp_secondary_init,
+	.smp_boot_secondary	= smp_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= realview_cpu_die,
 #endif
-- 
1.7.9.5
