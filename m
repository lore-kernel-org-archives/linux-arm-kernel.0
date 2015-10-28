From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 28 Oct 2015 14:11:29 +0100
Subject: [PATCH 4/8] clocksource/drivers/prima2: Prevent ftrace recursion
In-Reply-To: <1446037894-22601-1-git-send-email-daniel.lezcano@linaro.org>
References: <5630C947.4020706@linaro.org>
 <1446037894-22601-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1446037894-22601-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>

Currently prima2 timer can be used as a scheduler clock. We properly
marked sirfsoc_read_sched_clock() as notrace but we then call another
function sirfsoc_timer_read() that _wasn't_ notrace.

Having a traceable function in the sched_clock() path leads to a recursion
within ftrace and a kernel crash.

Fix this by adding notrace attribute to the sirfsoc_timer_read() function.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-prima2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index 78de982..2854c66 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -73,7 +73,7 @@ static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
 }
 
 /* read 64-bit timer counter */
-static cycle_t sirfsoc_timer_read(struct clocksource *cs)
+static cycle_t notrace sirfsoc_timer_read(struct clocksource *cs)
 {
 	u64 cycles;
 
-- 
1.9.1
