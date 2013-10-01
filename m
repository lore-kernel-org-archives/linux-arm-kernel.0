From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  1 Oct 2013 12:57:20 +0200
Subject: [PATCH] RFT: ARM: gemini: convert to GENERIC_CLOCKEVENTS
Message-ID: <1380625040-25912-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the gemini machine to use generic clockevents
by rewriting the timer driver.

Cc: arm at kernel.org
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This is flagged as Request for Testing (RFT) as I have no Gemini
platform. If I do not get help with testing this, the next step
will be a patch series to delete the platform.
---
 arch/arm/Kconfig            |  3 +-
 arch/arm/mach-gemini/time.c | 97 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6..1a903e6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -386,8 +386,9 @@ config ARCH_CLPS711X
 config ARCH_GEMINI
 	bool "Cortina Systems Gemini"
 	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_USES_GETTIMEOFFSET
+	select CLKSRC_MMIO
 	select CPU_FA526
+	select GENERIC_CLOCKEVENTS
 	select NEED_MACH_GPIO_H
 	help
 	  Support for the Cortina Systems Gemini family SoCs
diff --git a/arch/arm/mach-gemini/time.c b/arch/arm/mach-gemini/time.c
index 21dc5a8..0a63c4d 100644
--- a/arch/arm/mach-gemini/time.c
+++ b/arch/arm/mach-gemini/time.c
@@ -13,6 +13,8 @@
 #include <mach/hardware.h>
 #include <mach/global_reg.h>
 #include <asm/mach/time.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
 
 /*
  * Register definitions for the timers
@@ -33,19 +35,89 @@
 #define TIMER_3_CR_CLOCK		(1 << 7)
 #define TIMER_3_CR_INT			(1 << 8)
 
+static unsigned int tick_rate;
+
+static int gemini_timer_set_next_event(unsigned long cycles,
+				       struct clock_event_device *evt)
+{
+	u32 cr;
+
+	cr = readl(TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+
+	/* This may be overdoing it, feel free to test without this */
+	cr &= ~TIMER_2_CR_ENABLE;
+	cr &= ~TIMER_2_CR_INT;
+	writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+
+	/* Set next event */
+	writel(cycles, TIMER_COUNT(IO_ADDRESS(GEMINI_TIMER2_BASE)));
+	writel(cycles, TIMER_LOAD(IO_ADDRESS(GEMINI_TIMER2_BASE)));
+	cr |= TIMER_2_CR_ENABLE;
+	cr |= TIMER_2_CR_INT;
+	writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+
+	return 0;
+}
+
+static void gemini_timer_set_mode(enum clock_event_mode mode,
+				  struct clock_event_device *evt)
+{
+	u32 period = DIV_ROUND_CLOSEST(tick_rate, HZ);
+	u32 cr;
+
+	switch (mode) {
+        case CLOCK_EVT_MODE_PERIODIC:
+		/* Start the timer */
+		writel(period,
+		       TIMER_COUNT(IO_ADDRESS(GEMINI_TIMER2_BASE)));
+		writel(period,
+		       TIMER_LOAD(IO_ADDRESS(GEMINI_TIMER2_BASE)));
+		cr = readl(TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+		cr |= TIMER_2_CR_ENABLE;
+		cr |= TIMER_2_CR_INT;
+		writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_UNUSED:
+        case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+		/*
+		 * Disable also for oneshot: the set_next() call will
+		 * arm the timer instead.
+		 */
+		cr = readl(TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+		cr &= ~TIMER_2_CR_ENABLE;
+		cr &= ~TIMER_2_CR_INT;
+		writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+		break;
+	default:
+                break;
+	}
+}
+
+/* Use TIMER2 as clock event */
+static struct clock_event_device gemini_clockevent = {
+	.name		= "TIMER2",
+	.rating		= 300, /* Reasonably fast and accurate clock event */
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event	= gemini_timer_set_next_event,
+	.set_mode	= gemini_timer_set_mode,
+};
+
 /*
  * IRQ handler for the timer
  */
 static irqreturn_t gemini_timer_interrupt(int irq, void *dev_id)
 {
-	timer_tick();
+	struct clock_event_device *evt = &gemini_clockevent;
 
+	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
 
 static struct irqaction gemini_timer_irq = {
 	.name		= "Gemini Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.flags		= IRQF_TIMER,
 	.handler	= gemini_timer_interrupt,
 };
 
@@ -54,9 +126,9 @@ static struct irqaction gemini_timer_irq = {
  */
 void __init gemini_timer_init(void)
 {
-	unsigned int tick_rate, reg_v;
+	u32 reg_v;
 
-	reg_v = __raw_readl(IO_ADDRESS(GEMINI_GLOBAL_BASE + GLOBAL_STATUS));
+	reg_v = readl(IO_ADDRESS(GEMINI_GLOBAL_BASE + GLOBAL_STATUS));
 	tick_rate = REG_TO_AHB_SPEED(reg_v) * 1000000;
 
 	printk(KERN_INFO "Bus: %dMHz", tick_rate / 1000000);
@@ -82,8 +154,17 @@ void __init gemini_timer_init(void)
 	 * Make irqs happen for the system timer
 	 */
 	setup_irq(IRQ_TIMER2, &gemini_timer_irq);
-	/* Start the timer */
-	__raw_writel(tick_rate / HZ, TIMER_COUNT(IO_ADDRESS(GEMINI_TIMER2_BASE)));
-	__raw_writel(tick_rate / HZ, TIMER_LOAD(IO_ADDRESS(GEMINI_TIMER2_BASE)));
-	__raw_writel(TIMER_2_CR_ENABLE | TIMER_2_CR_INT, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+
+	/* Enable and use TIMER1 as clock source */
+	writel(0xffffffff, TIMER_COUNT(IO_ADDRESS(GEMINI_TIMER1_BASE)));
+	writel(0xffffffff, TIMER_LOAD(IO_ADDRESS(GEMINI_TIMER1_BASE)));
+	writel(TIMER_1_CR_ENABLE, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+	if (clocksource_mmio_init(TIMER_COUNT(IO_ADDRESS(GEMINI_TIMER1_BASE)),
+				  "TIMER1", tick_rate, 300, 32,
+				  clocksource_mmio_readl_up))
+		pr_err("timer: failed to initialize gemini clock source\n");
+
+	/* Configure and register the clockevent */
+	clockevents_config_and_register(&gemini_clockevent, tick_rate,
+					1, 0xffffffff);
 }
-- 
1.8.3.1
