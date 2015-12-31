From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 31 Dec 2015 21:07:42 +0200
Subject: [PATCH v2 15/32] powerpc: define __smp_xxx
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
Message-ID: <1451572003-2440-16-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defines __smp_xxx barriers for powerpc
for use by virtualization.

smp_xxx barriers are removed as they are
defined correctly by asm-generic/barriers.h

This reduces the amount of arch-specific boiler-plate code.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/barrier.h | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 980ad0c..c0deafc 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -44,19 +44,11 @@
 #define dma_rmb()	__lwsync()
 #define dma_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
 
-#ifdef CONFIG_SMP
-#define smp_lwsync()	__lwsync()
+#define __smp_lwsync()	__lwsync()
 
-#define smp_mb()	mb()
-#define smp_rmb()	__lwsync()
-#define smp_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
-#else
-#define smp_lwsync()	barrier()
-
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
-#endif /* CONFIG_SMP */
+#define __smp_mb()	mb()
+#define __smp_rmb()	__lwsync()
+#define __smp_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
 
 /*
  * This is a barrier which prevents following instructions from being
@@ -67,18 +59,18 @@
 #define data_barrier(x)	\
 	asm volatile("twi 0,%0,0; isync" : : "r" (x) : "memory");
 
-#define smp_store_release(p, v)						\
+#define __smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
-	smp_lwsync();							\
+	__smp_lwsync();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 
-#define smp_load_acquire(p)						\
+#define __smp_load_acquire(p)						\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-	smp_lwsync();							\
+	__smp_lwsync();							\
 	___p1;								\
 })
 
-- 
MST
