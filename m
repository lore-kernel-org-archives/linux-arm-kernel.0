From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:15 +0100
Subject: [PATCH 14/18] arm64: atomics: tidy up common atomic{,64}_* macros
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-15-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common (i.e. identical for ll/sc and lse) atomic macros in atomic.h
are needlessley different for atomic_t and atomic64_t.

This patch tidies up the definitions to make them consistent across the
two atomic types and factors out common code such as the add_unless
implementation based on cmpxchg.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic.h | 92 +++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index ee32776d926c..51816ab2312d 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -26,8 +26,6 @@
 #include <asm/barrier.h>
 #include <asm/lse.h>
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 #ifdef __KERNEL__
 
 #define __ARM64_IN_ATOMIC_IMPL
@@ -42,67 +40,53 @@
 
 #include <asm/cmpxchg.h>
 
-/*
- * On ARM, ordinary assignment (str instruction) doesn't clear the local
- * strex/ldrex monitor on some implementations. The reason we can use it for
- * atomic_set() is the clrex or dummy strex done on every exception return.
- */
-#define atomic_read(v)	ACCESS_ONCE((v)->counter)
-#define atomic_set(v,i)	(((v)->counter) = (i))
-
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
-
-static inline int __atomic_add_unless(atomic_t *v, int a, int u)
-{
-	int c, old;
-
-	c = atomic_read(v);
-	while (c != u && (old = atomic_cmpxchg((v), c, c + a)) != c)
-		c = old;
-	return c;
-}
+#define ___atomic_add_unless(v, a, u, sfx)				\
+({									\
+	typeof((v)->counter) c, old;					\
+									\
+	c = atomic##sfx##_read(v);					\
+	while (c != (u) &&						\
+	      (old = atomic##sfx##_cmpxchg((v), c, c + (a))) != c)	\
+		c = old;						\
+	c;								\
+ })
 
-#define atomic_inc(v)		atomic_add(1, v)
-#define atomic_dec(v)		atomic_sub(1, v)
+#define ATOMIC_INIT(i)	{ (i) }
 
-#define atomic_inc_and_test(v)	(atomic_add_return(1, v) == 0)
-#define atomic_dec_and_test(v)	(atomic_sub_return(1, v) == 0)
-#define atomic_inc_return(v)    (atomic_add_return(1, v))
-#define atomic_dec_return(v)    (atomic_sub_return(1, v))
-#define atomic_sub_and_test(i, v) (atomic_sub_return(i, v) == 0)
+#define atomic_read(v)			READ_ONCE((v)->counter)
+#define atomic_set(v, i)		(((v)->counter) = (i))
+#define atomic_xchg(v, new)		xchg(&((v)->counter), (new))
 
-#define atomic_add_negative(i,v) (atomic_add_return(i, v) < 0)
+#define atomic_inc(v)			atomic_add(1, (v))
+#define atomic_dec(v)			atomic_sub(1, (v))
+#define atomic_inc_return(v)		atomic_add_return(1, (v))
+#define atomic_dec_return(v)		atomic_sub_return(1, (v))
+#define atomic_inc_and_test(v)		(atomic_inc_return(v) == 0)
+#define atomic_dec_and_test(v)		(atomic_dec_return(v) == 0)
+#define atomic_sub_and_test(i, v)	(atomic_sub_return((i), (v)) == 0)
+#define atomic_add_negative(i, v)	(atomic_add_return((i), (v)) < 0)
+#define __atomic_add_unless(v, a, u)	___atomic_add_unless(v, a, u,)
 
 /*
  * 64-bit atomic operations.
  */
-#define ATOMIC64_INIT(i) { (i) }
-
-#define atomic64_read(v)	ACCESS_ONCE((v)->counter)
-#define atomic64_set(v,i)	(((v)->counter) = (i))
-
-#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
-
-static inline int atomic64_add_unless(atomic64_t *v, long a, long u)
-{
-	long c, old;
-
-	c = atomic64_read(v);
-	while (c != u && (old = atomic64_cmpxchg((v), c, c + a)) != c)
-		c = old;
+#define ATOMIC64_INIT			ATOMIC_INIT
+#define atomic64_read			atomic_read
+#define atomic64_set			atomic_set
+#define atomic64_xchg			atomic_xchg
+
+#define atomic64_inc(v)			atomic64_add(1, (v))
+#define atomic64_dec(v)			atomic64_sub(1, (v))
+#define atomic64_inc_return(v)		atomic64_add_return(1, (v))
+#define atomic64_dec_return(v)		atomic64_sub_return(1, (v))
+#define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
+#define atomic64_dec_and_test(v)	(atomic64_dec_return(v) == 0)
+#define atomic64_sub_and_test(i, v)	(atomic64_sub_return((i), (v)) == 0)
+#define atomic64_add_negative(i, v)	(atomic64_add_return((i), (v)) < 0)
+#define atomic64_add_unless(v, a, u)	(___atomic_add_unless(v, a, u, 64) != u)
 
-	return c != u;
-}
+#define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1, 0)
 
-#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
-#define atomic64_inc(v)			atomic64_add(1LL, (v))
-#define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
-#define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
-#define atomic64_sub_and_test(a, v)	(atomic64_sub_return((a), (v)) == 0)
-#define atomic64_dec(v)			atomic64_sub(1LL, (v))
-#define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
-#define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
-#define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1LL, 0LL)
 
 #endif
 #endif
-- 
2.1.4
