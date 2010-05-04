From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 04 May 2010 17:44:21 +0100
Subject: [PATCH 1/8] ARM: Improve the L2 cache performance when PL310 is used
In-Reply-To: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100504164421.26355.9656.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this L2 cache controller, the cache maintenance by PA and sync
operations are atomic and do not require a "wait" loop or spinlocks.
This patch conditionally defines the cache_wait() function and locking
primitives (rather than duplicating the functions or file).

Since L2x0 cache controllers do not work with ARMv7 CPUs, the patch
automatically enables CACHE_PL310 when CPU_V7 is defined.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/Kconfig      |    7 ++++
 arch/arm/mm/cache-l2x0.c |   73 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5bd7c89..5df74c1 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -767,6 +767,13 @@ config CACHE_L2X0
 	help
 	  This option enables the L2x0 PrimeCell.
 
+config CACHE_PL310
+	bool
+	depends on CACHE_L2X0
+	default y if CPU_V7
+	help
+	  This option enables support for the PL310 cache controller.
+
 config CACHE_TAUROS2
 	bool "Enable the Tauros2 L2 cache controller"
 	depends on ARCH_DOVE
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 21ad68b..87bd0a0 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -26,15 +26,42 @@
 #define CACHE_LINE_SIZE		32
 
 static void __iomem *l2x0_base;
-static DEFINE_SPINLOCK(l2x0_lock);
 
-static inline void cache_wait(void __iomem *reg, unsigned long mask)
+static inline void cache_wait_always(void __iomem *reg, unsigned long mask)
 {
 	/* wait for the operation to complete */
 	while (readl(reg) & mask)
 		;
 }
 
+#ifdef CONFIG_CACHE_PL310
+
+static inline void cache_wait(void __iomem *reg, unsigned long mask)
+{
+	/* cache operations are atomic */
+}
+
+#define _l2x0_lock(lock, flags)		((void)(flags))
+#define _l2x0_unlock(lock, flags)	((void)(flags))
+
+#define block_end(start, end)		(end)
+
+#define L2CC_TYPE			"PL310/L2C-310"
+
+#else	/* !CONFIG_CACHE_PL310 */
+
+#define cache_wait			cache_wait_always
+
+static DEFINE_SPINLOCK(l2x0_lock);
+#define _l2x0_lock(lock, flags)		spin_lock_irqsave(lock, flags)
+#define _l2x0_unlock(lock, flags)	spin_unlock_irqrestore(lock, flags)
+
+#define block_end(start, end)		((start) + min((end) - (start), 4096UL))
+
+#define L2CC_TYPE			"L2x0"
+
+#endif	/* CONFIG_CACHE_PL310 */
+
 static inline void cache_sync(void)
 {
 	void __iomem *base = l2x0_base;
@@ -97,9 +124,9 @@ static void l2x0_cache_sync(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&l2x0_lock, flags);
+	_l2x0_lock(&l2x0_lock, flags);
 	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
+	_l2x0_unlock(&l2x0_lock, flags);
 }
 
 static inline void l2x0_inv_all(void)
@@ -107,11 +134,11 @@ static inline void l2x0_inv_all(void)
 	unsigned long flags;
 
 	/* invalidate all ways */
-	spin_lock_irqsave(&l2x0_lock, flags);
+	_l2x0_lock(&l2x0_lock, flags);
 	writel(0xff, l2x0_base + L2X0_INV_WAY);
-	cache_wait(l2x0_base + L2X0_INV_WAY, 0xff);
+	cache_wait_always(l2x0_base + L2X0_INV_WAY, 0xff);
 	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
+	_l2x0_unlock(&l2x0_lock, flags);
 }
 
 static void l2x0_inv_range(unsigned long start, unsigned long end)
@@ -119,7 +146,7 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
-	spin_lock_irqsave(&l2x0_lock, flags);
+	_l2x0_lock(&l2x0_lock, flags);
 	if (start & (CACHE_LINE_SIZE - 1)) {
 		start &= ~(CACHE_LINE_SIZE - 1);
 		debug_writel(0x03);
@@ -136,7 +163,7 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 	}
 
 	while (start < end) {
-		unsigned long blk_end = start + min(end - start, 4096UL);
+		unsigned long blk_end = block_end(start, end);
 
 		while (start < blk_end) {
 			l2x0_inv_line(start);
@@ -144,13 +171,13 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 		}
 
 		if (blk_end < end) {
-			spin_unlock_irqrestore(&l2x0_lock, flags);
-			spin_lock_irqsave(&l2x0_lock, flags);
+			_l2x0_unlock(&l2x0_lock, flags);
+			_l2x0_lock(&l2x0_lock, flags);
 		}
 	}
 	cache_wait(base + L2X0_INV_LINE_PA, 1);
 	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
+	_l2x0_unlock(&l2x0_lock, flags);
 }
 
 static void l2x0_clean_range(unsigned long start, unsigned long end)
@@ -158,10 +185,10 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
-	spin_lock_irqsave(&l2x0_lock, flags);
+	_l2x0_lock(&l2x0_lock, flags);
 	start &= ~(CACHE_LINE_SIZE - 1);
 	while (start < end) {
-		unsigned long blk_end = start + min(end - start, 4096UL);
+		unsigned long blk_end = block_end(start, end);
 
 		while (start < blk_end) {
 			l2x0_clean_line(start);
@@ -169,13 +196,13 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
 		}
 
 		if (blk_end < end) {
-			spin_unlock_irqrestore(&l2x0_lock, flags);
-			spin_lock_irqsave(&l2x0_lock, flags);
+			_l2x0_unlock(&l2x0_lock, flags);
+			_l2x0_lock(&l2x0_lock, flags);
 		}
 	}
 	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
 	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
+	_l2x0_unlock(&l2x0_lock, flags);
 }
 
 static void l2x0_flush_range(unsigned long start, unsigned long end)
@@ -183,10 +210,10 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
-	spin_lock_irqsave(&l2x0_lock, flags);
+	_l2x0_lock(&l2x0_lock, flags);
 	start &= ~(CACHE_LINE_SIZE - 1);
 	while (start < end) {
-		unsigned long blk_end = start + min(end - start, 4096UL);
+		unsigned long blk_end = block_end(start, end);
 
 		debug_writel(0x03);
 		while (start < blk_end) {
@@ -196,13 +223,13 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 		debug_writel(0x00);
 
 		if (blk_end < end) {
-			spin_unlock_irqrestore(&l2x0_lock, flags);
-			spin_lock_irqsave(&l2x0_lock, flags);
+			_l2x0_unlock(&l2x0_lock, flags);
+			_l2x0_lock(&l2x0_lock, flags);
 		}
 	}
 	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
 	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
+	_l2x0_unlock(&l2x0_lock, flags);
 }
 
 void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
@@ -236,5 +263,5 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	outer_cache.flush_range = l2x0_flush_range;
 	outer_cache.sync = l2x0_cache_sync;
 
-	printk(KERN_INFO "L2X0 cache controller enabled\n");
+	pr_info(L2CC_TYPE " cache controller enabled\n");
 }
