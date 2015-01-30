From: nathan.sullivan@ni.com (Nathan Sullivan)
Date: Fri, 30 Jan 2015 12:40:15 -0600
Subject: [PATCH] clocksource: mark sched_clock_read functions notrace
Message-ID: <1422643216-26673-1-git-send-email-nathan.sullivan@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These functions will be called by ftrace code when function_graph is
used, so mark them notrace to avoid infinite recursion.

Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
---
 drivers/clocksource/arm_arch_timer.c    |    2 +-
 drivers/clocksource/arm_global_timer.c  |    2 +-
 drivers/clocksource/samsung_pwm_timer.c |    2 +-
 drivers/clocksource/timer-prima2.c      |    2 +-
 drivers/clocksource/timer-sun5i.c       |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 095c177..df5af55 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -405,7 +405,7 @@ u32 arch_timer_get_rate(void)
 	return arch_timer_rate;
 }
 
-static u64 arch_counter_get_cntvct_mem(void)
+static u64 notrace arch_counter_get_cntvct_mem(void)
 {
 	u32 vct_lo, vct_hi, tmp_hi;
 
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index e683377..b4e221a 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -60,7 +60,7 @@ static struct clock_event_device __percpu *gt_evt;
  *  different to the 32-bit upper value read previously, go back to step 2.
  *  Otherwise the 64-bit timer counter value is correct.
  */
-static u64 gt_counter_read(void)
+static u64 notrace gt_counter_read(void)
 {
 	u64 counter;
 	u32 lower;
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 5645cfc..09f4ee3 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -310,7 +310,7 @@ static void samsung_clocksource_resume(struct clocksource *cs)
 	samsung_time_start(pwm.source_id, true);
 }
 
-static cycle_t samsung_clocksource_read(struct clocksource *c)
+static cycle_t notrace samsung_clocksource_read(struct clocksource *c)
 {
 	return ~readl_relaxed(pwm.source_reg);
 }
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index ce18d57..4410817 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -73,7 +73,7 @@ static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
 }
 
 /* read 64-bit timer counter */
-static cycle_t sirfsoc_timer_read(struct clocksource *cs)
+static cycle_t notrace sirfsoc_timer_read(struct clocksource *cs)
 {
 	u64 cycles;
 
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 0226844..604b3bf 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -137,7 +137,7 @@ static struct irqaction sun5i_timer_irq = {
 	.dev_id = &sun5i_clockevent,
 };
 
-static u64 sun5i_timer_sched_read(void)
+static u64 notrace sun5i_timer_sched_read(void)
 {
 	return ~readl(timer_base + TIMER_CNTVAL_LO_REG(1));
 }
-- 
1.7.10.4
