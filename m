From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Dec 2009 17:40:07 +0000
Subject: [RFC PATCH 1/2] ARM: cache-l2x0: avoid taking spinlock for every
	iteration
Message-ID: <E1NJVwt-0006uj-11@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Taking the spinlock for every iteration is very expensive; instead,
batch iterations up into 4K blocks, releasing and reacquiring the
spinlock between each block.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c |   65 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b480f1d..c1b7bff 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -31,14 +31,10 @@ static DEFINE_SPINLOCK(l2x0_lock);
 static inline void sync_writel(unsigned long val, unsigned long reg,
 			       unsigned long complete_mask)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&l2x0_lock, flags);
 	writel(val, l2x0_base + reg);
 	/* wait for the operation to complete */
 	while (readl(l2x0_base + reg) & complete_mask)
 		;
-	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static inline void cache_sync(void)
@@ -48,15 +44,20 @@ static inline void cache_sync(void)
 
 static inline void l2x0_inv_all(void)
 {
+	unsigned long flags;
+
 	/* invalidate all ways */
+	spin_lock_irqsave(&l2x0_lock, flags);
 	sync_writel(0xff, L2X0_INV_WAY, 0xff);
 	cache_sync();
+	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_inv_range(unsigned long start, unsigned long end)
 {
-	unsigned long addr;
+	unsigned long flags;
 
+	spin_lock_irqsave(&l2x0_lock, flags);
 	if (start & (CACHE_LINE_SIZE - 1)) {
 		start &= ~(CACHE_LINE_SIZE - 1);
 		sync_writel(start, L2X0_CLEAN_INV_LINE_PA, 1);
@@ -68,29 +69,67 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 		sync_writel(end, L2X0_CLEAN_INV_LINE_PA, 1);
 	}
 
-	for (addr = start; addr < end; addr += CACHE_LINE_SIZE)
-		sync_writel(addr, L2X0_INV_LINE_PA, 1);
+	while (start < end) {
+		unsigned long blk_end = start + min(end - start, 4096UL);
+
+		while (start < blk_end) {
+			sync_writel(start, L2X0_INV_LINE_PA, 1);
+			start += CACHE_LINE_SIZE;
+		}
+
+		if (blk_end < end) {
+			spin_unlock_irqrestore(&l2x0_lock, flags);
+			spin_lock_irqsave(&l2x0_lock, flags);
+		}
+	}
 	cache_sync();
+	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_clean_range(unsigned long start, unsigned long end)
 {
-	unsigned long addr;
+	unsigned long flags;
 
+	spin_lock_irqsave(&l2x0_lock, flags);
 	start &= ~(CACHE_LINE_SIZE - 1);
-	for (addr = start; addr < end; addr += CACHE_LINE_SIZE)
-		sync_writel(addr, L2X0_CLEAN_LINE_PA, 1);
+	while (start < end) {
+		unsigned long blk_end = start + min(end - start, 4096UL);
+
+		while (start < blk_end) {
+			sync_writel(start, L2X0_CLEAN_LINE_PA, 1);
+			start += CACHE_LINE_SIZE;
+		}
+
+		if (blk_end < end) {
+			spin_unlock_irqrestore(&l2x0_lock, flags);
+			spin_lock_irqsave(&l2x0_lock, flags);
+		}
+	}
 	cache_sync();
+	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_flush_range(unsigned long start, unsigned long end)
 {
-	unsigned long addr;
+	unsigned long flags;
 
+	spin_lock_irqsave(&l2x0_lock, flags);
 	start &= ~(CACHE_LINE_SIZE - 1);
-	for (addr = start; addr < end; addr += CACHE_LINE_SIZE)
-		sync_writel(addr, L2X0_CLEAN_INV_LINE_PA, 1);
+	while (start < end) {
+		unsigned long blk_end = start + min(end - start, 4096UL);
+
+		while (start < blk_end) {
+			sync_writel(start, L2X0_CLEAN_INV_LINE_PA, 1);
+			start += CACHE_LINE_SIZE;
+		}
+
+		if (blk_end < end) {
+			spin_unlock_irqrestore(&l2x0_lock, flags);
+			spin_lock_irqsave(&l2x0_lock, flags);
+		}
+	}
 	cache_sync();
+	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
-- 
1.6.2.5
