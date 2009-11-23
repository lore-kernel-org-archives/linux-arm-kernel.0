From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Tue, 24 Nov 2009 03:47:43 +0530
Subject: [PATCH] ARM l2x0: check whether l2x0 already enabled
Message-ID: <1259014663.2742.3.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Date: Tue, 24 Nov 2009 13:59:20 +0530

If running in non-secure mode, accessing
control and auxiliary registers of l2x0
will fault.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/mm/cache-l2x0.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b480f1d..7c0d056 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -99,18 +99,24 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 
 	l2x0_base = base;
 
-	/* disable L2X0 */
-	writel(0, l2x0_base + L2X0_CTRL);
+	/* check if l2x0 controller is already enabled.
+	 * if you are booting from non-secure mode
+	 * accessing the below registers will fault.
+	 */
+	if (!(readl(l2x0_base + L2X0_CTRL) & 1)) {
 
-	aux = readl(l2x0_base + L2X0_AUX_CTRL);
-	aux &= aux_mask;
-	aux |= aux_val;
-	writel(aux, l2x0_base + L2X0_AUX_CTRL);
+		/* L2x0 controller is disabled */
 
-	l2x0_inv_all();
+		aux = readl(l2x0_base + L2X0_AUX_CTRL);
+		aux &= aux_mask;
+		aux |= aux_val;
+		writel(aux, l2x0_base + L2X0_AUX_CTRL);
 
-	/* enable L2X0 */
-	writel(1, l2x0_base + L2X0_CTRL);
+		l2x0_inv_all();
+
+		/* enable L2X0 */
+		writel(1, l2x0_base + L2X0_CTRL);
+	}
 
 	outer_cache.inv_range = l2x0_inv_range;
 	outer_cache.clean_range = l2x0_clean_range;
-- 
1.6.3.GIT
