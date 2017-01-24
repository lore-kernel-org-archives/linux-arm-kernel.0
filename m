From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 24 Jan 2017 15:16:41 +0300
Subject: [PATCH v5 6/8] clocksource/drivers/rockchip_timer: low level routines
 take rk_timer as parameter
In-Reply-To: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
References: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1485260203-14216-7-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass rk_timer instead of clock_event_device to low lever timer routines.
So that code could be reused by clocksource implementation.

Drop rk_base() and rk_ctrl().

This is refactoring step without functional changes.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Reviwed-by: Heiko St?bner <heiko@sntech.de>
---
 drivers/clocksource/rockchip_timer.c |   57 ++++++++++++++++------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index 6d68d4c..a17dc61 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -53,70 +53,67 @@ static inline struct rk_timer *rk_timer(struct clock_event_device *ce)
 	return &rk_clock_event_device(ce)->timer;
 }
 
-static inline void __iomem *rk_base(struct clock_event_device *ce)
+static inline void rk_timer_disable(struct rk_timer *timer)
 {
-	return rk_timer(ce)->base;
+	writel_relaxed(TIMER_DISABLE, timer->ctrl);
 }
 
-static inline void __iomem *rk_ctrl(struct clock_event_device *ce)
-{
-	return rk_timer(ce)->ctrl;
-}
-
-static inline void rk_timer_disable(struct clock_event_device *ce)
-{
-	writel_relaxed(TIMER_DISABLE, rk_ctrl(ce));
-}
-
-static inline void rk_timer_enable(struct clock_event_device *ce, u32 flags)
+static inline void rk_timer_enable(struct rk_timer *timer, u32 flags)
 {
 	writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
-		       rk_ctrl(ce));
+		       timer->ctrl);
 }
 
 static void rk_timer_update_counter(unsigned long cycles,
-				    struct clock_event_device *ce)
+				    struct rk_timer *timer)
 {
-	writel_relaxed(cycles, rk_base(ce) + TIMER_LOAD_COUNT0);
-	writel_relaxed(0, rk_base(ce) + TIMER_LOAD_COUNT1);
+	writel_relaxed(cycles, timer->base + TIMER_LOAD_COUNT0);
+	writel_relaxed(0, timer->base + TIMER_LOAD_COUNT1);
 }
 
-static void rk_timer_interrupt_clear(struct clock_event_device *ce)
+static void rk_timer_interrupt_clear(struct rk_timer *timer)
 {
-	writel_relaxed(1, rk_base(ce) + TIMER_INT_STATUS);
+	writel_relaxed(1, timer->base + TIMER_INT_STATUS);
 }
 
 static inline int rk_timer_set_next_event(unsigned long cycles,
 					  struct clock_event_device *ce)
 {
-	rk_timer_disable(ce);
-	rk_timer_update_counter(cycles, ce);
-	rk_timer_enable(ce, TIMER_MODE_USER_DEFINED_COUNT);
+	struct rk_timer *timer = rk_timer(ce);
+
+	rk_timer_disable(timer);
+	rk_timer_update_counter(cycles, timer);
+	rk_timer_enable(timer, TIMER_MODE_USER_DEFINED_COUNT);
 	return 0;
 }
 
 static int rk_timer_shutdown(struct clock_event_device *ce)
 {
-	rk_timer_disable(ce);
+	struct rk_timer *timer = rk_timer(ce);
+
+	rk_timer_disable(timer);
 	return 0;
 }
 
 static int rk_timer_set_periodic(struct clock_event_device *ce)
 {
-	rk_timer_disable(ce);
-	rk_timer_update_counter(rk_timer(ce)->freq / HZ - 1, ce);
-	rk_timer_enable(ce, TIMER_MODE_FREE_RUNNING);
+	struct rk_timer *timer = rk_timer(ce);
+
+	rk_timer_disable(timer);
+	rk_timer_update_counter(timer->freq / HZ - 1, timer);
+	rk_timer_enable(timer, TIMER_MODE_FREE_RUNNING);
 	return 0;
 }
 
 static irqreturn_t rk_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *ce = dev_id;
+	struct rk_timer *timer = rk_timer(ce);
 
-	rk_timer_interrupt_clear(ce);
+	rk_timer_interrupt_clear(timer);
 
 	if (clockevent_state_oneshot(ce))
-		rk_timer_disable(ce);
+		rk_timer_disable(timer);
 
 	ce->event_handler(ce);
 
@@ -183,8 +180,8 @@ static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
 	ce->cpumask = cpu_possible_mask;
 	ce->rating = 250;
 
-	rk_timer_interrupt_clear(ce);
-	rk_timer_disable(ce);
+	rk_timer_interrupt_clear(timer);
+	rk_timer_disable(timer);
 
 	ret = request_irq(irq, rk_timer_interrupt, IRQF_TIMER, TIMER_NAME, ce);
 	if (ret) {
-- 
1.7.9.5
