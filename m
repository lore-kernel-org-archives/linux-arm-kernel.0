From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Nov 2018 15:39:21 -0800
Subject: [PATCH 1/3] arm64/atomics: refactor LL/SC base asm templates
In-Reply-To: <20181113233923.20098-1-ard.biesheuvel@linaro.org>
References: <20181113233923.20098-1-ard.biesheuvel@linaro.org>
Message-ID: <20181113233923.20098-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactor the asm templates that emit the LL/SC instruction
sequences so that we will be able to reuse them in the LSE
code, which will emit them out of line, but without the use
of function calls.

This involves factoring out the core instruction sequences
and using named operands throughout.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 139 ++++++++++----------
 1 file changed, 72 insertions(+), 67 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index f5a2d09afb38..5f55f6b8dd7e 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -36,6 +36,51 @@
  * this file, which unfortunately don't work on a per-function basis
  * (the optimize attribute silently ignores these options).
  */
+#define __LL_SC_ATOMIC_OP(asm_op, w)					\
+"	prfm		pstl1strm, %[v]				\n"	\
+"1:	ldxr		%" #w "[res], %[v]			\n"	\
+"	" #asm_op "	%" #w "[res], %" #w "[res], %" #w "[i]	\n"	\
+"	stxr		%w[tmp], %" #w "[res], %[v]		\n"	\
+"	cbnz		%w[tmp], 1b"
+
+#define __LL_SC_ATOMIC_OP_RETURN(asm_op, mb, acq, rel, w)		\
+"	prfm		pstl1strm, %[v]				\n"	\
+"1:	ld" #acq "xr	%" #w "[res], %[v]			\n"	\
+"	" #asm_op "	%" #w "[res], %" #w "[res], %" #w "[i]	\n"	\
+"	st" #rel "xr	%w[tmp], %" #w "[res], %[v]		\n"	\
+"	cbnz		%w[tmp], 1b				\n"	\
+"	" #mb
+
+#define __LL_SC_ATOMIC_FETCH_OP(asm_op, mb, acq, rel, w)		\
+"	prfm		pstl1strm, %[v]				\n"	\
+"1:	ld" #acq "xr	%" #w "[res], %[v]			\n"	\
+"	" #asm_op "	%" #w "[val], %" #w "[res], %" #w "[i]	\n"	\
+"	st" #rel "xr	%w[tmp], %" #w "[val], %[v]		\n"	\
+"	cbnz		%w[tmp], 1b				\n"	\
+"	" #mb								\
+
+#define __LL_SC_CMPXCHG_BASE_OP(w, sz, name, mb, acq, rel)		\
+"	prfm			pstl1strm, %[v]			\n"	\
+"1:	ld" #acq "xr" #sz "	%" #w "[oldval], %[v]		\n"	\
+"	eor			%" #w "[tmp], %" #w "[oldval], "	\
+"					      %" #w "[old]	\n"	\
+"	cbnz			%" #w "[tmp], 2f		\n"	\
+"	st" #rel "xr" #sz "	%w[tmp], %" #w "[new], %[v]	\n"	\
+"	cbnz			%w[tmp], 1b			\n"	\
+"	" #mb "							\n"	\
+"2:"
+
+#define __LL_SC_CMPXCHG_DBL_OP(mb, rel)					\
+"	prfm		pstl1strm, %[v]				\n"	\
+"1:	ldxp		%[tmp], %[ret], %[v]			\n"	\
+"	eor		%[tmp], %[tmp], %[old1]			\n"	\
+"	eor		%[ret], %[ret], %[old2]			\n"	\
+"	orr		%[ret], %[tmp], %[ret]			\n"	\
+"	cbnz		%[ret], 2f				\n"	\
+"	st" #rel "xp	%w[tmp], %[new1], %[new2], %[v]		\n"	\
+"	cbnz		%w[tmp], 1b				\n"	\
+"	" #mb "							\n"	\
+"2:"									\
 
 #define ATOMIC_OP(op, asm_op)						\
 __LL_SC_INLINE void							\
@@ -44,14 +89,10 @@ __LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
 	unsigned long tmp;						\
 	int result;							\
 									\
-	asm volatile("// atomic_" #op "\n"				\
-"	prfm	pstl1strm, %2\n"					\
-"1:	ldxr	%w0, %2\n"						\
-"	" #asm_op "	%w0, %w0, %w3\n"				\
-"	stxr	%w1, %w0, %2\n"						\
-"	cbnz	%w1, 1b"						\
-	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
-	: "Ir" (i));							\
+	asm volatile("	// atomic_" #op "\n"				\
+	__LL_SC_ATOMIC_OP(asm_op, w)					\
+	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)	\
+	: [i]"Ir" (i));							\
 }									\
 __LL_SC_EXPORT(atomic_##op);
 
@@ -63,14 +104,9 @@ __LL_SC_PREFIX(atomic_##op##_return##name(int i, atomic_t *v))		\
 	int result;							\
 									\
 	asm volatile("// atomic_" #op "_return" #name "\n"		\
-"	prfm	pstl1strm, %2\n"					\
-"1:	ld" #acq "xr	%w0, %2\n"					\
-"	" #asm_op "	%w0, %w0, %w3\n"				\
-"	st" #rel "xr	%w1, %w0, %2\n"					\
-"	cbnz	%w1, 1b\n"						\
-"	" #mb								\
-	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
-	: "Ir" (i)							\
+	__LL_SC_ATOMIC_OP_RETURN(asm_op, mb, acq, rel, w)		\
+	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)	\
+	: [i]"Ir" (i)							\
 	: cl);								\
 									\
 	return result;							\
@@ -85,14 +121,10 @@ __LL_SC_PREFIX(atomic_fetch_##op##name(int i, atomic_t *v))		\
 	int val, result;						\
 									\
 	asm volatile("// atomic_fetch_" #op #name "\n"			\
-"	prfm	pstl1strm, %3\n"					\
-"1:	ld" #acq "xr	%w0, %3\n"					\
-"	" #asm_op "	%w1, %w0, %w4\n"				\
-"	st" #rel "xr	%w2, %w1, %3\n"					\
-"	cbnz	%w2, 1b\n"						\
-"	" #mb								\
-	: "=&r" (result), "=&r" (val), "=&r" (tmp), "+Q" (v->counter)	\
-	: "Ir" (i)							\
+	__LL_SC_ATOMIC_FETCH_OP(asm_op, mb, acq, rel, w)		\
+	: [res]"=&r" (result), [val]"=&r" (val), [tmp]"=&r" (tmp),	\
+	  [v]"+Q" (v->counter)						\
+	: [i]"Ir" (i)							\
 	: cl);								\
 									\
 	return result;							\
@@ -139,13 +171,9 @@ __LL_SC_PREFIX(atomic64_##op(long i, atomic64_t *v))			\
 	unsigned long tmp;						\
 									\
 	asm volatile("// atomic64_" #op "\n"				\
-"	prfm	pstl1strm, %2\n"					\
-"1:	ldxr	%0, %2\n"						\
-"	" #asm_op "	%0, %0, %3\n"					\
-"	stxr	%w1, %0, %2\n"						\
-"	cbnz	%w1, 1b"						\
-	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
-	: "Ir" (i));							\
+	__LL_SC_ATOMIC_OP(asm_op, )					\
+	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)	\
+	: [i]"Ir" (i));							\
 }									\
 __LL_SC_EXPORT(atomic64_##op);
 
@@ -157,14 +185,9 @@ __LL_SC_PREFIX(atomic64_##op##_return##name(long i, atomic64_t *v))	\
 	unsigned long tmp;						\
 									\
 	asm volatile("// atomic64_" #op "_return" #name "\n"		\
-"	prfm	pstl1strm, %2\n"					\
-"1:	ld" #acq "xr	%0, %2\n"					\
-"	" #asm_op "	%0, %0, %3\n"					\
-"	st" #rel "xr	%w1, %0, %2\n"					\
-"	cbnz	%w1, 1b\n"						\
-"	" #mb								\
-	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
-	: "Ir" (i)							\
+	__LL_SC_ATOMIC_OP_RETURN(asm_op, mb, acq, rel, )		\
+	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)	\
+	: [i]"Ir" (i)							\
 	: cl);								\
 									\
 	return result;							\
@@ -179,14 +202,10 @@ __LL_SC_PREFIX(atomic64_fetch_##op##name(long i, atomic64_t *v))	\
 	unsigned long tmp;						\
 									\
 	asm volatile("// atomic64_fetch_" #op #name "\n"		\
-"	prfm	pstl1strm, %3\n"					\
-"1:	ld" #acq "xr	%0, %3\n"					\
-"	" #asm_op "	%1, %0, %4\n"					\
-"	st" #rel "xr	%w2, %1, %3\n"					\
-"	cbnz	%w2, 1b\n"						\
-"	" #mb								\
-	: "=&r" (result), "=&r" (val), "=&r" (tmp), "+Q" (v->counter)	\
-	: "Ir" (i)							\
+	__LL_SC_ATOMIC_FETCH_OP(asm_op, mb, acq, rel, )			\
+	: [res]"=&r" (result), [val]"=&r" (val), [tmp]"=&r" (tmp),	\
+	  [v]"+Q" (v->counter)						\
+	: [i]"Ir" (i)							\
 	: cl);								\
 									\
 	return result;							\
@@ -257,14 +276,7 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 	unsigned long tmp, oldval;					\
 									\
 	asm volatile(							\
-	"	prfm	pstl1strm, %[v]\n"				\
-	"1:	ld" #acq "xr" #sz "\t%" #w "[oldval], %[v]\n"		\
-	"	eor	%" #w "[tmp], %" #w "[oldval], %" #w "[old]\n"	\
-	"	cbnz	%" #w "[tmp], 2f\n"				\
-	"	st" #rel "xr" #sz "\t%w[tmp], %" #w "[new], %[v]\n"	\
-	"	cbnz	%w[tmp], 1b\n"					\
-	"	" #mb "\n"						\
-	"2:"								\
+	__LL_SC_CMPXCHG_BASE_OP(w, sz, name, mb, acq, rel)		\
 	: [tmp] "=&r" (tmp), [oldval] "=&r" (oldval),			\
 	  [v] "+Q" (*(unsigned long *)ptr)				\
 	: [old] "Lr" (old), [new] "r" (new)				\
@@ -304,18 +316,11 @@ __LL_SC_PREFIX(__cmpxchg_double##name(unsigned long old1,		\
 	unsigned long tmp, ret;						\
 									\
 	asm volatile("// __cmpxchg_double" #name "\n"			\
-	"	prfm	pstl1strm, %2\n"				\
-	"1:	ldxp	%0, %1, %2\n"					\
-	"	eor	%0, %0, %3\n"					\
-	"	eor	%1, %1, %4\n"					\
-	"	orr	%1, %0, %1\n"					\
-	"	cbnz	%1, 2f\n"					\
-	"	st" #rel "xp	%w0, %5, %6, %2\n"			\
-	"	cbnz	%w0, 1b\n"					\
-	"	" #mb "\n"						\
-	"2:"								\
-	: "=&r" (tmp), "=&r" (ret), "+Q" (*(unsigned long *)ptr)	\
-	: "r" (old1), "r" (old2), "r" (new1), "r" (new2)		\
+	__LL_SC_CMPXCHG_DBL_OP(mb, rel)					\
+	: [tmp]"=&r" (tmp), [ret]"=&r" (ret),				\
+	  [v]"+Q" (*(unsigned long *)ptr)				\
+	: [old1]"r" (old1), [old2]"r" (old2), [new1]"r" (new1),		\
+	  [new2]"r" (new2)						\
 	: cl);								\
 									\
 	return ret;							\
-- 
2.17.1
