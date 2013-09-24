From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 25 Sep 2013 00:02:39 +0200
Subject: [PATCH] ARM: davinci: convert to clockevents_config_and_register
Message-ID: <1380060159-12008-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clockevents_config_and_register is superior compared to setting
shift/mult and {min,max}_delta_ns by hand.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I wonder where the 50 us limit comes from. This is not a hardware limit,
is it?

Best regards
Uwe

 arch/arm/mach-davinci/time.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 7a55b5c..627bf8b 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -331,7 +331,6 @@ static void davinci_set_mode(enum clock_event_mode mode,
 
 static struct clock_event_device clockevent_davinci = {
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.shift		= 32,
 	.set_next_event	= davinci_set_next_event,
 	.set_mode	= davinci_set_mode,
 };
@@ -397,14 +396,11 @@ void __init davinci_timer_init(void)
 
 	/* setup clockevent */
 	clockevent_davinci.name = id_to_name[timers[TID_CLOCKEVENT].id];
-	clockevent_davinci.mult = div_sc(davinci_clock_tick_rate, NSEC_PER_SEC,
-					 clockevent_davinci.shift);
-	clockevent_davinci.max_delta_ns =
-		clockevent_delta2ns(0xfffffffe, &clockevent_davinci);
-	clockevent_davinci.min_delta_ns = 50000; /* 50 usec */
 
 	clockevent_davinci.cpumask = cpumask_of(0);
-	clockevents_register_device(&clockevent_davinci);
+	/* min tick corresponds to 50 usec assuming a 24 MHz clock */
+	clockevents_config_and_register(&clockevent_davinci,
+		davinci_clock_tick_rate, 1200, 0xfffffffe);
 
 	for (i=0; i< ARRAY_SIZE(timers); i++)
 		timer32_config(&timers[i]);
-- 
1.8.4.rc3
