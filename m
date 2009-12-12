From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Dec 2009 17:40:20 +0000
Subject: [RFC PATCH 2/2] ARM: cache-l2x0: make better use of background cache
	handling
Message-ID: <E1NJVx6-0006um-Do@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no point having the hardware support background operations
if we issue a cache operation, and then wait for it to complete
before calculating the address of the next operation.  We gain no
advantage in the cache controller stalling the bus until completion.

What we should be doing is using the 'wait' time productively by
calculating the address of the next operation, and only then waiting
for the previous operation to complete.  This means that cache
operations can occur in parallel with the CPU calculating the next
address.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c1b7bff..ec85dda 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -28,18 +28,18 @@
 static void __iomem *l2x0_base;
 static DEFINE_SPINLOCK(l2x0_lock);
 
-static inline void sync_writel(unsigned long val, unsigned long reg,
-			       unsigned long complete_mask)
+static inline void cache_wait(void __iomem *reg, unsigned long mask)
 {
-	writel(val, l2x0_base + reg);
 	/* wait for the operation to complete */
-	while (readl(l2x0_base + reg) & complete_mask)
+	while (readl(reg) & mask)
 		;
 }
 
 static inline void cache_sync(void)
 {
-	sync_writel(0, L2X0_CACHE_SYNC, 1);
+	void __iomem *base = l2x0_base;
+	writel(0, base + L2X0_CACHE_SYNC);
+	cache_wait(base + L2X0_CACHE_SYNC, 1);
 }
 
 static inline void l2x0_inv_all(void)
@@ -48,32 +48,37 @@ static inline void l2x0_inv_all(void)
 
 	/* invalidate all ways */
 	spin_lock_irqsave(&l2x0_lock, flags);
-	sync_writel(0xff, L2X0_INV_WAY, 0xff);
+	writel(0xff, l2x0_base + L2X0_INV_WAY);
+	cache_wait(l2x0_base + L2X0_INV_WAY, 0xff);
 	cache_sync();
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_inv_range(unsigned long start, unsigned long end)
 {
+	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
 	spin_lock_irqsave(&l2x0_lock, flags);
 	if (start & (CACHE_LINE_SIZE - 1)) {
 		start &= ~(CACHE_LINE_SIZE - 1);
-		sync_writel(start, L2X0_CLEAN_INV_LINE_PA, 1);
+		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
+		writel(start, base + L2X0_CLEAN_INV_LINE_PA);
 		start += CACHE_LINE_SIZE;
 	}
 
 	if (end & (CACHE_LINE_SIZE - 1)) {
 		end &= ~(CACHE_LINE_SIZE - 1);
-		sync_writel(end, L2X0_CLEAN_INV_LINE_PA, 1);
+		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
+		writel(end, base + L2X0_CLEAN_INV_LINE_PA);
 	}
 
 	while (start < end) {
 		unsigned long blk_end = start + min(end - start, 4096UL);
 
 		while (start < blk_end) {
-			sync_writel(start, L2X0_INV_LINE_PA, 1);
+			cache_wait(base + L2X0_INV_LINE_PA, 1);
+			writel(start, base + L2X0_INV_LINE_PA);
 			start += CACHE_LINE_SIZE;
 		}
 
@@ -82,12 +87,14 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 			spin_lock_irqsave(&l2x0_lock, flags);
 		}
 	}
+	cache_wait(base + L2X0_INV_LINE_PA, 1);
 	cache_sync();
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_clean_range(unsigned long start, unsigned long end)
 {
+	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
 	spin_lock_irqsave(&l2x0_lock, flags);
@@ -96,7 +103,8 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
 		unsigned long blk_end = start + min(end - start, 4096UL);
 
 		while (start < blk_end) {
-			sync_writel(start, L2X0_CLEAN_LINE_PA, 1);
+			cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
+			writel(start, base + L2X0_CLEAN_LINE_PA);
 			start += CACHE_LINE_SIZE;
 		}
 
@@ -105,12 +113,14 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
 			spin_lock_irqsave(&l2x0_lock, flags);
 		}
 	}
+	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
 	cache_sync();
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_flush_range(unsigned long start, unsigned long end)
 {
+	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
 	spin_lock_irqsave(&l2x0_lock, flags);
@@ -119,7 +129,8 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 		unsigned long blk_end = start + min(end - start, 4096UL);
 
 		while (start < blk_end) {
-			sync_writel(start, L2X0_CLEAN_INV_LINE_PA, 1);
+			cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
+			writel(start, base + L2X0_CLEAN_INV_LINE_PA);
 			start += CACHE_LINE_SIZE;
 		}
 
@@ -128,6 +139,7 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 			spin_lock_irqsave(&l2x0_lock, flags);
 		}
 	}
+	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
 	cache_sync();
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
-- 
1.6.2.5
