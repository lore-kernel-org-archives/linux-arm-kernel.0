From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 03 Mar 2010 12:16:42 +0000
Subject: [PATCH v3 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100303121307.22029.26151.stgit@e102109-lin.cambridge.arm.com>
References: <20100303121307.22029.26151.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100303121642.22029.24521.stgit@e102109-lin.cambridge.arm.com>
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
begin the transfer.

The patch also adds support for platform-defined barriers that can be
defined in mach/barriers.h. This is required by at least two platforms -
MSM and RealView (possible OMAP as well). On RealView with an outer
cache (PL310 for example) stores to Normal Non-cacheable memory are
buffered by the outer cache but the DSB doesn't go as far as this. A
separate L2x0 sync command is required (a store to Strongly Ordered
memory would do as well, similar to the MSM requirements and maybe
faster).

Note that the SMP barriers are implemented as DMB since they are only
guaranteed to work with Normal cacheable memory.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Walker <dwalker@codeaurora.org>
Cc: Larry Bassel <lbassel@quicinc.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/system.h |   14 ++++++++------
 arch/arm/mm/Kconfig           |    6 ++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 058e7e9..146305a 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -138,10 +138,12 @@ extern unsigned int user_debug;
 #define dmb() __asm__ __volatile__ ("" : : : "memory")
 #endif
 
-#if __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
-#define mb()		dmb()
+#ifdef CONFIG_ARCH_HAS_BARRIERS
+#include <mach/barriers.h>
+#elif __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
+#define mb()		dsb()
 #define rmb()		dmb()
-#define wmb()		dmb()
+#define wmb()		dsb()
 #else
 #define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
 #define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
@@ -153,9 +155,9 @@ extern unsigned int user_debug;
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
index f62beb7..f67f2c4 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -802,3 +802,9 @@ config ARM_L1_CACHE_SHIFT
 	int
 	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
 	default 5
+
+config ARCH_HAS_BARRIERS
+	bool
+	help
+	  This option allows the use of custom mandatory barriers
+	  included via the mach/barriers.h file.
