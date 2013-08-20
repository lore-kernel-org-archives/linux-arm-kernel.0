From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 19:31:30 +0200
Subject: [PATCH 03/16] clocksource: samsung_pwm_timer: Get clock from device
 tree
In-Reply-To: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
References: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377019903-14614-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting with device tree static clkdev aliases should not be used.
This patch modifies the samsung_pwm_timer driver to use DT-based clock
lookup when booting with device tree.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index ac60f8b..ab29476 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -368,10 +368,6 @@ static void __init samsung_clocksource_init(void)
 
 static void __init samsung_timer_resources(void)
 {
-	pwm.timerclk = clk_get(NULL, "timers");
-	if (IS_ERR(pwm.timerclk))
-		panic("failed to get timers clock for timer");
-
 	clk_prepare_enable(pwm.timerclk);
 
 	pwm.tcnt_max = (1UL << pwm.variant.bits) - 1;
@@ -416,6 +412,10 @@ void __init samsung_pwm_clocksource_init(void __iomem *base,
 	memcpy(&pwm.variant, variant, sizeof(pwm.variant));
 	memcpy(pwm.irq, irqs, SAMSUNG_PWM_NUM * sizeof(*irqs));
 
+	pwm.timerclk = clk_get(NULL, "timers");
+	if (IS_ERR(pwm.timerclk))
+		panic("failed to get timers clock for timer");
+
 	_samsung_pwm_clocksource_init();
 }
 
@@ -447,6 +447,10 @@ static void __init samsung_pwm_alloc(struct device_node *np,
 		return;
 	}
 
+	pwm.timerclk = of_clk_get_by_name(np, "timers");
+	if (IS_ERR(pwm.timerclk))
+		panic("failed to get timers clock for timer");
+
 	_samsung_pwm_clocksource_init();
 }
 
-- 
1.8.3.2
