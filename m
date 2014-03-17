From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:16 +0000
Subject: [PATCH 09/44] ARM: l2c: provide generic helper for way-based
 operations
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLC4-0002cR-RX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a generic helper function for way based operations.  These are
always background operations, and thus have to be waited for before a
new operation is commenced.  This helper extracts that requirement from
several locations in the code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index a1313d20f205..1c3a23318f53 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -70,6 +70,12 @@ static inline void l2c_set_debug(void __iomem *base, unsigned long val)
 	outer_cache.set_debug(val);
 }
 
+static void __l2c_op_way(void __iomem *reg)
+{
+	writel_relaxed(l2x0_way_mask, reg);
+	cache_wait_way(reg, l2x0_way_mask);
+}
+
 static inline void l2c_unlock(void __iomem *base, unsigned num)
 {
 	unsigned i;
@@ -166,8 +172,7 @@ static void l2x0_cache_sync(void)
 static void __l2x0_flush_all(void)
 {
 	debug_writel(0x03);
-	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
-	cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
+	__l2c_op_way(l2x0_base + L2X0_CLEAN_INV_WAY);
 	cache_sync();
 	debug_writel(0x00);
 }
@@ -188,8 +193,7 @@ static void l2x0_clean_all(void)
 
 	/* clean all ways */
 	raw_spin_lock_irqsave(&l2x0_lock, flags);
-	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_WAY);
-	cache_wait_way(l2x0_base + L2X0_CLEAN_WAY, l2x0_way_mask);
+	__l2c_op_way(l2x0_base + L2X0_CLEAN_WAY);
 	cache_sync();
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
@@ -202,8 +206,7 @@ static void l2x0_inv_all(void)
 	raw_spin_lock_irqsave(&l2x0_lock, flags);
 	/* Invalidating when L2 is enabled is a nono */
 	BUG_ON(readl(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN);
-	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
-	cache_wait_way(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
+	__l2c_op_way(l2x0_base + L2X0_INV_WAY);
 	cache_sync();
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
-- 
1.8.3.1
