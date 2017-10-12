From: salyzyn@android.com (Mark Salyzyn)
Date: Thu, 12 Oct 2017 16:00:23 -0700
Subject: [PATCH v2 6/10] arm: vdso: Add support for CLOCK_MONOTONIC_RAW
Message-ID: <20171012230029.86865-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a case for CLOCK_MONOTONIC_RAW to match up with support that
is available in arm64's vdso.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2: split first CL into 6 of 7 pieces
---
 arch/arm/include/asm/vdso_datapage.h |  4 +++
 arch/arm/kernel/vdso.c               |  5 ++++
 arch/arm/vdso/vgettimeofday.c        | 51 ++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso_datapage.h
index fa3e1856244d..d57c296f7f52 100644
--- a/arch/arm/include/asm/vdso_datapage.h
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -46,6 +46,10 @@ struct vdso_data {
 	u64 xtime_clock_snsec;	/* CLOCK_REALTIME sub-ns base */
 	u32 tz_minuteswest;	/* timezone info for gettimeofday(2) */
 	u32 tz_dsttime;
+
+	u32 cs_raw_mult;	/* Raw clocksource multipler */
+	u32 raw_time_sec;	/* Raw time */
+	u32 raw_time_nsec;
 };
 
 union vdso_data_store {
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index aed84b659cc5..7377638a3b00 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -335,9 +335,14 @@ void update_vsyscall(struct timekeeper *tk)
 
 	if (!vdso_data->use_syscall) {
 		vdso_data->cs_cycle_last	= tk->tkr_mono.cycle_last;
+		vdso_data->raw_time_sec		= tk->raw_time.tv_sec;
+		vdso_data->raw_time_nsec	= (tk->raw_time.tv_nsec <<
+						   tk->raw_time.shift) +
+						  tk->tkr_raw.xtime_nsec;
 		vdso_data->xtime_clock_sec	= tk->xtime_sec;
 		vdso_data->xtime_clock_snsec	= tk->tkr_mono.xtime_nsec;
 		vdso_data->cs_mono_mult		= tk->tkr_mono.mult;
+		vdso_data->cs_raw_mult		= tk->tkr_raw.mult;
 		/* tkr_mono.shift == tkr_raw.shift */
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
 		vdso_data->cs_mask		= tk->tkr_mono.mask;
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 7fcc8cfcb7df..b374c143d53e 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -206,6 +206,47 @@ static __always_inline notrace int do_monotonic(const struct vdso_data *vd,
 	return 0;
 }
 
+static __always_inline notrace int do_monotonic_raw(const struct vdso_data *vd,
+						    struct timespec *ts)
+{
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
+	u64 mask;
+#endif
+
+	typeof(((struct vdso_data *)vd)->raw_time_sec) sec;
+
+	do {
+		seq = vdso_read_begin(vd);
+
+		if (vd->use_syscall)
+			return -1;
+
+		cycle_last = vd->cs_cycle_last;
+
+		mult = vd->cs_raw_mult;
+		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
+		mask = vd->cs_mask;
+#endif
+
+		sec = vd->raw_time_sec;
+		nsec = vd->raw_time_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
+
+	return 0;
+}
+
 #else /* CONFIG_ARM_ARCH_TIMER */
 
 static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
@@ -218,6 +259,12 @@ static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 	return -1;
 }
 
+static notrace int do_monotonic_raw(const struct vdso_data *vd,
+				    struct timespec *ts)
+{
+	return -1;
+}
+
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
@@ -239,6 +286,10 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 		if (do_monotonic(vd, ts))
 			goto fallback;
 		break;
+	case CLOCK_MONOTONIC_RAW:
+		if (do_monotonic_raw(vd, ts))
+			goto fallback;
+		break;
 	default:
 		goto fallback;
 	}
-- 
2.15.0.rc0.271.g36b669edcc-goog
