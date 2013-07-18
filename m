From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:21:14 -0700
Subject: [PATCH v4 01/17] clocksource: Extract max nsec calculation into
 separate function
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374189690-10810-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to calculate the same number in the clocksource code and
the sched_clock code, so extract this code into its own function.
We also drop the min_t and just use min() because the two types
are the same.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 include/linux/clocksource.h |  2 ++
 kernel/time/clocksource.c   | 45 ++++++++++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index dbbf8aa..67301a4 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -292,6 +292,8 @@ extern void clocksource_resume(void);
 extern struct clocksource * __init __weak clocksource_default_clock(void);
 extern void clocksource_mark_unstable(struct clocksource *cs);
 
+extern u64
+clocks_calc_max_nsecs(u32 mult, u32 shift, u32 maxadj, u64 mask);
 extern void
 clocks_calc_mult_shift(u32 *mult, u32 *shift, u32 from, u32 to, u32 minsec);
 
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 50a8736..637a14a 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -537,40 +537,55 @@ static u32 clocksource_max_adjustment(struct clocksource *cs)
 }
 
 /**
- * clocksource_max_deferment - Returns max time the clocksource can be deferred
- * @cs:         Pointer to clocksource
- *
+ * clocks_calc_max_nsecs - Returns maximum nanoseconds that can be converted
+ * @mult:	cycle to nanosecond multiplier
+ * @shift:	cycle to nanosecond divisor (power of two)
+ * @maxadj:	maximum adjustment value to mult (~11%)
+ * @mask:	bitmask for two's complement subtraction of non 64 bit counters
  */
-static u64 clocksource_max_deferment(struct clocksource *cs)
+u64 clocks_calc_max_nsecs(u32 mult, u32 shift, u32 maxadj, u64 mask)
 {
 	u64 max_nsecs, max_cycles;
 
 	/*
 	 * Calculate the maximum number of cycles that we can pass to the
 	 * cyc2ns function without overflowing a 64-bit signed result. The
-	 * maximum number of cycles is equal to ULLONG_MAX/(cs->mult+cs->maxadj)
+	 * maximum number of cycles is equal to ULLONG_MAX/(mult+maxadj)
 	 * which is equivalent to the below.
-	 * max_cycles < (2^63)/(cs->mult + cs->maxadj)
-	 * max_cycles < 2^(log2((2^63)/(cs->mult + cs->maxadj)))
-	 * max_cycles < 2^(log2(2^63) - log2(cs->mult + cs->maxadj))
-	 * max_cycles < 2^(63 - log2(cs->mult + cs->maxadj))
-	 * max_cycles < 1 << (63 - log2(cs->mult + cs->maxadj))
+	 * max_cycles < (2^63)/(mult + maxadj)
+	 * max_cycles < 2^(log2((2^63)/(mult + maxadj)))
+	 * max_cycles < 2^(log2(2^63) - log2(mult + maxadj))
+	 * max_cycles < 2^(63 - log2(mult + maxadj))
+	 * max_cycles < 1 << (63 - log2(mult + maxadj))
 	 * Please note that we add 1 to the result of the log2 to account for
 	 * any rounding errors, ensure the above inequality is satisfied and
 	 * no overflow will occur.
 	 */
-	max_cycles = 1ULL << (63 - (ilog2(cs->mult + cs->maxadj) + 1));
+	max_cycles = 1ULL << (63 - (ilog2(mult + maxadj) + 1));
 
 	/*
 	 * The actual maximum number of cycles we can defer the clocksource is
-	 * determined by the minimum of max_cycles and cs->mask.
+	 * determined by the minimum of max_cycles and mask.
 	 * Note: Here we subtract the maxadj to make sure we don't sleep for
 	 * too long if there's a large negative adjustment.
 	 */
-	max_cycles = min_t(u64, max_cycles, (u64) cs->mask);
-	max_nsecs = clocksource_cyc2ns(max_cycles, cs->mult - cs->maxadj,
-					cs->shift);
+	max_cycles = min(max_cycles, mask);
+	max_nsecs = clocksource_cyc2ns(max_cycles, mult - maxadj, shift);
+
+	return max_nsecs;
+}
+
+/**
+ * clocksource_max_deferment - Returns max time the clocksource can be deferred
+ * @cs:         Pointer to clocksource
+ *
+ */
+static u64 clocksource_max_deferment(struct clocksource *cs)
+{
+	u64 max_nsecs;
 
+	max_nsecs = clocks_calc_max_nsecs(cs->mult, cs->shift, cs->maxadj,
+					  cs->mask);
 	/*
 	 * To ensure that the clocksource does not wrap whilst we are idle,
 	 * limit the time the clocksource can be deferred by 12.5%. Please
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
