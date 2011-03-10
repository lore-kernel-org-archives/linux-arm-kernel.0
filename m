From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 10 Mar 2011 19:38:03 +0530
Subject: [PATCH v2 07/19] OMAP4: PM: Program CPU1 to hit OFF when off-lined
In-Reply-To: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1299766095-23879-8-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Program non-boot CPUs to hit lowest supported power state
when it is off-lined using cpu hotplug framework.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap-hotplug.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 4976b93..9f8f097 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -20,6 +20,9 @@
 
 #include <asm/cacheflush.h>
 #include <mach/omap4-common.h>
+#include <mach/omap-wakeupgen.h>
+
+#include "powerdomain.h"
 
 int platform_cpu_kill(unsigned int cpu)
 {
@@ -32,6 +35,8 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
+	unsigned int this_cpu;
+
 	flush_cache_all();
 	dsb();
 
@@ -39,18 +44,21 @@ void platform_cpu_die(unsigned int cpu)
 	 * we're ready for shutdown now, so do it
 	 */
 	if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
-		printk(KERN_CRIT "Secure clear status failed\n");
+		pr_err("Secure clear status failed\n");
 
 	for (;;) {
 		/*
-		 * Execute WFI
+		 * Enter into low power state
+		 * clear all interrupt wakeup sources
 		 */
-		do_wfi();
-
-		if (omap_read_auxcoreboot0() == cpu) {
+		omap_wakeupgen_irqmask_all(cpu, 1);
+		omap4_enter_lowpower(cpu, PWRDM_POWER_OFF);
+		this_cpu = hard_smp_processor_id();
+		if (omap_read_auxcoreboot0() == this_cpu) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
+			omap_wakeupgen_irqmask_all(this_cpu, 0);
 			break;
 		}
 		pr_debug("CPU%u: spurious wakeup call\n", cpu);
-- 
1.6.0.4
