From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Sep 2017 19:03:07 +0100
Subject: [PATCH] arm64: avoid instrumenting atomic_ll_sc.o
Message-ID: <1506448987-31070-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our out-of-line atomics are built with a special calling convention,
preventing pointless stack spilling, and allowing us to patch call sites
with ARMv8.1 atomic instructions.

Instrumentation inserted by the compiler may result in calls to
functions not following this special calling convention, resulting in
registers being unexpectedly clobbered, and various problems resulting
from this.

For example, if a kernel is built with KCOV and ARM64_LSE_ATOMICS, the
compiler inserts calls to __sanitizer_cov_trace_pc in the prologues of
the atomic functions. This has been observed to result in spurious
cmpxchg failures, leading to a hang early on in the boot process.

This patch avoids such issues by preventing instrumentation of our
out-of-line atomics.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/lib/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index a0abc14..8fea178 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -17,5 +17,9 @@ CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
 		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
 		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
 		   -fcall-saved-x18
+GCOV_PROFILE_atomic_ll_sc.o	:= n
+KASAN_SANITIZE_atomic_ll_sc.o	:= n
+KCOV_INSTRUMENT_atomic_ll_sc.o	:= n
+UBSAN_SANITIZE_atomic_ll_sc.o	:= n
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
-- 
1.9.1
