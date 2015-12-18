From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:21 +0100
Subject: [PATCH 68/69] clocksource/drivers/h8300: Initializer cleanup.
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-68-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer8.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 1ba453b..9087dd2 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -33,7 +33,6 @@ struct timer8_priv {
 	void __iomem *mapbase;
 	unsigned long flags;
 	unsigned int rate;
-	unsigned int tcora;
 };
 
 static irqreturn_t timer8_interrupt(int irq, void *dev_id)
@@ -163,8 +162,6 @@ static void __init h8300_8timer_init(struct device_node *node)
 {
 	void __iomem *base;
 	int irq;
-	int ret = 0;
-	int rate;
 	struct clk *clk;
 
 	clk = of_clk_get(node, 0);
@@ -187,20 +184,20 @@ static void __init h8300_8timer_init(struct device_node *node)
 
 	timer8_priv.mapbase = base;
 
-	rate = clk_get_rate(clk) / SCALE;
-	if (!rate) {
+	timer8_priv.rate = clk_get_rate(clk) / SCALE;
+	if (!timer8_priv.rate) {
 		pr_err("Failed to get rate for the clocksource\n");
 		goto unmap_reg;
 	}
 
-	ret = request_irq(irq, timer8_interrupt,
-			  IRQF_TIMER, timer8_priv.ced.name, &timer8_priv);
-	if (ret < 0) {
+	if (request_irq(irq, timer8_interrupt, IRQF_TIMER,
+			timer8_priv.ced.name, &timer8_priv) < 0) {
 		pr_err("failed to request irq %d for clockevent\n", irq);
 		goto unmap_reg;
 	}
 
-	clockevents_config_and_register(&timer8_priv.ced, rate, 1, 0x0000ffff);
+	clockevents_config_and_register(&timer8_priv.ced,
+					timer8_priv.rate, 1, 0x0000ffff);
 
 	return;
 unmap_reg:
-- 
1.9.1
