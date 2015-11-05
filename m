From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  5 Nov 2015 14:00:56 +0000
Subject: [PATCH] arm64: cmpxchg_dbl: fix return value type
Message-ID: <1446732056-31294-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current arm64 __cmpxchg_double{_mb} implementations carry out the
compare exchange by first comparing the old values passed in to the
values read from the pointer provided and by stashing the cumulative
bitwise difference in a 64-bit register.

By comparing the register content against 0, it is possible to detect if
the values read differ from the old values passed in, so that the compare
exchange detects whether it has to bail out or carry on completing the
operation with the exchange.

Given the current implementation, to detect the cmpxchg operation
status, the __cmpxchg_double{_mb} functions should return the 64-bit
stashed bitwise difference so that the caller can detect cmpxchg failure
by comparing the return value content against 0. The current implementation
declares the return value as an int, which means that the 64-bit
value stashing the bitwise difference is truncated before being
returned to the __cmpxchg_double{_mb} callers, which means that
any bitwise difference present in the top 32 bits goes undetected,
triggering false positives and subsequent kernel failures.

This patch fixes the issue by declaring the arm64 __cmpxchg_double{_mb}
return values as a long, so that the bitwise difference is
properly propagated on failure, restoring the expected behaviour.

Fixes: e9a4b795652f ("arm64: cmpxchg_dbl: patch in lse instructions when
supported by the CPU")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: <stable@vger.kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 2 +-
 arch/arm64/include/asm/atomic_lse.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index 74d0b8e..f61c84f 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -233,7 +233,7 @@ __CMPXCHG_CASE( ,  ,  mb_8, dmb ish,  , l, "memory")
 #undef __CMPXCHG_CASE
 
 #define __CMPXCHG_DBL(name, mb, rel, cl)				\
-__LL_SC_INLINE int							\
+__LL_SC_INLINE long							\
 __LL_SC_PREFIX(__cmpxchg_double##name(unsigned long old1,		\
 				      unsigned long old2,		\
 				      unsigned long new1,		\
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 1fce790..197e06a 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -387,7 +387,7 @@ __CMPXCHG_CASE(x,  ,  mb_8, al, "memory")
 #define __LL_SC_CMPXCHG_DBL(op)	__LL_SC_CALL(__cmpxchg_double##op)
 
 #define __CMPXCHG_DBL(name, mb, cl...)					\
-static inline int __cmpxchg_double##name(unsigned long old1,		\
+static inline long __cmpxchg_double##name(unsigned long old1,		\
 					 unsigned long old2,		\
 					 unsigned long new1,		\
 					 unsigned long new2,		\
-- 
2.5.1
