From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:28:24 +0100
Subject: [PATCH 26/97] ARM: l2c: move and add ARM L2C-2x0/L2C-310 save/resume
 code to non-OF
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerE0-0001V6-1N@rmk-PC.arm.linux.org.uk>
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
index 713cdcef25d1..4d985c17291c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -383,6 +383,21 @@ static void l2x0_enable(void __iomem *base, u32 aux, unsigned num_lock)
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
@@ -392,6 +407,7 @@ static const struct l2c_init_data l2x0_init_fns __initconst = {
 		.flush_all = l2x0_flush_all,
 		.disable = l2x0_disable,
 		.sync = l2x0_cache_sync,
+		.resume = l2x0_resume,
 	},
 };
 
@@ -422,6 +438,65 @@ static const struct l2c_init_data l2x0_init_fns __initconst = {
  *	Affects: store buffer
  *	store buffer is not automatically drained.
  */
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
@@ -455,6 +530,7 @@ static const struct l2c_init_data l2c310_init_fns __initconst = {
 	.num_lock = 8,
 	.enable = l2c_enable,
 	.fixup = l2c310_fixup,
+	.save = pl310_save,
 	.outer_cache = {
 		.inv_range = l2x0_inv_range,
 		.clean_range = l2x0_clean_range,
@@ -462,6 +538,7 @@ static const struct l2c_init_data l2c310_init_fns __initconst = {
 		.flush_all = l2x0_flush_all,
 		.disable = l2x0_disable,
 		.sync = l2x0_cache_sync,
+		.resume = pl310_resume,
 	},
 };
 
@@ -614,21 +691,6 @@ static void __init l2x0_of_parse(const struct device_node *np,
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
@@ -677,65 +739,6 @@ static void __init pl310_of_parse(const struct device_node *np,
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
 	.num_lock = 8,
 	.of_parse = pl310_of_parse,
-- 
1.8.3.1
