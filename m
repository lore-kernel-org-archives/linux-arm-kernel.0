From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:20:29 +0000
Subject: [PATCH 71/75] ARM: l2c: permit flush_all() on large flush_range() XXX
 Needs more thought XXX
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYa5-0007Hi-HD@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to allow flush_all() to be used in normal operation, we need
some locking to prevent any other cache operations being issued while
a background flush_all() operation is proceeding.  The read-write
spinlock provides what's necessary here, but we must avoid bringing
lockdep issues into this code.  Hence we continue to use the raw_*
operations, and use the arch read/write spinlock implementation
directly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 90 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index cbf036dff6d1..c1750f1bf572 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -53,6 +53,54 @@ struct l2x0_regs l2x0_saved_regs;
 /*
  * Common code for all cache controllers.
  */
+#ifdef CONFIG_SMP
+static arch_rwlock_t l2c_rw_lock = __ARCH_RW_LOCK_UNLOCKED;
+
+static unsigned long l2c_lock_exclusive(void)
+{
+	unsigned long flags;
+	raw_local_irq_save(flags);
+	arch_write_lock(&l2c_rw_lock);
+	return flags;
+}
+
+static void l2c_unlock_exclusive(unsigned long flags)
+{
+	arch_write_unlock(&l2c_rw_lock);
+	raw_local_irq_restore(flags);
+}
+
+static void l2c_lock_shared(void)
+{
+	arch_read_lock(&l2c_rw_lock);
+}
+
+static void l2c_unlock_shared(void)
+{
+	arch_read_unlock(&l2c_rw_lock);
+}
+#else
+static unsigned long l2c_lock_exclusive(void)
+{
+	unsigned long flags;
+	raw_local_irq_save(flags);
+	return flags;
+}
+
+static void l2c_unlock_exclusive(unsigned long flags)
+{
+	raw_local_irq_restore(flags);
+}
+
+static void l2c_lock_shared(void)
+{
+}
+
+static void l2c_unlock_shared(void)
+{
+}
+#endif
+
 static inline void l2c_wait_mask(void __iomem *reg, unsigned long mask)
 {
 	/* wait for cache operation by line or way to complete */
@@ -233,6 +281,7 @@ static void l2c210_inv_range(unsigned long start, unsigned long end)
 {
 	void __iomem *base = l2x0_base;
 
+	l2c_lock_shared();
 	if (start & (CACHE_LINE_SIZE - 1)) {
 		start &= ~(CACHE_LINE_SIZE - 1);
 		writel_relaxed(start, base + L2X0_CLEAN_INV_LINE_PA);
@@ -246,6 +295,7 @@ static void l2c210_inv_range(unsigned long start, unsigned long end)
 
 	__l2c210_op_pa_range(base + L2X0_INV_LINE_PA, start, end);
 	__l2c210_cache_sync(base);
+	l2c_unlock_shared();
 }
 
 static void l2c210_clean_range(unsigned long start, unsigned long end)
@@ -253,8 +303,10 @@ static void l2c210_clean_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 
 	start &= ~(CACHE_LINE_SIZE - 1);
+	l2c_lock_shared();
 	__l2c210_op_pa_range(base + L2X0_CLEAN_LINE_PA, start, end);
 	__l2c210_cache_sync(base);
+	l2c_unlock_shared();
 }
 
 static void l2c210_flush_range(unsigned long start, unsigned long end)
@@ -262,23 +314,33 @@ static void l2c210_flush_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 
 	start &= ~(CACHE_LINE_SIZE - 1);
+	if ((end - start) >= l2x0_size) {
+		outer_cache.flush_all();
+		return;
+	}
+
+	l2c_lock_shared();
 	__l2c210_op_pa_range(base + L2X0_CLEAN_INV_LINE_PA, start, end);
 	__l2c210_cache_sync(base);
+	l2c_unlock_shared();
 }
 
 static void l2c210_flush_all(void)
 {
 	void __iomem *base = l2x0_base;
+	unsigned long flags;
 
-	BUG_ON(!irqs_disabled());
-
+	flags = l2c_lock_exclusive();
 	__l2c_op_way(base + L2X0_CLEAN_INV_WAY);
 	__l2c210_cache_sync(base);
+	l2c_unlock_exclusive(flags);
 }
 
 static void l2c210_sync(void)
 {
+	l2c_lock_shared();
 	__l2c210_cache_sync(l2x0_base);
+	l2c_unlock_shared();
 }
 
 static void l2c210_resume(void)
@@ -501,7 +563,7 @@ static void l2c310_inv_range_erratum(unsigned long start, unsigned long end)
 		unsigned long flags;
 
 		/* Erratum 588369 for both clean+invalidate operations */
-		raw_spin_lock_irqsave(&l2x0_lock, flags);
+		flags = l2c_lock_exclusive();
 		l2c_set_debug(base, 0x03);
 
 		if (start & (CACHE_LINE_SIZE - 1)) {
@@ -518,20 +580,26 @@ static void l2c310_inv_range_erratum(unsigned long start, unsigned long end)
 		}
 
 		l2c_set_debug(base, 0x00);
-		raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+		l2c_unlock_exclusive(flags);
 	}
 
+	l2c_lock_shared();
 	__l2c210_op_pa_range(base + L2X0_INV_LINE_PA, start, end);
 	__l2c210_cache_sync(base);
+	l2c_unlock_shared();
 }
 
 static void l2c310_flush_range_erratum(unsigned long start, unsigned long end)
 {
-	raw_spinlock_t *lock = &l2x0_lock;
 	unsigned long flags;
 	void __iomem *base = l2x0_base;
 
-	raw_spin_lock_irqsave(lock, flags);
+	if ((end - start) >= l2x0_size) {
+		outer_cache.flush_all();
+		return;
+	}
+
+	flags = l2c_lock_exclusive();
 	while (start < end) {
 		unsigned long blk_end = start + min(end - start, 4096UL);
 
@@ -544,12 +612,12 @@ static void l2c310_flush_range_erratum(unsigned long start, unsigned long end)
 		l2c_set_debug(base, 0x00);
 
 		if (blk_end < end) {
-			raw_spin_unlock_irqrestore(lock, flags);
-			raw_spin_lock_irqsave(lock, flags);
+			l2c_unlock_exclusive(flags);
+			flags = l2c_lock_exclusive();
 		}
 	}
-	raw_spin_unlock_irqrestore(lock, flags);
 	__l2c210_cache_sync(base);
+	l2c_unlock_exclusive(flags);
 }
 
 static void l2c310_flush_all_erratum(void)
@@ -557,12 +625,12 @@ static void l2c310_flush_all_erratum(void)
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&l2x0_lock, flags);
+	flags = l2c_lock_exclusive();
 	l2c_set_debug(base, 0x03);
 	__l2c_op_way(base + L2X0_CLEAN_INV_WAY);
 	l2c_set_debug(base, 0x00);
 	__l2c210_cache_sync(base);
-	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+	l2c_unlock_exclusive(flags);
 }
 
 static void __init l2c310_save(void __iomem *base)
-- 
1.8.3.1
