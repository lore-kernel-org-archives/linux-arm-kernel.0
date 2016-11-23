From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 23 Nov 2016 20:29:32 +0300
Subject: [PATCH 4/9] clocksource/drivers/rockchip_timer: move TIMER_INT_UNMASK
 out of rk_timer_enable()
In-Reply-To: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
References: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1479922177-20136-4-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allow to enable timer without enabling interrupts from it.
As that mode will be used in clocksource implementation.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/clocksource/rockchip_timer.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index 2f18166..3b530f9 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -60,8 +60,7 @@ static inline void rk_timer_disable(struct rk_timer *timer)
 
 static inline void rk_timer_enable(struct rk_timer *timer, u32 flags)
 {
-	writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
-		       timer->ctrl);
+	writel_relaxed(TIMER_ENABLE | flags, timer->ctrl);
 }
 
 static void rk_timer_update_counter(unsigned long cycles,
@@ -82,7 +81,7 @@ static inline int rk_timer_set_next_event(unsigned long cycles,
 	struct rk_timer *timer = rk_timer(ce);
 	rk_timer_disable(timer);
 	rk_timer_update_counter(cycles, timer);
-	rk_timer_enable(timer, TIMER_MODE_USER_DEFINED_COUNT);
+	rk_timer_enable(timer, TIMER_MODE_USER_DEFINED_COUNT | TIMER_INT_UNMASK);
 	return 0;
 }
 
@@ -98,7 +97,7 @@ static int rk_timer_set_periodic(struct clock_event_device *ce)
 	struct rk_timer *timer = rk_timer(ce);
 	rk_timer_disable(timer);
 	rk_timer_update_counter(timer->freq / HZ - 1, timer);
-	rk_timer_enable(timer, TIMER_MODE_FREE_RUNNING);
+	rk_timer_enable(timer, TIMER_MODE_FREE_RUNNING | TIMER_INT_UNMASK);
 	return 0;
 }
 
-- 
1.7.9.5
