From: salyzyn@android.com (Mark Salyzyn)
Date: Fri, 10 Nov 2017 10:24:53 -0800
Subject: [PATCH] lib: vdso: add support for time
Message-ID: <20171110182513.44671-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add time() vdso support to match up with existing support in the x86's
vdso.  Currently benefitting arm and arm64 which uses the common
vgettimeofday.c implementation.  On arm provides about a ~14 fold
improvement in speed over the straight syscall, and about a ~5 fold
improvement in speed over an alternate library implementation that
relies on the vdso call to gettimeofday to fulfill the request.

We can provide __vdso_time even if we can not provide a speed
enhanced __vdso_gettimeofday (arm, virtual counters).

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

NB: to be applied _after_
 [PATCH v5 10/12] arm64: vdso: replace gettimeofday.S with global vgettimeofday.C

---
 arch/arm/kernel/vdso.c            |  1 +
 arch/arm/vdso/vdso.lds.S          |  1 +
 arch/arm64/kernel/vdso/compiler.h |  1 +
 arch/arm64/kernel/vdso/vdso.lds.S |  1 +
 lib/vdso/vgettimeofday.c          | 10 ++++++++++
 5 files changed, 14 insertions(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index da52aade40a3..b8ae87b4d526 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -190,6 +190,7 @@ static void __init patch_vdso(void *ehdr)
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_getres");
+		/* do not zero out __vdso_time, no cntvct_ok dependency */
 	}
 }
 
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 1d81e8c3acf6..1eb577091d1f 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -83,6 +83,7 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
+		__vdso_time;
 	local: *;
 	};
 }
diff --git a/arch/arm64/kernel/vdso/compiler.h b/arch/arm64/kernel/vdso/compiler.h
index 921a7191b497..fb27545640f2 100644
--- a/arch/arm64/kernel/vdso/compiler.h
+++ b/arch/arm64/kernel/vdso/compiler.h
@@ -65,5 +65,6 @@ static __always_inline notrace u64 arch_vdso_read_counter(void)
 #define __vdso_clock_gettime __kernel_clock_gettime
 #define __vdso_gettimeofday __kernel_gettimeofday
 #define __vdso_clock_getres __kernel_clock_getres
+#define __vdso_time __kernel_time
 
 #endif /* __VDSO_COMPILER_H */
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index beca249bc2f3..9de0ffc369c5 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -88,6 +88,7 @@ VERSION
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
 		__kernel_clock_getres;
+		__kernel_time;
 	local: *;
 	};
 }
diff --git a/lib/vdso/vgettimeofday.c b/lib/vdso/vgettimeofday.c
index 079955162be8..d8d675d46749 100644
--- a/lib/vdso/vgettimeofday.c
+++ b/lib/vdso/vgettimeofday.c
@@ -385,3 +385,13 @@ int __vdso_clock_getres(clockid_t clock, struct timespec *res)
 
 	return 0;
 }
+
+notrace time_t __vdso_time(time_t *t)
+{
+	const struct vdso_data *vd = __get_datapage();
+	time_t result = READ_ONCE(vd->xtime_coarse_sec);
+
+	if (t)
+		*t = result;
+	return result;
+}
-- 
2.15.0.448.gf294e3d99a-goog
