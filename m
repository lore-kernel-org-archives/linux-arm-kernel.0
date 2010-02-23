From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2010 12:21:56 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100223111036.GA10501@n2100.arm.linux.org.uk>
References: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
	<20100223111036.GA10501@n2100.arm.linux.org.uk>
Message-ID: <1266927716.3123.57.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-02-23 at 11:10 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2010 at 11:01:05AM +0000, Catalin Marinas wrote:
> > -#define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > -#define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > -#define wmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> > +#define mb()		dsb()
> > +#define rmb()		dmb()
> > +#define wmb()		dsb()
> 
> What is the reason for getting rid of the arch_is_coherent() bit here
> and imposing non-compiler barriers on everything?  I'd assume that
> Lennert knew what he was doing with Xscale3.
> 
> This also breaks ARMv3 since you now issue a mcr for the write buffer
> on architectures which have no write buffer.

What about the patch below?


ARM: Change the mandatory barriers implementation

From: Catalin Marinas <catalin.marinas@arm.com>

The mandatory barriers (mb, rmb, wmb) are used even on uniprocessor
systems for things like ordering Normal Non-cacheable memory accesses
with DMA transfer (via Device memory writes). The current implementation
uses dmb() for mb() and friends but this is not sufficient. The DMB only
ensures the ordering of accesses with regards to a single observer
accessing the same memory. If a DMA transfer is started by a write to
Device memory, the data to be transfered may not reach the main memory
(even if mapped as Normal Non-cacheable) before the device receives the
notification to begin the transfer. The only barrier that would help in
this situation is DSB which would completely drain the write buffers.

The patch also adds support for platform-defined barriers that can be
defined in mach/barriers.h. This is required by at least two platforms -
MSM and RealView (possible OMAP as well). On RealView with an outer
cache (PL310 for example) stores to Normal Non-cacheable memory are
buffered by the outer cache but the DSB doesn't go as far as this. A
separate L2x0 sync command is required (a store to Strongly Ordered
memory would do as well, similar to the MSM requirements and maybe
faster).

Note that the SMP barriers are not affected as they only deal with
ordering in Normal memory. There is however a situation with the use of
IPIs. A DMB is not enough to ensure that a write to Normal memory is
strictly ordered with respect to the IPI generation (and interrupt
handling). A solution is for the users of smp_call_function() to use a
mandatory barrier.

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
index 058e7e9..0db8b06 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -138,10 +138,12 @@ extern unsigned int user_debug;
 #define dmb() __asm__ __volatile__ ("" : : : "memory")
 #endif
 
-#if __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
-#define mb()		dmb()
+#ifdef CONFIG_ARCH_HAS_BARRIERS
+#include <mach/barriers.h>
+#elif __LINUX_ARM_ARCH__ >= 5
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



-- 
Catalin
