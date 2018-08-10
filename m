From: trong@android.com (Tri Vo)
Date: Thu,  9 Aug 2018 19:07:51 -0700
Subject: [RFC PATCH] arm64: lse: use register variables instead of -ffixed,
 -fcall flags
Message-ID: <20180810020751.44859-1-trong@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-ffixed, -fcall-used, -fcall-saved flags are used to build LL/SC
fallback atomic implementations in such a way that:
1. LSE implementations only assume x16, x17, x30 to be clobbered by a
function call to LL/SC fallbacks.
2. LL/SC fallbacks are responsible for saving/restoring the rest of the
GPRs.
3. LL/SC fallbacks always prefer to allocate in x16, x17 since there is
no need to save/restore them.

Same result can be achieved without -ffixed, -fcall-used, -fcall-saved
flags by explicitly telling the compiler where to allocate each variable
in LL/SC atomic implementations. This patch makes all functions use x16,
x17 registers. 'fetch' variants of the functions need one more scratch
register, so we allocate one from the PCS's set of callee-saved
registers (in this case x19).

With this patch:
1. the desired register allocation is reflected in the code rather than
in compiler flags.
2. LSE atomic support can be built with both clang and gcc.
3. Number of preserved registers in LL/SC fallbacks is unchanged.

The tradeoff is that the compiler loses flexibility in allocating
registers for inline LL/SC atomic implementations.

Signed-off-by: Tri Vo <trong@android.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 46 +++++++++++++++------------
 arch/arm64/lib/Makefile               | 12 -------
 2 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index f819fdcff1ac..24bc00212568 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -30,19 +30,19 @@
  * store exclusive to ensure that these are atomic.  We may loop
  * to ensure that the update happens.
  *
- * NOTE: these functions do *not* follow the PCS and must explicitly
- * save any clobbered registers other than x0 (regardless of return
- * value).  This is achieved through -fcall-saved-* compiler flags for
- * this file, which unfortunately don't work on a per-function basis
- * (the optimize attribute silently ignores these options).
+ * NOTE: the callers of these function do *not* follow the PCS, but these
+ * functions *do* follow the PCS. For correctness, these functions only allocate
+ * registers that either *must* be assumed clobbered by the caller (x16, x17,
+ * x30) or are callee-saved. For performance, these functions prefer allocating
+ * x16, x17 since there is no need to stack/unstack them.
  */

 #define ATOMIC_OP(op, asm_op)						\
 __LL_SC_INLINE void							\
 __LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
 {									\
-	unsigned long tmp;						\
-	int result;							\
+	register unsigned long tmp asm ("x16");				\
+	register int result asm ("w17");				\
 									\
 	asm volatile("// atomic_" #op "\n"				\
 "	prfm	pstl1strm, %2\n"					\
@@ -59,8 +59,8 @@ __LL_SC_EXPORT(atomic_##op);
 __LL_SC_INLINE int							\
 __LL_SC_PREFIX(atomic_##op##_return##name(int i, atomic_t *v))		\
 {									\
-	unsigned long tmp;						\
-	int result;							\
+	register unsigned long tmp asm ("x16");				\
+	register int result asm ("w17");				\
 									\
 	asm volatile("// atomic_" #op "_return" #name "\n"		\
 "	prfm	pstl1strm, %2\n"					\
@@ -81,8 +81,9 @@ __LL_SC_EXPORT(atomic_##op##_return##name);
 __LL_SC_INLINE int							\
 __LL_SC_PREFIX(atomic_fetch_##op##name(int i, atomic_t *v))		\
 {									\
-	unsigned long tmp;						\
-	int val, result;						\
+	register unsigned long tmp asm ("x16");				\
+	register int result asm ("w17");				\
+	register int val asm ("w19");					\
 									\
 	asm volatile("// atomic_fetch_" #op #name "\n"			\
 "	prfm	pstl1strm, %3\n"					\
@@ -135,8 +136,8 @@ ATOMIC_OPS(xor, eor)
 __LL_SC_INLINE void							\
 __LL_SC_PREFIX(atomic64_##op(long i, atomic64_t *v))			\
 {									\
-	long result;							\
-	unsigned long tmp;						\
+	register unsigned long tmp asm ("x16");				\
+	register long result asm ("x17");				\
 									\
 	asm volatile("// atomic64_" #op "\n"				\
 "	prfm	pstl1strm, %2\n"					\
@@ -153,8 +154,8 @@ __LL_SC_EXPORT(atomic64_##op);
 __LL_SC_INLINE long							\
 __LL_SC_PREFIX(atomic64_##op##_return##name(long i, atomic64_t *v))	\
 {									\
-	long result;							\
-	unsigned long tmp;						\
+	register unsigned long tmp asm ("x16");				\
+	register long result asm ("x17");				\
 									\
 	asm volatile("// atomic64_" #op "_return" #name "\n"		\
 "	prfm	pstl1strm, %2\n"					\
@@ -175,8 +176,9 @@ __LL_SC_EXPORT(atomic64_##op##_return##name);
 __LL_SC_INLINE long							\
 __LL_SC_PREFIX(atomic64_fetch_##op##name(long i, atomic64_t *v))	\
 {									\
-	long result, val;						\
-	unsigned long tmp;						\
+	register unsigned long tmp asm ("x16");				\
+	register long result asm ("x17");				\
+	register long val asm ("x19");					\
 									\
 	asm volatile("// atomic64_fetch_" #op #name "\n"		\
 "	prfm	pstl1strm, %3\n"					\
@@ -228,8 +230,8 @@ ATOMIC64_OPS(xor, eor)
 __LL_SC_INLINE long
 __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
 {
-	long result;
-	unsigned long tmp;
+	register unsigned long tmp asm ("x16");
+	register long result asm ("x17");

 	asm volatile("// atomic64_dec_if_positive\n"
 "	prfm	pstl1strm, %2\n"
@@ -254,7 +256,8 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 				     unsigned long old,			\
 				     unsigned long new))		\
 {									\
-	unsigned long tmp, oldval;					\
+	register unsigned long tmp asm ("x16");				\
+	register unsigned long oldval asm ("x17");			\
 									\
 	asm volatile(							\
 	"	prfm	pstl1strm, %[v]\n"				\
@@ -302,7 +305,8 @@ __LL_SC_PREFIX(__cmpxchg_double##name(unsigned long old1,		\
 				      unsigned long new2,		\
 				      volatile void *ptr))		\
 {									\
-	unsigned long tmp, ret;						\
+	register unsigned long tmp asm ("x16");				\
+	register unsigned long ret asm ("x17");				\
 									\
 	asm volatile("// __cmpxchg_double" #name "\n"			\
 	"	prfm	pstl1strm, %2\n"				\
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index c86b7909ef31..b9bcdf5f4aed 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -4,16 +4,4 @@ lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
 		   strchr.o strrchr.o

-# Tell the compiler to treat all general purpose registers (with the
-# exception of the IP registers, which are already handled by the caller
-# in case of a PLT) as callee-saved, which allows for efficient runtime
-# patching of the bl instruction in the caller with an atomic instruction
-# when supported by the CPU. Result and argument registers are handled
-# correctly, based on the function prototype.
 lib-$(CONFIG_ARM64_LSE_ATOMICS) += atomic_ll_sc.o
-CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
-		   -ffixed-x3 -ffixed-x4 -ffixed-x5 -ffixed-x6		\
-		   -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9		\
-		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
-		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
-		   -fcall-saved-x18
--
2.18.0.597.ga71716f1ad-goog
