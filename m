From: khilman@ti.com (Kevin Hilman)
Date: Wed, 7 Sep 2011 12:04:44 -0700
Subject: [PATCH 1/2] OMAP2/3: PM: trigger CPU PM notifiers in idle and
 suspend path
Message-ID: <mailman.122.1315504676.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add calls to CPU PM notifier core in the idle and suspend paths
so any CPU PM notifiers are properly called.

[add more description about the need to trigger notifiers only after
 next power states are programmed.]

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c |    5 +++++
 arch/arm/mach-omap2/pm34xx.c |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index bf089e7..9f7e551 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/gpio.h>
 #include <linux/console.h>
+#include <linux/cpu_pm.h>
 
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
@@ -142,11 +143,15 @@ static void omap2_enter_full_retention(void)
 	omap_uart_prepare_idle(1);
 	omap_uart_prepare_idle(2);
 
+	cpu_pm_enter();
+
 	/* Jump to SRAM suspend code */
 	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_POWER));
 
+	cpu_pm_exit();
+
 	omap_uart_resume_idle(2);
 	omap_uart_resume_idle(1);
 	omap_uart_resume_idle(0);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..b167c7f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/console.h>
+#include <linux/cpu_pm.h>
 #include <trace/events/power.h>
 
 #include <asm/suspend.h>
@@ -386,6 +387,8 @@ void omap_sram_idle(void)
 			if (!console_trylock())
 				goto console_still_active;
 
+	cpu_pm_enter();
+
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
@@ -465,6 +468,8 @@ void omap_sram_idle(void)
 		omap_uart_resume_idle(3);
 	}
 
+	cpu_pm_exit();
+
 	if (!is_suspending())
 		console_unlock();
 
-- 
1.7.6
