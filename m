From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:14 +0100
Subject: [PATCH 13/18] arm64: cmpxchg: avoid memory barrier on comparison
 failure
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-14-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cmpxchg doesn't require memory barrier semantics when the value
comparison fails, so make the barrier conditional on success.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h | 48 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index d21091bae901..fb26f2b1f300 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -92,19 +92,18 @@ __LL_SC_PREFIX(atomic_cmpxchg(atomic_t *ptr, int old, int new))
 	unsigned long tmp;
 	int oldval;
 
-	smp_mb();
-
 	asm volatile("// atomic_cmpxchg\n"
 "1:	ldxr	%w1, %2\n"
 "	eor	%w0, %w1, %w3\n"
 "	cbnz	%w0, 2f\n"
-"	stxr	%w0, %w4, %2\n"
+"	stlxr	%w0, %w4, %2\n"
 "	cbnz	%w0, 1b\n"
+"	dmb	ish\n"
 "2:"
 	: "=&r" (tmp), "=&r" (oldval), "+Q" (ptr->counter)
-	: "Lr" (old), "r" (new));
+	: "Lr" (old), "r" (new)
+	: "memory");
 
-	smp_mb();
 	return oldval;
 }
 __LL_SC_EXPORT(atomic_cmpxchg);
@@ -164,19 +163,18 @@ __LL_SC_PREFIX(atomic64_cmpxchg(atomic64_t *ptr, long old, long new))
 	long oldval;
 	unsigned long res;
 
-	smp_mb();
-
 	asm volatile("// atomic64_cmpxchg\n"
 "1:	ldxr	%1, %2\n"
 "	eor	%0, %1, %3\n"
 "	cbnz	%w0, 2f\n"
-"	stxr	%w0, %4, %2\n"
+"	stlxr	%w0, %4, %2\n"
 "	cbnz	%w0, 1b\n"
+"	dmb	ish\n"
 "2:"
 	: "=&r" (res), "=&r" (oldval), "+Q" (ptr->counter)
-	: "Lr" (old), "r" (new));
+	: "Lr" (old), "r" (new)
+	: "memory");
 
-	smp_mb();
 	return oldval;
 }
 __LL_SC_EXPORT(atomic64_cmpxchg);
@@ -203,7 +201,7 @@ __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
 }
 __LL_SC_EXPORT(atomic64_dec_if_positive);
 
-#define __CMPXCHG_CASE(w, sz, name, mb, cl)				\
+#define __CMPXCHG_CASE(w, sz, name, mb, rel, cl)			\
 __LL_SC_INLINE unsigned long						\
 __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 				     unsigned long old,			\
@@ -212,11 +210,10 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 	unsigned long tmp, oldval;					\
 									\
 	asm volatile(							\
-	"	" #mb "\n"						\
 	"1:	ldxr" #sz "\t%" #w "[oldval], %[v]\n"			\
 	"	eor	%" #w "[tmp], %" #w "[oldval], %" #w "[old]\n"	\
 	"	cbnz	%" #w "[tmp], 2f\n"				\
-	"	stxr" #sz "\t%w[tmp], %" #w "[new], %[v]\n"		\
+	"	st" #rel "xr" #sz "\t%w[tmp], %" #w "[new], %[v]\n"	\
 	"	cbnz	%w[tmp], 1b\n"					\
 	"	" #mb "\n"						\
 	"	mov	%" #w "[oldval], %" #w "[old]\n"		\
@@ -230,18 +227,18 @@ __LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,		\
 }									\
 __LL_SC_EXPORT(__cmpxchg_case_##name);
 
-__CMPXCHG_CASE(w, b,    1,        ,         )
-__CMPXCHG_CASE(w, h,    2,        ,         )
-__CMPXCHG_CASE(w,  ,    4,        ,         )
-__CMPXCHG_CASE( ,  ,    8,        ,         )
-__CMPXCHG_CASE(w, b, mb_1, dmb ish, "memory")
-__CMPXCHG_CASE(w, h, mb_2, dmb ish, "memory")
-__CMPXCHG_CASE(w,  , mb_4, dmb ish, "memory")
-__CMPXCHG_CASE( ,  , mb_8, dmb ish, "memory")
+__CMPXCHG_CASE(w, b,    1,        ,  ,         )
+__CMPXCHG_CASE(w, h,    2,        ,  ,         )
+__CMPXCHG_CASE(w,  ,    4,        ,  ,         )
+__CMPXCHG_CASE( ,  ,    8,        ,  ,         )
+__CMPXCHG_CASE(w, b, mb_1, dmb ish, l, "memory")
+__CMPXCHG_CASE(w, h, mb_2, dmb ish, l, "memory")
+__CMPXCHG_CASE(w,  , mb_4, dmb ish, l, "memory")
+__CMPXCHG_CASE( ,  , mb_8, dmb ish, l, "memory")
 
 #undef __CMPXCHG_CASE
 
-#define __CMPXCHG_DBL(name, mb, cl)					\
+#define __CMPXCHG_DBL(name, mb, rel, cl)				\
 __LL_SC_INLINE int							\
 __LL_SC_PREFIX(__cmpxchg_double##name(unsigned long old1,		\
 				      unsigned long old2,		\
@@ -252,13 +249,12 @@ __LL_SC_PREFIX(__cmpxchg_double##name(unsigned long old1,		\
 	unsigned long tmp, ret;						\
 									\
 	asm volatile("// __cmpxchg_double" #name "\n"			\
-	"	" #mb "\n"						\
 	"1:	ldxp	%0, %1, %2\n"					\
 	"	eor	%0, %0, %3\n"					\
 	"	eor	%1, %1, %4\n"					\
 	"	orr	%1, %0, %1\n"					\
 	"	cbnz	%1, 2f\n"					\
-	"	stxp	%w0, %5, %6, %2\n"				\
+	"	st" #rel "xp	%w0, %5, %6, %2\n"			\
 	"	cbnz	%w0, 1b\n"					\
 	"	" #mb "\n"						\
 	"2:"								\
@@ -270,8 +266,8 @@ __LL_SC_PREFIX(__cmpxchg_double##name(unsigned long old1,		\
 }									\
 __LL_SC_EXPORT(__cmpxchg_double##name);
 
-__CMPXCHG_DBL(   ,        ,         )
-__CMPXCHG_DBL(_mb, dmb ish, "memory")
+__CMPXCHG_DBL(   ,        ,  ,         )
+__CMPXCHG_DBL(_mb, dmb ish, l, "memory")
 
 #undef __CMPXCHG_DBL
 
-- 
2.1.4
