From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Nov 2018 15:39:23 -0800
Subject: [PATCH 3/3] arm64/atomics: remove out of line LL/SC alternatives
In-Reply-To: <20181113233923.20098-1-ard.biesheuvel@linaro.org>
References: <20181113233923.20098-1-ard.biesheuvel@linaro.org>
Message-ID: <20181113233923.20098-4-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we are no longer emitting calls to the out of line LL/SC
alternatives from the LSE implementation, drop the exports, the
prototype decorations and the Makefile rules that build the object
file that contains them.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 48 ++++++--------------
 arch/arm64/include/asm/lse.h          |  9 ----
 arch/arm64/lib/Makefile               | 19 --------
 arch/arm64/lib/atomic_ll_sc.c         |  3 --
 4 files changed, 15 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index 10d0b7360747..0aa65d7a9f27 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -85,8 +85,7 @@
 #if !(defined(CONFIG_ARM64_LSE_ATOMICS) && defined(CONFIG_AS_LSE))
 
 #define ATOMIC_OP(op, asm_op)						\
-__LL_SC_INLINE void							\
-__LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
+static inline void atomic_##op(int i, atomic_t *v))			\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -96,11 +95,9 @@ __LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
 	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)	\
 	: [i]"Ir" (i));							\
 }									\
-__LL_SC_EXPORT(atomic_##op);
 
 #define ATOMIC_OP_RETURN(name, mb, acq, rel, cl, op, asm_op)		\
-__LL_SC_INLINE int							\
-__LL_SC_PREFIX(atomic_##op##_return##name(int i, atomic_t *v))		\
+static inline int atomic_##op##_return##name(int i, atomic_t *v)	\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -113,11 +110,9 @@ __LL_SC_PREFIX(atomic_##op##_return##name(int i, atomic_t *v))		\
 									\
 	return result;							\
 }									\
-__LL_SC_EXPORT(atomic_##op##_return##name);
 
 #define ATOMIC_FETCH_OP(name, mb, acq, rel, cl, op, asm_op)		\
-__LL_SC_INLINE int							\
-__LL_SC_PREFIX(atomic_fetch_##op##name(int i, atomic_t *v))		\
+static inline int atomic_fetch_##op##name(int i, atomic_t *v)		\
 {									\
 	unsigned long tmp;						\
 	int val, result;						\
@@ -131,7 +126,6 @@ __LL_SC_PREFIX(atomic_fetch_##op##name(int i, atomic_t *v))		\
 									\
 	return result;							\
 }									\
-__LL_SC_EXPORT(atomic_fetch_##op##name);
 
 #define ATOMIC_OPS(...)							\
 	ATOMIC_OP(__VA_ARGS__)						\
@@ -166,8 +160,7 @@ ATOMIC_OPS(xor, eor)
 #undef ATOMIC_OP
 
 #define ATOMIC64_OP(op, asm_op)						\
-__LL_SC_INLINE void							\
-__LL_SC_PREFIX(atomic64_##op(long i, atomic64_t *v))			\
+static inline void atomic64_##op(long i, atomic64_t *v)			\
 {									\
 	long result;							\
 	unsigned long tmp;						\
@@ -177,11 +170,9 @@ __LL_SC_PREFIX(atomic64_##op(long i, atomic64_t *v))			\
 	: [res]"=&r" (result), [tmp]"=&r" (tmp), [v]"+Q" (v->counter)	\
 	: [i]"Ir" (i));							\
 }									\
-__LL_SC_EXPORT(atomic64_##op);
 
 #define ATOMIC64_OP_RETURN(name, mb, acq, rel, cl, op, asm_op)		\
-__LL_SC_INLINE long							\
-__LL_SC_PREFIX(atomic64_##op##_return##name(long i, atomic64_t *v))	\
+static inline long atomic64_##op##_return##name(long i, atomic64_t *v)	\
 {									\
 	long result;							\
 	unsigned long tmp;						\
@@ -194,11 +185,9 @@ __LL_SC_PREFIX(atomic64_##op##_return##name(long i, atomic64_t *v))	\
 									\
 	return result;							\
 }									\
-__LL_SC_EXPORT(atomic64_##op##_return##name);
 
 #define ATOMIC64_FETCH_OP(name, mb, acq, rel, cl, op, asm_op)		\
-__LL_SC_INLINE long							\
-__LL_SC_PREFIX(atomic64_fetch_##op##name(long i, atomic64_t *v))	\
+static inline long atomic64_fetch_##op##name(long i, atomic64_t *v)	\
 {									\
 	long result, val;						\
 	unsigned long tmp;						\
@@ -212,7 +201,6 @@ __LL_SC_PREFIX(atomic64_fetch_##op##name(long i, atomic64_t *v))	\
 									\
 	return result;							\
 }									\
-__LL_SC_EXPORT(atomic64_fetch_##op##name);
 
 #define ATOMIC64_OPS(...)						\
 	ATOMIC64_OP(__VA_ARGS__)					\
@@ -246,8 +234,7 @@ ATOMIC64_OPS(xor, eor)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-__LL_SC_INLINE long
-__LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
+static inline long atomic64_dec_if_positive(atomic64_t *v)
 {
 	long result;
 	unsigned long tmp;
@@ -267,13 +254,11 @@ __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
 
 	return result;
 }
-__LL_SC_EXPORT(atomic64_dec_if_positive);
 
 #define __CMPXCHG_CASE(w, sz, name, mb, acq, rel, cl)			\
-__LL_SC_INLINE unsigned long						\
-__LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
-				     unsigned long old,			\
-				     unsigned long new))		\
+static inline unsigned long __cmpxchg_case_##name(volatile void *ptr,	\
+						  unsigned long old,	\
+						  unsigned long new)	\
 {									\
 	unsigned long tmp, oldval;					\
 									\
@@ -286,7 +271,6 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 									\
 	return oldval;							\
 }									\
-__LL_SC_EXPORT(__cmpxchg_case_##name);
 
 __CMPXCHG_CASE(w, b,     1,        ,  ,  ,         )
 __CMPXCHG_CASE(w, h,     2,        ,  ,  ,         )
@@ -308,12 +292,11 @@ __CMPXCHG_CASE( ,  ,  mb_8, dmb ish,  , l, "memory")
 #undef __CMPXCHG_CASE
 
 #define __CMPXCHG_DBL(name, mb, rel, cl)				\
-__LL_SC_INLINE long							\
-__LL_SC_PREFIX(__cmpxchg_double##name(unsigned long old1,		\
-				      unsigned long old2,		\
-				      unsigned long new1,		\
-				      unsigned long new2,		\
-				      volatile void *ptr))		\
+static inline long __cmpxchg_double##name(unsigned long old1,		\
+					  unsigned long old2,		\
+					  unsigned long new1,		\
+					  unsigned long new2,		\
+					  volatile void *ptr)		\
 {									\
 	unsigned long tmp, ret;						\
 									\
@@ -327,7 +310,6 @@ __LL_SC_PREFIX(__cmpxchg_double##name(unsigned long old1,		\
 									\
 	return ret;							\
 }									\
-__LL_SC_EXPORT(__cmpxchg_double##name);
 
 __CMPXCHG_DBL(   ,        ,  ,         )
 __CMPXCHG_DBL(_mb, dmb ish, l, "memory")
diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index ef70f62ea25e..3ae4f9a6c207 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -22,11 +22,6 @@
 
 __asm__(".arch_extension	lse");
 
-/* Move the ll/sc atomics out-of-line */
-#define __LL_SC_INLINE		notrace
-#define __LL_SC_PREFIX(x)	__ll_sc_##x
-#define __LL_SC_EXPORT(x)	EXPORT_SYMBOL(__LL_SC_PREFIX(x))
-
 /* In-line patching at runtime */
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)				\
 	ALTERNATIVE(llsc, lse, ARM64_HAS_LSE_ATOMICS)
@@ -42,10 +37,6 @@ __asm__(".arch_extension	lse");
 
 #else	/* __ASSEMBLER__ */
 
-#define __LL_SC_INLINE		static inline
-#define __LL_SC_PREFIX(x)	x
-#define __LL_SC_EXPORT(x)
-
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)	llsc
 
 #endif	/* __ASSEMBLER__ */
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 69ff9887f724..39be2f7f0084 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -5,25 +5,6 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
 		   strchr.o strrchr.o tishift.o
 
-# Tell the compiler to treat all general purpose registers (with the
-# exception of the IP registers, which are already handled by the caller
-# in case of a PLT) as callee-saved, which allows for efficient runtime
-# patching of the bl instruction in the caller with an atomic instruction
-# when supported by the CPU. Result and argument registers are handled
-# correctly, based on the function prototype.
-lib-$(CONFIG_ARM64_LSE_ATOMICS) += atomic_ll_sc.o
-CFLAGS_atomic_ll_sc.o	:= -ffixed-x1 -ffixed-x2        		\
-		   -ffixed-x3 -ffixed-x4 -ffixed-x5 -ffixed-x6		\
-		   -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9		\
-		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
-		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
-		   -fcall-saved-x18 -fomit-frame-pointer
-CFLAGS_REMOVE_atomic_ll_sc.o := -pg
-GCOV_PROFILE_atomic_ll_sc.o	:= n
-KASAN_SANITIZE_atomic_ll_sc.o	:= n
-KCOV_INSTRUMENT_atomic_ll_sc.o	:= n
-UBSAN_SANITIZE_atomic_ll_sc.o	:= n
-
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
 obj-$(CONFIG_CRC32) += crc32.o
diff --git a/arch/arm64/lib/atomic_ll_sc.c b/arch/arm64/lib/atomic_ll_sc.c
deleted file mode 100644
index b0c538b0da28..000000000000
--- a/arch/arm64/lib/atomic_ll_sc.c
+++ /dev/null
@@ -1,3 +0,0 @@
-#include <asm/atomic.h>
-#define __ARM64_IN_ATOMIC_IMPL
-#include <asm/atomic_ll_sc.h>
-- 
2.17.1
