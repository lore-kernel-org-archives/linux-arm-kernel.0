From: salyzyn@android.com (Mark Salyzyn)
Date: Fri, 26 Jan 2018 09:18:48 -0800
Subject: [PATCH v6 11/12] lib: vdso: Add support for CLOCK_BOOTTIME
Message-ID: <20180126171907.87576-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take an effort to recode the arm64 vdso code from assembler to C
previously submitted by Andrew Pinski <apinski@cavium.com>, rework
it for use in both arm and arm64, overlapping any optimizations
for each architecture. But instead of landing it in arm64, land the
result into lib/vdso and unify both implementations to simplify
future maintenance.

Add a case for CLOCK_BOOTTIME as it is popular for measuring
relative time on systems expected to suspend() or hibernate().

Android uses CLOCK_BOOTTIME for all relative time measurements
and timeouts. Switching to vdso reduced CPU utilization and improves
accuracy. There is also a desire by some partners to switch all
logging over to CLOCK_BOOTTIME, and thus this operation alone would
contribute to a near percentile CPU load.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org

v2:
- rebased and changed from 3/3 to 10/10, fortified commit message.

v3:
- move arch/arm/vdso/vgettimeofday.c to lib/vdso/vgettimeofday.c.

v4:
- update commit message to reflect specific, and overall reasoning
  of patch series.
- drop forced inline operations.
- switch typeof() with __kernel_time_t.

v5:
- added comment about open coded timepsec_add_ns() for clarity.

v6:
- fix issue with __iter_div_u64_rem scaling by splitting sec & nsec
---
 arch/arm/include/asm/vdso_datapage.h   |  2 ++
 arch/arm/kernel/vdso.c                 |  4 +++
 arch/arm64/include/asm/vdso_datapage.h |  2 ++
 arch/arm64/kernel/vdso.c               |  4 +++
 lib/vdso/vgettimeofday.c               | 56 ++++++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+)

diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso_datapage.h
index 1c6e6a5d5d9d..0120852b6b12 100644
--- a/arch/arm/include/asm/vdso_datapage.h
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -64,6 +64,8 @@ struct vdso_data {
 	u32 tz_minuteswest;	/* timezone info for gettimeofday(2) */
 	u32 tz_dsttime;
 
+	u32 btm_sec;		/* monotonic to boot time */
+	u32 btm_nsec;
 	/* Raw clocksource multipler */
 	u32 cs_raw_mult;
 	/* Raw time */
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index bab013d6c2e3..ce1b1483e4e2 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -335,6 +335,8 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_data->wtm_clock_nsec		= wtm->tv_nsec;
 
 	if (!vdso_data->use_syscall) {
+		struct timespec btm = ktime_to_timespec(tk->offs_boot);
+
 		vdso_data->cs_cycle_last	= tk->tkr_mono.cycle_last;
 		vdso_data->raw_time_sec		= tk->raw_sec;
 		vdso_data->raw_time_nsec	= tk->tkr_raw.xtime_nsec;
@@ -345,6 +347,8 @@ void update_vsyscall(struct timekeeper *tk)
 		/* tkr_mono.shift == tkr_raw.shift */
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
 		vdso_data->cs_mask		= tk->tkr_mono.mask;
+		vdso_data->btm_sec		= btm.tv_sec;
+		vdso_data->btm_nsec		= btm.tv_nsec;
 	}
 
 	vdso_write_end(vdso_data);
diff --git a/arch/arm64/include/asm/vdso_datapage.h b/arch/arm64/include/asm/vdso_datapage.h
index 95f4a7abab80..348b9be9efe7 100644
--- a/arch/arm64/include/asm/vdso_datapage.h
+++ b/arch/arm64/include/asm/vdso_datapage.h
@@ -45,6 +45,8 @@ struct vdso_data {
 	__u64 xtime_coarse_nsec;
 	__u64 wtm_clock_sec;	/* Wall to monotonic time */
 	vdso_wtm_clock_nsec_t wtm_clock_nsec;
+	__u32 btm_sec;		/* monotonic to boot time */
+	__u32 btm_nsec;
 	__u32 tb_seq_count;	/* Timebase sequence counter */
 	/* cs_* members must be adjacent and in this order (ldp accesses) */
 	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 59f150c25889..8dd2ad220a0f 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -233,6 +233,8 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_data->wtm_clock_nsec		= tk->wall_to_monotonic.tv_nsec;
 
 	if (!use_syscall) {
+		struct timespec btm = ktime_to_timespec(tk->offs_boot);
+
 		/* tkr_mono.cycle_last == tkr_raw.cycle_last */
 		vdso_data->cs_cycle_last	= tk->tkr_mono.cycle_last;
 		vdso_data->raw_time_sec         = tk->raw_sec;
@@ -243,6 +245,8 @@ void update_vsyscall(struct timekeeper *tk)
 		vdso_data->cs_raw_mult		= tk->tkr_raw.mult;
 		/* tkr_mono.shift == tkr_raw.shift */
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
+		vdso_data->btm_sec		= btm.tv_sec;
+		vdso_data->btm_nsec		= btm.tv_nsec;
 	}
 
 	smp_wmb();
diff --git a/lib/vdso/vgettimeofday.c b/lib/vdso/vgettimeofday.c
index 33c5917fe9f8..4c3af7bc6499 100644
--- a/lib/vdso/vgettimeofday.c
+++ b/lib/vdso/vgettimeofday.c
@@ -247,6 +247,51 @@ static notrace int do_monotonic_raw(const struct vdso_data *vd,
 	return 0;
 }
 
+static notrace int do_boottime(const struct vdso_data *vd, struct timespec *ts)
+{
+	u32 seq, mult, shift;
+	u64 nsec, cycle_last;
+	vdso_wtm_clock_nsec_t wtm_nsec;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
+	u64 mask;
+#endif
+	__kernel_time_t sec;
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
+		sec += vd->wtm_clock_sec + vd->btm_sec;
+		wtm_nsec = vd->wtm_clock_nsec + vd->btm_nsec;
+
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	nsec += get_clock_shifted_nsec(cycle_last, mult, mask);
+	nsec >>= shift;
+	nsec += wtm_nsec;
+
+	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
+
+	return 0;
+}
+
 #else /* ARCH_PROVIDES_TIMER */
 
 static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
@@ -265,6 +310,12 @@ static notrace int do_monotonic_raw(const struct vdso_data *vd,
 	return -1;
 }
 
+static notrace int do_boottime(const struct vdso_data *vd,
+			       struct timespec *ts)
+{
+	return -1;
+}
+
 #endif /* ARCH_PROVIDES_TIMER */
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
@@ -290,6 +341,10 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
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
@@ -326,6 +381,7 @@ int __vdso_clock_getres(clockid_t clock, struct timespec *res)
 	long nsec;
 
 	if (clock == CLOCK_REALTIME ||
+	    clock == CLOCK_BOOTTIME ||
 	    clock == CLOCK_MONOTONIC ||
 	    clock == CLOCK_MONOTONIC_RAW)
 		nsec = MONOTONIC_RES_NSEC;
-- 
2.16.0.rc1.238.g530d649a79-goog
