From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:30:51 +0200
Subject: [PATCH 32/92] clocksource/drivers/meson6_timer.c: Convert init
 function to return error
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-32-git-send-email-daniel.lezcano@linaro.org>
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
 drivers/clocksource/meson6_timer.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
index 1fa22c4..3a6e78f 100644
--- a/drivers/clocksource/meson6_timer.c
+++ b/drivers/clocksource/meson6_timer.c
@@ -126,18 +126,22 @@ static struct irqaction meson6_timer_irq = {
 	.dev_id		= &meson6_clockevent,
 };
 
-static void __init meson6_timer_init(struct device_node *node)
+static int __init meson6_timer_init(struct device_node *node)
 {
 	u32 val;
 	int ret, irq;
 
 	timer_base = of_io_request_and_map(node, 0, "meson6-timer");
-	if (IS_ERR(timer_base))
-		panic("Can't map registers");
+	if (IS_ERR(timer_base)) {
+		pr_err("Can't map registers");
+		return -ENXIO;
+	}
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (irq <= 0)
-		panic("Can't parse IRQ");
+	if (irq <= 0) {
+		pr_err("Can't parse IRQ");
+		return -EINVAL;
+	}
 
 	/* Set 1us for timer E */
 	val = readl(timer_base + TIMER_ISA_MUX);
@@ -158,14 +162,17 @@ static void __init meson6_timer_init(struct device_node *node)
 	meson6_clkevt_time_stop(CED_ID);
 
 	ret = setup_irq(irq, &meson6_timer_irq);
-	if (ret)
+	if (ret) {
 		pr_warn("failed to setup irq %d\n", irq);
+		return ret;
+	}
 
 	meson6_clockevent.cpumask = cpu_possible_mask;
 	meson6_clockevent.irq = irq;
 
 	clockevents_config_and_register(&meson6_clockevent, USEC_PER_SEC,
 					1, 0xfffe);
+	return 0;
 }
-CLOCKSOURCE_OF_DECLARE(meson6, "amlogic,meson6-timer",
+CLOCKSOURCE_OF_DECLARE_RET(meson6, "amlogic,meson6-timer",
 		       meson6_timer_init);
-- 
1.9.1
