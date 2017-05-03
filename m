From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  3 May 2017 16:09:37 +0100
Subject: [PATCH 5/6] arm64: atomic_lse: match asm register sizes
In-Reply-To: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
References: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1493824178-7399-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LSE atomic code uses asm register variables to ensure that
parameters are allocated in specific registers. In the majority of cases
we specifically ask for an x register when using 64-bit values, but in a
couple of cases we use a w regsiter for a 64-bit value.

For asm register variables, the compiler only cares about the register
index, with wN and xN having the same meaning. The compiler determines
the register size to use based on the type of the variable. Thus, this
inconsistency is merely confusing, and not harmful to code generation.

For consistency, this patch updates those cases to use the x register
alias. There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic_lse.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 7457ce0..99fa69c 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -322,7 +322,7 @@ static inline void atomic64_and(long i, atomic64_t *v)
 #define ATOMIC64_FETCH_OP_AND(name, mb, cl...)				\
 static inline long atomic64_fetch_and##name(long i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("w0") = i;				\
+	register long x0 asm ("x0") = i;				\
 	register atomic64_t *x1 asm ("x1") = v;				\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
@@ -394,7 +394,7 @@ static inline void atomic64_sub(long i, atomic64_t *v)
 #define ATOMIC64_FETCH_OP_SUB(name, mb, cl...)				\
 static inline long atomic64_fetch_sub##name(long i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("w0") = i;				\
+	register long x0 asm ("x0") = i;				\
 	register atomic64_t *x1 asm ("x1") = v;				\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
-- 
1.9.1
