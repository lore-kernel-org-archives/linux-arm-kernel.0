From: salyzyn@android.com (Mark Salyzyn)
Date: Fri, 27 Oct 2017 15:26:11 -0700
Subject: [PATCH v3 07/12] arm: vdso: add support for clock_getres
Message-ID: <20171027222616.58095-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock_getres vdso support to match up with existing support in
the arcm64's vdso.

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

v2:
- split first CL into 7 of 7 pieces

v3:
- rebase (unchanged)

---
 arch/arm/kernel/vdso.c        |  1 +
 arch/arm/vdso/vdso.lds.S      |  1 +
 arch/arm/vdso/vgettimeofday.c | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 7377638a3b00..287424541f3a 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -189,6 +189,7 @@ static void __init patch_vdso(void *ehdr)
 	if (!cntvct_ok) {
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
+		vdso_nullpatch_one(&einfo, "__vdso_clock_getres");
 	}
 }
 
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 89ca89f12d23..1d81e8c3acf6 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -82,6 +82,7 @@ VERSION
 	global:
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index b374c143d53e..841e7fd74a1b 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -31,6 +31,7 @@
 
 DEFINE_FALLBACK(gettimeofday, struct timeval *, tv, struct timezone *, tz)
 DEFINE_FALLBACK(clock_gettime, clockid_t, clock, struct timespec *, ts)
+DEFINE_FALLBACK(clock_getres, clockid_t, clock, struct timespec *, ts)
 
 static notrace u32 vdso_read_begin(const struct vdso_data *vd)
 {
@@ -320,3 +321,25 @@ notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 
 	return 0;
 }
+
+int __vdso_clock_getres(clockid_t clock_id, struct timespec *res)
+{
+	typeof(res->tv_nsec) nsec;
+
+	if (clock_id == CLOCK_REALTIME ||
+	    clock_id == CLOCK_MONOTONIC ||
+	    clock_id == CLOCK_MONOTONIC_RAW)
+		nsec = MONOTONIC_RES_NSEC;
+	else if (clock_id == CLOCK_REALTIME_COARSE ||
+		 clock_id == CLOCK_MONOTONIC_COARSE)
+		nsec = LOW_RES_NSEC;
+	else
+		return clock_getres_fallback(clock_id, res);
+
+	if (likely(res != NULL)) {
+		res->tv_sec = 0;
+		res->tv_nsec = nsec;
+	}
+
+	return 0;
+}
-- 
2.15.0.rc2.357.g7e34df9404-goog
