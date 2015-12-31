From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 31 Dec 2015 21:07:51 +0200
Subject: [PATCH v2 16/32] arm64: define __smp_xxx
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
Message-ID: <1451572003-2440-17-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defines __smp_xxx barriers for arm64,
for use by virtualization.

smp_xxx barriers are removed as they are
defined correctly by asm-generic/barriers.h

Note: arm64 does not support !SMP config,
so smp_xxx and __smp_xxx are always equivalent.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/barrier.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 91a43f4..dae5c49 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -35,11 +35,11 @@
 #define dma_rmb()	dmb(oshld)
 #define dma_wmb()	dmb(oshst)
 
-#define smp_mb()	dmb(ish)
-#define smp_rmb()	dmb(ishld)
-#define smp_wmb()	dmb(ishst)
+#define __smp_mb()	dmb(ish)
+#define __smp_rmb()	dmb(ishld)
+#define __smp_wmb()	dmb(ishst)
 
-#define smp_store_release(p, v)						\
+#define __smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	switch (sizeof(*p)) {						\
@@ -62,7 +62,7 @@ do {									\
 	}								\
 } while (0)
 
-#define smp_load_acquire(p)						\
+#define __smp_load_acquire(p)						\
 ({									\
 	union { typeof(*p) __val; char __c[1]; } __u;			\
 	compiletime_assert_atomic_type(*p);				\
-- 
MST
