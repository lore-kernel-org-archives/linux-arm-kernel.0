From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:00 +0100
Subject: [PATCH 47/69] clocksource/drivers/h8300_timer8: Retrieve the clock
 rate at init time
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-47-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code retrieves the rate value when the timer is enabled which
occurs each time a timer is re-armed. Except if the clock frequency has changed
magically I don't see why this should be done each time.

Retrieve the clock rate value at init time only.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer8.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 24d91b1..187c416 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -34,7 +34,6 @@ struct timer8_priv {
 	unsigned long flags;
 	unsigned int rate;
 	unsigned int tcora;
-	struct clk *pclk;
 };
 
 static unsigned long timer8_get_counter(struct timer8_priv *p)
@@ -92,7 +91,6 @@ static void timer8_set_next(struct timer8_priv *p, unsigned long delta)
 
 static int timer8_enable(struct timer8_priv *p)
 {
-	p->rate = clk_get_rate(p->pclk) / SCALE;
 	ctrl_outw(0xffff, p->mapbase + TCORA);
 	ctrl_outw(0x0000, p->mapbase + _8TCNT);
 	ctrl_outw(0x0c02, p->mapbase + _8TCR);
@@ -102,16 +100,15 @@ static int timer8_enable(struct timer8_priv *p)
 
 static int timer8_start(struct timer8_priv *p)
 {
-	int ret = 0;
+	int ret;
 
-	if (!(p->flags & FLAG_STARTED))
-		ret = timer8_enable(p);
+	if ((p->flags & FLAG_STARTED))
+		return 0;
 
-	if (ret)
-		goto out;
-	p->flags |= FLAG_STARTED;
+	ret = timer8_enable(p);
+	if (!ret)
+		p->flags |= FLAG_STARTED;
 
- out:
 	return ret;
 }
 
@@ -217,7 +214,12 @@ static void __init h8300_8timer_init(struct device_node *node)
 	}
 
 	timer8_priv.mapbase = (unsigned long)base;
-	timer8_priv.pclk = clk;
+
+	rate = clk_get_rate(clk) / SCALE;
+	if (!rate) {
+		pr_err("Failed to get rate for the clocksource\n");
+		goto unmap_reg;
+	}
 
 	ret = request_irq(irq, timer8_interrupt,
 			  IRQF_TIMER, timer8_priv.ced.name, &timer8_priv);
@@ -225,10 +227,10 @@ static void __init h8300_8timer_init(struct device_node *node)
 		pr_err("failed to request irq %d for clockevent\n", irq);
 		goto unmap_reg;
 	}
-	rate = clk_get_rate(clk) / SCALE;
+
 	clockevents_config_and_register(&timer8_priv.ced, rate, 1, 0x0000ffff);
-	return;
 
+	return;
 unmap_reg:
 	iounmap(base);
 free_clk:
-- 
1.9.1
