From: salyzyn@android.com (Mark Salyzyn)
Date: Fri, 27 Oct 2017 15:27:57 -0700
Subject: [PATCH v3 12/12] lib: vdso: do not expose gettimeofday,
 if no arch supported timer
Message-ID: <20171027222803.58460-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org

v3:
- do not expose gettimeofday if arch does not support user space timer

---
 lib/vdso/vgettimeofday.c | 52 +++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/lib/vdso/vgettimeofday.c b/lib/vdso/vgettimeofday.c
index 0546ff12673d..22d0873778ed 100644
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
 
@@ -293,30 +295,6 @@ static __always_inline notrace int do_boottime(const struct vdso_data *vd,
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
@@ -330,6 +308,7 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 	case CLOCK_MONOTONIC_COARSE:
 		do_monotonic_coarse(vd, ts);
 		break;
+#ifdef ARCH_PROVIDES_TIMER
 	case CLOCK_REALTIME:
 		if (do_realtime(vd, ts))
 			goto fallback;
@@ -346,6 +325,7 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 		if (do_boottime(vd, ts))
 			goto fallback;
 		break;
+#endif
 	default:
 		goto fallback;
 	}
@@ -355,6 +335,7 @@ notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 	return clock_gettime_fallback(clock, ts);
 }
 
+#ifdef ARCH_PROVIDES_TIMER
 notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	const struct vdso_data *vd = __get_datapage();
@@ -376,21 +357,28 @@ notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 
 	return 0;
 }
+#endif
 
 int __vdso_clock_getres(clockid_t clock_id, struct timespec *res)
 {
 	typeof(res->tv_nsec) nsec;
 
-	if (clock_id == CLOCK_REALTIME ||
-	    clock_id == CLOCK_BOOTTIME ||
-	    clock_id == CLOCK_MONOTONIC ||
-	    clock_id == CLOCK_MONOTONIC_RAW)
-		nsec = MONOTONIC_RES_NSEC;
-	else if (clock_id == CLOCK_REALTIME_COARSE ||
-		 clock_id == CLOCK_MONOTONIC_COARSE)
+	switch (clock_id) {
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
 		return clock_getres_fallback(clock_id, res);
+	}
 
 	if (likely(res != NULL)) {
 		res->tv_sec = 0;
-- 
2.15.0.rc2.357.g7e34df9404-goog
