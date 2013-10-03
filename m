From: will.deacon@arm.com (Will Deacon)
Date: Thu,  3 Oct 2013 19:17:32 +0100
Subject: [PATCH v2 1/3] ARM: cmpxchg: implement barrier-less cmpxchg64_local
In-Reply-To: <1380824254-22337-1-git-send-email-will.deacon@arm.com>
References: <1380824254-22337-1-git-send-email-will.deacon@arm.com>
Message-ID: <1380824254-22337-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our cmpxchg64 macros are wrappers around atomic64_cmpxchg. Whilst this is
great for code re-use, there is a case for barrier-less cmpxchg where it
is known to be safe (for example cmpxchg64_local and cmpxchg-based
lockrefs).

This patch introduces a 64-bit cmpxchg implementation specifically
for the cmpxchg64_* macros, so that it can be later used by the lockref
code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/cmpxchg.h | 52 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 4f009c1..fbd978f 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -223,6 +223,42 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	return ret;
 }
 
+static inline unsigned long long __cmpxchg64(unsigned long long *ptr,
+					     unsigned long long old,
+					     unsigned long long new)
+{
+	unsigned long long oldval;
+	unsigned long res;
+
+	__asm__ __volatile__(
+"1:	ldrexd		%1, %H1, [%3]\n"
+"	teq		%1, %4\n"
+"	teqeq		%H1, %H4\n"
+"	bne		2f\n"
+"	strexd		%0, %5, %H5, [%3]\n"
+"	teq		%0, #0\n"
+"	bne		1b\n"
+"2:"
+	: "=&r" (res), "=&r" (oldval), "+Qo" (*ptr)
+	: "r" (ptr), "r" (old), "r" (new)
+	: "cc");
+
+	return oldval;
+}
+
+static inline unsigned long long __cmpxchg64_mb(unsigned long long *ptr,
+						unsigned long long old,
+						unsigned long long new)
+{
+	unsigned long long ret;
+
+	smp_mb();
+	ret = __cmpxchg64(ptr, old, new);
+	smp_mb();
+
+	return ret;
+}
+
 #define cmpxchg_local(ptr,o,n)						\
 	((__typeof__(*(ptr)))__cmpxchg_local((ptr),			\
 				       (unsigned long)(o),		\
@@ -230,18 +266,14 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 				       sizeof(*(ptr))))
 
 #define cmpxchg64(ptr, o, n)						\
-	((__typeof__(*(ptr)))atomic64_cmpxchg(container_of((ptr),	\
-						atomic64_t,		\
-						counter),		\
-					      (unsigned long long)(o),	\
-					      (unsigned long long)(n)))
+	((__typeof__(*(ptr)))__cmpxchg64_mb((ptr),			\
+					(unsigned long long)(o),	\
+					(unsigned long long)(n)))
 
 #define cmpxchg64_local(ptr, o, n)					\
-	((__typeof__(*(ptr)))local64_cmpxchg(container_of((ptr),	\
-						local64_t,		\
-						a),			\
-					     (unsigned long long)(o),	\
-					     (unsigned long long)(n)))
+	((__typeof__(*(ptr)))__cmpxchg64((ptr),				\
+					(unsigned long long)(o),	\
+					(unsigned long long)(n)))
 
 #endif	/* __LINUX_ARM_ARCH__ >= 6 */
 
-- 
1.8.2.2
