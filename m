From: elder@linaro.org (Alex Elder)
Date: Fri, 28 Mar 2014 16:12:57 -0500
Subject: [RFC PATCH 4/7] ARM: vexpress: use central SMP spin-table routines
In-Reply-To: <1396041180-29897-1-git-send-email-elder@linaro.org>
References: <1396041180-29897-1-git-send-email-elder@linaro.org>
Message-ID: <1396041180-29897-5-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second patch involved replacing the use of smp
operations defined under arch/arm/mach-versatile.  Both realview and
vexpress use the same smp_boot_secondary and smp_secondary_init
functions, and those are equivalent to the common ones now available
in arch/arm/kernel/smp.c.

This converts mach-vexpress to use the common routines.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/mach-vexpress/platsmp.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 993c9ae..1ed4078 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -22,8 +22,6 @@
 
 #include <mach/motherboard.h>
 
-#include <plat/platsmp.h>
-
 #include "core.h"
 
 #if defined(CONFIG_OF)
@@ -193,14 +191,14 @@ static void __init vexpress_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	vexpress_flags_set(virt_to_phys(versatile_secondary_startup));
+	vexpress_flags_set(virt_to_phys(secondary_holding_pen));
 }
 
 struct smp_operations __initdata vexpress_smp_ops = {
 	.smp_init_cpus		= vexpress_smp_init_cpus,
 	.smp_prepare_cpus	= vexpress_smp_prepare_cpus,
-	.smp_secondary_init	= versatile_secondary_init,
-	.smp_boot_secondary	= versatile_boot_secondary,
+	.smp_secondary_init	= smp_secondary_init,
+	.smp_boot_secondary	= smp_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= vexpress_cpu_die,
 #endif
-- 
1.7.9.5
