From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:11 +0000
Subject: [PATCH 08/44] ARM: l2c: split out cache unlock code
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLBz-0002cL-Ny@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split the cache unlock code out of l2x0_unlock().  We want to be able
to re-use this functionality later.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 595c50519e41..a1313d20f205 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -50,6 +50,9 @@ struct l2x0_regs l2x0_saved_regs;
 
 static bool of_init = false;
 
+/*
+ * Common code for all cache controllers.
+ */
 static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
 {
 	/* wait for cache operation by line or way to complete */
@@ -67,6 +70,18 @@ static inline void l2c_set_debug(void __iomem *base, unsigned long val)
 	outer_cache.set_debug(val);
 }
 
+static inline void l2c_unlock(void __iomem *base, unsigned num)
+{
+	unsigned i;
+
+	for (i = 0; i < num; i++) {
+		writel_relaxed(0, base + L2X0_LOCKDOWN_WAY_D_BASE +
+			       i * L2X0_LOCKDOWN_STRIDE);
+		writel_relaxed(0, base + L2X0_LOCKDOWN_WAY_I_BASE +
+			       i * L2X0_LOCKDOWN_STRIDE);
+	}
+}
+
 #ifdef CONFIG_CACHE_PL310
 static inline void cache_wait(void __iomem *reg, unsigned long mask)
 {
@@ -308,7 +323,6 @@ static void l2x0_disable(void)
 static void l2x0_unlock(u32 cache_id)
 {
 	int lockregs;
-	int i;
 
 	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
 	case L2X0_CACHE_ID_PART_L310:
@@ -323,12 +337,7 @@ static void l2x0_unlock(u32 cache_id)
 		break;
 	}
 
-	for (i = 0; i < lockregs; i++) {
-		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D_BASE +
-			       i * L2X0_LOCKDOWN_STRIDE);
-		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I_BASE +
-			       i * L2X0_LOCKDOWN_STRIDE);
-	}
+	l2c_unlock(l2x0_base, lockregs);
 }
 
 void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
-- 
1.8.3.1
