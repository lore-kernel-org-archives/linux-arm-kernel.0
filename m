From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  5 Nov 2013 10:03:19 +0100
Subject: [PATCH] ARM: u300: fix timekeeping when periodic mode is used
In-Reply-To: <20131105083336.GK14892@pengutronix.de>
References: <20131105083336.GK14892@pengutronix.de>
Message-ID: <1383642199-11473-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To determine the value to write to the hardware's timer counter register
the symbol CLOCK_TICK_RATE is used. This value is a dummy value on u300
though. So instead use the clock rate that is used for oneshot mode.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-u300/timer.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 9a5f9fb..5226162 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -184,11 +184,13 @@
 #define U300_TIMER_APP_CRC					(0x100)
 #define U300_TIMER_APP_CRC_CLOCK_REQUEST_ENABLE			(0x00000001)
 
-#define TICKS_PER_JIFFY ((CLOCK_TICK_RATE + (HZ/2)) / HZ)
-#define US_PER_TICK ((1000000 + (HZ/2)) / HZ)
-
 static void __iomem *u300_timer_base;
 
+struct u300_clockevent_data {
+	struct clock_event_device cevd;
+	unsigned ticks_per_jiffy;
+};
+
 /*
  * The u300_set_mode() function is always called first, if we
  * have oneshot timer active, the oneshot scheduling function
@@ -197,6 +199,9 @@ static void __iomem *u300_timer_base;
 static void u300_set_mode(enum clock_event_mode mode,
 			  struct clock_event_device *evt)
 {
+	struct u300_clockevent_data *cevdata =
+		container_of(evt, struct u300_clockevent_data, cevd);
+
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* Disable interrupts on GPT1 */
@@ -209,7 +214,7 @@ static void u300_set_mode(enum clock_event_mode mode,
 		 * Set the periodic mode to a certain number of ticks per
 		 * jiffy.
 		 */
-		writel(TICKS_PER_JIFFY,
+		writel(cevdata->ticks_per_jiffy,
 		       u300_timer_base + U300_TIMER_APP_GPT1TC);
 		/*
 		 * Set continuous mode, so the timer keeps triggering
@@ -305,20 +310,23 @@ static int u300_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-
-/* Use general purpose timer 1 as clock event */
-static struct clock_event_device clockevent_u300_1mhz = {
-	.name		= "GPT1",
-	.rating		= 300, /* Reasonably fast and accurate clock event */
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_next_event	= u300_set_next_event,
-	.set_mode	= u300_set_mode,
+static struct u300_clockevent_data u300_clockevent_data = {
+	/* Use general purpose timer 1 as clock event */
+	.cevd = {
+		.name		= "GPT1",
+		/* Reasonably fast and accurate clock event */
+		.rating		= 300,
+		.features	= CLOCK_EVT_FEAT_PERIODIC |
+			CLOCK_EVT_FEAT_ONESHOT,
+		.set_next_event	= u300_set_next_event,
+		.set_mode	= u300_set_mode,
+	},
 };
 
 /* Clock event timer interrupt handler */
 static irqreturn_t u300_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = &clockevent_u300_1mhz;
+	struct clock_event_device *evt = &u300_clockevent_data.cevd;
 	/* ACK/Clear timer IRQ for the APP GPT1 Timer */
 
 	writel(U300_TIMER_APP_GPT1IA_IRQ_ACK,
@@ -379,6 +387,8 @@ static void __init u300_timer_init_of(struct device_node *np)
 	clk_prepare_enable(clk);
 	rate = clk_get_rate(clk);
 
+	u300_clockevent_data.ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
+
 	setup_sched_clock(u300_read_sched_clock, 32, rate);
 
 	u300_delay_timer.read_current_timer = &u300_read_current_timer;
@@ -428,7 +438,7 @@ static void __init u300_timer_init_of(struct device_node *np)
 		pr_err("timer: failed to initialize U300 clock source\n");
 
 	/* Configure and register the clockevent */
-	clockevents_config_and_register(&clockevent_u300_1mhz, rate,
+	clockevents_config_and_register(&u300_clockevent_data.cevd, rate,
 					1, 0xffffffff);
 
 	/*
-- 
1.8.4.rc3
