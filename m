From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Apr 2012 17:05:53 +0100
Subject: [RFC PATCH] ARM: cmpxchg64: use atomic64 and local64 routines for
 cmpxchg64
Message-ID: <1334333153-18899-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cmpxchg64 routines for ARMv6+ CPUs replicate inline assembly that
already exists for atomic64 operations. Furthermore, the cmpxchg64 code
uses the "memory" constraint in the clobber list rather than identifying
the region of memory that is actually modified.

This patch replaces the ARMv6+ cmpxchg64 code with macros that expand to
the atomic64_ and local64_ variants, casting the pointer parameter to
the appropriate container type.

Cc: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Right, so I work around a hairy cast using container_of, but it looks like
atomic_t is already synonymous to unsigned long (see atomic_clear_mask,
for example) so if we extend this assumption to atomic64_t then the cast
would be alright.

 arch/arm/include/asm/cmpxchg.h |   73 +++++++--------------------------------
 1 files changed, 13 insertions(+), 60 deletions(-)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index d41d7cb..7eb18c1 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -229,66 +229,19 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 				       (unsigned long)(n),		\
 				       sizeof(*(ptr))))
 
-#ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
-
-/*
- * Note : ARMv7-M (currently unsupported by Linux) does not support
- * ldrexd/strexd. If ARMv7-M is ever supported by the Linux kernel, it should
- * not be allowed to use __cmpxchg64.
- */
-static inline unsigned long long __cmpxchg64(volatile void *ptr,
-					     unsigned long long old,
-					     unsigned long long new)
-{
-	register unsigned long long oldval asm("r0");
-	register unsigned long long __old asm("r2") = old;
-	register unsigned long long __new asm("r4") = new;
-	unsigned long res;
-
-	do {
-		asm volatile(
-		"	@ __cmpxchg8\n"
-		"	ldrexd	%1, %H1, [%2]\n"
-		"	mov	%0, #0\n"
-		"	teq	%1, %3\n"
-		"	teqeq	%H1, %H3\n"
-		"	strexdeq %0, %4, %H4, [%2]\n"
-			: "=&r" (res), "=&r" (oldval)
-			: "r" (ptr), "Ir" (__old), "r" (__new)
-			: "memory", "cc");
-	} while (res);
-
-	return oldval;
-}
-
-static inline unsigned long long __cmpxchg64_mb(volatile void *ptr,
-						unsigned long long old,
-						unsigned long long new)
-{
-	unsigned long long ret;
-
-	smp_mb();
-	ret = __cmpxchg64(ptr, old, new);
-	smp_mb();
-
-	return ret;
-}
-
-#define cmpxchg64(ptr,o,n)						\
-	((__typeof__(*(ptr)))__cmpxchg64_mb((ptr),			\
-					    (unsigned long long)(o),	\
-					    (unsigned long long)(n)))
-
-#define cmpxchg64_local(ptr,o,n)					\
-	((__typeof__(*(ptr)))__cmpxchg64((ptr),				\
-					 (unsigned long long)(o),	\
-					 (unsigned long long)(n)))
-
-#else /* min ARCH = ARMv6 */
-
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
-
-#endif
+#define cmpxchg64(ptr, o, n)						\
+	((__typeof__(*(ptr)))atomic64_cmpxchg(container_of((ptr),	\
+						atomic64_t,		\
+						counter),		\
+					      (unsigned long)(o),	\
+					      (unsigned long)(n)))
+
+#define cmpxchg64_local(ptr, o, n)					\
+	((__typeof__(*(ptr)))local64_cmpxchg(container_of((ptr),	\
+						local64_t,		\
+						a),			\
+					     (unsigned long)(o),	\
+					     (unsigned long)(n)))
 
 #endif	/* __LINUX_ARM_ARCH__ >= 6 */
 
-- 
1.7.4.1
