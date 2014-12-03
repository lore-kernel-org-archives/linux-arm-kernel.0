From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 3 Dec 2014 14:43:06 -0500 (EST)
Subject: [PATCH] optimize ktime_divns for constant divisors
Message-ID: <alpine.LFD.2.11.1412031424150.470@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least on ARM, do_div() is optimized to turn constant divisors into
an inline multiplication by the reciprocal value at compile time. 
However this optimization is missed entirely whenever ktime_divns() is
used and the slow out-of-line division code is used all the time.

Let ktime_divns() use do_div() inline whenever the divisor is constant
and small enough.  This will make things like ktime_to_us() and 
ktime_to_ms() much faster.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index c9d645ad98..411dd8bfe5 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -166,7 +166,17 @@ static inline bool ktime_before(const ktime_t cmp1, const ktime_t cmp2)
 }
 
 #if BITS_PER_LONG < 64
-extern u64 ktime_divns(const ktime_t kt, s64 div);
+extern u64 __ktime_divns(const ktime_t kt, s64 div);
+static inline u64 ktime_divns(const ktime_t kt, s64 div)
+{
+	if (__builtin_constant_p(div) && !(div >> 32)) {
+		u64 ns = kt.tv64;
+		do_div(ns, div);
+		return ns;
+	} else {
+		return __ktime_divns(kt, div);
+	}
+}
 #else /* BITS_PER_LONG < 64 */
 # define ktime_divns(kt, div)		(u64)((kt).tv64 / (div))
 #endif
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 37e50aadd4..890535c41c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -266,7 +266,7 @@ lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 /*
  * Divide a ktime value by a nanosecond value
  */
-u64 ktime_divns(const ktime_t kt, s64 div)
+u64 __ktime_divns(const ktime_t kt, s64 div)
 {
 	u64 dclc;
 	int sft = 0;
@@ -282,7 +282,7 @@ u64 ktime_divns(const ktime_t kt, s64 div)
 
 	return dclc;
 }
-EXPORT_SYMBOL_GPL(ktime_divns);
+EXPORT_SYMBOL_GPL(__ktime_divns);
 #endif /* BITS_PER_LONG >= 64 */
 
 /*
