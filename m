From: salyzyn@android.com (Mark Salyzyn)
Date: Tue, 31 Oct 2017 11:32:13 -0700
Subject: [PATCH v4 08/12] arm: vdso: Add ARCH_CLOCK_FIXED_MASK
Message-ID: <20171031183216.81259-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take an effort to recode the arm64 vdso code from assembler to C
previously submitted by Andrew Pinski <apinski@cavium.com>, rework
it for use in both arm and arm64, overlapping any optimizations
for each architecture. But instead of landing it in arm64, land the
result into lib/vdso and unify both implementations to simplify
future maintenance.

Add ARCH_CLOCK_FIXED_MASK as an efficiency since arm64 has no
purpose for cs_mask vdso_data variable.

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

v4:
- New in series, split off from earlier.

---
 arch/arm/vdso/vgettimeofday.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 1152308067e1..bbacf4d0d6a2 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -123,7 +123,11 @@ static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
 {
 	u32 seq, mult, shift;
 	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
 	u64 mask;
+#endif
 	vdso_xtime_clock_sec_t sec;
 
 	do {
@@ -136,7 +140,9 @@ static notrace int do_realtime(const struct vdso_data *vd, struct timespec *ts)
 
 		mult = vd->cs_mono_mult;
 		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
 		mask = vd->cs_mask;
+#endif
 
 		sec = vd->xtime_clock_sec;
 		nsec = vd->xtime_clock_snsec;
@@ -156,7 +162,11 @@ static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 {
 	u32 seq, mult, shift;
 	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
 	u64 mask;
+#endif
 	vdso_wtm_clock_nsec_t wtm_nsec;
 	__kernel_time_t sec;
 
@@ -170,7 +180,9 @@ static notrace int do_monotonic(const struct vdso_data *vd, struct timespec *ts)
 
 		mult = vd->cs_mono_mult;
 		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
 		mask = vd->cs_mask;
+#endif
 
 		sec = vd->xtime_clock_sec;
 		nsec = vd->xtime_clock_snsec;
@@ -195,7 +207,11 @@ static notrace int do_monotonic_raw(const struct vdso_data *vd,
 {
 	u32 seq, mult, shift;
 	u64 nsec, cycle_last;
+#ifdef ARCH_CLOCK_FIXED_MASK
+	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
+#else
 	u64 mask;
+#endif
 	vdso_raw_time_sec_t sec;
 
 	do {
@@ -208,7 +224,9 @@ static notrace int do_monotonic_raw(const struct vdso_data *vd,
 
 		mult = vd->cs_raw_mult;
 		shift = vd->cs_shift;
+#ifndef ARCH_CLOCK_FIXED_MASK
 		mask = vd->cs_mask;
+#endif
 
 		sec = vd->raw_time_sec;
 		nsec = vd->raw_time_nsec;
-- 
2.15.0.rc2.357.g7e34df9404-goog
