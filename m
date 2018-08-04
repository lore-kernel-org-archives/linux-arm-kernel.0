From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat,  4 Aug 2018 11:55:53 +0200
Subject: [RFC PATCH] arm64: lse: provide additional GPR to 'fetch' LL/SC
 fallback variants
Message-ID: <20180804095553.16358-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When support for ARMv8.2 LSE atomics is compiled in, the original
LL/SC implementations are demoted to fallbacks that are invoked
via function calls on systems that do not implement the new instructions.

Due to the fact that these function calls may occur from modules that
are located further than 128 MB away from their targets in the core
kernel, such calls may be indirected via PLT entries, which are permitted
to clobber registers x16 and x17. Since we must assume that those
registers do not retain their value across a function call to such a
LL/SC fallback, and given that those function calls are hidden from the
compiler entirely, we must assume that calling any of the LSE atomics
routines clobbers x16 and x17 (and x30, for that matter).

Fortunately, there is an upside: having two scratch register available
permits the compiler to emit many of the LL/SC fallbacks without having
to preserve/restore registers on the stack, which would penalise the
users of the LL/SC fallbacks even more, given that they are already
putting up with the function call overhead.

However, the 'fetch' variants need an additional scratch register in
order to execute without the need to preserve registers on the stack.

So let's give those routines an additional scratch register 'x15' when
emitted as a LL/SC fallback, and ensure that the register is marked as
clobbered at the associated LSE call sites (but not anywhere else)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 16 +++++++++-------
 arch/arm64/include/asm/atomic_lse.h   | 12 ++++++------
 arch/arm64/include/asm/lse.h          |  3 +++
 arch/arm64/lib/Makefile               |  2 +-
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index f5a2d09afb38..7a2ac2900810 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -51,7 +51,8 @@ __LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
 "	stxr	%w1, %w0, %2\n"						\
 "	cbnz	%w1, 1b"						\
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
-	: "Ir" (i));							\
+	: "Ir" (i)							\
+	: __LL_SC_PRESERVE());						\
 }									\
 __LL_SC_EXPORT(atomic_##op);
 
@@ -71,7 +72,7 @@ __LL_SC_PREFIX(atomic_##op##_return##name(int i, atomic_t *v))		\
 "	" #mb								\
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
 	: "Ir" (i)							\
-	: cl);								\
+	: __LL_SC_PRESERVE(cl));					\
 									\
 	return result;							\
 }									\
@@ -145,7 +146,8 @@ __LL_SC_PREFIX(atomic64_##op(long i, atomic64_t *v))			\
 "	stxr	%w1, %0, %2\n"						\
 "	cbnz	%w1, 1b"						\
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
-	: "Ir" (i));							\
+	: "Ir" (i)							\
+	: __LL_SC_PRESERVE());						\
 }									\
 __LL_SC_EXPORT(atomic64_##op);
 
@@ -165,7 +167,7 @@ __LL_SC_PREFIX(atomic64_##op##_return##name(long i, atomic64_t *v))	\
 "	" #mb								\
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
 	: "Ir" (i)							\
-	: cl);								\
+	: __LL_SC_PRESERVE(cl));					\
 									\
 	return result;							\
 }									\
@@ -242,7 +244,7 @@ __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
 "2:"
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
 	:
-	: "cc", "memory");
+	: __LL_SC_PRESERVE("cc", "memory"));
 
 	return result;
 }
@@ -268,7 +270,7 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 	: [tmp] "=&r" (tmp), [oldval] "=&r" (oldval),			\
 	  [v] "+Q" (*(unsigned long *)ptr)				\
 	: [old] "Lr" (old), [new] "r" (new)				\
-	: cl);								\
+	: __LL_SC_PRESERVE(cl));					\
 									\
 	return oldval;							\
 }									\
@@ -316,7 +318,7 @@ __LL_SC_PREFIX(__cmpxchg_double##name(unsigned long old1,		\
 	"2:"								\
 	: "=&r" (tmp), "=&r" (ret), "+Q" (*(unsigned long *)ptr)	\
 	: "r" (old1), "r" (old2), "r" (new1), "r" (new2)		\
-	: cl);								\
+	: __LL_SC_PRESERVE(cl));					\
 									\
 	return ret;							\
 }									\
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index f9b0b09153e0..2520f8c2ee4a 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -59,7 +59,7 @@ static inline int atomic_fetch_##op##name(int i, atomic_t *v)		\
 "	" #asm_op #mb "	%w[i], %w[i], %[v]")				\
 	: [i] "+r" (w0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	: __LL_SC_FETCH_CLOBBERS, ##cl);				\
 									\
 	return w0;							\
 }
@@ -137,7 +137,7 @@ static inline int atomic_fetch_and##name(int i, atomic_t *v)		\
 	"	ldclr" #mb "	%w[i], %w[i], %[v]")			\
 	: [i] "+&r" (w0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	: __LL_SC_FETCH_CLOBBERS, ##cl);				\
 									\
 	return w0;							\
 }
@@ -209,7 +209,7 @@ static inline int atomic_fetch_sub##name(int i, atomic_t *v)		\
 	"	ldadd" #mb "	%w[i], %w[i], %[v]")			\
 	: [i] "+&r" (w0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	: __LL_SC_FETCH_CLOBBERS, ##cl);				\
 									\
 	return w0;							\
 }
@@ -256,7 +256,7 @@ static inline long atomic64_fetch_##op##name(long i, atomic64_t *v)	\
 "	" #asm_op #mb "	%[i], %[i], %[v]")				\
 	: [i] "+r" (x0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	: __LL_SC_FETCH_CLOBBERS, ##cl);				\
 									\
 	return x0;							\
 }
@@ -334,7 +334,7 @@ static inline long atomic64_fetch_and##name(long i, atomic64_t *v)	\
 	"	ldclr" #mb "	%[i], %[i], %[v]")			\
 	: [i] "+&r" (x0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	: __LL_SC_FETCH_CLOBBERS, ##cl);				\
 									\
 	return x0;							\
 }
@@ -406,7 +406,7 @@ static inline long atomic64_fetch_sub##name(long i, atomic64_t *v)	\
 	"	ldadd" #mb "	%[i], %[i], %[v]")			\
 	: [i] "+&r" (x0), [v] "+Q" (v->counter)				\
 	: "r" (x1)							\
-	: __LL_SC_CLOBBERS, ##cl);					\
+	: __LL_SC_FETCH_CLOBBERS, ##cl);				\
 									\
 	return x0;							\
 }
diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index 8262325e2fc6..7101a7e6df1c 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -30,6 +30,8 @@ __asm__(".arch_extension	lse");
 /* Macro for constructing calls to out-of-line ll/sc atomics */
 #define __LL_SC_CALL(op)	"bl\t" __stringify(__LL_SC_PREFIX(op)) "\n"
 #define __LL_SC_CLOBBERS	"x16", "x17", "x30"
+#define __LL_SC_FETCH_CLOBBERS	"x15", __LL_SC_CLOBBERS
+#define __LL_SC_PRESERVE(...)	"x15", ##__VA_ARGS__
 
 /* In-line patching at runtime */
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)				\
@@ -49,6 +51,7 @@ __asm__(".arch_extension	lse");
 #define __LL_SC_INLINE		static inline
 #define __LL_SC_PREFIX(x)	x
 #define __LL_SC_EXPORT(x)
+#define __LL_SC_PRESERVE(x...)	x
 
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)	llsc
 
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 137710f4dac3..be69c4077e75 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -16,7 +16,7 @@ CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
 		   -ffixed-x3 -ffixed-x4 -ffixed-x5 -ffixed-x6		\
 		   -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9		\
 		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
-		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
+		   -fcall-saved-x13 -fcall-saved-x14 \
 		   -fcall-saved-x18 -fomit-frame-pointer
 CFLAGS_REMOVE_atomic_ll_sc.o := -pg
 GCOV_PROFILE_atomic_ll_sc.o	:= n
-- 
2.18.0
