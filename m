From: salyzyn@android.com (Mark Salyzyn)
Date: Thu, 12 Oct 2017 16:00:08 -0700
Subject: [PATCH v2 5/10] arm: vdso: do calculations outside reader loops
Message-ID: <20171012230012.86812-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In variable timer reading loops, pick up just the values until all
are synchronized, then outside of loop pick up cntvct and perform
calculations to determine final offset, shifted and multiplied
output value.

This replaces get_ns with get_clock_shifted_nsec as cntvct reader.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2: split first CL into 5 of 7 pieces
---
 arch/arm/vdso/vgettimeofday.c | 95 ++++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 28 deletions(-)

diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 71003a1997c4..7fcc8cfcb7df 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -99,28 +99,38 @@ static notrace int do_monotonic_coarse(const struct vdso_data *vd,
 
 #ifdef CONFIG_ARM_ARCH_TIMER
 
-static __always_inline notrace u64 get_ns(const struct vdso_data *vd)
+/*
+ * Returns the clock delta, in nanoseconds left-shifted by the clock
+ * shift.
+ */
+static __always_inline notrace u64 get_clock_shifted_nsec(const u64 cycle_last,
+							  const u32 mult,
+							  const u64 mask)
 {
-	u64 cycle_delta;
-	u64 cycle_now;
-	u64 nsec;
-
-	cycle_now = __arch_counter_get_cntvct();
+	u64 res;
 
-	cycle_delta = (cycle_now - vd->cs_cycle_last) & vd->cs_mask;
+	/* Read the virtual counter. */
+	res = __arch_counter_get_cntvct();
 
-	nsec = (cycle_delta * vd->cs_mono_mult) + vd->xtime_clock_snsec;
-	nsec >>= vd->cs_shift;
+	res = res - cycle_last;
 
-	return nsec;
+	res &= mask;
+	return res * mult;
 }
 
 /* Code size doesn't matter (vdso is 4k/16k/64k anyway) and this is faster. */
 static __always_inline notrace int do_realtime(const struct vdso_data *vd,
 					       struct timespec *ts)
 {
-	u64 nsecs;
-	u32 seq;
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
+	u64 mask;
+#endif
+
+	typeof(((struct vdso_data *)vd)->xtime_clock_sec) sec;
 
 	do {
 		seq = vdso_read_begin(vd);
@@ -128,13 +138,24 @@ static __always_inline notrace int do_realtime(const struct vdso_data *vd,
 		if (vd->use_syscall)
 			return -1;
 
-		ts->tv_sec = vd->xtime_clock_sec;
-		nsecs = get_ns(vd);
+		cycle_last = vd->cs_cycle_last;
 
-	} while (vdso_read_retry(vd, seq));
+		mult = vd->cs_mono_mult;
+		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
+		mask = vd->cs_mask;
+#endif
+
+		sec = vd->xtime_clock_sec;
+		nsec = vd->xtime_clock_snsec;
 
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, nsecs);
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
 
 	return 0;
 }
@@ -142,9 +163,16 @@ static __always_inline notrace int do_realtime(const struct vdso_data *vd,
 static __always_inline notrace int do_monotonic(const struct vdso_data *vd,
 						struct timespec *ts)
 {
-	struct timespec tomono;
-	u64 nsecs;
-	u32 seq;
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
+	u64 mask;
+#endif
+
+	typeof(((struct vdso_data *)vd)->wtm_clock_nsec) wtm_nsec;
+	typeof(ts->tv_sec) sec;
 
 	do {
 		seq = vdso_read_begin(vd);
@@ -152,17 +180,28 @@ static __always_inline notrace int do_monotonic(const struct vdso_data *vd,
 		if (vd->use_syscall)
 			return -1;
 
-		ts->tv_sec = vd->xtime_clock_sec;
-		nsecs = get_ns(vd);
+		cycle_last = vd->cs_cycle_last;
 
-		tomono.tv_sec = vd->wtm_clock_sec;
-		tomono.tv_nsec = vd->wtm_clock_nsec;
+		mult = vd->cs_mono_mult;
+		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
+		mask = vd->cs_mask;
+#endif
 
-	} while (vdso_read_retry(vd, seq));
+		sec = vd->xtime_clock_sec;
+		nsec = vd->xtime_clock_snsec;
 
-	ts->tv_sec += tomono.tv_sec;
-	ts->tv_nsec = 0;
-	timespec_add_ns(ts, nsecs + tomono.tv_nsec);
+		sec += vd->wtm_clock_sec;
+		wtm_nsec = vd->wtm_clock_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	nsec += wtm_nsec;
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
 
 	return 0;
 }
-- 
2.15.0.rc0.271.g36b669edcc-goog
