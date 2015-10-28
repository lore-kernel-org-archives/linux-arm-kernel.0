From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 28 Oct 2015 14:11:32 +0100
Subject: [PATCH 7/8] clocksource/drivers/digicolor: Prevent ftrace recursion
In-Reply-To: <1446037894-22601-1-git-send-email-daniel.lezcano@linaro.org>
References: <5630C947.4020706@linaro.org>
 <1446037894-22601-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1446037894-22601-7-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>

Having a traceable function in the sched_clock() path leads to a recursion
within ftrace and a kernel crash.

We should not trace digicolor_timer_sched_read() function. Fix this by adding
the notrace attribute to this function.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-digicolor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index e73947f0f..a536eeb 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -143,7 +143,7 @@ static irqreturn_t digicolor_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static u64 digicolor_timer_sched_read(void)
+static u64 notrace digicolor_timer_sched_read(void)
 {
 	return ~readl(dc_timer_dev.base + COUNT(TIMER_B));
 }
-- 
1.9.1
