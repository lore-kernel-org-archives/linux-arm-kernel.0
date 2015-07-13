From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:12 +0100
Subject: [PATCH 11/18] arm64: cmpxchg_dbl: patch in lse instructions when
 supported by the CPU
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-12-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On CPUs which support the LSE atomic instructions introduced in ARMv8.1,
it makes sense to use them in preference to ll/sc sequences.

This patch introduces runtime patching of our cmpxchg_double primitives
so that the LSE casp instruction is used instead.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 34 ++++++++++++++++++
 arch/arm64/include/asm/atomic_lse.h   | 45 +++++++++++++++++++++++
 arch/arm64/include/asm/cmpxchg.h      | 68 +++++++++--------------------------
 3 files changed, 96 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index b4298f9a898f..77d3aabf52ad 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -243,4 +243,38 @@ __CMPXCHG_CASE( ,  , mb_8, dmb ish, "memory")
 
 #undef __CMPXCHG_CASE
 
+#define __CMPXCHG_DBL(name, mb, cl)					\
+__LL_SC_INLINE int							\
+__LL_SC_PREFIX(__cmpxchg_double##name(unsigned long old1,		\
+				      unsigned long old2,		\
+				      unsigned long new1,		\
+				      unsigned long new2,		\
+				      volatile void *ptr))		\
+{									\
+	unsigned long tmp, ret;						\
+									\
+	asm volatile("// __cmpxchg_double" #name "\n"			\
+	"	" #mb "\n"						\
+	"1:	ldxp	%0, %1, %2\n"					\
+	"	eor	%0, %0, %3\n"					\
+	"	eor	%1, %1, %4\n"					\
+	"	orr	%1, %0, %1\n"					\
+	"	cbnz	%1, 2f\n"					\
+	"	stxp	%w0, %5, %6, %2\n"				\
+	"	cbnz	%w0, 1b\n"					\
+	"	" #mb "\n"						\
+	"2:"								\
+	: "=&r" (tmp), "=&r" (ret), "+Q" (*(unsigned long *)ptr)	\
+	: "r" (old1), "r" (old2), "r" (new1), "r" (new2)		\
+	: cl);								\
+									\
+	return ret;							\
+}									\
+__LL_SC_EXPORT(__cmpxchg_double##name);
+
+__CMPXCHG_DBL(   ,        ,         )
+__CMPXCHG_DBL(_mb, dmb ish, "memory")
+
+#undef __CMPXCHG_DBL
+
 #endif	/* __ASM_ATOMIC_LL_SC_H */
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index a87ed3af6ced..b1f55aac6d96 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -266,4 +266,49 @@ __CMPXCHG_CASE( ,  , mb_8, al, "memory")
 #undef __LL_SC_CMPXCHG
 #undef __CMPXCHG_CASE
 
+#define __LL_SC_CMPXCHG_DBL(op, tmp)					\
+	__LL_SC_SAVE_LR(tmp)						\
+	__LL_SC_CALL(__cmpxchg_double##op)				\
+	__LL_SC_RESTORE_LR(tmp)
+
+#define __CMPXCHG_DBL(name, mb, cl)					\
+static inline int __cmpxchg_double##name(unsigned long old1,		\
+					 unsigned long old2,		\
+					 unsigned long new1,		\
+					 unsigned long new2,		\
+					 volatile void *ptr)		\
+{									\
+	unsigned long tmp;						\
+	unsigned long oldval1 = old1;					\
+	unsigned long oldval2 = old2;					\
+	register unsigned long x0 asm ("x0") = old1;			\
+	register unsigned long x1 asm ("x1") = old2;			\
+	register unsigned long x2 asm ("x2") = new1;			\
+	register unsigned long x3 asm ("x3") = new2;			\
+	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
+									\
+	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"	nop\n"							\
+	__LL_SC_CMPXCHG_DBL(name, %[tmp]),				\
+	/* LSE atomics */						\
+	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
+	"	eor	%[old1], %[old1], %[oldval1]\n"			\
+	"	eor	%[old2], %[old2], %[oldval2]\n"			\
+	"	orr	%[old1], %[old1], %[old2]")			\
+	: [tmp] "=&r" (tmp), [old1] "+r" (x0), [old2] "+r" (x1),	\
+	  [v] "+Q" (*(unsigned long *)ptr)				\
+	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
+	  [oldval1] "r" (oldval1), [oldval2] "r" (oldval2)		\
+	: cl);								\
+									\
+	return x0;							\
+}
+
+__CMPXCHG_DBL(   ,   ,         )
+__CMPXCHG_DBL(_mb, al, "memory")
+
+#undef __LL_SC_CMPXCHG_DBL
+#undef __CMPXCHG_DBL
+
 #endif	/* __ASM_ATOMIC_LSE_H */
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 60a558127cef..f70212629d02 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -128,51 +128,6 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	unreachable();
 }
 
-#define system_has_cmpxchg_double()     1
-
-static inline int __cmpxchg_double(volatile void *ptr1, volatile void *ptr2,
-		unsigned long old1, unsigned long old2,
-		unsigned long new1, unsigned long new2, int size)
-{
-	unsigned long loop, lost;
-
-	switch (size) {
-	case 8:
-		VM_BUG_ON((unsigned long *)ptr2 - (unsigned long *)ptr1 != 1);
-		do {
-			asm volatile("// __cmpxchg_double8\n"
-			"	ldxp	%0, %1, %2\n"
-			"	eor	%0, %0, %3\n"
-			"	eor	%1, %1, %4\n"
-			"	orr	%1, %0, %1\n"
-			"	mov	%w0, #0\n"
-			"	cbnz	%1, 1f\n"
-			"	stxp	%w0, %5, %6, %2\n"
-			"1:\n"
-				: "=&r"(loop), "=&r"(lost), "+Q" (*(u64 *)ptr1)
-				: "r" (old1), "r"(old2), "r"(new1), "r"(new2));
-		} while (loop);
-		break;
-	default:
-		BUILD_BUG();
-	}
-
-	return !lost;
-}
-
-static inline int __cmpxchg_double_mb(volatile void *ptr1, volatile void *ptr2,
-			unsigned long old1, unsigned long old2,
-			unsigned long new1, unsigned long new2, int size)
-{
-	int ret;
-
-	smp_mb();
-	ret = __cmpxchg_double(ptr1, ptr2, old1, old2, new1, new2, size);
-	smp_mb();
-
-	return ret;
-}
-
 static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 					 unsigned long new, int size)
 {
@@ -210,21 +165,32 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 	__ret; \
 })
 
+#define system_has_cmpxchg_double()     1
+
+#define __cmpxchg_double_check(ptr1, ptr2)					\
+({										\
+	if (sizeof(*(ptr1)) != 8)						\
+		BUILD_BUG();							\
+	VM_BUG_ON((unsigned long *)(ptr2) - (unsigned long *)(ptr1) != 1);	\
+})
+
 #define cmpxchg_double(ptr1, ptr2, o1, o2, n1, n2) \
 ({\
 	int __ret;\
-	__ret = __cmpxchg_double_mb((ptr1), (ptr2), (unsigned long)(o1), \
-			(unsigned long)(o2), (unsigned long)(n1), \
-			(unsigned long)(n2), sizeof(*(ptr1)));\
+	__cmpxchg_double_check(ptr1, ptr2); \
+	__ret = !__cmpxchg_double_mb((unsigned long)(o1), (unsigned long)(o2), \
+				     (unsigned long)(n1), (unsigned long)(n2), \
+				     ptr1); \
 	__ret; \
 })
 
 #define cmpxchg_double_local(ptr1, ptr2, o1, o2, n1, n2) \
 ({\
 	int __ret;\
-	__ret = __cmpxchg_double((ptr1), (ptr2), (unsigned long)(o1), \
-			(unsigned long)(o2), (unsigned long)(n1), \
-			(unsigned long)(n2), sizeof(*(ptr1)));\
+	__cmpxchg_double_check(ptr1, ptr2); \
+	__ret = !__cmpxchg_double((unsigned long)(o1), (unsigned long)(o2), \
+				  (unsigned long)(n1), (unsigned long)(n2), \
+				  ptr1); \
 	__ret; \
 })
 
-- 
2.1.4
