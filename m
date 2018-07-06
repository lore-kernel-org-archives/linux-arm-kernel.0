From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Jul 2018 13:26:11 +0100
Subject: Clarifying dma_wmb behavior in presence of non-coherent masters
 and outer caches
In-Reply-To: <20180702174552.GD23687@arm.com>
References: <1530275290.22468.69.camel@pengutronix.de>
 <20180629142539.GH17271@n2100.armlinux.org.uk>
 <20180629162248.GB20010@arm.com>
 <20180629164801.GJ17271@n2100.armlinux.org.uk>
 <20180629174321.GA20909@arm.com>
 <1530539366.22468.89.camel@pengutronix.de>
 <20180702174552.GD23687@arm.com>
Message-ID: <20180706122610.GA6993@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Mon, Jul 02, 2018 at 06:45:52PM +0100, Will Deacon wrote:
> On Mon, Jul 02, 2018 at 03:49:26PM +0200, Lucas Stach wrote:
> > Also the section "External caches", "Before AMBA4 ACE" seems to suggest
> > that the barriers aren't fully propagated to the PL310 write-caches and
> > master ports. I'm unsure if this is just an artifact of the mentioned
> > MMIO access, so handling of normal vs. device memory transactions in
> > the PL310.
> 
> I'll check with the hardware folks about the PL310, but I don't see how
> you could propagate barriers over AXI3 anyway because I don't think this
> stuff existed back then.

Damn. As I feared, you can't propagate the barrier to the PL310, so the
A9 is unable to enforce ordering beyond the responses it gets back. The
PL310 will then re-order normal memory accesses (including non-cacheable)
in its store buffer, so we do actually need a bloody CACHE SYNC here.

Patch below. Does it help?

Will

--->8

>From 5a2769b45e94b212d21bc44f5940ed5f3bde5cc2 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Wed, 4 Jul 2018 10:56:22 +0100
Subject: [PATCH] ARM: barrier: Kick outer-cache and SoC fabric in dma_wmb()

Prior to AMBA4-ACE, the AXI bus protocol had no support for barrier
transactions or shareability domains and was therefore unable to enforce
ordering between memory accesses either side of a barrier instruction,
requiring the CPU to handle all of the ordering itself.

Unfortunately, IP such as the venerable PL310 will re-order stores to
Normal memory inside its store-buffer, meaning that accesses to a coherent
DMA buffer (i.e. one allocated by dma_alloc_coherent()) can be observed
out-of-order by a non-coherent DMA engine unless the PL310 is kicked with
a CACHE_SYNC command between buffering the accesses. Whilst this is already
the case for mb() and wmb(), dma_wmb() just expands to a DMB OSHST, leading
to sequences such as:

	STR	Rdata, [Rbuf, #DATA_OFFSET]
	DMB	OSHST
	STR	Rvalid, [Rbuf, #VALID_OFFSET]

being reordered such that the DMA device sees the write of valid but not
the write of data.

This patch ensures that the SoC fabric and the outer-cache are kicked
by dma_wmb() if they are able to buffer transactions outside of the CPU
but before the Point of Coherency.

Reported-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/barrier.h    | 14 ++++++++++----
 arch/arm/include/asm/outercache.h |  6 ++++++
 arch/arm/mm/flush.c               | 24 +++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 69772e742a0a..e31833f72b69 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -53,17 +53,23 @@
 #ifdef CONFIG_ARM_HEAVY_MB
 extern void (*soc_mb)(void);
 extern void arm_heavy_mb(void);
-#define __arm_heavy_mb(x...) do { dsb(x); arm_heavy_mb(); } while (0)
+extern void arm_heavy_wmb(void);
+extern void arm_heavy_dma_wmb(void);
+#define __arm_heavy_mb()	arm_heavy_mb()
+#define __arm_heavy_wmb()	arm_heavy_wmb()
+#define __arm_heavy_dma_wmb()	arm_heavy_dma_wmb()
 #else
-#define __arm_heavy_mb(x...) dsb(x)
+#define __arm_heavy_mb()	dsb()
+#define __arm_heavy_wmb()	dsb(st)
+#define __arm_heavy_dma_wmb()	dmb(oshst)
 #endif
 
 #if defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
 #define mb()		__arm_heavy_mb()
 #define rmb()		dsb()
-#define wmb()		__arm_heavy_mb(st)
+#define wmb()		__arm_heavy_wmb()
 #define dma_rmb()	dmb(osh)
-#define dma_wmb()	dmb(oshst)
+#define dma_wmb()	__arm_heavy_dma_wmb()
 #else
 #define mb()		barrier()
 #define rmb()		barrier()
diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index c2bf24f40177..e744efe6e2a7 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -43,6 +43,12 @@ struct outer_cache_fns {
 
 extern struct outer_cache_fns outer_cache;
 
+#ifdef CONFIG_OUTER_CACHE_SYNC
+static inline bool outer_cache_has_sync(void) { return outer_cache.sync; }
+#else
+static inline bool outer_cache_has_sync(void) { return 0; }
+#endif
+
 #ifdef CONFIG_OUTER_CACHE
 /**
  * outer_inv_range - invalidate range of outer cache lines
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 58469623b015..1252689362d8 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -24,7 +24,7 @@
 #ifdef CONFIG_ARM_HEAVY_MB
 void (*soc_mb)(void);
 
-void arm_heavy_mb(void)
+static void __arm_heavy_sync(void)
 {
 #ifdef CONFIG_OUTER_CACHE_SYNC
 	if (outer_cache.sync)
@@ -33,7 +33,29 @@ void arm_heavy_mb(void)
 	if (soc_mb)
 		soc_mb();
 }
+
+void arm_heavy_mb(void)
+{
+	dsb();
+	__arm_heavy_sync();
+}
 EXPORT_SYMBOL(arm_heavy_mb);
+
+void arm_heavy_wmb(void)
+{
+	dsb(st);
+	__arm_heavy_sync();
+}
+EXPORT_SYMBOL(arm_heavy_wmb);
+
+void arm_heavy_dma_wmb(void)
+{
+	if (outer_cache_has_sync() || soc_mb)
+		arm_heavy_wmb();
+	else
+		dmb(oshst);
+}
+EXPORT_SYMBOL(arm_heavy_dma_wmb);
 #endif
 
 #ifdef CONFIG_CPU_CACHE_VIPT
-- 
2.1.4
