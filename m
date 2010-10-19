From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Oct 2010 16:38:59 +0200
Subject: [PATCH 04/12] ARM: Convert l2x0_lock to raw_spinlock
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20101019143717.GH11713@pengutronix.de>
Message-ID: <1287499147-13846-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

l2x20_lock needs to be a real spinlock on preempt-rt. Convert it to a
raw_spinlock. No change for !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mm/cache-l2x0.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9982eb3..d2ae7da 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -26,7 +26,7 @@
 #define CACHE_LINE_SIZE		32
 
 static void __iomem *l2x0_base;
-static DEFINE_SPINLOCK(l2x0_lock);
+static DEFINE_RAW_SPINLOCK(l2x0_lock);
 static uint32_t l2x0_way_mask;	/* Bitmask of active ways */
 
 static inline void cache_wait(void __iomem *reg, unsigned long mask)
@@ -98,9 +98,9 @@ static void l2x0_cache_sync(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&l2x0_lock, flags);
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
 	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static inline void l2x0_inv_all(void)
@@ -108,11 +108,11 @@ static inline void l2x0_inv_all(void)
 	unsigned long flags;
 
 	/* invalidate all ways */
-	spin_lock_irqsave(&l2x0_lock, flags);
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
 	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
 	cache_wait(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
 	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_inv_range(unsigned long start, unsigned long end)
@@ -120,7 +120,7 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
-	spin_lock_irqsave(&l2x0_lock, flags);
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
 	if (start & (CACHE_LINE_SIZE - 1)) {
 		start &= ~(CACHE_LINE_SIZE - 1);
 		debug_writel(0x03);
@@ -145,13 +145,13 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 		}
 
 		if (blk_end < end) {
-			spin_unlock_irqrestore(&l2x0_lock, flags);
-			spin_lock_irqsave(&l2x0_lock, flags);
+			raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+			raw_spin_lock_irqsave(&l2x0_lock, flags);
 		}
 	}
 	cache_wait(base + L2X0_INV_LINE_PA, 1);
 	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_clean_range(unsigned long start, unsigned long end)
@@ -159,7 +159,7 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
-	spin_lock_irqsave(&l2x0_lock, flags);
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
 	start &= ~(CACHE_LINE_SIZE - 1);
 	while (start < end) {
 		unsigned long blk_end = start + min(end - start, 4096UL);
@@ -170,13 +170,13 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
 		}
 
 		if (blk_end < end) {
-			spin_unlock_irqrestore(&l2x0_lock, flags);
-			spin_lock_irqsave(&l2x0_lock, flags);
+			raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+			raw_spin_lock_irqsave(&l2x0_lock, flags);
 		}
 	}
 	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
 	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_flush_range(unsigned long start, unsigned long end)
@@ -184,7 +184,7 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
-	spin_lock_irqsave(&l2x0_lock, flags);
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
 	start &= ~(CACHE_LINE_SIZE - 1);
 	while (start < end) {
 		unsigned long blk_end = start + min(end - start, 4096UL);
@@ -197,13 +197,13 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 		debug_writel(0x00);
 
 		if (blk_end < end) {
-			spin_unlock_irqrestore(&l2x0_lock, flags);
-			spin_lock_irqsave(&l2x0_lock, flags);
+			raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+			raw_spin_lock_irqsave(&l2x0_lock, flags);
 		}
 	}
 	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
 	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
-- 
1.7.2.3
