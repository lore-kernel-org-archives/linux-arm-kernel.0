From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 31 Dec 2015 21:09:17 +0200
Subject: [PATCH v2 27/32] x86: define __smp_xxx
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
Message-ID: <1451572003-2440-28-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defines __smp_xxx barriers for x86,
for use by virtualization.

smp_xxx barriers are removed as they are
defined correctly by asm-generic/barriers.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/barrier.h | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index cc4c2a7..a584e1c 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -31,17 +31,10 @@
 #endif
 #define dma_wmb()	barrier()
 
-#ifdef CONFIG_SMP
-#define smp_mb()	mb()
-#define smp_rmb()	dma_rmb()
-#define smp_wmb()	barrier()
-#define smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
-#else /* !SMP */
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
-#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); barrier(); } while (0)
-#endif /* SMP */
+#define __smp_mb()	mb()
+#define __smp_rmb()	dma_rmb()
+#define __smp_wmb()	barrier()
+#define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
 
 #if defined(CONFIG_X86_PPRO_FENCE)
 
@@ -50,31 +43,31 @@
  * model and we should fall back to full barriers.
  */
 
-#define smp_store_release(p, v)						\
+#define __smp_store_release(p, v)					\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	__smp_mb();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 
-#define smp_load_acquire(p)						\
+#define __smp_load_acquire(p)						\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
+	__smp_mb();							\
 	___p1;								\
 })
 
 #else /* regular x86 TSO memory ordering */
 
-#define smp_store_release(p, v)						\
+#define __smp_store_release(p, v)					\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 
-#define smp_load_acquire(p)						\
+#define __smp_load_acquire(p)						\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
@@ -85,8 +78,8 @@ do {									\
 #endif
 
 /* Atomic operations are already serializing on x86 */
-#define smp_mb__before_atomic()	barrier()
-#define smp_mb__after_atomic()	barrier()
+#define __smp_mb__before_atomic()	barrier()
+#define __smp_mb__after_atomic()	barrier()
 
 #include <asm-generic/barrier.h>
 
-- 
MST
