From: baolin.wang@linaro.org (Baolin Wang)
Date: Mon, 14 May 2018 16:55:36 +0800
Subject: [RFC PATCH 10/10] time: timekeeping: Remove time compensating from
 nonstop clocksources
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Message-ID: <a38362d75aed947756d84976265de5772b3787cb.1526285602.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have converted all nonstop clocksources to use persistent clock,
thus we can simplify the time compensating by removing the nonstop
clocksources. Now we can compensate the suspend time for the OS time from
the persistent clock or rtc device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 kernel/time/timekeeping.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 49cbcee..48d2a80 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1666,7 +1666,6 @@ void timekeeping_inject_sleeptime64(struct timespec64 *delta)
 void timekeeping_resume(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	struct clocksource *clock = tk->tkr_mono.clock;
 	unsigned long flags;
 	struct timespec64 ts_new, ts_delta;
 	u64 cycle_now;
@@ -1682,27 +1681,17 @@ void timekeeping_resume(void)
 
 	/*
 	 * After system resumes, we need to calculate the suspended time and
-	 * compensate it for the OS time. There are 3 sources that could be
-	 * used: Nonstop clocksource during suspend, persistent clock and rtc
-	 * device.
+	 * compensate it for the OS time. There are 2 sources that could be
+	 * used: persistent clock and rtc device.
 	 *
 	 * One specific platform may have 1 or 2 or all of them, and the
 	 * preference will be:
-	 *	suspend-nonstop clocksource -> persistent clock -> rtc
+	 *	persistent clock -> rtc
 	 * The less preferred source will only be tried if there is no better
 	 * usable source. The rtc part is handled separately in rtc core code.
 	 */
 	cycle_now = tk_clock_read(&tk->tkr_mono);
-	if ((clock->flags & CLOCK_SOURCE_SUSPEND_NONSTOP) &&
-		cycle_now > tk->tkr_mono.cycle_last) {
-		u64 nsec, cyc_delta;
-
-		cyc_delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last,
-					      tk->tkr_mono.mask);
-		nsec = mul_u64_u32_shr(cyc_delta, clock->mult, clock->shift);
-		ts_delta = ns_to_timespec64(nsec);
-		sleeptime_injected = true;
-	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
+	if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
 		ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
 		sleeptime_injected = true;
 	}
-- 
1.7.9.5
