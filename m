From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Nov 2018 15:39:22 -0800
Subject: [PATCH 2/3] arm64/atomics: use subsections for out of line LL/SC
 alternatives
In-Reply-To: <20181113233923.20098-1-ard.biesheuvel@linaro.org>
References: <20181113233923.20098-1-ard.biesheuvel@linaro.org>
Message-ID: <20181113233923.20098-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building with support for LSE atomics, the LL/SC alternative are
emitted as functions, and 'bl' instructions are patched into the code
stream to call them instead of the LSE instructions when the CPU does
not support LSE.

This has some downsides: the LSE atomics are coded up in such a way
that the asm input registers are always aligned with the prototypes
of the out of line alternatives, limiting the freedom the compiler
to allocate registers. Also, the registers x16, x17 and x30 need to
be added to the clobber list, given that those may be corrupted by
a function call. Unfortunately, we still end up with stack spills in
the out of line alternatives that requires 3 temp registers, due to
the fact that x30 needs to be preserved to be able to return.

Also, doing function calls from inline assembler is likely to become
more of a maintenance burden going forward, due to the introduction
of live patching (which requires reliable stack traces), code flow
integrity, Clang support etc etc.

So instead, let's use subsections to emit the out of line alternatives,
but as part of the inline asm expansion so that the compiler is in
charge of the register allocation. The number of allocated registers
still exceeds what LSE actually needs, but the compiler is free to
select them, and the out of line alternatives will no longer require
to spill x30.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/atomic_ll_sc.h |   3 +
 arch/arm64/include/asm/atomic_lse.h   | 558 ++++++++++----------
 arch/arm64/include/asm/lse.h          |   4 -
 3 files changed, 285 insertions(+), 280 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index 5f55f6b8dd7e..10d0b7360747 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -82,6 +82,8 @@
 "	" #mb "							\n"	\
 "2:"									\
 
+#if !(defined(CONFIG_ARM64_LSE_ATOMICS) && defined(CONFIG_AS_LSE))
+
 #define ATOMIC_OP(op, asm_op)						\
 __LL_SC_INLINE void							\
 __LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
@@ -332,4 +334,5 @@ __CMPXCHG_DBL(_mb, dmb ish, l, "memory")
 
 #undef __CMPXCHG_DBL
 
+#endif	/* !(defined(CONFIG_ARM64_LSE_ATOMICS) && defined(CONFIG_AS_LSE)) */
 #endif	/* __ASM_ATOMIC_LL_SC_H */
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index f9b0b09153e0..70bae15cc8d6 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -25,510 +25,516 @@
 #error "please don't include this file directly"
 #endif
 
-#define __LL_SC_ATOMIC(op)	__LL_SC_CALL(atomic_##op)
-#define ATOMIC_OP(op, asm_op)						\
+#include <asm/atomic_ll_sc.h>
+
+#define __LL_SC_ATOMIC(op)						\
+"	b		3f					\n"	\
+"	.subsection	1					\n"	\
+"3:			" op "					\n"	\
+"	b		4f					\n"	\
+"	.previous						\n"	\
+"4:								\n"
+
+#define ATOMIC_OP(op, llsc_op, lse_op)					\
 static inline void atomic_##op(int i, atomic_t *v)			\
 {									\
-	register int w0 asm ("w0") = i;					\
-	register atomic_t *x1 asm ("x1") = v;				\
+	unsigned long tmp;						\
+	int result;							\
 									\
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(op),		\
-"	" #asm_op "	%w[i], %[v]\n")					\
-	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS);						\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_OP(llsc_op, w)),			\
+"	" #lse_op "	%w[i], %[v]\n")					\
+	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)	\
+	: [i]"r" (i));							\
 }
 
-ATOMIC_OP(andnot, stclr)
-ATOMIC_OP(or, stset)
-ATOMIC_OP(xor, steor)
-ATOMIC_OP(add, stadd)
+ATOMIC_OP(andnot, bic, stclr)
+ATOMIC_OP(or,     orr, stset)
+ATOMIC_OP(xor,    eor, steor)
+ATOMIC_OP(add,    add, stadd)
 
 #undef ATOMIC_OP
 
-#define ATOMIC_FETCH_OP(name, mb, op, asm_op, cl...)			\
+#define ATOMIC_FETCH_OP(name, ac, rl, mb, op, llsc_op, lse_op, cl...)	\
 static inline int atomic_fetch_##op##name(int i, atomic_t *v)		\
 {									\
-	register int w0 asm ("w0") = i;					\
-	register atomic_t *x1 asm ("x1") = v;				\
+	unsigned long tmp;						\
+	int val, result;						\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_ATOMIC(fetch_##op##name),				\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_FETCH_OP(llsc_op, mb, ac, rl, w)),\
 	/* LSE atomics */						\
-"	" #asm_op #mb "	%w[i], %w[i], %[v]")				\
-	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+"	" #lse_op #ac #rl " %w[i], %w[res], %[v]")			\
+	: [res]"=&r" (result), [val]"=&r" (val), [tmp]"=&r" (tmp),	\
+	  [v]"+Q" (v->counter)						\
+	: [i]"r" (i)							\
+	: cl);								\
 									\
-	return w0;							\
+	return result;							\
 }
 
-#define ATOMIC_FETCH_OPS(op, asm_op)					\
-	ATOMIC_FETCH_OP(_relaxed,   , op, asm_op)			\
-	ATOMIC_FETCH_OP(_acquire,  a, op, asm_op, "memory")		\
-	ATOMIC_FETCH_OP(_release,  l, op, asm_op, "memory")		\
-	ATOMIC_FETCH_OP(        , al, op, asm_op, "memory")
+#define ATOMIC_FETCH_OPS(op, llsc_op, lse_op)					\
+	ATOMIC_FETCH_OP(_relaxed,  ,  ,        , op, llsc_op, lse_op)		\
+	ATOMIC_FETCH_OP(_acquire, a,  ,        , op, llsc_op, lse_op, "memory")	\
+	ATOMIC_FETCH_OP(_release,  , l,        , op, llsc_op, lse_op, "memory")	\
+	ATOMIC_FETCH_OP(        , a, l, dmb ish, op, llsc_op, lse_op, "memory")
 
-ATOMIC_FETCH_OPS(andnot, ldclr)
-ATOMIC_FETCH_OPS(or, ldset)
-ATOMIC_FETCH_OPS(xor, ldeor)
-ATOMIC_FETCH_OPS(add, ldadd)
+ATOMIC_FETCH_OPS(andnot, bic, ldclr)
+ATOMIC_FETCH_OPS(or,     orr, ldset)
+ATOMIC_FETCH_OPS(xor,    eor, ldeor)
+ATOMIC_FETCH_OPS(add,    add, ldadd)
 
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_FETCH_OPS
 
-#define ATOMIC_OP_ADD_RETURN(name, mb, cl...)				\
+#define ATOMIC_OP_ADD_RETURN(name, ac, rl, mb, cl...)			\
 static inline int atomic_add_return##name(int i, atomic_t *v)		\
 {									\
-	register int w0 asm ("w0") = i;					\
-	register atomic_t *x1 asm ("x1") = v;				\
+	unsigned long tmp;						\
+	int result;							\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_ATOMIC(add_return##name)				\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_OP_RETURN(add, mb, ac, rl, w))	\
 	__nops(1),							\
 	/* LSE atomics */						\
-	"	ldadd" #mb "	%w[i], w30, %[v]\n"			\
-	"	add	%w[i], %w[i], w30")				\
-	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	"	ldadd" #ac #rl " %w[i], %w[res], %[v]\n"		\
+	"	add		%w[res], %w[res], %w[i]")		\
+	: [v]"+Q" (v->counter), [res]"=&r" (result), [tmp]"=&r" (tmp)	\
+	: [i]"r" (i)							\
+	: cl);								\
 									\
-	return w0;							\
+	return result;							\
 }
 
-ATOMIC_OP_ADD_RETURN(_relaxed,   )
-ATOMIC_OP_ADD_RETURN(_acquire,  a, "memory")
-ATOMIC_OP_ADD_RETURN(_release,  l, "memory")
-ATOMIC_OP_ADD_RETURN(        , al, "memory")
+ATOMIC_OP_ADD_RETURN(_relaxed,  ,  ,        )
+ATOMIC_OP_ADD_RETURN(_acquire, a,  ,        , "memory")
+ATOMIC_OP_ADD_RETURN(_release,  , l,        , "memory")
+ATOMIC_OP_ADD_RETURN(        , a, l, dmb ish, "memory")
 
 #undef ATOMIC_OP_ADD_RETURN
 
 static inline void atomic_and(int i, atomic_t *v)
 {
-	register int w0 asm ("w0") = i;
-	register atomic_t *x1 asm ("x1") = v;
+	unsigned long tmp;
+	int result;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	__LL_SC_ATOMIC(and)
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_OP(and, w))
 	__nops(1),
 	/* LSE atomics */
-	"	mvn	%w[i], %w[i]\n"
-	"	stclr	%w[i], %[v]")
-	: [i] "+&r" (w0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
+	"	mvn	%w[tmp], %w[i]\n"
+	"	stclr	%w[tmp], %[v]")
+	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)
+	: [i]"r" (i));
 }
 
-#define ATOMIC_FETCH_OP_AND(name, mb, cl...)				\
+#define ATOMIC_FETCH_OP_AND(name, ac, rl, mb, cl...)			\
 static inline int atomic_fetch_and##name(int i, atomic_t *v)		\
 {									\
-	register int w0 asm ("w0") = i;					\
-	register atomic_t *x1 asm ("x1") = v;				\
+	unsigned long tmp;						\
+	int val, result;						\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_ATOMIC(fetch_and##name)					\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_FETCH_OP(and, mb, ac, rl, w))	\
 	__nops(1),							\
 	/* LSE atomics */						\
-	"	mvn	%w[i], %w[i]\n"					\
-	"	ldclr" #mb "	%w[i], %w[i], %[v]")			\
-	: [i] "+&r" (w0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	"	mvn		%w[res], %w[i]\n"			\
+	"	ldclr" #ac #rl " %w[res], %w[res], %[v]")		\
+	: [res]"=&r" (result), [val]"=&r" (val), [tmp]"=&r" (tmp),	\
+	  [v]"+Q" (v->counter)						\
+	: [i]"r" (i)							\
+	: cl);								\
 									\
-	return w0;							\
+	return result;							\
 }
 
-ATOMIC_FETCH_OP_AND(_relaxed,   )
-ATOMIC_FETCH_OP_AND(_acquire,  a, "memory")
-ATOMIC_FETCH_OP_AND(_release,  l, "memory")
-ATOMIC_FETCH_OP_AND(        , al, "memory")
+ATOMIC_FETCH_OP_AND(_relaxed,  ,  ,        )
+ATOMIC_FETCH_OP_AND(_acquire, a,  ,        , "memory")
+ATOMIC_FETCH_OP_AND(_release,  , l,        , "memory")
+ATOMIC_FETCH_OP_AND(        , a, l, dmb ish, "memory")
 
 #undef ATOMIC_FETCH_OP_AND
 
 static inline void atomic_sub(int i, atomic_t *v)
 {
-	register int w0 asm ("w0") = i;
-	register atomic_t *x1 asm ("x1") = v;
+	unsigned long tmp;
+	int result;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	__LL_SC_ATOMIC(sub)
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_OP(sub, w))
 	__nops(1),
 	/* LSE atomics */
-	"	neg	%w[i], %w[i]\n"
-	"	stadd	%w[i], %[v]")
-	: [i] "+&r" (w0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
+	"	neg	%w[tmp], %w[i]\n"
+	"	stadd	%w[tmp], %[v]")
+	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)
+	: [i]"r" (i));
 }
 
-#define ATOMIC_OP_SUB_RETURN(name, mb, cl...)				\
+#define ATOMIC_OP_SUB_RETURN(name, ac, rl, mb, cl...)			\
 static inline int atomic_sub_return##name(int i, atomic_t *v)		\
 {									\
-	register int w0 asm ("w0") = i;					\
-	register atomic_t *x1 asm ("x1") = v;				\
+	unsigned long tmp;						\
+	int result;							\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_ATOMIC(sub_return##name)				\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_OP_RETURN(sub, mb, ac, rl, w))	\
 	__nops(2),							\
 	/* LSE atomics */						\
-	"	neg	%w[i], %w[i]\n"					\
-	"	ldadd" #mb "	%w[i], w30, %[v]\n"			\
-	"	add	%w[i], %w[i], w30")				\
-	: [i] "+&r" (w0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS , ##cl);					\
+	"	neg		%w[tmp], %w[i]\n"			\
+	"	ldadd" #ac #rl " %w[tmp], %w[res], %[v]\n"		\
+	"	add		%w[res], %w[res], %w[tmp]")		\
+	: [v]"+Q" (v->counter), [res]"=&r" (result), [tmp]"=&r" (tmp)	\
+	: [i]"r" (i)							\
+	: cl);								\
 									\
-	return w0;							\
+	return result;							\
 }
 
-ATOMIC_OP_SUB_RETURN(_relaxed,   )
-ATOMIC_OP_SUB_RETURN(_acquire,  a, "memory")
-ATOMIC_OP_SUB_RETURN(_release,  l, "memory")
-ATOMIC_OP_SUB_RETURN(        , al, "memory")
+ATOMIC_OP_SUB_RETURN(_relaxed,  ,  ,        )
+ATOMIC_OP_SUB_RETURN(_acquire, a,  ,        , "memory")
+ATOMIC_OP_SUB_RETURN(_release,  , l,        , "memory")
+ATOMIC_OP_SUB_RETURN(        , a, l, dmb ish, "memory")
 
 #undef ATOMIC_OP_SUB_RETURN
 
-#define ATOMIC_FETCH_OP_SUB(name, mb, cl...)				\
+#define ATOMIC_FETCH_OP_SUB(name, ac, rl, mb, cl...)			\
 static inline int atomic_fetch_sub##name(int i, atomic_t *v)		\
 {									\
-	register int w0 asm ("w0") = i;					\
-	register atomic_t *x1 asm ("x1") = v;				\
+	unsigned long tmp;						\
+	int val, result;						\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_ATOMIC(fetch_sub##name)					\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_FETCH_OP(sub, mb, ac, rl, w))	\
 	__nops(1),							\
 	/* LSE atomics */						\
-	"	neg	%w[i], %w[i]\n"					\
-	"	ldadd" #mb "	%w[i], %w[i], %[v]")			\
-	: [i] "+&r" (w0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	"	neg		%w[tmp], %w[i]\n"			\
+	"	ldadd" #ac #rl " %w[tmp], %w[res], %[v]")		\
+	: [res]"=&r" (result), [val]"=&r" (val), [tmp]"=&r" (tmp),	\
+	  [v]"+Q" (v->counter)						\
+	: [i]"r" (i)							\
+	: cl);								\
 									\
-	return w0;							\
+	return result;							\
 }
 
-ATOMIC_FETCH_OP_SUB(_relaxed,   )
-ATOMIC_FETCH_OP_SUB(_acquire,  a, "memory")
-ATOMIC_FETCH_OP_SUB(_release,  l, "memory")
-ATOMIC_FETCH_OP_SUB(        , al, "memory")
+ATOMIC_FETCH_OP_SUB(_relaxed,  ,  ,        )
+ATOMIC_FETCH_OP_SUB(_acquire, a,  ,        , "memory")
+ATOMIC_FETCH_OP_SUB(_release,  , l,        , "memory")
+ATOMIC_FETCH_OP_SUB(        , a, l, dmb ish, "memory")
 
 #undef ATOMIC_FETCH_OP_SUB
-#undef __LL_SC_ATOMIC
 
-#define __LL_SC_ATOMIC64(op)	__LL_SC_CALL(atomic64_##op)
-#define ATOMIC64_OP(op, asm_op)						\
+#define ATOMIC64_OP(op, llsc_op, lse_op)				\
 static inline void atomic64_##op(long i, atomic64_t *v)			\
 {									\
-	register long x0 asm ("x0") = i;				\
-	register atomic64_t *x1 asm ("x1") = v;				\
+	long result;							\
+	unsigned long tmp;						\
 									\
-	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(op),	\
-"	" #asm_op "	%[i], %[v]\n")					\
-	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS);						\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_OP(llsc_op, )),			\
+"	" #lse_op "	%[i], %[v]\n")					\
+	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)	\
+	: [i]"r" (i));							\
 }
 
-ATOMIC64_OP(andnot, stclr)
-ATOMIC64_OP(or, stset)
-ATOMIC64_OP(xor, steor)
-ATOMIC64_OP(add, stadd)
+ATOMIC64_OP(andnot, bic, stclr)
+ATOMIC64_OP(or,     orr, stset)
+ATOMIC64_OP(xor,    eor, steor)
+ATOMIC64_OP(add,    add, stadd)
 
 #undef ATOMIC64_OP
 
-#define ATOMIC64_FETCH_OP(name, mb, op, asm_op, cl...)			\
+#define ATOMIC64_FETCH_OP(name, ac, rl, mb, op, llsc_op, lse_op, cl...)	\
 static inline long atomic64_fetch_##op##name(long i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("x0") = i;				\
-	register atomic64_t *x1 asm ("x1") = v;				\
+	long result, val;						\
+	unsigned long tmp;						\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_ATOMIC64(fetch_##op##name),				\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_FETCH_OP(llsc_op, mb, ac, rl, )),	\
 	/* LSE atomics */						\
-"	" #asm_op #mb "	%[i], %[i], %[v]")				\
-	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+"	" #lse_op #ac #rl "	%[i], %[res], %[v]")			\
+	: [res]"=&r" (result), [val]"=&r" (val), [tmp]"=&r" (tmp),	\
+	  [v]"+Q" (v->counter)						\
+	: [i]"r" (i)							\
+	: cl);								\
 									\
-	return x0;							\
+	return result;							\
 }
 
-#define ATOMIC64_FETCH_OPS(op, asm_op)					\
-	ATOMIC64_FETCH_OP(_relaxed,   , op, asm_op)			\
-	ATOMIC64_FETCH_OP(_acquire,  a, op, asm_op, "memory")		\
-	ATOMIC64_FETCH_OP(_release,  l, op, asm_op, "memory")		\
-	ATOMIC64_FETCH_OP(        , al, op, asm_op, "memory")
+#define ATOMIC64_FETCH_OPS(op, llsc_op, lse_op)						\
+	ATOMIC64_FETCH_OP(_relaxed,  ,  ,        , op, llsc_op, lse_op)			\
+	ATOMIC64_FETCH_OP(_acquire, a,  ,        , op, llsc_op, lse_op, "memory")	\
+	ATOMIC64_FETCH_OP(_release,  , l,        , op, llsc_op, lse_op, "memory")	\
+	ATOMIC64_FETCH_OP(        , a, l, dmb ish, op, llsc_op, lse_op, "memory")
 
-ATOMIC64_FETCH_OPS(andnot, ldclr)
-ATOMIC64_FETCH_OPS(or, ldset)
-ATOMIC64_FETCH_OPS(xor, ldeor)
-ATOMIC64_FETCH_OPS(add, ldadd)
+ATOMIC64_FETCH_OPS(andnot, bic, ldclr)
+ATOMIC64_FETCH_OPS(or,     orr, ldset)
+ATOMIC64_FETCH_OPS(xor,    eor, ldeor)
+ATOMIC64_FETCH_OPS(add,    add, ldadd)
 
 #undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_FETCH_OPS
 
-#define ATOMIC64_OP_ADD_RETURN(name, mb, cl...)				\
+#define ATOMIC64_OP_ADD_RETURN(name, ac, rl, mb, cl...)			\
 static inline long atomic64_add_return##name(long i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("x0") = i;				\
-	register atomic64_t *x1 asm ("x1") = v;				\
+	unsigned long tmp;						\
+	long result;							\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_ATOMIC64(add_return##name)				\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_OP_RETURN(add, mb, ac, rl, ))	\
 	__nops(1),							\
 	/* LSE atomics */						\
-	"	ldadd" #mb "	%[i], x30, %[v]\n"			\
-	"	add	%[i], %[i], x30")				\
-	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	"	ldadd" #ac #rl " %[i], %[res], %[v]\n"			\
+	"	add		%[res], %[res], %[i]")			\
+	: [v]"+Q" (v->counter), [res]"=&r" (result), [tmp]"=&r" (tmp)	\
+	: [i]"r" (i)							\
+	: cl);								\
 									\
-	return x0;							\
+	return result;							\
 }
 
-ATOMIC64_OP_ADD_RETURN(_relaxed,   )
-ATOMIC64_OP_ADD_RETURN(_acquire,  a, "memory")
-ATOMIC64_OP_ADD_RETURN(_release,  l, "memory")
-ATOMIC64_OP_ADD_RETURN(        , al, "memory")
+ATOMIC64_OP_ADD_RETURN(_relaxed,  ,  ,        )
+ATOMIC64_OP_ADD_RETURN(_acquire, a,  ,        , "memory")
+ATOMIC64_OP_ADD_RETURN(_release,  , l,        , "memory")
+ATOMIC64_OP_ADD_RETURN(        , a, l, dmb ish, "memory")
 
 #undef ATOMIC64_OP_ADD_RETURN
 
 static inline void atomic64_and(long i, atomic64_t *v)
 {
-	register long x0 asm ("x0") = i;
-	register atomic64_t *x1 asm ("x1") = v;
+	long result;
+	unsigned long tmp;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	__LL_SC_ATOMIC64(and)
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_OP(and, ))
 	__nops(1),
 	/* LSE atomics */
-	"	mvn	%[i], %[i]\n"
-	"	stclr	%[i], %[v]")
-	: [i] "+&r" (x0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
+	"	mvn	%[tmp], %[i]\n"
+	"	stclr	%[tmp], %[v]")
+	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)
+	: [i]"r" (i));
 }
 
-#define ATOMIC64_FETCH_OP_AND(name, mb, cl...)				\
+#define ATOMIC64_FETCH_OP_AND(name, ac, rl, mb, cl...)			\
 static inline long atomic64_fetch_and##name(long i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("x0") = i;				\
-	register atomic64_t *x1 asm ("x1") = v;				\
+	long result, val;						\
+	unsigned long tmp;						\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_ATOMIC64(fetch_and##name)				\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_FETCH_OP(and, mb, ac, rl, ))	\
 	__nops(1),							\
 	/* LSE atomics */						\
-	"	mvn	%[i], %[i]\n"					\
-	"	ldclr" #mb "	%[i], %[i], %[v]")			\
-	: [i] "+&r" (x0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	"	mvn		%[res], %[i]\n"				\
+	"	ldclr" #ac #rl " %[res], %[res], %[v]")			\
+	: [res]"=&r" (result), [val]"=&r" (val), [tmp]"=&r" (tmp),	\
+	  [v]"+Q" (v->counter)						\
+	: [i]"r" (i)							\
+	: cl);								\
 									\
-	return x0;							\
+	return result;							\
 }
 
-ATOMIC64_FETCH_OP_AND(_relaxed,   )
-ATOMIC64_FETCH_OP_AND(_acquire,  a, "memory")
-ATOMIC64_FETCH_OP_AND(_release,  l, "memory")
-ATOMIC64_FETCH_OP_AND(        , al, "memory")
+ATOMIC64_FETCH_OP_AND(_relaxed,  ,  ,        )
+ATOMIC64_FETCH_OP_AND(_acquire, a,  ,        , "memory")
+ATOMIC64_FETCH_OP_AND(_release,  , l,        , "memory")
+ATOMIC64_FETCH_OP_AND(        , a, l, dmb ish, "memory")
 
 #undef ATOMIC64_FETCH_OP_AND
 
 static inline void atomic64_sub(long i, atomic64_t *v)
 {
-	register long x0 asm ("x0") = i;
-	register atomic64_t *x1 asm ("x1") = v;
+	long result;
+	unsigned long tmp;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	__LL_SC_ATOMIC64(sub)
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_OP(sub, ))
 	__nops(1),
 	/* LSE atomics */
-	"	neg	%[i], %[i]\n"
-	"	stadd	%[i], %[v]")
-	: [i] "+&r" (x0), [v] "+Q" (v->counter)
-	: "r" (x1)
-	: __LL_SC_CLOBBERS);
+	"	neg	%[tmp], %[i]\n"
+	"	stadd	%[tmp], %[v]")
+	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)
+	: [i]"r" (i));
 }
 
-#define ATOMIC64_OP_SUB_RETURN(name, mb, cl...)				\
+#define ATOMIC64_OP_SUB_RETURN(name, ac, rl, mb, cl...)			\
 static inline long atomic64_sub_return##name(long i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("x0") = i;				\
-	register atomic64_t *x1 asm ("x1") = v;				\
+	unsigned long tmp;						\
+	long result;							\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_ATOMIC64(sub_return##name)				\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_OP_RETURN(sub, mb, ac, rl, ))	\
 	__nops(2),							\
 	/* LSE atomics */						\
-	"	neg	%[i], %[i]\n"					\
-	"	ldadd" #mb "	%[i], x30, %[v]\n"			\
-	"	add	%[i], %[i], x30")				\
-	: [i] "+&r" (x0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	"	neg		%[tmp], %[i]\n"				\
+	"	ldadd" #ac #rl " %[tmp], %[res], %[v]\n"			\
+	"	add		%[res], %[res], %[tmp]")		\
+	: [v]"+Q" (v->counter), [res]"=&r" (result), [tmp]"=&r" (tmp)	\
+	: [i]"r" (i)							\
+	: cl);								\
 									\
-	return x0;							\
+	return result;							\
 }
 
-ATOMIC64_OP_SUB_RETURN(_relaxed,   )
-ATOMIC64_OP_SUB_RETURN(_acquire,  a, "memory")
-ATOMIC64_OP_SUB_RETURN(_release,  l, "memory")
-ATOMIC64_OP_SUB_RETURN(        , al, "memory")
+ATOMIC64_OP_SUB_RETURN(_relaxed,  ,  ,        )
+ATOMIC64_OP_SUB_RETURN(_acquire, a,  ,        , "memory")
+ATOMIC64_OP_SUB_RETURN(_release,  , l,        , "memory")
+ATOMIC64_OP_SUB_RETURN(        , a, l, dmb ish, "memory")
 
 #undef ATOMIC64_OP_SUB_RETURN
 
-#define ATOMIC64_FETCH_OP_SUB(name, mb, cl...)				\
+#define ATOMIC64_FETCH_OP_SUB(name, ac, rl, mb, cl...)			\
 static inline long atomic64_fetch_sub##name(long i, atomic64_t *v)	\
 {									\
-	register long x0 asm ("x0") = i;				\
-	register atomic64_t *x1 asm ("x1") = v;				\
+	long result, val;						\
+	unsigned long tmp;						\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_ATOMIC64(fetch_sub##name)				\
+	__LL_SC_ATOMIC(__LL_SC_ATOMIC_FETCH_OP(sub, mb, ac, rl, ))	\
 	__nops(1),							\
 	/* LSE atomics */						\
-	"	neg	%[i], %[i]\n"					\
-	"	ldadd" #mb "	%[i], %[i], %[v]")			\
-	: [i] "+&r" (x0), [v] "+Q" (v->counter)				\
-	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	"	neg		%[tmp], %[i]\n"				\
+	"	ldadd" #ac #rl " %[tmp], %[res], %[v]")			\
+	: [res]"=&r" (result), [val]"=&r" (val), [tmp]"=&r" (tmp),	\
+	  [v]"+Q" (v->counter)						\
+	: [i]"r" (i)							\
+	: cl);								\
 									\
-	return x0;							\
+	return result;							\
 }
 
-ATOMIC64_FETCH_OP_SUB(_relaxed,   )
-ATOMIC64_FETCH_OP_SUB(_acquire,  a, "memory")
-ATOMIC64_FETCH_OP_SUB(_release,  l, "memory")
-ATOMIC64_FETCH_OP_SUB(        , al, "memory")
+ATOMIC64_FETCH_OP_SUB(_relaxed,  ,  ,        )
+ATOMIC64_FETCH_OP_SUB(_acquire, a,  ,        , "memory")
+ATOMIC64_FETCH_OP_SUB(_release,  , l,        , "memory")
+ATOMIC64_FETCH_OP_SUB(        , a, l, dmb ish, "memory")
 
 #undef ATOMIC64_FETCH_OP_SUB
 
 static inline long atomic64_dec_if_positive(atomic64_t *v)
 {
-	register long x0 asm ("x0") = (long)v;
+	long tmp, result;
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	__LL_SC_ATOMIC64(dec_if_positive)
-	__nops(6),
+	"	prfm	pstl1strm, %[v]\n"
+	"1:	ldxr	%[tmp], %[v]\n"
+	"	subs	%[res], %[tmp], #1\n"
+	"	b.lt	2f\n"
+	"	stlxr	%w[tmp], %[res], %[v]\n"
+	"	cbnz	%w[tmp], 1b\n"
+	"	dmb	ish\n"
+	"2:",
 	/* LSE atomics */
-	"1:	ldr	x30, %[v]\n"
-	"	subs	%[ret], x30, #1\n"
+	"1:	ldr	%[tmp], %[v]\n"
+	"	subs	%[res], %[tmp], #1\n"
 	"	b.lt	2f\n"
-	"	casal	x30, %[ret], %[v]\n"
-	"	sub	x30, x30, #1\n"
-	"	sub	x30, x30, %[ret]\n"
-	"	cbnz	x30, 1b\n"
+	"	casal	%[tmp], %[res], %[v]\n"
+	"	sub	%[tmp], %[tmp], #1\n"
+	"	sub	%[tmp], %[tmp], %[res]\n"
+	"	cbnz	%[tmp], 1b\n"
 	"2:")
-	: [ret] "+&r" (x0), [v] "+Q" (v->counter)
+	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)
 	:
-	: __LL_SC_CLOBBERS, "cc", "memory");
+	: "cc", "memory");
 
-	return x0;
+	return result;
 }
 
 #undef __LL_SC_ATOMIC64
 
-#define __LL_SC_CMPXCHG(op)	__LL_SC_CALL(__cmpxchg_case_##op)
-
-#define __CMPXCHG_CASE(w, sz, name, mb, cl...)				\
+#define __CMPXCHG_CASE(w, sz, name, ac, rl, mb, cl...)			\
 static inline unsigned long __cmpxchg_case_##name(volatile void *ptr,	\
 						  unsigned long old,	\
 						  unsigned long new)	\
 {									\
-	register unsigned long x0 asm ("x0") = (unsigned long)ptr;	\
-	register unsigned long x1 asm ("x1") = old;			\
-	register unsigned long x2 asm ("x2") = new;			\
+	unsigned long tmp, oldval;					\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_CMPXCHG(name)						\
-	__nops(2),							\
+	__LL_SC_ATOMIC(__LL_SC_CMPXCHG_BASE_OP(w, sz, name, mb, ac, rl))\
+	__nops(1),							\
 	/* LSE atomics */						\
-	"	mov	" #w "30, %" #w "[old]\n"			\
-	"	cas" #mb #sz "\t" #w "30, %" #w "[new], %[v]\n"		\
-	"	mov	%" #w "[ret], " #w "30")			\
-	: [ret] "+r" (x0), [v] "+Q" (*(unsigned long *)ptr)		\
-	: [old] "r" (x1), [new] "r" (x2)				\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	"	mov			%" #w "[oldval], %" #w "[old]\n"\
+	"	cas" #ac #rl #sz "	%" #w "[oldval], %" #w "[new], "\
+	"						 %[v]\n")	\
+	: [tmp] "=&r" (tmp), [oldval] "=&r" (oldval),			\
+	  [v] "+Q" (*(unsigned long *)ptr)				\
+	: [old] "Lr" (old), [new] "r" (new)				\
+	: cl);								\
 									\
-	return x0;							\
+	return oldval;							\
 }
 
-__CMPXCHG_CASE(w, b,     1,   )
-__CMPXCHG_CASE(w, h,     2,   )
-__CMPXCHG_CASE(w,  ,     4,   )
-__CMPXCHG_CASE(x,  ,     8,   )
-__CMPXCHG_CASE(w, b, acq_1,  a, "memory")
-__CMPXCHG_CASE(w, h, acq_2,  a, "memory")
-__CMPXCHG_CASE(w,  , acq_4,  a, "memory")
-__CMPXCHG_CASE(x,  , acq_8,  a, "memory")
-__CMPXCHG_CASE(w, b, rel_1,  l, "memory")
-__CMPXCHG_CASE(w, h, rel_2,  l, "memory")
-__CMPXCHG_CASE(w,  , rel_4,  l, "memory")
-__CMPXCHG_CASE(x,  , rel_8,  l, "memory")
-__CMPXCHG_CASE(w, b,  mb_1, al, "memory")
-__CMPXCHG_CASE(w, h,  mb_2, al, "memory")
-__CMPXCHG_CASE(w,  ,  mb_4, al, "memory")
-__CMPXCHG_CASE(x,  ,  mb_8, al, "memory")
-
-#undef __LL_SC_CMPXCHG
-#undef __CMPXCHG_CASE
+__CMPXCHG_CASE(w, b,     1,  ,  ,        )
+__CMPXCHG_CASE(w, h,     2,  ,  ,        )
+__CMPXCHG_CASE(w,  ,     4,  ,  ,        )
+__CMPXCHG_CASE(x,  ,     8,  ,  ,        )
+__CMPXCHG_CASE(w, b, acq_1, a,  ,        , "memory")
+__CMPXCHG_CASE(w, h, acq_2, a,  ,        , "memory")
+__CMPXCHG_CASE(w,  , acq_4, a,  ,        , "memory")
+__CMPXCHG_CASE(x,  , acq_8, a,  ,        , "memory")
+__CMPXCHG_CASE(w, b, rel_1,  , l,        , "memory")
+__CMPXCHG_CASE(w, h, rel_2,  , l,        , "memory")
+__CMPXCHG_CASE(w,  , rel_4,  , l,        , "memory")
+__CMPXCHG_CASE(x,  , rel_8,  , l,        , "memory")
+__CMPXCHG_CASE(w, b,  mb_1, a, l, dmb ish, "memory")
+__CMPXCHG_CASE(w, h,  mb_2, a, l, dmb ish, "memory")
+__CMPXCHG_CASE(w,  ,  mb_4, a, l, dmb ish, "memory")
+__CMPXCHG_CASE(x,  ,  mb_8, a, l, dmb ish, "memory")
 
-#define __LL_SC_CMPXCHG_DBL(op)	__LL_SC_CALL(__cmpxchg_double##op)
+#undef __CMPXCHG_CASE
 
-#define __CMPXCHG_DBL(name, mb, cl...)					\
+#define __CMPXCHG_DBL(name, ac, rl, mb, cl...)				\
 static inline long __cmpxchg_double##name(unsigned long old1,		\
 					 unsigned long old2,		\
 					 unsigned long new1,		\
 					 unsigned long new2,		\
 					 volatile void *ptr)		\
 {									\
-	unsigned long oldval1 = old1;					\
-	unsigned long oldval2 = old2;					\
-	register unsigned long x0 asm ("x0") = old1;			\
-	register unsigned long x1 asm ("x1") = old2;			\
+	register unsigned long oldval1 asm ("x0") = old1;		\
+	register unsigned long oldval2 asm ("x1") = old2;		\
 	register unsigned long x2 asm ("x2") = new1;			\
 	register unsigned long x3 asm ("x3") = new2;			\
-	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	__LL_SC_CMPXCHG_DBL(name)					\
+	__LL_SC_ATOMIC(__LL_SC_CMPXCHG_DBL_OP(mb, rl))			\
 	__nops(3),							\
 	/* LSE atomics */						\
-	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
-	"	eor	%[old1], %[old1], %[oldval1]\n"			\
-	"	eor	%[old2], %[old2], %[oldval2]\n"			\
-	"	orr	%[old1], %[old1], %[old2]")			\
-	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
-	  [v] "+Q" (*(unsigned long *)ptr)				\
-	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
-	  [oldval1] "r" (oldval1), [oldval2] "r" (oldval2)		\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	"	casp" #ac #rl "	%[ret], %[tmp], %[new1], %[new2], "	\
+	"			%[v]\n"					\
+	"	eor		%[ret], %[ret], %[old1]\n"		\
+	"	eor		%[tmp], %[tmp], %[old2]\n"		\
+	"	orr		%[ret], %[ret], %[tmp]")		\
+	: [ret]"+&r" (oldval1), [tmp]"+&r" (oldval2),			\
+	  [v]"+Q" (*(unsigned long *)ptr)				\
+	: [old1]"r" (old1), [old2]"r" (old2), [new1]"r" (x2),		\
+	  [new2]"r" (x3)						\
+	: cl);								\
 									\
-	return x0;							\
+	return oldval1;							\
 }
 
-__CMPXCHG_DBL(   ,   )
-__CMPXCHG_DBL(_mb, al, "memory")
+__CMPXCHG_DBL(   ,  ,  ,        )
+__CMPXCHG_DBL(_mb, a, l, dmb ish, "memory")
 
-#undef __LL_SC_CMPXCHG_DBL
 #undef __CMPXCHG_DBL
 
 #endif	/* __ASM_ATOMIC_LSE_H */
diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index 8262325e2fc6..ef70f62ea25e 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -27,10 +27,6 @@ __asm__(".arch_extension	lse");
 #define __LL_SC_PREFIX(x)	__ll_sc_##x
 #define __LL_SC_EXPORT(x)	EXPORT_SYMBOL(__LL_SC_PREFIX(x))
 
-/* Macro for constructing calls to out-of-line ll/sc atomics */
-#define __LL_SC_CALL(op)	"bl\t" __stringify(__LL_SC_PREFIX(op)) "\n"
-#define __LL_SC_CLOBBERS	"x16", "x17", "x30"
-
 /* In-line patching at runtime */
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)				\
 	ALTERNATIVE(llsc, lse, ARM64_HAS_LSE_ATOMICS)
-- 
2.17.1
