From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 12 Jan 2015 00:04:43 +0800
Subject: [PATCH v4] clocksource: marco: rename marco to atlas7
Message-ID: <1420992283-7307-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

marco project is replaced by atlas7 and we should obliterate
its all traces.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 -v4:
 rebase againest Thierry Reding's
 [PATCH] clocksource: sirf: Remove unused variable

 drivers/clocksource/Makefile                       |    2 +-
 .../clocksource/{timer-marco.c => timer-atlas7.c}  |   14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)
 rename drivers/clocksource/{timer-marco.c => timer-atlas7.c} (95%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 94d90b2..306bc47 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
 obj-$(CONFIG_ARCH_CLPS711X)	+= clps711x-timer.o
-obj-$(CONFIG_ARCH_MARCO)	+= timer-marco.o
+obj-$(CONFIG_ARCH_ATLAS7)	+= timer-atlas7.o
 obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
 obj-$(CONFIG_ARCH_PXA)		+= pxa_timer.o
diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-atlas7.c
similarity index 95%
rename from drivers/clocksource/timer-marco.c
rename to drivers/clocksource/timer-atlas7.c
index 3ddb81f..60f9de3 100644
--- a/drivers/clocksource/timer-marco.c
+++ b/drivers/clocksource/timer-atlas7.c
@@ -38,7 +38,7 @@
 
 #define SIRFSOC_TIMER_REG_CNT 6
 
-static unsigned long marco_timer_rate;
+static unsigned long atlas7_timer_rate;
 
 static const u32 sirfsoc_timer_reg_list[SIRFSOC_TIMER_REG_CNT] = {
 	SIRFSOC_TIMER_WATCHDOG_EN,
@@ -195,7 +195,7 @@ static int sirfsoc_local_timer_setup(struct clock_event_device *ce)
 	ce->rating = 200;
 	ce->set_mode = sirfsoc_timer_set_mode;
 	ce->set_next_event = sirfsoc_timer_set_next_event;
-	clockevents_calc_mult_shift(ce, marco_timer_rate, 60);
+	clockevents_calc_mult_shift(ce, atlas7_timer_rate, 60);
 	ce->max_delta_ns = clockevent_delta2ns(-2, ce);
 	ce->min_delta_ns = clockevent_delta2ns(2, ce);
 	ce->cpumask = cpumask_of(cpu);
@@ -255,7 +255,7 @@ static void __init sirfsoc_clockevent_init(void)
 }
 
 /* initialize the kernel jiffy timer source */
-static void __init sirfsoc_marco_timer_init(struct device_node *np)
+static void __init sirfsoc_atlas7_timer_init(struct device_node *np)
 {
 	struct clk *clk;
 
@@ -264,7 +264,7 @@ static void __init sirfsoc_marco_timer_init(struct device_node *np)
 
 	BUG_ON(clk_prepare_enable(clk));
 
-	marco_timer_rate = clk_get_rate(clk);
+	atlas7_timer_rate = clk_get_rate(clk);
 
 	/* timer dividers: 0, not divided */
 	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
@@ -282,7 +282,7 @@ static void __init sirfsoc_marco_timer_init(struct device_node *np)
 	/* Clear all interrupts */
 	writel_relaxed(0xFFFF, sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS);
 
-	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, marco_timer_rate));
+	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, atlas7_timer_rate));
 
 	sirfsoc_clockevent_init();
 }
@@ -301,6 +301,6 @@ static void __init sirfsoc_of_timer_init(struct device_node *np)
 	if (!sirfsoc_timer1_irq.irq)
 		panic("No irq passed for timer1 via DT\n");
 
-	sirfsoc_marco_timer_init(np);
+	sirfsoc_atlas7_timer_init(np);
 }
-CLOCKSOURCE_OF_DECLARE(sirfsoc_marco_timer, "sirf,marco-tick", sirfsoc_of_timer_init );
+CLOCKSOURCE_OF_DECLARE(sirfsoc_atlas7_timer, "sirf,atlas7-tick", sirfsoc_of_timer_init);
-- 
1.7.9.5
