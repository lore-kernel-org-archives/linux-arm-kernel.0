From: salyzyn@android.com (Mark Salyzyn)
Date: Tue, 31 Oct 2017 11:33:40 -0700
Subject: [PATCH v4 12/12] lib: vdso: do not expose gettimeofday,
 if no arch supported timer
Message-ID: <20171031183345.81499-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take an effort to recode the arm64 vdso code from assembler to C
previously submitted by Andrew Pinski <apinski@cavium.com>, rework
it for use in both arm and arm64, overlapping any optimizations
for each architecture. But instead of landing it in arm64, land the
result into lib/vdso and unify both implementations to simplify
future maintenance.

If ARCH_PROVIDES_TIMER is not defined, do not expose gettimeofday.
libc will default directly to syscall.  Also ifdef clock_gettime
switch cases and stubs if not supported and other unused components.

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

v3:
- do not expose gettimeofday if arch does not support user space timer.

v4:
- update commit message to reflect overall reasoning of patch series.

---
 lib/vdso/vgettimeofday.c | 52 +++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/lib/vdso/vgettimeofday.c b/lib/vdso/vgettimeofday.c
index 4f500aba7e60..896e20e34a23 100644
--- a/lib/vdso/vgettimeofday.c
+++ b/lib/vdso/vgettimeofday.c
@@ -29,7 +29,9 @@
 #include "compiler.h"
 #include "datapage.h"
 
+#ifdef ARCH_PROVIDES_TIMER
 DEFINE_FALLBACK(gettimeofday, struct timeval *, tv, struct timezone *, tz)
+#endif
 DEFINE_FALLBACK(clock_gettime, clockid_t, clock, struct timespec *, ts)
 DEFINE_FALLBACK(clock_getres, clockid_t, clock, struct timespec *, ts)
 
@@ -285,30 +287,6 @@ static notrace int do_boottime(const struct vdso_data *vd, struct timespec *ts)
 	return 0;
 }
 
-#else /* ARCH_PROVIDES_TIMER */
-
-static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
-{
-	return -1;
-}
-
-static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
-{
-	return -1;
-}
-
-static notrace int do_monotonic_raw(const struct vdso_data *vd,
-				    struct timespec *ts)
-{
-	return -1;
-}
-
-static notrace int do_boottime(const struct vdso_data *vd,
-			       struct timespec *ts)
-{
-	return -1;
-}
-
 #endif /* ARCH_PROVIDES_TIMER */
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
@@ -322,6 +300,7 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 	case CLOCK_MONOTONIC_COARSE:
 		do_monotonic_coarse(vd, ts);
 		break;
+#ifdef ARCH_PROVIDES_TIMER
 	case CLOCK_REALTIME:
 		if (do_realtime(vd, ts))
 			goto fallback;
@@ -338,6 +317,7 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 		if (do_boottime(vd, ts))
 			goto fallback;
 		break;
+#endif
 	default:
 		goto fallback;
 	}
@@ -347,6 +327,7 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 	return clock_gettime_fallback(clock, ts);
 }
 
+#ifdef ARCH_PROVIDES_TIMER
 notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	const struct vdso_data *vd = __get_datapage();
@@ -368,21 +349,28 @@ notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 
 	return 0;
 }
+#endif
 
 int __vdso_clock_getres(clockid_t clock, struct timespec *res)
 {
 	long nsec;
 
-	if (clock == CLOCK_REALTIME ||
-	    clock == CLOCK_BOOTTIME ||
-	    clock == CLOCK_MONOTONIC ||
-	    clock == CLOCK_MONOTONIC_RAW)
-		nsec = MONOTONIC_RES_NSEC;
-	else if (clock == CLOCK_REALTIME_COARSE ||
-		 clock == CLOCK_MONOTONIC_COARSE)
+	switch (clock) {
+	case CLOCK_REALTIME_COARSE:
+	case CLOCK_MONOTONIC_COARSE:
 		nsec = LOW_RES_NSEC;
-	else
+		break;
+#ifdef ARCH_PROVIDES_TIMER
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+	case CLOCK_BOOTTIME:
+		nsec = MONOTONIC_RES_NSEC;
+		break;
+#endif
+	default:
 		return clock_getres_fallback(clock, res);
+	}
 
 	if (likely(res != NULL)) {
 		res->tv_sec = 0;
-- 
2.15.0.rc2.357.g7e34df9404-goog
