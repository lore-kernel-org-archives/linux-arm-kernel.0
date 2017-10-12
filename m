From: salyzyn@android.com (Mark Salyzyn)
Date: Thu, 12 Oct 2017 16:01:45 -0700
Subject: [PATCH v2 10/10] arm+arm64: vdso: Add support for CLOCK_BOOTTIME
Message-ID: <20171012230154.87782-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a case for CLOCK_BOOTTIME as it is popular for measuring
relative time on systems expected to suspend() or hibernate().

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2: rebased and changed from 3/3 to 10/10, fortified commit message.
---
 arch/arm/include/asm/vdso_datapage.h   |  1 +
 arch/arm/kernel/vdso.c                 |  1 +
 arch/arm/vdso/vgettimeofday.c          | 56 ++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/vdso_datapage.h |  1 +
 arch/arm64/kernel/vdso.c               |  1 +
 5 files changed, 60 insertions(+)

diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso_datapage.h
index d57c296f7f52..d2c8e0807f06 100644
--- a/arch/arm/include/asm/vdso_datapage.h
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -47,6 +47,7 @@ struct vdso_data {
 	u32 tz_minuteswest;	/* timezone info for gettimeofday(2) */
 	u32 tz_dsttime;
 
+	u64 btm_nsec;		/* monotonic to boot time */
 	u32 cs_raw_mult;	/* Raw clocksource multipler */
 	u32 raw_time_sec;	/* Raw time */
 	u32 raw_time_nsec;
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 287424541f3a..9370ab4b2734 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -347,6 +347,7 @@ void update_vsyscall(struct timekeeper *tk)
 		/* tkr_mono.shift == tkr_raw.shift */
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
 		vdso_data->cs_mask		= tk->tkr_mono.mask;
+		vdso_data->btm_nsec		= ktime_to_ns(tk->offs_boot);
 	}
 
 	vdso_write_end(vdso_data);
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 841e7fd74a1b..6b5b24f6d78d 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -248,6 +248,51 @@ static __always_inline notrace int do_monotonic_raw(const struct vdso_data *vd,
 	return 0;
 }
 
+static __always_inline notrace int do_boottime(const struct vdso_data *vd,
+					       struct timespec *ts)
+{
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last, wtm_nsec;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
+	u64 mask;
+#endif
+
+	typeof(ts->tv_sec) sec;
+
+	do {
+		seq = vdso_read_begin(vd);
+
+		if (vd->use_syscall)
+			return -1;
+
+		cycle_last = vd->cs_cycle_last;
+
+		mult = vd->cs_mono_mult;
+		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
+		mask = vd->cs_mask;
+#endif
+
+		sec = vd->xtime_clock_sec;
+		nsec = vd->xtime_clock_snsec;
+
+		sec += vd->wtm_clock_sec;
+		wtm_nsec = vd->wtm_clock_nsec + vd->btm_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	nsec += wtm_nsec;
+
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
+
+	return 0;
+}
+
 #else /* CONFIG_ARM_ARCH_TIMER */
 
 static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
@@ -266,6 +311,12 @@ static notrace int do_monotonic_raw(const struct vdso_data *vd,
 	return -1;
 }
 
+static notrace int do_boottime(const struct vdso_data *vd,
+			       struct timespec *ts)
+{
+	return -1;
+}
+
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
@@ -291,6 +342,10 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 		if (do_monotonic_raw(vd, ts))
 			goto fallback;
 		break;
+	case CLOCK_BOOTTIME:
+		if (do_boottime(vd, ts))
+			goto fallback;
+		break;
 	default:
 		goto fallback;
 	}
@@ -327,6 +382,7 @@ int __vdso_clock_getres(clockid_t clock_id, struct timespec *res)
 	typeof(res->tv_nsec) nsec;
 
 	if (clock_id == CLOCK_REALTIME ||
+	    clock_id == CLOCK_BOOTTIME ||
 	    clock_id == CLOCK_MONOTONIC ||
 	    clock_id == CLOCK_MONOTONIC_RAW)
 		nsec = MONOTONIC_RES_NSEC;
diff --git a/arch/arm64/include/asm/vdso_datapage.h b/arch/arm64/include/asm/vdso_datapage.h
index c9e30226cdbc..1e115b0f373d 100644
--- a/arch/arm64/include/asm/vdso_datapage.h
+++ b/arch/arm64/include/asm/vdso_datapage.h
@@ -30,6 +30,7 @@ struct vdso_data {
 	__u64 xtime_coarse_nsec;
 	__u64 wtm_clock_sec;	/* Wall to monotonic time */
 	__u64 wtm_clock_nsec;
+	__u64 btm_nsec;		/* monotonic to boot time */
 	__u32 tb_seq_count;	/* Timebase sequence counter */
 	/* cs_* members must be adjacent and in this order (ldp accesses) */
 	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 59f150c25889..0710edd8bedc 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -243,6 +243,7 @@ void update_vsyscall(struct timekeeper *tk)
 		vdso_data->cs_raw_mult		= tk->tkr_raw.mult;
 		/* tkr_mono.shift == tkr_raw.shift */
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
+		vdso_data->btm_nsec		= ktime_to_ns(tk->offs_boot);
 	}
 
 	smp_wmb();
-- 
2.15.0.rc0.271.g36b669edcc-goog
