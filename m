From: salyzyn@android.com (Mark Salyzyn)
Date: Mon,  1 Oct 2018 10:58:26 -0700
Subject: RESEND [PATCH v5 06/12] arm: vdso: add support for clock_getres
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
Message-ID: <20181001175845.168430-7-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take an effort to recode the arm64 vdso code from assembler to C
previously submitted by Andrew Pinski <apinski@cavium.com>, rework
it for use in both arm and arm64, overlapping any optimizations
for each architecture. But instead of landing it in arm64, land the
result into lib/vdso and unify both implementations to simplify
future maintenance.

Add clock_getres vdso support to match up with existing support in
the arm64's vdso.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
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
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel at android.com

v2:
- split first CL into 7 of 7 pieces

v4:
- update commit message to reflect overall reasoning.
- replace typeof() with long for nsec
- replace clock_id with clock to match usage elsewhere.

v5:
- add linux/hrtimer.h to compiler.h to supply for LOW_RES_NSEC and
  MONOTONIC_RES_NSEC.
---
 arch/arm/kernel/vdso.c        |  1 +
 arch/arm/vdso/compiler.h      |  1 +
 arch/arm/vdso/vdso.lds.S      |  1 +
 arch/arm/vdso/vgettimeofday.c | 23 +++++++++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 9c13a32fa5f0..c299967df63c 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -191,6 +191,7 @@ static void __init patch_vdso(void *ehdr)
 	if (!cntvct_ok) {
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
+		vdso_nullpatch_one(&einfo, "__vdso_clock_getres");
 	}
 }
 
diff --git a/arch/arm/vdso/compiler.h b/arch/arm/vdso/compiler.h
index 3edddb705a1b..c7751019246a 100644
--- a/arch/arm/vdso/compiler.h
+++ b/arch/arm/vdso/compiler.h
@@ -27,6 +27,7 @@
 #include <asm/processor.h>	/* for cpu_relax()			*/
 #include <asm/unistd.h>
 #include <linux/compiler.h>
+#include <linux/hrtimer.h>	/* for LOW_RES_NSEC and MONOTONIC_RES_NSEC */
 #include <linux/time.h>		/* for NSEC_PER_SEC			*/
 
 #ifndef CONFIG_AEABI
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
index a2c4db83edc4..a354586f8a65 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -32,6 +32,7 @@
 
 DEFINE_FALLBACK(gettimeofday, struct timeval *, tv, struct timezone *, tz)
 DEFINE_FALLBACK(clock_gettime, clockid_t, clock, struct timespec *, ts)
+DEFINE_FALLBACK(clock_getres, clockid_t, clock, struct timespec *, ts)
 
 static notrace u32 vdso_read_begin(const struct vdso_data *vd)
 {
@@ -301,3 +302,25 @@ notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 
 	return 0;
 }
+
+int __vdso_clock_getres(clockid_t clock, struct timespec *res)
+{
+	long nsec;
+
+	if (clock == CLOCK_REALTIME ||
+	    clock == CLOCK_MONOTONIC ||
+	    clock == CLOCK_MONOTONIC_RAW)
+		nsec = MONOTONIC_RES_NSEC;
+	else if (clock == CLOCK_REALTIME_COARSE ||
+		 clock == CLOCK_MONOTONIC_COARSE)
+		nsec = LOW_RES_NSEC;
+	else
+		return clock_getres_fallback(clock, res);
+
+	if (likely(res != NULL)) {
+		res->tv_sec = 0;
+		res->tv_nsec = nsec;
+	}
+
+	return 0;
+}
-- 
2.19.0.605.g01d371f741-goog
