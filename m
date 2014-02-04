From: will.deacon@arm.com (Will Deacon)
Date: Tue,  4 Feb 2014 13:28:45 +0000
Subject: [PATCH 2/2] ARM: atomics: implement a better __atomic_add_unless for
 v6+
In-Reply-To: <1391520525-14903-1-git-send-email-will.deacon@arm.com>
References: <1391520525-14903-1-git-send-email-will.deacon@arm.com>
Message-ID: <1391520525-14903-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looking at perf profiles of multi-threaded hackbench runs, a significant
performance hit appears to manifest from the cmpxchg loop used to
implement the 32-bit atomic_add_unless function. This can be mitigated
by writing a direct implementation of __atomic_add_unless which doesn't
require iteration outside of the atomic operation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/atomic.h | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 6e410090896e..9a92fd7864a8 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -141,6 +141,33 @@ static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
 	return oldval;
 }
 
+static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+	int oldval, newval;
+	unsigned long tmp;
+
+	smp_mb();
+	prefetchw(&v->counter);
+
+	__asm__ __volatile__ ("@ atomic_add_unless\n"
+"1:	ldrex	%0, [%4]\n"
+"	teq	%0, %5\n"
+"	beq	2f\n"
+"	add	%1, %0, %6\n"
+"	strex	%2, %1, [%4]\n"
+"	teq	%2, #0\n"
+"	bne	1b\n"
+"2:"
+	: "=&r" (oldval), "=&r" (newval), "=&r" (tmp), "+Qo" (v->counter)
+	: "r" (&v->counter), "r" (u), "r" (a)
+	: "cc");
+
+	if (oldval != u)
+		smp_mb();
+
+	return oldval;
+}
+
 #else /* ARM_ARCH_6 */
 
 #ifdef CONFIG_SMP
@@ -189,10 +216,6 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return ret;
 }
 
-#endif /* __LINUX_ARM_ARCH__ */
-
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
-
 static inline int __atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
@@ -203,6 +226,10 @@ static inline int __atomic_add_unless(atomic_t *v, int a, int u)
 	return c;
 }
 
+#endif /* __LINUX_ARM_ARCH__ */
+
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
 #define atomic_inc(v)		atomic_add(1, v)
 #define atomic_dec(v)		atomic_sub(1, v)
 
-- 
1.8.2.2
