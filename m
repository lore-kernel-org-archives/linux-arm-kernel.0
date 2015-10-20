From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 20 Oct 2015 16:02:37 +0800
Subject: [PATCH 4/7] clocksource: prima2: fix ftrace
In-Reply-To: <1445328160-402-1-git-send-email-jszhang@marvell.com>
References: <1445328160-402-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445328160-402-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently prima2 timer can be used as a scheduler clock, we properly
marked sirfsoc_read_sched_clock() as notrace. But we then call another
function sirfsoc_timer_read() that _wasn't_ notrace.

This patch fix this by adding notrace attribute to the
sirfsoc_timer_read() function.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
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
2.6.1
