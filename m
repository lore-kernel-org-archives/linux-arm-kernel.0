From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:31:08 +0200
Subject: [PATCH 49/92] clocksource/drivers/atlas7: Convert init function to
 return error
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-49-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init functions do not return any error. They behave as the following:

  - panic, thus leading to a kernel crash while another timer may work and
       make the system boot up correctly

  or

  - print an error and let the caller unaware if the state of the system

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-atlas7.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-atlas7.c b/drivers/clocksource/timer-atlas7.c
index 27fa136..7b1a007 100644
--- a/drivers/clocksource/timer-atlas7.c
+++ b/drivers/clocksource/timer-atlas7.c
@@ -238,7 +238,7 @@ static struct notifier_block sirfsoc_cpu_nb = {
 	.notifier_call = sirfsoc_cpu_notify,
 };
 
-static void __init sirfsoc_clockevent_init(void)
+static int __init sirfsoc_clockevent_init(void)
 {
 	sirfsoc_clockevent = alloc_percpu(struct clock_event_device);
 	BUG_ON(!sirfsoc_clockevent);
@@ -246,11 +246,11 @@ static void __init sirfsoc_clockevent_init(void)
 	BUG_ON(register_cpu_notifier(&sirfsoc_cpu_nb));
 
 	/* Immediately configure the timer on the boot CPU */
-	sirfsoc_local_timer_setup(this_cpu_ptr(sirfsoc_clockevent));
+	return sirfsoc_local_timer_setup(this_cpu_ptr(sirfsoc_clockevent));
 }
 
 /* initialize the kernel jiffy timer source */
-static void __init sirfsoc_atlas7_timer_init(struct device_node *np)
+static int __init sirfsoc_atlas7_timer_init(struct device_node *np)
 {
 	struct clk *clk;
 
@@ -279,23 +279,29 @@ static void __init sirfsoc_atlas7_timer_init(struct device_node *np)
 
 	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, atlas7_timer_rate));
 
-	sirfsoc_clockevent_init();
+	return sirfsoc_clockevent_init();
 }
 
-static void __init sirfsoc_of_timer_init(struct device_node *np)
+static int __init sirfsoc_of_timer_init(struct device_node *np)
 {
 	sirfsoc_timer_base = of_iomap(np, 0);
-	if (!sirfsoc_timer_base)
-		panic("unable to map timer cpu registers\n");
+	if (!sirfsoc_timer_base) {
+		pr_err("unable to map timer cpu registers\n");
+		return -ENXIO;
+	}
 
 	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
-	if (!sirfsoc_timer_irq.irq)
-		panic("No irq passed for timer0 via DT\n");
+	if (!sirfsoc_timer_irq.irq) {
+		pr_err("No irq passed for timer0 via DT\n");
+		return -EINVAL;
+	}
 
 	sirfsoc_timer1_irq.irq = irq_of_parse_and_map(np, 1);
-	if (!sirfsoc_timer1_irq.irq)
-		panic("No irq passed for timer1 via DT\n");
+	if (!sirfsoc_timer1_irq.irq) {
+		pr_err("No irq passed for timer1 via DT\n");
+		return -EINVAL;
+	}
 
-	sirfsoc_atlas7_timer_init(np);
+	return sirfsoc_atlas7_timer_init(np);
 }
-CLOCKSOURCE_OF_DECLARE(sirfsoc_atlas7_timer, "sirf,atlas7-tick", sirfsoc_of_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(sirfsoc_atlas7_timer, "sirf,atlas7-tick", sirfsoc_of_timer_init);
-- 
1.9.1
