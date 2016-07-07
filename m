From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  7 Jul 2016 10:00:56 +0200
Subject: [PATCH 23/93] clocksource/drivers/bcm2835_timer: Convert init
 function to return error
In-Reply-To: <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
References: <577E0BED.3020608@linaro.org>
 <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467878526-1238-23-git-send-email-daniel.lezcano@linaro.org>
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
Acked-by: Eric Anholt <eric@anholt.net>
---
 drivers/clocksource/bcm2835_timer.c | 40 +++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 6f28229..2dcf896 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -80,19 +80,24 @@ static irqreturn_t bcm2835_time_interrupt(int irq, void *dev_id)
 	}
 }
 
-static void __init bcm2835_timer_init(struct device_node *node)
+static int __init bcm2835_timer_init(struct device_node *node)
 {
 	void __iomem *base;
 	u32 freq;
-	int irq;
+	int irq, ret;
 	struct bcm2835_timer *timer;
 
 	base = of_iomap(node, 0);
-	if (!base)
-		panic("Can't remap registers");
+	if (!base) {
+		pr_err("Can't remap registers");
+		return -ENXIO;
+	}
 
-	if (of_property_read_u32(node, "clock-frequency", &freq))
-		panic("Can't read clock-frequency");
+	ret = of_property_read_u32(node, "clock-frequency", &freq);
+	if (ret) {
+		pr_err("Can't read clock-frequency");
+		return ret;
+	}
 
 	system_clock = base + REG_COUNTER_LO;
 	sched_clock_register(bcm2835_sched_read, 32, freq);
@@ -101,12 +106,16 @@ static void __init bcm2835_timer_init(struct device_node *node)
 		freq, 300, 32, clocksource_mmio_readl_up);
 
 	irq = irq_of_parse_and_map(node, DEFAULT_TIMER);
-	if (irq <= 0)
-		panic("Can't parse IRQ");
+	if (irq <= 0) {
+		pr_err("Can't parse IRQ");
+		return -EINVAL;
+	}
 
 	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
-	if (!timer)
-		panic("Can't allocate timer struct\n");
+	if (!timer) {
+		pr_err("Can't allocate timer struct\n");
+		return -ENOMEM;
+	}
 
 	timer->control = base + REG_CONTROL;
 	timer->compare = base + REG_COMPARE(DEFAULT_TIMER);
@@ -121,12 +130,17 @@ static void __init bcm2835_timer_init(struct device_node *node)
 	timer->act.dev_id = timer;
 	timer->act.handler = bcm2835_time_interrupt;
 
-	if (setup_irq(irq, &timer->act))
-		panic("Can't set up timer IRQ\n");
+	ret = setup_irq(irq, &timer->act);
+	if (ret) {
+		pr_err("Can't set up timer IRQ\n");
+		return ret;
+	}
 
 	clockevents_config_and_register(&timer->evt, freq, 0xf, 0xffffffff);
 
 	pr_info("bcm2835: system timer (irq = %d)\n", irq);
+
+	return 0;
 }
-CLOCKSOURCE_OF_DECLARE(bcm2835, "brcm,bcm2835-system-timer",
+CLOCKSOURCE_OF_DECLARE_RET(bcm2835, "brcm,bcm2835-system-timer",
 			bcm2835_timer_init);
-- 
1.9.1
