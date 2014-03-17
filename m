From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:15:18 +0000
Subject: [PATCH 21/44] ARM: l2c: move and add ARM L2C-2x0/L2C-310 save/resume
 code to non-OF
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLD4-0002dG-6F@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the save/resume code hooks to the non-OF implementations as well.
There's no reason for the non-OF implementations to be any different
from the OF implementations.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 151 ++++++++++++++++++++++++-----------------------
 1 file changed, 77 insertions(+), 74 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index e6913bc67c34..e4e7dd4ab9b5 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -371,6 +371,21 @@ static void l2x0_enable(void __iomem *base, u32 aux)
 	writel_relaxed(L2X0_CTRL_EN, base + L2X0_CTRL);
 }
 
+static void l2x0_resume(void)
+{
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
+		/* restore aux ctrl and enable l2 */
+		l2x0_unlock(readl_relaxed(l2x0_base + L2X0_CACHE_ID));
+
+		writel_relaxed(l2x0_saved_regs.aux_ctrl, l2x0_base +
+			L2X0_AUX_CTRL);
+
+		l2x0_inv_all();
+
+		writel_relaxed(L2X0_CTRL_EN, l2x0_base + L2X0_CTRL);
+	}
+}
+
 static const struct l2c_init_data l2x0_init_fns __initconst = {
 	.enable = l2x0_enable,
 	.outer_cache = {
@@ -380,6 +395,7 @@ static const struct l2c_init_data l2x0_init_fns __initconst = {
 		.flush_all = l2x0_flush_all,
 		.disable = l2x0_disable,
 		.sync = l2x0_cache_sync,
+		.resume = l2x0_resume,
 	},
 };
 
@@ -416,6 +432,65 @@ static void l2c310_enable(void __iomem *base, u32 aux)
 	l2c_enable(base, aux, 8);
 }
 
+static void __init pl310_save(void __iomem *base)
+{
+	u32 l2x0_revision = readl_relaxed(base + L2X0_CACHE_ID) &
+		L2X0_CACHE_ID_RTL_MASK;
+
+	l2x0_saved_regs.tag_latency = readl_relaxed(base +
+		L2X0_TAG_LATENCY_CTRL);
+	l2x0_saved_regs.data_latency = readl_relaxed(base +
+		L2X0_DATA_LATENCY_CTRL);
+	l2x0_saved_regs.filter_end = readl_relaxed(base +
+		L2X0_ADDR_FILTER_END);
+	l2x0_saved_regs.filter_start = readl_relaxed(base +
+		L2X0_ADDR_FILTER_START);
+
+	if (l2x0_revision >= L310_CACHE_ID_RTL_R2P0) {
+		/*
+		 * From r2p0, there is Prefetch offset/control register
+		 */
+		l2x0_saved_regs.prefetch_ctrl = readl_relaxed(base +
+			L2X0_PREFETCH_CTRL);
+		/*
+		 * From r3p0, there is Power control register
+		 */
+		if (l2x0_revision >= L310_CACHE_ID_RTL_R3P0)
+			l2x0_saved_regs.pwr_ctrl = readl_relaxed(base +
+				L2X0_POWER_CTRL);
+	}
+}
+
+static void pl310_resume(void)
+{
+	u32 l2x0_revision;
+
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
+		/* restore pl310 setup */
+		writel_relaxed(l2x0_saved_regs.tag_latency,
+			l2x0_base + L2X0_TAG_LATENCY_CTRL);
+		writel_relaxed(l2x0_saved_regs.data_latency,
+			l2x0_base + L2X0_DATA_LATENCY_CTRL);
+		writel_relaxed(l2x0_saved_regs.filter_end,
+			l2x0_base + L2X0_ADDR_FILTER_END);
+		writel_relaxed(l2x0_saved_regs.filter_start,
+			l2x0_base + L2X0_ADDR_FILTER_START);
+
+		l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
+			L2X0_CACHE_ID_RTL_MASK;
+
+		if (l2x0_revision >= L310_CACHE_ID_RTL_R2P0) {
+			writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
+				l2x0_base + L2X0_PREFETCH_CTRL);
+			if (l2x0_revision >= L310_CACHE_ID_RTL_R3P0)
+				writel_relaxed(l2x0_saved_regs.pwr_ctrl,
+					l2x0_base + L2X0_POWER_CTRL);
+		}
+	}
+
+	l2x0_resume();
+}
+
 static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	struct outer_cache_fns *fns)
 {
@@ -448,6 +523,7 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 static const struct l2c_init_data l2c310_init_fns __initconst = {
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
+	.save = pl310_save,
 	.outer_cache = {
 		.inv_range = l2x0_inv_range,
 		.clean_range = l2x0_clean_range,
@@ -455,6 +531,7 @@ static const struct l2c_init_data l2c310_init_fns __initconst = {
 		.flush_all = l2x0_flush_all,
 		.disable = l2x0_disable,
 		.sync = l2x0_cache_sync,
+		.resume = pl310_resume,
 	},
 };
 
@@ -607,21 +684,6 @@ static void __init l2x0_of_parse(const struct device_node *np,
 	*aux_mask &= ~mask;
 }
 
-static void l2x0_resume(void)
-{
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
-		/* restore aux ctrl and enable l2 */
-		l2x0_unlock(readl_relaxed(l2x0_base + L2X0_CACHE_ID));
-
-		writel_relaxed(l2x0_saved_regs.aux_ctrl, l2x0_base +
-			L2X0_AUX_CTRL);
-
-		l2x0_inv_all();
-
-		writel_relaxed(L2X0_CTRL_EN, l2x0_base + L2X0_CTRL);
-	}
-}
-
 static const struct l2c_init_data of_l2x0_data __initconst = {
 	.of_parse = l2x0_of_parse,
 	.enable = l2x0_enable,
@@ -670,65 +732,6 @@ static void __init pl310_of_parse(const struct device_node *np,
 	}
 }
 
-static void __init pl310_save(void __iomem *base)
-{
-	u32 l2x0_revision = readl_relaxed(base + L2X0_CACHE_ID) &
-		L2X0_CACHE_ID_RTL_MASK;
-
-	l2x0_saved_regs.tag_latency = readl_relaxed(base +
-		L2X0_TAG_LATENCY_CTRL);
-	l2x0_saved_regs.data_latency = readl_relaxed(base +
-		L2X0_DATA_LATENCY_CTRL);
-	l2x0_saved_regs.filter_end = readl_relaxed(base +
-		L2X0_ADDR_FILTER_END);
-	l2x0_saved_regs.filter_start = readl_relaxed(base +
-		L2X0_ADDR_FILTER_START);
-
-	if (l2x0_revision >= L310_CACHE_ID_RTL_R2P0) {
-		/*
-		 * From r2p0, there is Prefetch offset/control register
-		 */
-		l2x0_saved_regs.prefetch_ctrl = readl_relaxed(base +
-			L2X0_PREFETCH_CTRL);
-		/*
-		 * From r3p0, there is Power control register
-		 */
-		if (l2x0_revision >= L310_CACHE_ID_RTL_R3P0)
-			l2x0_saved_regs.pwr_ctrl = readl_relaxed(base +
-				L2X0_POWER_CTRL);
-	}
-}
-
-static void pl310_resume(void)
-{
-	u32 l2x0_revision;
-
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
-		/* restore pl310 setup */
-		writel_relaxed(l2x0_saved_regs.tag_latency,
-			l2x0_base + L2X0_TAG_LATENCY_CTRL);
-		writel_relaxed(l2x0_saved_regs.data_latency,
-			l2x0_base + L2X0_DATA_LATENCY_CTRL);
-		writel_relaxed(l2x0_saved_regs.filter_end,
-			l2x0_base + L2X0_ADDR_FILTER_END);
-		writel_relaxed(l2x0_saved_regs.filter_start,
-			l2x0_base + L2X0_ADDR_FILTER_START);
-
-		l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
-			L2X0_CACHE_ID_RTL_MASK;
-
-		if (l2x0_revision >= L310_CACHE_ID_RTL_R2P0) {
-			writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
-				l2x0_base + L2X0_PREFETCH_CTRL);
-			if (l2x0_revision >= L310_CACHE_ID_RTL_R3P0)
-				writel_relaxed(l2x0_saved_regs.pwr_ctrl,
-					l2x0_base + L2X0_POWER_CTRL);
-		}
-	}
-
-	l2x0_resume();
-}
-
 static const struct l2c_init_data of_pl310_data __initconst = {
 	.of_parse = pl310_of_parse,
 	.enable = l2c310_enable,
-- 
1.8.3.1
