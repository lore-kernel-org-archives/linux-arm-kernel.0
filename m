From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:11 +0100
Subject: [PATCH 10/18] arm64: cmpxchg: patch in lse instructions when
 supported by the CPU
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-11-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On CPUs which support the LSE atomic instructions introduced in ARMv8.1,
it makes sense to use them in preference to ll/sc sequences.

This patch introduces runtime patching of our cmpxchg primitives so that
the LSE cas instruction is used instead.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic.h       |  3 +-
 arch/arm64/include/asm/atomic_ll_sc.h | 38 ++++++++++++++++
 arch/arm64/include/asm/atomic_lse.h   | 40 +++++++++++++++++
 arch/arm64/include/asm/cmpxchg.h      | 84 ++++++++---------------------------
 4 files changed, 99 insertions(+), 66 deletions(-)

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index cb53efa23f62..ee32776d926c 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -24,7 +24,6 @@
 #include <linux/types.h>
 
 #include <asm/barrier.h>
-#include <asm/cmpxchg.h>
 #include <asm/lse.h>
 
 #define ATOMIC_INIT(i)	{ (i) }
@@ -41,6 +40,8 @@
 
 #undef __ARM64_IN_ATOMIC_IMPL
 
+#include <asm/cmpxchg.h>
+
 /*
  * On ARM, ordinary assignment (str instruction) doesn't clear the local
  * strex/ldrex monitor on some implementations. The reason we can use it for
diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index 9cf298914ac3..b4298f9a898f 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -205,4 +205,42 @@ __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
 }
 __LL_SC_EXPORT(atomic64_dec_if_positive);
 
+#define __CMPXCHG_CASE(w, sz, name, mb, cl)				\
+__LL_SC_INLINE unsigned long						\
+__LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
+				     unsigned long old,			\
+				     unsigned long new))		\
+{									\
+	unsigned long tmp, oldval;					\
+									\
+	asm volatile(							\
+	"	" #mb "\n"						\
+	"1:	ldxr" #sz "\t%" #w "[oldval], %[v]\n"			\
+	"	eor	%" #w "[tmp], %" #w "[oldval], %" #w "[old]\n"	\
+	"	cbnz	%" #w "[tmp], 2f\n"				\
+	"	stxr" #sz "\t%w[tmp], %" #w "[new], %[v]\n"		\
+	"	cbnz	%w[tmp], 1b\n"					\
+	"	" #mb "\n"						\
+	"	mov	%" #w "[oldval], %" #w "[old]\n"		\
+	"2:"								\
+	: [tmp] "=&r" (tmp), [oldval] "=&r" (oldval),			\
+	  [v] "+Q" (*(unsigned long *)ptr)				\
+	: [old] "Lr" (old), [new] "r" (new)				\
+	: cl);								\
+									\
+	return oldval;							\
+}									\
+__LL_SC_EXPORT(__cmpxchg_case_##name);
+
+__CMPXCHG_CASE(w, b,    1,        ,         )
+__CMPXCHG_CASE(w, h,    2,        ,         )
+__CMPXCHG_CASE(w,  ,    4,        ,         )
+__CMPXCHG_CASE( ,  ,    8,        ,         )
+__CMPXCHG_CASE(w, b, mb_1, dmb ish, "memory")
+__CMPXCHG_CASE(w, h, mb_2, dmb ish, "memory")
+__CMPXCHG_CASE(w,  , mb_4, dmb ish, "memory")
+__CMPXCHG_CASE( ,  , mb_8, dmb ish, "memory")
+
+#undef __CMPXCHG_CASE
+
 #endif	/* __ASM_ATOMIC_LL_SC_H */
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index d59780350514..a87ed3af6ced 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -226,4 +226,44 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 
 #undef __LL_SC_ATOMIC64
 
+#define __LL_SC_CMPXCHG(op, tmp)					\
+	__LL_SC_SAVE_LR(tmp)						\
+	__LL_SC_CALL(__cmpxchg_case_##op)				\
+	__LL_SC_RESTORE_LR(tmp)
+
+#define __CMPXCHG_CASE(w, sz, name, mb, cl)				\
+static inline unsigned long __cmpxchg_case_##name(volatile void *ptr,	\
+						  unsigned long old,	\
+						  unsigned long new)	\
+{									\
+	unsigned long tmp;						\
+	register unsigned long x0 asm ("x0") = (unsigned long)ptr;	\
+	register unsigned long x1 asm ("x1") = old;			\
+	register unsigned long x2 asm ("x2") = new;			\
+									\
+	asm volatile(							\
+	ARM64_LSE_ATOMIC_INSN(__LL_SC_CMPXCHG(name, %[tmp]),		\
+	"	mov	%" #w "[tmp], %" #w "[old]\n"			\
+	"	cas" #mb #sz "\t%" #w "[tmp], %" #w "[new], %[v]\n"	\
+	"	mov	%" #w "[ret], %" #w "[tmp]")			\
+	: [tmp] "=&r" (tmp), [ret] "+r" (x0),				\
+	  [v] "+Q" (*(unsigned long *)ptr)				\
+	: [old] "r" (x1), [new] "r" (x2)				\
+	: cl);								\
+									\
+	return x0;							\
+}
+
+__CMPXCHG_CASE(w, b,    1,   ,         )
+__CMPXCHG_CASE(w, h,    2,   ,         )
+__CMPXCHG_CASE(w,  ,    4,   ,         )
+__CMPXCHG_CASE( ,  ,    8,   ,         )
+__CMPXCHG_CASE(w, b, mb_1, al, "memory")
+__CMPXCHG_CASE(w, h, mb_2, al, "memory")
+__CMPXCHG_CASE(w,  , mb_4, al, "memory")
+__CMPXCHG_CASE( ,  , mb_8, al, "memory")
+
+#undef __LL_SC_CMPXCHG
+#undef __CMPXCHG_CASE
+
 #endif	/* __ASM_ATOMIC_LSE_H */
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index d0cce8068902..60a558127cef 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -21,6 +21,7 @@
 #include <linux/bug.h>
 #include <linux/mmdebug.h>
 
+#include <asm/atomic.h>
 #include <asm/barrier.h>
 #include <asm/lse.h>
 
@@ -111,74 +112,20 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				      unsigned long new, int size)
 {
-	unsigned long oldval = 0, res;
-
 	switch (size) {
 	case 1:
-		do {
-			asm volatile("// __cmpxchg1\n"
-			"	ldxrb	%w1, %2\n"
-			"	mov	%w0, #0\n"
-			"	cmp	%w1, %w3\n"
-			"	b.ne	1f\n"
-			"	stxrb	%w0, %w4, %2\n"
-			"1:\n"
-				: "=&r" (res), "=&r" (oldval), "+Q" (*(u8 *)ptr)
-				: "Ir" (old), "r" (new)
-				: "cc");
-		} while (res);
-		break;
-
+		return __cmpxchg_case_1(ptr, old, new);
 	case 2:
-		do {
-			asm volatile("// __cmpxchg2\n"
-			"	ldxrh	%w1, %2\n"
-			"	mov	%w0, #0\n"
-			"	cmp	%w1, %w3\n"
-			"	b.ne	1f\n"
-			"	stxrh	%w0, %w4, %2\n"
-			"1:\n"
-				: "=&r" (res), "=&r" (oldval), "+Q" (*(u16 *)ptr)
-				: "Ir" (old), "r" (new)
-				: "cc");
-		} while (res);
-		break;
-
+		return __cmpxchg_case_2(ptr, old, new);
 	case 4:
-		do {
-			asm volatile("// __cmpxchg4\n"
-			"	ldxr	%w1, %2\n"
-			"	mov	%w0, #0\n"
-			"	cmp	%w1, %w3\n"
-			"	b.ne	1f\n"
-			"	stxr	%w0, %w4, %2\n"
-			"1:\n"
-				: "=&r" (res), "=&r" (oldval), "+Q" (*(u32 *)ptr)
-				: "Ir" (old), "r" (new)
-				: "cc");
-		} while (res);
-		break;
-
+		return __cmpxchg_case_4(ptr, old, new);
 	case 8:
-		do {
-			asm volatile("// __cmpxchg8\n"
-			"	ldxr	%1, %2\n"
-			"	mov	%w0, #0\n"
-			"	cmp	%1, %3\n"
-			"	b.ne	1f\n"
-			"	stxr	%w0, %4, %2\n"
-			"1:\n"
-				: "=&r" (res), "=&r" (oldval), "+Q" (*(u64 *)ptr)
-				: "Ir" (old), "r" (new)
-				: "cc");
-		} while (res);
-		break;
-
+		return __cmpxchg_case_8(ptr, old, new);
 	default:
 		BUILD_BUG();
 	}
 
-	return oldval;
+	unreachable();
 }
 
 #define system_has_cmpxchg_double()     1
@@ -229,13 +176,20 @@ static inline int __cmpxchg_double_mb(volatile void *ptr1, volatile void *ptr2,
 static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 					 unsigned long new, int size)
 {
-	unsigned long ret;
-
-	smp_mb();
-	ret = __cmpxchg(ptr, old, new, size);
-	smp_mb();
+	switch (size) {
+	case 1:
+		return __cmpxchg_case_mb_1(ptr, old, new);
+	case 2:
+		return __cmpxchg_case_mb_2(ptr, old, new);
+	case 4:
+		return __cmpxchg_case_mb_4(ptr, old, new);
+	case 8:
+		return __cmpxchg_case_mb_8(ptr, old, new);
+	default:
+		BUILD_BUG();
+	}
 
-	return ret;
+	unreachable();
 }
 
 #define cmpxchg(ptr, o, n) \
-- 
2.1.4
