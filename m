From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 30 May 2011 16:08:20 +0200
Subject: [PATCH 2/2] mach-u300: cleanup clockevent code
Message-ID: <1306764500-28402-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Use the new clockevents_config_and_register() function to register
the U300 clockevent, since that code requires ->cpumask to be set
we set this even on this UP system to please the framework.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/timer.c |   32 ++++++++++++--------------------
 1 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 5e886a4..9a1bebf 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -27,9 +27,6 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
-/* Be able to sleep for atleast 4 seconds (usually more) */
-#define APPTIMER_MIN_RANGE 4
-
 /*
  * APP side special timer registers
  * This timer contains four timers which can fire an interrupt each.
@@ -309,11 +306,11 @@ static int u300_set_next_event(unsigned long cycles,
 
 /* Use general purpose timer 1 as clock event */
 static struct clock_event_device clockevent_u300_1mhz = {
-	.name           = "GPT1",
-	.rating         = 300, /* Reasonably fast and accurate clock event */
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_next_event = u300_set_next_event,
-	.set_mode       = u300_set_mode,
+	.name		= "GPT1",
+	.rating		= 300, /* Reasonably fast and accurate clock event */
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event	= u300_set_next_event,
+	.set_mode	= u300_set_mode,
 };
 
 /* Clock event timer interrupt handler */
@@ -328,9 +325,9 @@ static irqreturn_t u300_timer_interrupt(int irq, void *dev_id)
 }
 
 static struct irqaction u300_timer_irq = {
-	.name           = "U300 Timer Tick",
-	.flags          = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler        = u300_timer_interrupt,
+	.name		= "U300 Timer Tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= u300_timer_interrupt,
 };
 
 /*
@@ -414,16 +411,11 @@ static void __init u300_timer_init(void)
 			"GPT2", rate, 300, 32, clocksource_mmio_readl_up))
 		pr_err("timer: failed to initialize U300 clock source\n");
 
-	clockevents_calc_mult_shift(&clockevent_u300_1mhz,
-				    rate, APPTIMER_MIN_RANGE);
-	/* 32bit counter, so 32bits delta is max */
-	clockevent_u300_1mhz.max_delta_ns =
-		clockevent_delta2ns(0xffffffff, &clockevent_u300_1mhz);
-	/* This timer is slow enough to set for 1 cycle == 1 MHz */
-	clockevent_u300_1mhz.min_delta_ns =
-		clockevent_delta2ns(1, &clockevent_u300_1mhz);
+	/* Configure and register the clockevent */
 	clockevent_u300_1mhz.cpumask = cpumask_of(0);
-	clockevents_register_device(&clockevent_u300_1mhz);
+	clockevents_config_and_register(&clockevent_u300_1mhz, rate,
+					1, 0xffffffff);
+
 	/*
 	 * TODO: init and register the rest of the timers too, they can be
 	 * used by hrtimers!
-- 
1.7.3.2
