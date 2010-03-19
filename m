From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Mar 2010 14:33:17 +0000
Subject: [PATCH v5 4/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100319143047.11748.9186.stgit@e102109-lin.cambridge.arm.com>
References: <20100319143047.11748.9186.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100319143317.11748.81936.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mandatory barriers (mb, rmb, wmb) are used even on uniprocessor
systems for things like ordering Normal Non-cacheable memory accesses
with DMA transfer (via Device memory writes). The current implementation
uses dmb() for mb() and friends but this is not sufficient. The DMB only
ensures the relative ordering of the observability of accesses by other
processors or devices acting as masters. In case of DMA transfers
started by writes to device memory, the relative ordering is not ensured
because accesses to slave ports of a device are not considered
observable by the DMB definition.

A DSB is required for the data to reach the main memory (even if mapped
as Normal Non-cacheable) before the device receives the notification to
begin the transfer. Furthermore, some L2 cache controllers (like L2x0 or
PL310) buffer stores to Normal Non-cacheable memory and this would need
to be drained with the outer_sync() function call.

The patch also allows platforms to define their own mandatory barriers
implementation by selecting CONFIG_ARCH_HAS_BARRIERS and providing a
mach/barriers.h file.

Note that the SMP barriers are unchanged (being DMBs as before) since
they are only guaranteed to work with Normal Cacheable memory.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/system.h |   16 ++++++++++------
 arch/arm/mm/Kconfig           |    6 ++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index ca88e6a..4ace45e 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -60,6 +60,8 @@
 #include <linux/linkage.h>
 #include <linux/irqflags.h>
 
+#include <asm/outercache.h>
+
 #define __exception	__attribute__((section(".exception.text")))
 
 struct thread_info;
@@ -137,10 +139,12 @@ extern unsigned int user_debug;
 #define dmb() __asm__ __volatile__ ("" : : : "memory")
 #endif
 
-#if __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
-#define mb()		dmb()
+#ifdef CONFIG_ARCH_HAS_BARRIERS
+#include <mach/barriers.h>
+#elif __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
+#define mb()		do { dsb(); outer_sync(); } while (0)
 #define rmb()		dmb()
-#define wmb()		dmb()
+#define wmb()		mb()
 #else
 #define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
 #define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
@@ -152,9 +156,9 @@ extern unsigned int user_debug;
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
 #else
-#define smp_mb()	mb()
-#define smp_rmb()	rmb()
-#define smp_wmb()	wmb()
+#define smp_mb()	dmb()
+#define smp_rmb()	dmb()
+#define smp_wmb()	dmb()
 #endif
 
 #define read_barrier_depends()		do { } while(0)
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 55a2a00..5bd7c89 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -788,3 +788,9 @@ config ARM_L1_CACHE_SHIFT
 	int
 	default 6 if ARM_L1_CACHE_SHIFT_6
 	default 5
+
+config ARCH_HAS_BARRIERS
+	bool
+	help
+	  This option allows the use of custom mandatory barriers
+	  included via the mach/barriers.h file.
