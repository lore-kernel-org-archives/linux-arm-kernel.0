From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 3 Aug 2010 09:37:23 +0200
Subject: [PATCH 2/3] ARM: clock U300 intcon and timer properly
Message-ID: <1280821043-14336-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the quirks to clock the U300 VIC and timer by custom
hooks and moves the control out to the clock framework where it
belongs. This is possible now that clocks are available early.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/clock.c |   19 -------------------
 arch/arm/mach-u300/clock.h |    2 --
 arch/arm/mach-u300/core.c  |    9 ++++++++-
 arch/arm/mach-u300/timer.c |   11 +++++++++--
 4 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-u300/clock.c b/arch/arm/mach-u300/clock.c
index 7836de3..7a94729 100644
--- a/arch/arm/mach-u300/clock.c
+++ b/arch/arm/mach-u300/clock.c
@@ -1315,25 +1315,6 @@ static void __init clk_register(void)
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 }
 
-/*
- * The interrupt controller is enabled before the clock API is registered.
- */
-void u300_enable_intcon_clock(void)
-{
-	clk_enable(&intcon_clk);
-}
-EXPORT_SYMBOL(u300_enable_intcon_clock);
-
-/*
- * The timer is enabled before the clock API is registered.
- */
-void u300_enable_timer_clock(void)
-{
-	clk_enable(&app_timer_clk);
-}
-EXPORT_SYMBOL(u300_enable_timer_clock);
-
-
 #if (defined(CONFIG_DEBUG_FS) && defined(CONFIG_U300_DEBUG))
 /*
  * The following makes it possible to view the status (especially
diff --git a/arch/arm/mach-u300/clock.h b/arch/arm/mach-u300/clock.h
index fc40c32..c34f3ea 100644
--- a/arch/arm/mach-u300/clock.h
+++ b/arch/arm/mach-u300/clock.h
@@ -45,8 +45,6 @@ struct clk {
 	void (*disable) (struct clk *);
 };
 
-void u300_enable_intcon_clock(void);
-void u300_enable_timer_clock(void);
 int u300_clock_init(void);
 
 #endif
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index b189763..ea41c23 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -19,6 +19,8 @@
 #include <linux/amba/bus.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 #include <mach/coh901318.h>
 
 #include <asm/types.h>
@@ -1477,14 +1479,19 @@ static struct platform_device *platform_devs[] __initdata = {
 void __init u300_init_irq(void)
 {
 	u32 mask[2] = {0, 0};
+	struct clk *clk;
 	int i;
 
 	/* initialize clocking early, we want to clock the INTCON */
 	u300_clock_init();
 
+	/* Clock the interrupt controller */
+	clk = clk_get_sys("intcon", NULL);
+	BUG_ON(IS_ERR(clk));
+	clk_enable(clk);
+
 	for (i = 0; i < NR_IRQS; i++)
 		set_bit(i, (unsigned long *) &mask[0]);
-	u300_enable_intcon_clock();
 	vic_init((void __iomem *) U300_INTCON0_VBASE, 0, mask[0], mask[0]);
 	vic_init((void __iomem *) U300_INTCON1_VBASE, 32, mask[1], mask[1]);
 }
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 63db057..16465e3 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -15,6 +15,8 @@
 #include <linux/clocksource.h>
 #include <linux/types.h>
 #include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 
@@ -23,7 +25,6 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
-#include "clock.h"
 
 /*
  * APP side special timer registers
@@ -367,7 +368,13 @@ unsigned long long notrace sched_clock(void)
  */
 static void __init u300_timer_init(void)
 {
-	u300_enable_timer_clock();
+	struct clk *clk;
+
+	/* Clock the interrupt controller */
+	clk = clk_get_sys("apptimer", NULL);
+	BUG_ON(IS_ERR(clk));
+	clk_enable(clk);
+
 	/*
 	 * Disable the "OS" and "DD" timers - these are designed for Symbian!
 	 * Example usage in cnh1601578 cpu subsystem pd_timer_app.c
-- 
1.6.3.3
