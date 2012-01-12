From: srinidhi.kasagar@stericsson.com (Srinidhi KASAGAR)
Date: Thu, 12 Jan 2012 11:07:42 +0530
Subject: [PATCH 1/2] mach-ux500: cache operations are atomic on PL310
Message-ID: <1326346663-6112-1-git-send-email-srinidhi.kasagar@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apply ERRATA_753970 for ux500 variant of cache sync too

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cache-l2x0.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 122ddde..8aaa21a 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -12,7 +12,7 @@
 
 static void __iomem *l2x0_base;
 
-static inline void ux500_cache_wait(void __iomem *reg, unsigned long mask)
+static inline void ux500_cache_wait_way(void __iomem *reg, unsigned long mask)
 {
 	/* wait for the operation to complete */
 	while (readl_relaxed(reg) & mask)
@@ -21,8 +21,13 @@ static inline void ux500_cache_wait(void __iomem *reg, unsigned long mask)
 
 static inline void ux500_cache_sync(void)
 {
+#ifdef CONFIG_ARM_ERRATA_753970
+	/* write to an unmmapped register */
+	writel_relaxed(0, l2x0_base + L2X0_DUMMY_REG);
+#else
 	writel_relaxed(0, l2x0_base + L2X0_CACHE_SYNC);
-	ux500_cache_wait(l2x0_base + L2X0_CACHE_SYNC, 1);
+#endif
+	/* cache operations by line are atomic in PL310 */
 }
 
 /*
@@ -46,7 +51,7 @@ static void ux500_l2x0_inv_all(void)
 
 	/* invalidate all ways */
 	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
-	ux500_cache_wait(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
+	ux500_cache_wait_way(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
 	ux500_cache_sync();
 }
 
-- 
1.7.4.3
