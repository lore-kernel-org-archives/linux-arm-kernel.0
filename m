From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Aug 2012 18:37:58 +0200
Subject: [PATCH] ARM: clps711x: convert to clocksource/clockevents
Message-ID: <1346344678-18248-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the ageing clps711x timer driver to the modern
clocksource/clockevent API.

This was blind-coded using the datasheet, it'd be great if someone
who has this machine could test it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                |    3 +-
 arch/arm/mach-clps711x/common.c |   59 +++++++++++++++++++++++++++++---------
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 181b697..8a3da9e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -383,8 +383,9 @@ config ARCH_HIGHBANK
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select CPU_ARM720T
-	select ARCH_USES_GETTIMEOFFSET
 	select NEED_MACH_MEMORY_H
+	select GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
 	help
 	  Support for Cirrus Logic 711x/721x/731x based boards.
 
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index f15293b..850697f 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -26,6 +26,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/sched.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
 
 #include <asm/sizes.h>
 #include <mach/hardware.h>
@@ -157,25 +159,42 @@ void __init clps711x_init_irq(void)
 	clps_writel(0, KBDEOI);
 }
 
-/*
- * gettimeoffset() returns time since last timer tick, in usecs.
- *
- * 'LATCH' is hwclock ticks (see CLOCK_TICK_RATE in timex.h) per jiffy.
- * 'tick' is usecs per jiffy.
- */
-static unsigned long clps711x_gettimeoffset(void)
+static void clps711x_set_mode(enum clock_event_mode mode,
+			  struct clock_event_device *evt)
 {
-	unsigned long hwticks;
-	hwticks = LATCH - (clps_readl(TC2D) & 0xffff);	/* since last underflow */
-	return (hwticks * (tick_nsec / 1000)) / LATCH;
+	u32 syscon;
+	u32 period = DIV_ROUND_CLOSEST(512000, HZ);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+	case CLOCK_EVT_MODE_RESUME:
+		/* Go into prescaler mode, program frequency */
+		syscon = clps_readl(SYSCON1);
+		syscon |= SYSCON1_TC2M;
+		clps_writel(syscon, SYSCON1);
+		clps_writel(period, TC2D);
+		break;
+	default:
+		break;
+	}
 }
 
+static struct clock_event_device clockevent_clps711x = {
+	.name		= "clps711x_tc2d",
+	.rating		= 300,
+	/* Only support periodic mode */
+	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.set_mode	= clps711x_set_mode,
+};
+
 /*
  * IRQ handler for the timer
  */
 static irqreturn_t p720t_timer_interrupt(int irq, void *dev_id)
 {
-	timer_tick();
+	struct clock_event_device *evt = &clockevent_clps711x;
+
+	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
 
@@ -190,17 +209,29 @@ static void __init clps711x_timer_init(void)
 	unsigned int syscon;
 
 	syscon = clps_readl(SYSCON1);
-	syscon |= SYSCON1_TC2S | SYSCON1_TC2M;
+	/* Timer 1 in free running mode */
+	syscon &= ~(SYSCON1_TC1M);
+	/* Timer 2 in prescale mode */
+	syscon |= SYSCON1_TC2M;
+	/* Set both timers to 512 kHz */
+	syscon |= (SYSCON1_TC1S | SYSCON1_TC2S);
 	clps_writel(syscon, SYSCON1);
 
-	clps_writel(LATCH-1, TC2D); /* 512kHz / 100Hz - 1 */
+	/* Start timer 1 in free running mode */
+	clps_writel(0xFFFFU, TC1D);
+	if (clocksource_mmio_init(CLPS711X_VIRT_BASE + TC1D,
+			"clps711x_tc1d", 512000, 300, 16,
+			clocksource_mmio_readl_down))
+		pr_err("timer: failed to initialize clps711x clock source\n");
 
+	/* Configure and register the clockevent */
+	clockevents_config_and_register(&clockevent_clps711x, 512000,
+					1, 0xFFFFU);
 	setup_irq(IRQ_TC2OI, &clps711x_timer_irq);
 }
 
 struct sys_timer clps711x_timer = {
 	.init		= clps711x_timer_init,
-	.offset		= clps711x_gettimeoffset,
 };
 
 void clps711x_restart(char mode, const char *cmd)
-- 
1.7.7.6
