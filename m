From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:16 +0100
Subject: [PATCH 15/18] arm64: atomics: prefetch the destination word for write
 prior to stxr
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-16-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cost of changing a cacheline from shared to exclusive state can be
significant, especially when this is triggered by an exclusive store,
since it may result in having to retry the transaction.

This patch makes use of prfm to prefetch cachelines for write prior to
ldxr/stxr loops when using the ll/sc atomic routines.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 9 +++++++++
 arch/arm64/include/asm/cmpxchg.h      | 8 ++++++++
 arch/arm64/include/asm/futex.h        | 2 ++
 arch/arm64/lib/bitops.S               | 2 ++
 4 files changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index fb26f2b1f300..652877fefae6 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -45,6 +45,7 @@ __LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
 	int result;							\
 									\
 	asm volatile("// atomic_" #op "\n"				\
+"	prfm	pstl1strm, %2\n"					\
 "1:	ldxr	%w0, %2\n"						\
 "	" #asm_op "	%w0, %w0, %w3\n"				\
 "	stxr	%w1, %w0, %2\n"						\
@@ -62,6 +63,7 @@ __LL_SC_PREFIX(atomic_##op##_return(int i, atomic_t *v))		\
 	int result;							\
 									\
 	asm volatile("// atomic_" #op "_return\n"			\
+"	prfm	pstl1strm, %2\n"					\
 "1:	ldxr	%w0, %2\n"						\
 "	" #asm_op "	%w0, %w0, %w3\n"				\
 "	stlxr	%w1, %w0, %2\n"						\
@@ -93,6 +95,7 @@ __LL_SC_PREFIX(atomic_cmpxchg(atomic_t *ptr, int old, int new))
 	int oldval;
 
 	asm volatile("// atomic_cmpxchg\n"
+"	prfm	pstl1strm, %2\n"
 "1:	ldxr	%w1, %2\n"
 "	eor	%w0, %w1, %w3\n"
 "	cbnz	%w0, 2f\n"
@@ -116,6 +119,7 @@ __LL_SC_PREFIX(atomic64_##op(long i, atomic64_t *v))			\
 	unsigned long tmp;						\
 									\
 	asm volatile("// atomic64_" #op "\n"				\
+"	prfm	pstl1strm, %2\n"					\
 "1:	ldxr	%0, %2\n"						\
 "	" #asm_op "	%0, %0, %3\n"					\
 "	stxr	%w1, %0, %2\n"						\
@@ -133,6 +137,7 @@ __LL_SC_PREFIX(atomic64_##op##_return(long i, atomic64_t *v))		\
 	unsigned long tmp;						\
 									\
 	asm volatile("// atomic64_" #op "_return\n"			\
+"	prfm	pstl1strm, %2\n"					\
 "1:	ldxr	%0, %2\n"						\
 "	" #asm_op "	%0, %0, %3\n"					\
 "	stlxr	%w1, %0, %2\n"						\
@@ -164,6 +169,7 @@ __LL_SC_PREFIX(atomic64_cmpxchg(atomic64_t *ptr, long old, long new))
 	unsigned long res;
 
 	asm volatile("// atomic64_cmpxchg\n"
+"	prfm	pstl1strm, %2\n"
 "1:	ldxr	%1, %2\n"
 "	eor	%0, %1, %3\n"
 "	cbnz	%w0, 2f\n"
@@ -186,6 +192,7 @@ __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
 	unsigned long tmp;
 
 	asm volatile("// atomic64_dec_if_positive\n"
+"	prfm	pstl1strm, %2\n"
 "1:	ldxr	%0, %2\n"
 "	subs	%0, %0, #1\n"
 "	b.mi	2f\n"
@@ -210,6 +217,7 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 	unsigned long tmp, oldval;					\
 									\
 	asm volatile(							\
+	"	prfm	pstl1strm, %2\n"				\
 	"1:	ldxr" #sz "\t%" #w "[oldval], %[v]\n"			\
 	"	eor	%" #w "[tmp], %" #w "[oldval], %" #w "[old]\n"	\
 	"	cbnz	%" #w "[tmp], 2f\n"				\
@@ -249,6 +257,7 @@ __LL_SC_PREFIX(__cmpxchg_double##name(unsigned long old1,		\
 	unsigned long tmp, ret;						\
 									\
 	asm volatile("// __cmpxchg_double" #name "\n"			\
+	"	prfm	pstl1strm, %2\n"				\
 	"1:	ldxp	%0, %1, %2\n"					\
 	"	eor	%0, %0, %3\n"					\
 	"	eor	%1, %1, %4\n"					\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index f70212629d02..7bfda0944c9b 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -33,12 +33,14 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 	case 1:
 		asm volatile(ARM64_LSE_ATOMIC_INSN(
 		/* LL/SC */
+		"	prfm	pstl1strm, %2\n"
 		"1:	ldxrb	%w0, %2\n"
 		"	stlxrb	%w1, %w3, %2\n"
 		"	cbnz	%w1, 1b\n"
 		"	dmb	ish",
 		/* LSE atomics */
 		"	nop\n"
+		"	nop\n"
 		"	swpalb	%w3, %w0, %2\n"
 		"	nop\n"
 		"	nop")
@@ -49,12 +51,14 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 	case 2:
 		asm volatile(ARM64_LSE_ATOMIC_INSN(
 		/* LL/SC */
+		"	prfm	pstl1strm, %2\n"
 		"1:	ldxrh	%w0, %2\n"
 		"	stlxrh	%w1, %w3, %2\n"
 		"	cbnz	%w1, 1b\n"
 		"	dmb	ish",
 		/* LSE atomics */
 		"	nop\n"
+		"	nop\n"
 		"	swpalh	%w3, %w0, %2\n"
 		"	nop\n"
 		"	nop")
@@ -65,12 +69,14 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 	case 4:
 		asm volatile(ARM64_LSE_ATOMIC_INSN(
 		/* LL/SC */
+		"	prfm	pstl1strm, %2\n"
 		"1:	ldxr	%w0, %2\n"
 		"	stlxr	%w1, %w3, %2\n"
 		"	cbnz	%w1, 1b\n"
 		"	dmb	ish",
 		/* LSE atomics */
 		"	nop\n"
+		"	nop\n"
 		"	swpal	%w3, %w0, %2\n"
 		"	nop\n"
 		"	nop")
@@ -81,12 +87,14 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 	case 8:
 		asm volatile(ARM64_LSE_ATOMIC_INSN(
 		/* LL/SC */
+		"	prfm	pstl1strm, %2\n"
 		"1:	ldxr	%0, %2\n"
 		"	stlxr	%w1, %3, %2\n"
 		"	cbnz	%w1, 1b\n"
 		"	dmb	ish",
 		/* LSE atomics */
 		"	nop\n"
+		"	nop\n"
 		"	swpal	%3, %0, %2\n"
 		"	nop\n"
 		"	nop")
diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index 74069b3bd919..a681608faf9a 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -24,6 +24,7 @@
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, tmp, oparg)		\
 	asm volatile(							\
+"	prfm	pstl1strm, %2\n"					\
 "1:	ldxr	%w1, %2\n"						\
 	insn "\n"							\
 "2:	stlxr	%w3, %w0, %2\n"						\
@@ -112,6 +113,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		return -EFAULT;
 
 	asm volatile("// futex_atomic_cmpxchg_inatomic\n"
+"	prfm	pstl1strm, %2\n"
 "1:	ldxr	%w1, %2\n"
 "	sub	%w3, %w1, %w4\n"
 "	cbnz	%w3, 3f\n"
diff --git a/arch/arm64/lib/bitops.S b/arch/arm64/lib/bitops.S
index bc18457c2bba..43ac736baa5b 100644
--- a/arch/arm64/lib/bitops.S
+++ b/arch/arm64/lib/bitops.S
@@ -31,6 +31,7 @@ ENTRY(	\name	)
 	eor	w0, w0, w3		// Clear low bits
 	mov	x2, #1
 	add	x1, x1, x0, lsr #3	// Get word offset
+alt_lse "	prfm	pstl1strm, [x1]",	"nop"
 	lsl	x3, x2, x3		// Create mask
 
 alt_lse	"1:	ldxr	x2, [x1]",		"\lse	x3, [x1]"
@@ -48,6 +49,7 @@ ENTRY(	\name	)
 	eor	w0, w0, w3		// Clear low bits
 	mov	x2, #1
 	add	x1, x1, x0, lsr #3	// Get word offset
+alt_lse "	prfm	pstl1strm, [x1]",	"nop"
 	lsl	x4, x2, x3		// Create mask
 
 alt_lse	"1:	ldxr	x2, [x1]",		"\lse	x4, x2, [x1]"
-- 
2.1.4
