From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 31 Dec 2015 21:08:30 +0200
Subject: [PATCH v2 21/32] mips: define __smp_xxx
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
Message-ID: <1451572003-2440-22-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defines __smp_xxx barriers for mips,
for use by virtualization.

smp_xxx barriers are removed as they are
defined correctly by asm-generic/barriers.h

Note: the only exception is smp_mb__before_llsc which is mips-specific.
We define both the __smp_mb__before_llsc variant (for use in
asm/barriers.h) and smp_mb__before_llsc (for use elsewhere on this
architecture).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/barrier.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index 3eac4b9..d296633 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -85,20 +85,20 @@
 #define wmb()		fast_wmb()
 #define rmb()		fast_rmb()
 
-#if defined(CONFIG_WEAK_ORDERING) && defined(CONFIG_SMP)
+#if defined(CONFIG_WEAK_ORDERING)
 # ifdef CONFIG_CPU_CAVIUM_OCTEON
-#  define smp_mb()	__sync()
-#  define smp_rmb()	barrier()
-#  define smp_wmb()	__syncw()
+#  define __smp_mb()	__sync()
+#  define __smp_rmb()	barrier()
+#  define __smp_wmb()	__syncw()
 # else
-#  define smp_mb()	__asm__ __volatile__("sync" : : :"memory")
-#  define smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
-#  define smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
+#  define __smp_mb()	__asm__ __volatile__("sync" : : :"memory")
+#  define __smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
+#  define __smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
 # endif
 #else
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
+#define __smp_mb()	barrier()
+#define __smp_rmb()	barrier()
+#define __smp_wmb()	barrier()
 #endif
 
 #if defined(CONFIG_WEAK_REORDERING_BEYOND_LLSC) && defined(CONFIG_SMP)
@@ -111,6 +111,7 @@
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #define smp_mb__before_llsc() smp_wmb()
+#define __smp_mb__before_llsc() __smp_wmb()
 /* Cause previous writes to become visible on all CPUs as soon as possible */
 #define nudge_writes() __asm__ __volatile__(".set push\n\t"		\
 					    ".set arch=octeon\n\t"	\
@@ -118,11 +119,12 @@
 					    ".set pop" : : : "memory")
 #else
 #define smp_mb__before_llsc() smp_llsc_mb()
+#define __smp_mb__before_llsc() smp_llsc_mb()
 #define nudge_writes() mb()
 #endif
 
-#define smp_mb__before_atomic()	smp_mb__before_llsc()
-#define smp_mb__after_atomic()	smp_llsc_mb()
+#define __smp_mb__before_atomic()	__smp_mb__before_llsc()
+#define __smp_mb__after_atomic()	smp_llsc_mb()
 
 #include <asm-generic/barrier.h>
 
-- 
MST
