From: will.deacon@arm.com (Will Deacon)
Date: Thu,  8 Oct 2015 20:15:18 +0100
Subject: [PATCH] arm64: atomics: implement native {relaxed, acquire,
 release} atomics
Message-ID: <1444331718-24036-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 654672d4ba1a ("locking/atomics: Add _{acquire|release|relaxed}()
variants of some atomic operation") introduced a relaxed atomic API to
Linux that maps nicely onto the arm64 memory model, including the new
ARMv8.1 atomic instructions.

This patch hooks up the API to our relaxed atomic instructions, rather
than have them all expand to the full-barrier variants as they do
currently.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic.h       |  63 +++++++-
 arch/arm64/include/asm/atomic_ll_sc.h |  98 +++++++-----
 arch/arm64/include/asm/atomic_lse.h   | 193 +++++++++++++----------
 arch/arm64/include/asm/cmpxchg.h      | 279 +++++++++++++++++-----------------
 4 files changed, 371 insertions(+), 262 deletions(-)

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 35a67783cfa0..5e13ad76a249 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -55,13 +55,42 @@
 
 #define atomic_read(v)			READ_ONCE((v)->counter)
 #define atomic_set(v, i)		(((v)->counter) = (i))
+
+#define atomic_add_return_relaxed	atomic_add_return_relaxed
+#define atomic_add_return_acquire	atomic_add_return_acquire
+#define atomic_add_return_release	atomic_add_return_release
+#define atomic_add_return		atomic_add_return
+
+#define atomic_inc_return_relaxed(v)	atomic_add_return_relaxed(1, (v))
+#define atomic_inc_return_acquire(v)	atomic_add_return_acquire(1, (v))
+#define atomic_inc_return_release(v)	atomic_add_return_release(1, (v))
+#define atomic_inc_return(v)		atomic_add_return(1, (v))
+
+#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
+#define atomic_sub_return_acquire	atomic_sub_return_acquire
+#define atomic_sub_return_release	atomic_sub_return_release
+#define atomic_sub_return		atomic_sub_return
+
+#define atomic_dec_return_relaxed(v)	atomic_sub_return_relaxed(1, (v))
+#define atomic_dec_return_acquire(v)	atomic_sub_return_acquire(1, (v))
+#define atomic_dec_return_release(v)	atomic_sub_return_release(1, (v))
+#define atomic_dec_return(v)		atomic_sub_return(1, (v))
+
+#define atomic_xchg_relaxed(v, new)	xchg_relaxed(&((v)->counter), (new))
+#define atomic_xchg_acquire(v, new)	xchg_acquire(&((v)->counter), (new))
+#define atomic_xchg_release(v, new)	xchg_release(&((v)->counter), (new))
 #define atomic_xchg(v, new)		xchg(&((v)->counter), (new))
+
+#define atomic_cmpxchg_relaxed(v, old, new)				\
+	cmpxchg_relaxed(&((v)->counter), (old), (new))
+#define atomic_cmpxchg_acquire(v, old, new)				\
+	cmpxchg_acquire(&((v)->counter), (old), (new))
+#define atomic_cmpxchg_release(v, old, new)				\
+	cmpxchg_release(&((v)->counter), (old), (new))
 #define atomic_cmpxchg(v, old, new)	cmpxchg(&((v)->counter), (old), (new))
 
 #define atomic_inc(v)			atomic_add(1, (v))
 #define atomic_dec(v)			atomic_sub(1, (v))
-#define atomic_inc_return(v)		atomic_add_return(1, (v))
-#define atomic_dec_return(v)		atomic_sub_return(1, (v))
 #define atomic_inc_and_test(v)		(atomic_inc_return(v) == 0)
 #define atomic_dec_and_test(v)		(atomic_dec_return(v) == 0)
 #define atomic_sub_and_test(i, v)	(atomic_sub_return((i), (v)) == 0)
@@ -75,13 +104,39 @@
 #define ATOMIC64_INIT			ATOMIC_INIT
 #define atomic64_read			atomic_read
 #define atomic64_set			atomic_set
+
+#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
+#define atomic64_add_return_acquire	atomic64_add_return_acquire
+#define atomic64_add_return_release	atomic64_add_return_release
+#define atomic64_add_return		atomic64_add_return
+
+#define atomic64_inc_return_relaxed(v)	atomic64_add_return_relaxed(1, (v))
+#define atomic64_inc_return_acquire(v)	atomic64_add_return_acquire(1, (v))
+#define atomic64_inc_return_release(v)	atomic64_add_return_release(1, (v))
+#define atomic64_inc_return(v)		atomic64_add_return(1, (v))
+
+#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
+#define atomic64_sub_return_acquire	atomic64_sub_return_acquire
+#define atomic64_sub_return_release	atomic64_sub_return_release
+#define atomic64_sub_return		atomic64_sub_return
+
+#define atomic64_dec_return_relaxed(v)	atomic64_sub_return_relaxed(1, (v))
+#define atomic64_dec_return_acquire(v)	atomic64_sub_return_acquire(1, (v))
+#define atomic64_dec_return_release(v)	atomic64_sub_return_release(1, (v))
+#define atomic64_dec_return(v)		atomic64_sub_return(1, (v))
+
+#define atomic64_xchg_relaxed		atomic_xchg_relaxed
+#define atomic64_xchg_acquire		atomic_xchg_acquire
+#define atomic64_xchg_release		atomic_xchg_release
 #define atomic64_xchg			atomic_xchg
+
+#define atomic64_cmpxchg_relaxed	atomic_cmpxchg_relaxed
+#define atomic64_cmpxchg_acquire	atomic_cmpxchg_acquire
+#define atomic64_cmpxchg_release	atomic_cmpxchg_release
 #define atomic64_cmpxchg		atomic_cmpxchg
 
 #define atomic64_inc(v)			atomic64_add(1, (v))
 #define atomic64_dec(v)			atomic64_sub(1, (v))
-#define atomic64_inc_return(v)		atomic64_add_return(1, (v))
-#define atomic64_dec_return(v)		atomic64_sub_return(1, (v))
 #define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
 #define atomic64_dec_and_test(v)	(atomic64_dec_return(v) == 0)
 #define atomic64_sub_and_test(i, v)	(atomic64_sub_return((i), (v)) == 0)
diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index b3b5c4ae3800..74d0b8eb0799 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -55,40 +55,47 @@ __LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
 }									\
 __LL_SC_EXPORT(atomic_##op);
 
-#define ATOMIC_OP_RETURN(op, asm_op)					\
+#define ATOMIC_OP_RETURN(name, mb, acq, rel, cl, op, asm_op)		\
 __LL_SC_INLINE int							\
-__LL_SC_PREFIX(atomic_##op##_return(int i, atomic_t *v))		\
+__LL_SC_PREFIX(atomic_##op##_return##name(int i, atomic_t *v))		\
 {									\
 	unsigned long tmp;						\
 	int result;							\
 									\
-	asm volatile("// atomic_" #op "_return\n"			\
+	asm volatile("// atomic_" #op "_return" #name "\n"		\
 "	prfm	pstl1strm, %2\n"					\
-"1:	ldxr	%w0, %2\n"						\
+"1:	ld" #acq "xr	%w0, %2\n"					\
 "	" #asm_op "	%w0, %w0, %w3\n"				\
-"	stlxr	%w1, %w0, %2\n"						\
-"	cbnz	%w1, 1b"						\
+"	st" #rel "xr	%w1, %w0, %2\n"					\
+"	cbnz	%w1, 1b\n"						\
+"	" #mb								\
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
 	: "Ir" (i)							\
-	: "memory");							\
+	: cl);								\
 									\
-	smp_mb();							\
 	return result;							\
 }									\
-__LL_SC_EXPORT(atomic_##op##_return);
+__LL_SC_EXPORT(atomic_##op##_return##name);
+
+#define ATOMIC_OPS(...)							\
+	ATOMIC_OP(__VA_ARGS__)						\
+	ATOMIC_OP_RETURN(        , dmb ish,  , l, "memory", __VA_ARGS__)
 
-#define ATOMIC_OPS(op, asm_op)						\
-	ATOMIC_OP(op, asm_op)						\
-	ATOMIC_OP_RETURN(op, asm_op)
+#define ATOMIC_OPS_RLX(...)						\
+	ATOMIC_OPS(__VA_ARGS__)						\
+	ATOMIC_OP_RETURN(_relaxed,        ,  ,  ,         , __VA_ARGS__)\
+	ATOMIC_OP_RETURN(_acquire,        , a,  , "memory", __VA_ARGS__)\
+	ATOMIC_OP_RETURN(_release,        ,  , l, "memory", __VA_ARGS__)
 
-ATOMIC_OPS(add, add)
-ATOMIC_OPS(sub, sub)
+ATOMIC_OPS_RLX(add, add)
+ATOMIC_OPS_RLX(sub, sub)
 
 ATOMIC_OP(and, and)
 ATOMIC_OP(andnot, bic)
 ATOMIC_OP(or, orr)
 ATOMIC_OP(xor, eor)
 
+#undef ATOMIC_OPS_RLX
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
@@ -111,40 +118,47 @@ __LL_SC_PREFIX(atomic64_##op(long i, atomic64_t *v))			\
 }									\
 __LL_SC_EXPORT(atomic64_##op);
 
-#define ATOMIC64_OP_RETURN(op, asm_op)					\
+#define ATOMIC64_OP_RETURN(name, mb, acq, rel, cl, op, asm_op)		\
 __LL_SC_INLINE long							\
-__LL_SC_PREFIX(atomic64_##op##_return(long i, atomic64_t *v))		\
+__LL_SC_PREFIX(atomic64_##op##_return##name(long i, atomic64_t *v))	\
 {									\
 	long result;							\
 	unsigned long tmp;						\
 									\
-	asm volatile("// atomic64_" #op "_return\n"			\
+	asm volatile("// atomic64_" #op "_return" #name "\n"		\
 "	prfm	pstl1strm, %2\n"					\
-"1:	ldxr	%0, %2\n"						\
+"1:	ld" #acq "xr	%0, %2\n"					\
 "	" #asm_op "	%0, %0, %3\n"					\
-"	stlxr	%w1, %0, %2\n"						\
-"	cbnz	%w1, 1b"						\
+"	st" #rel "xr	%w1, %0, %2\n"					\
+"	cbnz	%w1, 1b\n"						\
+"	" #mb								\
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
 	: "Ir" (i)							\
-	: "memory");							\
+	: cl);								\
 									\
-	smp_mb();							\
 	return result;							\
 }									\
-__LL_SC_EXPORT(atomic64_##op##_return);
+__LL_SC_EXPORT(atomic64_##op##_return##name);
+
+#define ATOMIC64_OPS(...)						\
+	ATOMIC64_OP(__VA_ARGS__)					\
+	ATOMIC64_OP_RETURN(, dmb ish,  , l, "memory", __VA_ARGS__)
 
-#define ATOMIC64_OPS(op, asm_op)					\
-	ATOMIC64_OP(op, asm_op)						\
-	ATOMIC64_OP_RETURN(op, asm_op)
+#define ATOMIC64_OPS_RLX(...)						\
+	ATOMIC64_OPS(__VA_ARGS__)					\
+	ATOMIC64_OP_RETURN(_relaxed,,  ,  ,         , __VA_ARGS__)	\
+	ATOMIC64_OP_RETURN(_acquire,, a,  , "memory", __VA_ARGS__)	\
+	ATOMIC64_OP_RETURN(_release,,  , l, "memory", __VA_ARGS__)
 
-ATOMIC64_OPS(add, add)
-ATOMIC64_OPS(sub, sub)
+ATOMIC64_OPS_RLX(add, add)
+ATOMIC64_OPS_RLX(sub, sub)
 
 ATOMIC64_OP(and, and)
 ATOMIC64_OP(andnot, bic)
 ATOMIC64_OP(or, orr)
 ATOMIC64_OP(xor, eor)
 
+#undef ATOMIC64_OPS_RLX
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
@@ -172,7 +186,7 @@ __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
 }
 __LL_SC_EXPORT(atomic64_dec_if_positive);
 
-#define __CMPXCHG_CASE(w, sz, name, mb, rel, cl)			\
+#define __CMPXCHG_CASE(w, sz, name, mb, acq, rel, cl)			\
 __LL_SC_INLINE unsigned long						\
 __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 				     unsigned long old,			\
@@ -182,7 +196,7 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 									\
 	asm volatile(							\
 	"	prfm	pstl1strm, %[v]\n"				\
-	"1:	ldxr" #sz "\t%" #w "[oldval], %[v]\n"			\
+	"1:	ld" #acq "xr" #sz "\t%" #w "[oldval], %[v]\n"		\
 	"	eor	%" #w "[tmp], %" #w "[oldval], %" #w "[old]\n"	\
 	"	cbnz	%" #w "[tmp], 2f\n"				\
 	"	st" #rel "xr" #sz "\t%w[tmp], %" #w "[new], %[v]\n"	\
@@ -199,14 +213,22 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 }									\
 __LL_SC_EXPORT(__cmpxchg_case_##name);
 
-__CMPXCHG_CASE(w, b,    1,        ,  ,         )
-__CMPXCHG_CASE(w, h,    2,        ,  ,         )
-__CMPXCHG_CASE(w,  ,    4,        ,  ,         )
-__CMPXCHG_CASE( ,  ,    8,        ,  ,         )
-__CMPXCHG_CASE(w, b, mb_1, dmb ish, l, "memory")
-__CMPXCHG_CASE(w, h, mb_2, dmb ish, l, "memory")
-__CMPXCHG_CASE(w,  , mb_4, dmb ish, l, "memory")
-__CMPXCHG_CASE( ,  , mb_8, dmb ish, l, "memory")
+__CMPXCHG_CASE(w, b,     1,        ,  ,  ,         )
+__CMPXCHG_CASE(w, h,     2,        ,  ,  ,         )
+__CMPXCHG_CASE(w,  ,     4,        ,  ,  ,         )
+__CMPXCHG_CASE( ,  ,     8,        ,  ,  ,         )
+__CMPXCHG_CASE(w, b, acq_1,        , a,  , "memory")
+__CMPXCHG_CASE(w, h, acq_2,        , a,  , "memory")
+__CMPXCHG_CASE(w,  , acq_4,        , a,  , "memory")
+__CMPXCHG_CASE( ,  , acq_8,        , a,  , "memory")
+__CMPXCHG_CASE(w, b, rel_1,        ,  , l, "memory")
+__CMPXCHG_CASE(w, h, rel_2,        ,  , l, "memory")
+__CMPXCHG_CASE(w,  , rel_4,        ,  , l, "memory")
+__CMPXCHG_CASE( ,  , rel_8,        ,  , l, "memory")
+__CMPXCHG_CASE(w, b,  mb_1, dmb ish,  , l, "memory")
+__CMPXCHG_CASE(w, h,  mb_2, dmb ish,  , l, "memory")
+__CMPXCHG_CASE(w,  ,  mb_4, dmb ish,  , l, "memory")
+__CMPXCHG_CASE( ,  ,  mb_8, dmb ish,  , l, "memory")
 
 #undef __CMPXCHG_CASE
 
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 55d740e63459..1fce7908e690 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -75,24 +75,32 @@ static inline void atomic_add(int i, atomic_t *v)
 	: "x30");
 }
 
-static inline int atomic_add_return(int i, atomic_t *v)
-{
-	register int w0 asm ("w0") = i;
-	register atomic_t *x1 asm ("x1") = v;
+#define ATOMIC_OP_ADD_RETURN(name, mb, cl...)				\
+static inline int atomic_add_return##name(int i, atomic_t *v)		\
+{									\
+	register int w0 asm ("w0") = i;					\
+	register atomic_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"	nop\n"							\
+	__LL_SC_ATOMIC(add_return##name),				\
+	/* LSE atomics */						\
+	"	ldadd" #mb "	%w[i], w30, %[v]\n"			\
+	"	add	%w[i], %w[i], w30")				\
+	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: "x30" , ##cl);						\
+									\
+	return w0;							\
+}
 
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-	"	nop\n"
-	__LL_SC_ATOMIC(add_return),
-	/* LSE atomics */
-	"	ldaddal	%w[i], w30, %[v]\n"
-	"	add	%w[i], %w[i], w30")
-	: [i] "+r" (w0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: "x30", "memory");
+ATOMIC_OP_ADD_RETURN(_relaxed,   )
+ATOMIC_OP_ADD_RETURN(_acquire,  a, "memory")
+ATOMIC_OP_ADD_RETURN(_release,  l, "memory")
+ATOMIC_OP_ADD_RETURN(        , al, "memory")
 
-	return w0;
-}
+#undef ATOMIC_OP_ADD_RETURN
 
 static inline void atomic_and(int i, atomic_t *v)
 {
@@ -128,27 +136,34 @@ static inline void atomic_sub(int i, atomic_t *v)
 	: "x30");
 }
 
-static inline int atomic_sub_return(int i, atomic_t *v)
-{
-	register int w0 asm ("w0") = i;
-	register atomic_t *x1 asm ("x1") = v;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-	"	nop\n"
-	__LL_SC_ATOMIC(sub_return)
-	"	nop",
-	/* LSE atomics */
-	"	neg	%w[i], %w[i]\n"
-	"	ldaddal	%w[i], w30, %[v]\n"
-	"	add	%w[i], %w[i], w30")
-	: [i] "+r" (w0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: "x30", "memory");
-
-	return w0;
+#define ATOMIC_OP_SUB_RETURN(name, mb, cl...)				\
+static inline int atomic_sub_return##name(int i, atomic_t *v)		\
+{									\
+	register int w0 asm ("w0") = i;					\
+	register atomic_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"	nop\n"							\
+	__LL_SC_ATOMIC(sub_return##name)				\
+	"	nop",							\
+	/* LSE atomics */						\
+	"	neg	%w[i], %w[i]\n"					\
+	"	ldadd" #mb "	%w[i], w30, %[v]\n"			\
+	"	add	%w[i], %w[i], w30")				\
+	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: "x30" , ##cl);						\
+									\
+	return w0;							\
 }
 
+ATOMIC_OP_SUB_RETURN(_relaxed,   )
+ATOMIC_OP_SUB_RETURN(_acquire,  a, "memory")
+ATOMIC_OP_SUB_RETURN(_release,  l, "memory")
+ATOMIC_OP_SUB_RETURN(        , al, "memory")
+
+#undef ATOMIC_OP_SUB_RETURN
 #undef __LL_SC_ATOMIC
 
 #define __LL_SC_ATOMIC64(op)	__LL_SC_CALL(atomic64_##op)
@@ -201,24 +216,32 @@ static inline void atomic64_add(long i, atomic64_t *v)
 	: "x30");
 }
 
-static inline long atomic64_add_return(long i, atomic64_t *v)
-{
-	register long x0 asm ("x0") = i;
-	register atomic64_t *x1 asm ("x1") = v;
+#define ATOMIC64_OP_ADD_RETURN(name, mb, cl...)				\
+static inline long atomic64_add_return##name(long i, atomic64_t *v)	\
+{									\
+	register long x0 asm ("x0") = i;				\
+	register atomic64_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"	nop\n"							\
+	__LL_SC_ATOMIC64(add_return##name),				\
+	/* LSE atomics */						\
+	"	ldadd" #mb "	%[i], x30, %[v]\n"			\
+	"	add	%[i], %[i], x30")				\
+	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: "x30" , ##cl);						\
+									\
+	return x0;							\
+}
 
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-	"	nop\n"
-	__LL_SC_ATOMIC64(add_return),
-	/* LSE atomics */
-	"	ldaddal	%[i], x30, %[v]\n"
-	"	add	%[i], %[i], x30")
-	: [i] "+r" (x0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: "x30", "memory");
+ATOMIC64_OP_ADD_RETURN(_relaxed,   )
+ATOMIC64_OP_ADD_RETURN(_acquire,  a, "memory")
+ATOMIC64_OP_ADD_RETURN(_release,  l, "memory")
+ATOMIC64_OP_ADD_RETURN(        , al, "memory")
 
-	return x0;
-}
+#undef ATOMIC64_OP_ADD_RETURN
 
 static inline void atomic64_and(long i, atomic64_t *v)
 {
@@ -254,26 +277,34 @@ static inline void atomic64_sub(long i, atomic64_t *v)
 	: "x30");
 }
 
-static inline long atomic64_sub_return(long i, atomic64_t *v)
-{
-	register long x0 asm ("x0") = i;
-	register atomic64_t *x1 asm ("x1") = v;
+#define ATOMIC64_OP_SUB_RETURN(name, mb, cl...)				\
+static inline long atomic64_sub_return##name(long i, atomic64_t *v)	\
+{									\
+	register long x0 asm ("x0") = i;				\
+	register atomic64_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"	nop\n"							\
+	__LL_SC_ATOMIC64(sub_return##name)				\
+	"	nop",							\
+	/* LSE atomics */						\
+	"	neg	%[i], %[i]\n"					\
+	"	ldadd" #mb "	%[i], x30, %[v]\n"			\
+	"	add	%[i], %[i], x30")				\
+	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
+	: "r" (x1)							\
+	: "x30" , ##cl);						\
+									\
+	return x0;							\
+}
 
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-	"	nop\n"
-	__LL_SC_ATOMIC64(sub_return)
-	"	nop",
-	/* LSE atomics */
-	"	neg	%[i], %[i]\n"
-	"	ldaddal	%[i], x30, %[v]\n"
-	"	add	%[i], %[i], x30")
-	: [i] "+r" (x0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: "x30", "memory");
+ATOMIC64_OP_SUB_RETURN(_relaxed,   )
+ATOMIC64_OP_SUB_RETURN(_acquire,  a, "memory")
+ATOMIC64_OP_SUB_RETURN(_release,  l, "memory")
+ATOMIC64_OP_SUB_RETURN(        , al, "memory")
 
-	return x0;
-}
+#undef ATOMIC64_OP_SUB_RETURN
 
 static inline long atomic64_dec_if_positive(atomic64_t *v)
 {
@@ -333,14 +364,22 @@ static inline unsigned long __cmpxchg_case_##name(volatile void *ptr,	\
 	return x0;							\
 }
 
-__CMPXCHG_CASE(w, b,    1,   )
-__CMPXCHG_CASE(w, h,    2,   )
-__CMPXCHG_CASE(w,  ,    4,   )
-__CMPXCHG_CASE(x,  ,    8,   )
-__CMPXCHG_CASE(w, b, mb_1, al, "memory")
-__CMPXCHG_CASE(w, h, mb_2, al, "memory")
-__CMPXCHG_CASE(w,  , mb_4, al, "memory")
-__CMPXCHG_CASE(x,  , mb_8, al, "memory")
+__CMPXCHG_CASE(w, b,     1,   )
+__CMPXCHG_CASE(w, h,     2,   )
+__CMPXCHG_CASE(w,  ,     4,   )
+__CMPXCHG_CASE(x,  ,     8,   )
+__CMPXCHG_CASE(w, b, acq_1,  a, "memory")
+__CMPXCHG_CASE(w, h, acq_2,  a, "memory")
+__CMPXCHG_CASE(w,  , acq_4,  a, "memory")
+__CMPXCHG_CASE(x,  , acq_8,  a, "memory")
+__CMPXCHG_CASE(w, b, rel_1,  l, "memory")
+__CMPXCHG_CASE(w, h, rel_2,  l, "memory")
+__CMPXCHG_CASE(w,  , rel_4,  l, "memory")
+__CMPXCHG_CASE(x,  , rel_8,  l, "memory")
+__CMPXCHG_CASE(w, b,  mb_1, al, "memory")
+__CMPXCHG_CASE(w, h,  mb_2, al, "memory")
+__CMPXCHG_CASE(w,  ,  mb_4, al, "memory")
+__CMPXCHG_CASE(x,  ,  mb_8, al, "memory")
 
 #undef __LL_SC_CMPXCHG
 #undef __CMPXCHG_CASE
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 899e9f1d19e4..9ea611ea69df 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -25,154 +25,151 @@
 #include <asm/barrier.h>
 #include <asm/lse.h>
 
-static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
-{
-	unsigned long ret, tmp;
-
-	switch (size) {
-	case 1:
-		asm volatile(ARM64_LSE_ATOMIC_INSN(
-		/* LL/SC */
-		"	prfm	pstl1strm, %2\n"
-		"1:	ldxrb	%w0, %2\n"
-		"	stlxrb	%w1, %w3, %2\n"
-		"	cbnz	%w1, 1b\n"
-		"	dmb	ish",
-		/* LSE atomics */
-		"	nop\n"
-		"	nop\n"
-		"	swpalb	%w3, %w0, %2\n"
-		"	nop\n"
-		"	nop")
-			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u8 *)ptr)
-			: "r" (x)
-			: "memory");
-		break;
-	case 2:
-		asm volatile(ARM64_LSE_ATOMIC_INSN(
-		/* LL/SC */
-		"	prfm	pstl1strm, %2\n"
-		"1:	ldxrh	%w0, %2\n"
-		"	stlxrh	%w1, %w3, %2\n"
-		"	cbnz	%w1, 1b\n"
-		"	dmb	ish",
-		/* LSE atomics */
-		"	nop\n"
-		"	nop\n"
-		"	swpalh	%w3, %w0, %2\n"
-		"	nop\n"
-		"	nop")
-			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u16 *)ptr)
-			: "r" (x)
-			: "memory");
-		break;
-	case 4:
-		asm volatile(ARM64_LSE_ATOMIC_INSN(
-		/* LL/SC */
-		"	prfm	pstl1strm, %2\n"
-		"1:	ldxr	%w0, %2\n"
-		"	stlxr	%w1, %w3, %2\n"
-		"	cbnz	%w1, 1b\n"
-		"	dmb	ish",
-		/* LSE atomics */
-		"	nop\n"
-		"	nop\n"
-		"	swpal	%w3, %w0, %2\n"
-		"	nop\n"
-		"	nop")
-			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u32 *)ptr)
-			: "r" (x)
-			: "memory");
-		break;
-	case 8:
-		asm volatile(ARM64_LSE_ATOMIC_INSN(
-		/* LL/SC */
-		"	prfm	pstl1strm, %2\n"
-		"1:	ldxr	%0, %2\n"
-		"	stlxr	%w1, %3, %2\n"
-		"	cbnz	%w1, 1b\n"
-		"	dmb	ish",
-		/* LSE atomics */
-		"	nop\n"
-		"	nop\n"
-		"	swpal	%3, %0, %2\n"
-		"	nop\n"
-		"	nop")
-			: "=&r" (ret), "=&r" (tmp), "+Q" (*(u64 *)ptr)
-			: "r" (x)
-			: "memory");
-		break;
-	default:
-		BUILD_BUG();
-	}
-
-	return ret;
+/*
+ * We need separate acquire parameters for ll/sc and lse, since the full
+ * barrier case is generated as release+dmb for the former and
+ * acquire+release for the latter.
+ */
+#define __XCHG_CASE(w, sz, name, mb, nop_lse, acq, acq_lse, rel, cl)	\
+static inline unsigned long __xchg_case_##name(unsigned long x,		\
+					       volatile void *ptr)	\
+{									\
+	unsigned long ret, tmp;						\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"	prfm	pstl1strm, %2\n"				\
+	"1:	ld" #acq "xr" #sz "\t%" #w "0, %2\n"			\
+	"	st" #rel "xr" #sz "\t%w1, %" #w "3, %2\n"		\
+	"	cbnz	%w1, 1b\n"					\
+	"	" #mb,							\
+	/* LSE atomics */						\
+	"	nop\n"							\
+	"	nop\n"							\
+	"	swp" #acq_lse #rel #sz "\t%" #w "3, %" #w "0, %2\n"	\
+	"	nop\n"							\
+	"	" #nop_lse)						\
+	: "=&r" (ret), "=&r" (tmp), "+Q" (*(u8 *)ptr)			\
+	: "r" (x)							\
+	: cl);								\
+									\
+	return ret;							\
 }
 
-#define xchg(ptr,x) \
-({ \
-	__typeof__(*(ptr)) __ret; \
-	__ret = (__typeof__(*(ptr))) \
-		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))); \
-	__ret; \
+__XCHG_CASE(w, b,     1,        ,    ,  ,  ,  ,         )
+__XCHG_CASE(w, h,     2,        ,    ,  ,  ,  ,         )
+__XCHG_CASE(w,  ,     4,        ,    ,  ,  ,  ,         )
+__XCHG_CASE( ,  ,     8,        ,    ,  ,  ,  ,         )
+__XCHG_CASE(w, b, acq_1,        ,    , a, a,  , "memory")
+__XCHG_CASE(w, h, acq_2,        ,    , a, a,  , "memory")
+__XCHG_CASE(w,  , acq_4,        ,    , a, a,  , "memory")
+__XCHG_CASE( ,  , acq_8,        ,    , a, a,  , "memory")
+__XCHG_CASE(w, b, rel_1,        ,    ,  ,  , l, "memory")
+__XCHG_CASE(w, h, rel_2,        ,    ,  ,  , l, "memory")
+__XCHG_CASE(w,  , rel_4,        ,    ,  ,  , l, "memory")
+__XCHG_CASE( ,  , rel_8,        ,    ,  ,  , l, "memory")
+__XCHG_CASE(w, b,  mb_1, dmb ish, nop,  , a, l, "memory")
+__XCHG_CASE(w, h,  mb_2, dmb ish, nop,  , a, l, "memory")
+__XCHG_CASE(w,  ,  mb_4, dmb ish, nop,  , a, l, "memory")
+__XCHG_CASE( ,  ,  mb_8, dmb ish, nop,  , a, l, "memory")
+
+#undef __XCHG_CASE
+
+#define __XCHG_GEN(sfx)							\
+static inline unsigned long __xchg##sfx(unsigned long x,		\
+					volatile void *ptr,		\
+					int size)			\
+{									\
+	switch (size) {							\
+	case 1:								\
+		return __xchg_case##sfx##_1(x, ptr);			\
+	case 2:								\
+		return __xchg_case##sfx##_2(x, ptr);			\
+	case 4:								\
+		return __xchg_case##sfx##_4(x, ptr);			\
+	case 8:								\
+		return __xchg_case##sfx##_8(x, ptr);			\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+									\
+	unreachable();							\
+}
+
+__XCHG_GEN()
+__XCHG_GEN(_acq)
+__XCHG_GEN(_rel)
+__XCHG_GEN(_mb)
+
+#undef __XCHG_GEN
+
+#define __xchg_wrapper(sfx, ptr, x)					\
+({									\
+	__typeof__(*(ptr)) __ret;					\
+	__ret = (__typeof__(*(ptr)))					\
+		__xchg##sfx((unsigned long)(x), (ptr), sizeof(*(ptr))); \
+	__ret;								\
 })
 
-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-				      unsigned long new, int size)
-{
-	switch (size) {
-	case 1:
-		return __cmpxchg_case_1(ptr, (u8)old, new);
-	case 2:
-		return __cmpxchg_case_2(ptr, (u16)old, new);
-	case 4:
-		return __cmpxchg_case_4(ptr, old, new);
-	case 8:
-		return __cmpxchg_case_8(ptr, old, new);
-	default:
-		BUILD_BUG();
-	}
-
-	unreachable();
+/* xchg */
+#define xchg_relaxed(...)	__xchg_wrapper(    , __VA_ARGS__)
+#define xchg_acquire(...)	__xchg_wrapper(_acq, __VA_ARGS__)
+#define xchg_release(...)	__xchg_wrapper(_rel, __VA_ARGS__)
+#define xchg(...)		__xchg_wrapper( _mb, __VA_ARGS__)
+
+#define __CMPXCHG_GEN(sfx)						\
+static inline unsigned long __cmpxchg##sfx(volatile void *ptr,		\
+					   unsigned long old,		\
+					   unsigned long new,		\
+					   int size)			\
+{									\
+	switch (size) {							\
+	case 1:								\
+		return __cmpxchg_case##sfx##_1(ptr, (u8)old, new);	\
+	case 2:								\
+		return __cmpxchg_case##sfx##_2(ptr, (u16)old, new);	\
+	case 4:								\
+		return __cmpxchg_case##sfx##_4(ptr, old, new);		\
+	case 8:								\
+		return __cmpxchg_case##sfx##_8(ptr, old, new);		\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+									\
+	unreachable();							\
 }
 
-static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
-					 unsigned long new, int size)
-{
-	switch (size) {
-	case 1:
-		return __cmpxchg_case_mb_1(ptr, (u8)old, new);
-	case 2:
-		return __cmpxchg_case_mb_2(ptr, (u16)old, new);
-	case 4:
-		return __cmpxchg_case_mb_4(ptr, old, new);
-	case 8:
-		return __cmpxchg_case_mb_8(ptr, old, new);
-	default:
-		BUILD_BUG();
-	}
-
-	unreachable();
-}
+__CMPXCHG_GEN()
+__CMPXCHG_GEN(_acq)
+__CMPXCHG_GEN(_rel)
+__CMPXCHG_GEN(_mb)
 
-#define cmpxchg(ptr, o, n) \
-({ \
-	__typeof__(*(ptr)) __ret; \
-	__ret = (__typeof__(*(ptr))) \
-		__cmpxchg_mb((ptr), (unsigned long)(o), (unsigned long)(n), \
-			     sizeof(*(ptr))); \
-	__ret; \
-})
+#undef __CMPXCHG_GEN
 
-#define cmpxchg_local(ptr, o, n) \
-({ \
-	__typeof__(*(ptr)) __ret; \
-	__ret = (__typeof__(*(ptr))) \
-		__cmpxchg((ptr), (unsigned long)(o), \
-			  (unsigned long)(n), sizeof(*(ptr))); \
-	__ret; \
+#define __cmpxchg_wrapper(sfx, ptr, o, n)				\
+({									\
+	__typeof__(*(ptr)) __ret;					\
+	__ret = (__typeof__(*(ptr)))					\
+		__cmpxchg##sfx((ptr), (unsigned long)(o),		\
+				(unsigned long)(n), sizeof(*(ptr)));	\
+	__ret;								\
 })
 
+/* cmpxchg */
+#define cmpxchg_relaxed(...)	__cmpxchg_wrapper(    , __VA_ARGS__)
+#define cmpxchg_acquire(...)	__cmpxchg_wrapper(_acq, __VA_ARGS__)
+#define cmpxchg_release(...)	__cmpxchg_wrapper(_rel, __VA_ARGS__)
+#define cmpxchg(...)		__cmpxchg_wrapper( _mb, __VA_ARGS__)
+#define cmpxchg_local		cmpxchg_relaxed
+
+/* cmpxchg64 */
+#define cmpxchg64_relaxed	cmpxchg_relaxed
+#define cmpxchg64_acquire	cmpxchg_acquire
+#define cmpxchg64_release	cmpxchg_release
+#define cmpxchg64		cmpxchg
+#define cmpxchg64_local		cmpxchg_local
+
+/* cmpxchg_double */
 #define system_has_cmpxchg_double()     1
 
 #define __cmpxchg_double_check(ptr1, ptr2)					\
@@ -202,6 +199,7 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 	__ret; \
 })
 
+/* this_cpu_cmpxchg */
 #define _protect_cmpxchg_local(pcp, o, n)			\
 ({								\
 	typeof(*raw_cpu_ptr(&(pcp))) __ret;			\
@@ -227,9 +225,4 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 	__ret;								\
 })
 
-#define cmpxchg64(ptr,o,n)		cmpxchg((ptr),(o),(n))
-#define cmpxchg64_local(ptr,o,n)	cmpxchg_local((ptr),(o),(n))
-
-#define cmpxchg64_relaxed(ptr,o,n)	cmpxchg_local((ptr),(o),(n))
-
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.1.4
