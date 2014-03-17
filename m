From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:21 +0000
Subject: [PATCH 10/44] ARM: l2c: rename cache_wait_way()
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLC9-0002cV-VM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cache_wait_way() is actually used to wait for a particular mask to
report clear; it's not really got much to do with cache ways at all.
Indeed, it gets used to wait for the C bit to clear on older caches.
Rename this with a more generic function name which better reflects
its purpose: l2c_wait_mask().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 1c3a23318f53..29ee7f692801 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -53,7 +53,7 @@ static bool of_init = false;
 /*
  * Common code for all cache controllers.
  */
-static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
+static inline void l2c_wait_mask(void __iomem *reg, unsigned long mask)
 {
 	/* wait for cache operation by line or way to complete */
 	while (readl_relaxed(reg) & mask)
@@ -73,7 +73,7 @@ static inline void l2c_set_debug(void __iomem *base, unsigned long val)
 static void __l2c_op_way(void __iomem *reg)
 {
 	writel_relaxed(l2x0_way_mask, reg);
-	cache_wait_way(reg, l2x0_way_mask);
+	l2c_wait_mask(reg, l2x0_way_mask);
 }
 
 static inline void l2c_unlock(void __iomem *base, unsigned num)
@@ -94,7 +94,7 @@ static inline void cache_wait(void __iomem *reg, unsigned long mask)
 	/* cache operations by line are atomic on PL310 */
 }
 #else
-#define cache_wait	cache_wait_way
+#define cache_wait	l2c_wait_mask
 #endif
 
 static inline void cache_sync(void)
-- 
1.8.3.1
