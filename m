From: jason.mcmullan@gmail.com (Jason S. McMullan)
Date: Fri, 30 Apr 2010 14:54:11 -0400
Subject: [PATCH] [arm l2x0] Extend cache-l2x0 to support the 16-way PL310
In-Reply-To: <1272653651-11590-1-git-send-email-jason.mcmullan@netronome.com>
References: <1272653651-11590-1-git-send-email-jason.mcmullan@netronome.com>
Message-ID: <1272653651-11590-2-git-send-email-jason.mcmullan@netronome.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L310 cache controller's interface is almost identical
to the L210. One major difference is that the PL310 can
have up to 16 ways.

This change uses the cache's part ID and the Assciativity
bits in the AUX_CTRL register to determine the number of ways.

Signed-off-by: Jason S. McMullan <jason.mcmullan@netronome.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    3 ++
 arch/arm/mm/cache-l2x0.c                   |   30 ++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index cdb9022..6bcba48 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -21,6 +21,9 @@
 #define __ASM_ARM_HARDWARE_L2X0_H
 
 #define L2X0_CACHE_ID			0x000
+#define   L2X0_CACHE_ID_PART_MASK	(0xf << 6)
+#define   L2X0_CACHE_ID_PART_L210	(1 << 6)
+#define   L2X0_CACHE_ID_PART_L310	(3 << 6)
 #define L2X0_CACHE_TYPE			0x004
 #define L2X0_CTRL			0x100
 #define L2X0_AUX_CTRL			0x104
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 21ad68b..32a70a7 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -27,6 +27,7 @@
 
 static void __iomem *l2x0_base;
 static DEFINE_SPINLOCK(l2x0_lock);
+static uint32_t l2x0_way_mask;	/* Bitmask of active ways */
 
 static inline void cache_wait(void __iomem *reg, unsigned long mask)
 {
@@ -106,10 +107,9 @@ static inline void l2x0_inv_all(void)
 {
 	unsigned long flags;
 
-	/* invalidate all ways */
 	spin_lock_irqsave(&l2x0_lock, flags);
-	writel(0xff, l2x0_base + L2X0_INV_WAY);
-	cache_wait(l2x0_base + L2X0_INV_WAY, 0xff);
+	writel(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
+	cache_wait(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
 	cache_sync();
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
@@ -217,10 +217,32 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	 * accessing the below registers will fault.
 	 */
 	if (!(readl(l2x0_base + L2X0_CTRL) & 1)) {
+		int ways;
+		uint32_t cache_id;
 
 		/* l2x0 controller is disabled */
-
+		cache_id = readl(l2x0_base + L2X0_CACHE_ID);
 		aux = readl(l2x0_base + L2X0_AUX_CTRL);
+
+		/* Determine the number of ways */
+		switch (cache_id) {
+		case L2X0_CACHE_ID_PART_L310:
+			if (aux & (1 << 16))
+				ways = 16;
+			else
+				ways = 8;
+			break;
+		case L2X0_CACHE_ID_PART_L210:
+			ways = (aux >> 13) & 0xf;
+			break;
+		default:
+			/* Assume unknown chips have 8 ways */
+			ways = 8;
+			break;
+		}
+
+		l2x0_way_mask = (1 << ways) - 1;
+
 		aux &= aux_mask;
 		aux |= aux_val;
 		writel(aux, l2x0_base + L2X0_AUX_CTRL);
-- 
1.7.0.4
