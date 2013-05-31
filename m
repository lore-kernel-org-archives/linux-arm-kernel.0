From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 22:59:44 +0200
Subject: [PATCH] clocksource: kona: adapt to CLOCKSOURCE_OF_DECLARE change
Message-ID: <3174210.ZivUajNGev@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLOCKSOURCE_OF_DECLARE functions now take a device_node pointer
as their argument, as of the clksrc/cleanup branch in arm-soc.
This patch adapts the bcm_kona_timer driver to the new interface.

This causes an annoying but harmless build-time warning, it would
be nice to have this fixed in 3.10.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Daudt <csd@broadcom.com>
Cc: John Stultz <john.stultz@linaro.org>
---
diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
index 350f493..ba3d859 100644
--- a/drivers/clocksource/bcm_kona_timer.c
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -103,16 +103,10 @@ static const struct of_device_id bcm_timer_ids[] __initconst = {
 	{},
 };
 
-static void __init kona_timers_init(void)
+static void __init kona_timers_init(struct device_node *node)
 {
-	struct device_node *node;
 	u32 freq;
 
-	node = of_find_matching_node(NULL, bcm_timer_ids);
-
-	if (!node)
-		panic("No timer");
-
 	if (!of_property_read_u32(node, "clock-frequency", &freq))
 		arch_timer_rate = freq;
 	else
@@ -199,13 +193,12 @@ static struct irqaction kona_timer_irq = {
 	.handler = kona_timer_interrupt,
 };
 
-static void __init kona_timer_init(void)
+static void __init kona_timer_init(struct device_node *node)
 {
-	kona_timers_init();
+	kona_timers_init(node);
 	kona_timer_clockevents_init();
 	setup_irq(timers.tmr_irq, &kona_timer_irq);
 	kona_timer_set_next_event((arch_timer_rate / HZ), NULL);
 }
 
-CLOCKSOURCE_OF_DECLARE(bcm_kona, "bcm,kona-timer",
-	kona_timer_init);
+CLOCKSOURCE_OF_DECLARE(bcm_kona, "bcm,kona-timer", kona_timer_init);
