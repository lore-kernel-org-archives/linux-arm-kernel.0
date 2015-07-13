From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:17 +0100
Subject: [PATCH 16/18] arm64: atomics: implement atomic{,
 64}_cmpxchg using cmpxchg
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-17-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need duplicate cmpxchg implementations, so use cmpxchg to
implement atomic{,64}_cmpxchg, like we do for xchg already.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic.h       |  2 ++
 arch/arm64/include/asm/atomic_ll_sc.h | 46 -----------------------------------
 arch/arm64/include/asm/atomic_lse.h   | 35 --------------------------
 3 files changed, 2 insertions(+), 81 deletions(-)

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 51816ab2312d..b4eff63be0ff 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -56,6 +56,7 @@
 #define atomic_read(v)			READ_ONCE((v)->counter)
 #define atomic_set(v, i)		(((v)->counter) = (i))
 #define atomic_xchg(v, new)		xchg(&((v)->counter), (new))
+#define atomic_cmpxchg(v, old, new)	cmpxchg(&((v)->counter), (old), (new))
 
 #define atomic_inc(v)			atomic_add(1, (v))
 #define atomic_dec(v)			atomic_sub(1, (v))
@@ -74,6 +75,7 @@
 #define atomic64_read			atomic_read
 #define atomic64_set			atomic_set
 #define atomic64_xchg			atomic_xchg
+#define atomic64_cmpxchg		atomic_cmpxchg
 
 #define atomic64_inc(v)			atomic64_add(1, (v))
 #define atomic64_dec(v)			atomic64_sub(1, (v))
diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index 652877fefae6..cbaedf9afb2f 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -88,29 +88,6 @@ ATOMIC_OPS(sub, sub)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-__LL_SC_INLINE int
-__LL_SC_PREFIX(atomic_cmpxchg(atomic_t *ptr, int old, int new))
-{
-	unsigned long tmp;
-	int oldval;
-
-	asm volatile("// atomic_cmpxchg\n"
-"	prfm	pstl1strm, %2\n"
-"1:	ldxr	%w1, %2\n"
-"	eor	%w0, %w1, %w3\n"
-"	cbnz	%w0, 2f\n"
-"	stlxr	%w0, %w4, %2\n"
-"	cbnz	%w0, 1b\n"
-"	dmb	ish\n"
-"2:"
-	: "=&r" (tmp), "=&r" (oldval), "+Q" (ptr->counter)
-	: "Lr" (old), "r" (new)
-	: "memory");
-
-	return oldval;
-}
-__LL_SC_EXPORT(atomic_cmpxchg);
-
 #define ATOMIC64_OP(op, asm_op)						\
 __LL_SC_INLINE void							\
 __LL_SC_PREFIX(atomic64_##op(long i, atomic64_t *v))			\
@@ -163,29 +140,6 @@ ATOMIC64_OPS(sub, sub)
 #undef ATOMIC64_OP
 
 __LL_SC_INLINE long
-__LL_SC_PREFIX(atomic64_cmpxchg(atomic64_t *ptr, long old, long new))
-{
-	long oldval;
-	unsigned long res;
-
-	asm volatile("// atomic64_cmpxchg\n"
-"	prfm	pstl1strm, %2\n"
-"1:	ldxr	%1, %2\n"
-"	eor	%0, %1, %3\n"
-"	cbnz	%w0, 2f\n"
-"	stlxr	%w0, %4, %2\n"
-"	cbnz	%w0, 1b\n"
-"	dmb	ish\n"
-"2:"
-	: "=&r" (res), "=&r" (oldval), "+Q" (ptr->counter)
-	: "Lr" (old), "r" (new)
-	: "memory");
-
-	return oldval;
-}
-__LL_SC_EXPORT(atomic64_cmpxchg);
-
-__LL_SC_INLINE long
 __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
 {
 	long result;
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 7adee6656d42..6a2bbdfcf290 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -92,24 +92,6 @@ static inline int atomic_sub_return(int i, atomic_t *v)
 	return w0;
 }
 
-static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
-{
-	unsigned long tmp;
-	register unsigned long x0 asm ("x0") = (unsigned long)ptr;
-	register int w1 asm ("w1") = old;
-	register int w2 asm ("w2") = new;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(cmpxchg, %[tmp]),
-	"	mov	%w[tmp], %w[old]\n"
-	"	casal	%w[tmp], %w[new], %[v]\n"
-	"	mov	%w[ret], %w[tmp]")
-	: [tmp] "=&r" (tmp), [ret] "+r" (x0), [v] "+Q" (ptr->counter)
-	: [old] "r" (w1), [new] "r" (w2)
-	: "memory");
-
-	return x0;
-}
-
 #undef __LL_SC_ATOMIC
 
 #define __LL_SC_ATOMIC64(op, tmp)					\
@@ -178,23 +160,6 @@ static inline long atomic64_sub_return(long i, atomic64_t *v)
 
 	return x0;
 }
-static inline long atomic64_cmpxchg(atomic64_t *ptr, long old, long new)
-{
-	unsigned long tmp;
-	register unsigned long x0 asm ("x0") = (unsigned long)ptr;
-	register long x1 asm ("x1") = old;
-	register long x2 asm ("x2") = new;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(cmpxchg, %[tmp]),
-	"	mov	%[tmp], %[old]\n"
-	"	casal	%[tmp], %[new], %[v]\n"
-	"	mov	%[ret], %[tmp]")
-	: [tmp] "=&r" (tmp), [ret] "+r" (x0), [v] "+Q" (ptr->counter)
-	: [old] "r" (x1), [new] "r" (x2)
-	: "memory");
-
-	return x0;
-}
 
 static inline long atomic64_dec_if_positive(atomic64_t *v)
 {
-- 
2.1.4
