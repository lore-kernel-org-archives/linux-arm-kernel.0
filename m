From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  7 Jul 2016 10:01:36 +0200
Subject: [PATCH 63/93] clocksource/drivers/vt8500: Convert init function to
 return error
In-Reply-To: <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
References: <577E0BED.3020608@linaro.org>
 <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467878526-1238-63-git-send-email-daniel.lezcano@linaro.org>
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
 drivers/clocksource/vt8500_timer.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index ddb4092..1bc8707 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -121,38 +121,48 @@ static struct irqaction irq = {
 	.dev_id  = &clockevent,
 };
 
-static void __init vt8500_timer_init(struct device_node *np)
+static int __init vt8500_timer_init(struct device_node *np)
 {
-	int timer_irq;
+	int timer_irq, ret;
 
 	regbase = of_iomap(np, 0);
 	if (!regbase) {
 		pr_err("%s: Missing iobase description in Device Tree\n",
 								__func__);
-		return;
+		return -ENXIO;
 	}
+
 	timer_irq = irq_of_parse_and_map(np, 0);
 	if (!timer_irq) {
 		pr_err("%s: Missing irq description in Device Tree\n",
 								__func__);
-		return;
+		return -EINVAL;
 	}
 
 	writel(1, regbase + TIMER_CTRL_VAL);
 	writel(0xf, regbase + TIMER_STATUS_VAL);
 	writel(~0, regbase + TIMER_MATCH_VAL);
 
-	if (clocksource_register_hz(&clocksource, VT8500_TIMER_HZ))
+	ret = clocksource_register_hz(&clocksource, VT8500_TIMER_HZ);
+	if (ret) {
 		pr_err("%s: vt8500_timer_init: clocksource_register failed for %s\n",
-					__func__, clocksource.name);
+		       __func__, clocksource.name);
+		return ret;
+	}
 
 	clockevent.cpumask = cpumask_of(0);
 
-	if (setup_irq(timer_irq, &irq))
+	ret = setup_irq(timer_irq, &irq);
+	if (ret) {
 		pr_err("%s: setup_irq failed for %s\n", __func__,
 							clockevent.name);
+		return ret;
+	}
+
 	clockevents_config_and_register(&clockevent, VT8500_TIMER_HZ,
 					MIN_OSCR_DELTA * 2, 0xf0000000);
+
+	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE(vt8500, "via,vt8500-timer", vt8500_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(vt8500, "via,vt8500-timer", vt8500_timer_init);
-- 
1.9.1
