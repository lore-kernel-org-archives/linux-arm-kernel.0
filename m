From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Jun 2016 23:27:01 +0200
Subject: [PATCH V2 42/63] clocksource/drivers/prima2: Convert init function to
 return error
In-Reply-To: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1466112442-31105-43-git-send-email-daniel.lezcano@linaro.org>
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
 drivers/clocksource/timer-prima2.c | 43 ++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index 2854c66..7b1084d 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -189,24 +189,36 @@ static void __init sirfsoc_clockevent_init(void)
 }
 
 /* initialize the kernel jiffy timer source */
-static void __init sirfsoc_prima2_timer_init(struct device_node *np)
+static int __init sirfsoc_prima2_timer_init(struct device_node *np)
 {
 	unsigned long rate;
 	struct clk *clk;
+	int ret;
 
 	clk = of_clk_get(np, 0);
-	BUG_ON(IS_ERR(clk));
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get clock");
+		return PTR_ERR(clk);
+	}
 
-	BUG_ON(clk_prepare_enable(clk));
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("Failed to enable clock");
+		return ret;
+	}
 
 	rate = clk_get_rate(clk);
 
-	BUG_ON(rate < PRIMA2_CLOCK_FREQ);
-	BUG_ON(rate % PRIMA2_CLOCK_FREQ);
+	if (rate < PRIMA2_CLOCK_FREQ || rate % PRIMA2_CLOCK_FREQ) {
+		pr_err("Invalid clock rate");
+		return -EINVAL;
+	}
 
 	sirfsoc_timer_base = of_iomap(np, 0);
-	if (!sirfsoc_timer_base)
-		panic("unable to map timer cpu registers\n");
+	if (!sirfsoc_timer_base) {
+		pr_err("unable to map timer cpu registers\n");
+		return -ENXIO;
+	}
 
 	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
 
@@ -216,14 +228,23 @@ static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
 	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_STATUS);
 
-	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource,
-				       PRIMA2_CLOCK_FREQ));
+	ret = clocksource_register_hz(&sirfsoc_clocksource, PRIMA2_CLOCK_FREQ);
+	if (ret) {
+		pr_err("Failed to register clocksource");
+		return ret;
+	}
 
 	sched_clock_register(sirfsoc_read_sched_clock, 64, PRIMA2_CLOCK_FREQ);
 
-	BUG_ON(setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq));
+	ret = setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq);
+	if (ret) {
+		pr_err("Failed to setup irq");
+		return ret;
+	}
 
 	sirfsoc_clockevent_init();
+
+	return 0;
 }
-CLOCKSOURCE_OF_DECLARE(sirfsoc_prima2_timer,
+CLOCKSOURCE_OF_DECLARE_RET(sirfsoc_prima2_timer,
 	"sirf,prima2-tick", sirfsoc_prima2_timer_init);
-- 
1.9.1
