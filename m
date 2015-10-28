From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 28 Oct 2015 14:11:26 +0100
Subject: [PATCH 1/8] clocksource/drivers/arm_global_timer: Prevent ftrace
 recursion
In-Reply-To: <5630C947.4020706@linaro.org>
References: <5630C947.4020706@linaro.org>
Message-ID: <1446037894-22601-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>

Currently arm_global_timer can be used as a scheduler clock. We properly
marked gt_sched_clock_read() as notrace but we then call another function
gt_counter_read() that _wasn't_ notrace.

Having a traceable function in the sched_clock() path leads to a recursion
within ftrace and a kernel crash.

Fix this by adding an extra notrace function to keep other users of
gt_counter_read() traceable.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_global_timer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 29ea50a..a2cb6fa 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -60,7 +60,7 @@ static struct clock_event_device __percpu *gt_evt;
  *  different to the 32-bit upper value read previously, go back to step 2.
  *  Otherwise the 64-bit timer counter value is correct.
  */
-static u64 gt_counter_read(void)
+static u64 notrace _gt_counter_read(void)
 {
 	u64 counter;
 	u32 lower;
@@ -79,6 +79,11 @@ static u64 gt_counter_read(void)
 	return counter;
 }
 
+static u64 gt_counter_read(void)
+{
+	return _gt_counter_read();
+}
+
 /**
  * To ensure that updates to comparator value register do not set the
  * Interrupt Status Register proceed as follows:
@@ -201,7 +206,7 @@ static struct clocksource gt_clocksource = {
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 static u64 notrace gt_sched_clock_read(void)
 {
-	return gt_counter_read();
+	return _gt_counter_read();
 }
 #endif
 
-- 
1.9.1
