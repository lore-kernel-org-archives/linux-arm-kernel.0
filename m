From: salyzyn@android.com (Mark Salyzyn)
Date: Tue, 31 Oct 2017 11:30:19 -0700
Subject: [PATCH v4 00/12] arm+arm64: vdso unification to lib/vdso/
Message-ID: <20171031183022.80775-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take an effort to recode the arm64 vdso code from assembler to C
previously submitted by Andrew Pinski <apinski@cavium.com>, rework
it for use in both arm and arm64, overlapping any optimizations
for each architecture. But instead of landing it in arm64, land the
result into lib/vdso and unify both implementations to simplify
future maintenance. This will act as the basis for implementing
arm64 vdso32 in the future.


apinski at cavium.com made the following claims in the original patch:

This allows the compiler to optimize the divide by 1000 and remove
the other divides.

On ThunderX, gettimeofday improves by 32%.  On ThunderX 2,
gettimeofday improves by 18%.

Note I noticed a bug in the old implementation of __kernel_clock_getres;
it was checking only the lower 32bits of the pointer; this would work
for most cases but could fail in a few.


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
- split first CL into 7 pieces, there were cosmetic adjustments.
- make sure profiling is turned off.
- kept quiet_cmd_vdsoas.

v3:
- changed are a result of private email review comments
- rebase
- move arch/arm/vdso/vgettimeofday.c to lib/vdso/vgettimeofday.c
- adjust vgettimeofday.c to be a better global candidate, switch to using
  ARCH_PROVIDES_TIMER and __arch_counter_get() as more generic.
- do not expose gettimeofday if arch does not support user space timer

v4:
- update commit messages to reflect reasoning here.
- switch to arch_vdso_read_counter as common API.
- split out ARCH_CLOCK_FIXED_MASK.
- Use GENMASK_ULL macro for ARCH_CLOCK_FIXED_MASK.
- dropping forced inline patch and side effects.
- replace all typeof()s with the appropriate types
  vdso_wtm_clock_nsec_t, vdso_xtime_clock_sec, vdso_raw_time_sec_t,
  long (tv_nsec) and __kernel_time_t (tv_sec).
- clock_getres implementation, use clock instead of clock_id to
  match usage elsewhere and remove an inconsistency.
- simplify arm64 implementation of arch_vdso_read_counter,
  use read_sysreg.
