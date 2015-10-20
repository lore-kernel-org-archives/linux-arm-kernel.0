From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 20 Oct 2015 16:02:35 +0800
Subject: [PATCH 2/7] clocksource: samsung_pwm_timer: fix ftrace
In-Reply-To: <1445328160-402-1-git-send-email-jszhang@marvell.com>
References: <1445328160-402-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445328160-402-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently samsung_pwm_timer can be used as a scheduler clock, we properly
marked samsung_read_sched_clock() as notrace. But we then call another
function samsung_clocksource_read() that _wasn't_ notrace.

This patch fix this by adding notrace attribute to the
samsung_clocksource_read() function.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index bc90e13..9502bc4 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -307,7 +307,7 @@ static void samsung_clocksource_resume(struct clocksource *cs)
 	samsung_time_start(pwm.source_id, true);
 }
 
-static cycle_t samsung_clocksource_read(struct clocksource *c)
+static cycle_t notrace samsung_clocksource_read(struct clocksource *c)
 {
 	return ~readl_relaxed(pwm.source_reg);
 }
-- 
2.6.1
