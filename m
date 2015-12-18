From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:14 +0100
Subject: [PATCH 61/69] clockevents/drivers/arm_global_timer: Use
 writel_relaxed in gt_compare_set
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-61-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>

Use the relaxed version to improve performance. we measured time of
4096 rounds of gt_compare_set() spent on Marvell BG2Q:

before the patch: 3690648ns on average
after the patch: 1083023ns on average

improved by 70%!

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_global_timer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index a2cb6fa..f99be6b 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -99,17 +99,17 @@ static void gt_compare_set(unsigned long delta, int periodic)
 
 	counter += delta;
 	ctrl = GT_CONTROL_TIMER_ENABLE;
-	writel(ctrl, gt_base + GT_CONTROL);
-	writel(lower_32_bits(counter), gt_base + GT_COMP0);
-	writel(upper_32_bits(counter), gt_base + GT_COMP1);
+	writel_relaxed(ctrl, gt_base + GT_CONTROL);
+	writel_relaxed(lower_32_bits(counter), gt_base + GT_COMP0);
+	writel_relaxed(upper_32_bits(counter), gt_base + GT_COMP1);
 
 	if (periodic) {
-		writel(delta, gt_base + GT_AUTO_INC);
+		writel_relaxed(delta, gt_base + GT_AUTO_INC);
 		ctrl |= GT_CONTROL_AUTO_INC;
 	}
 
 	ctrl |= GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE;
-	writel(ctrl, gt_base + GT_CONTROL);
+	writel_relaxed(ctrl, gt_base + GT_CONTROL);
 }
 
 static int gt_clockevent_shutdown(struct clock_event_device *evt)
-- 
1.9.1
