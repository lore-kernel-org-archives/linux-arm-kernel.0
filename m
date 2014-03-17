From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:15:23 +0000
Subject: [PATCH 22/44] ARM: l2c: clean up save/resume functions
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLD9-0002dK-HC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the pl310 save/resume functions to have a l2c310 prefix - this
is it's official name.  Use a local cached copy of the l2x0_base
virtual address, and also realise that many of the resume function
tails are the same as the enable functions, so make a call to the
enable function instead of duplicating that code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 105 ++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index e4e7dd4ab9b5..9243f55ab06d 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -373,17 +373,10 @@ static void l2x0_enable(void __iomem *base, u32 aux)
 
 static void l2x0_resume(void)
 {
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
-		/* restore aux ctrl and enable l2 */
-		l2x0_unlock(readl_relaxed(l2x0_base + L2X0_CACHE_ID));
-
-		writel_relaxed(l2x0_saved_regs.aux_ctrl, l2x0_base +
-			L2X0_AUX_CTRL);
-
-		l2x0_inv_all();
+	void __iomem *base = l2x0_base;
 
-		writel_relaxed(L2X0_CTRL_EN, l2x0_base + L2X0_CTRL);
-	}
+	if (!(readl_relaxed(base + L2X0_CTRL) & L2X0_CTRL_EN))
+		l2x0_enable(base, l2x0_saved_regs.aux_ctrl);
 }
 
 static const struct l2c_init_data l2x0_init_fns __initconst = {
@@ -432,10 +425,9 @@ static void l2c310_enable(void __iomem *base, u32 aux)
 	l2c_enable(base, aux, 8);
 }
 
-static void __init pl310_save(void __iomem *base)
+static void __init l2c310_save(void __iomem *base)
 {
-	u32 l2x0_revision = readl_relaxed(base + L2X0_CACHE_ID) &
-		L2X0_CACHE_ID_RTL_MASK;
+	unsigned revision;
 
 	l2x0_saved_regs.tag_latency = readl_relaxed(base +
 		L2X0_TAG_LATENCY_CTRL);
@@ -446,49 +438,49 @@ static void __init pl310_save(void __iomem *base)
 	l2x0_saved_regs.filter_start = readl_relaxed(base +
 		L2X0_ADDR_FILTER_START);
 
-	if (l2x0_revision >= L310_CACHE_ID_RTL_R2P0) {
-		/*
-		 * From r2p0, there is Prefetch offset/control register
-		 */
+	revision = readl_relaxed(base + L2X0_CACHE_ID) &
+			L2X0_CACHE_ID_RTL_MASK;
+
+	/* From r2p0, there is Prefetch offset/control register */
+	if (revision >= L310_CACHE_ID_RTL_R2P0)
 		l2x0_saved_regs.prefetch_ctrl = readl_relaxed(base +
-			L2X0_PREFETCH_CTRL);
-		/*
-		 * From r3p0, there is Power control register
-		 */
-		if (l2x0_revision >= L310_CACHE_ID_RTL_R3P0)
-			l2x0_saved_regs.pwr_ctrl = readl_relaxed(base +
-				L2X0_POWER_CTRL);
-	}
+							L2X0_PREFETCH_CTRL);
+
+	/* From r3p0, there is Power control register */
+	if (revision >= L310_CACHE_ID_RTL_R3P0)
+		l2x0_saved_regs.pwr_ctrl = readl_relaxed(base +
+							L2X0_POWER_CTRL);
 }
 
-static void pl310_resume(void)
+static void l2c310_resume(void)
 {
-	u32 l2x0_revision;
+	void __iomem *base = l2x0_base;
+
+	if (!(readl_relaxed(base + L2X0_CTRL) & L2X0_CTRL_EN)) {
+		unsigned revision;
 
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		/* restore pl310 setup */
 		writel_relaxed(l2x0_saved_regs.tag_latency,
-			l2x0_base + L2X0_TAG_LATENCY_CTRL);
+			       base + L2X0_TAG_LATENCY_CTRL);
 		writel_relaxed(l2x0_saved_regs.data_latency,
-			l2x0_base + L2X0_DATA_LATENCY_CTRL);
+			       base + L2X0_DATA_LATENCY_CTRL);
 		writel_relaxed(l2x0_saved_regs.filter_end,
-			l2x0_base + L2X0_ADDR_FILTER_END);
+			       base + L2X0_ADDR_FILTER_END);
 		writel_relaxed(l2x0_saved_regs.filter_start,
-			l2x0_base + L2X0_ADDR_FILTER_START);
+			       base + L2X0_ADDR_FILTER_START);
 
-		l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
-			L2X0_CACHE_ID_RTL_MASK;
+		revision = readl_relaxed(base + L2X0_CACHE_ID) &
+				L2X0_CACHE_ID_RTL_MASK;
 
-		if (l2x0_revision >= L310_CACHE_ID_RTL_R2P0) {
+		if (revision >= L310_CACHE_ID_RTL_R2P0)
 			writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
-				l2x0_base + L2X0_PREFETCH_CTRL);
-			if (l2x0_revision >= L310_CACHE_ID_RTL_R3P0)
-				writel_relaxed(l2x0_saved_regs.pwr_ctrl,
-					l2x0_base + L2X0_POWER_CTRL);
-		}
-	}
+				       base + L2X0_PREFETCH_CTRL);
+		if (revision >= L310_CACHE_ID_RTL_R3P0)
+			writel_relaxed(l2x0_saved_regs.pwr_ctrl,
+				       base + L2X0_POWER_CTRL);
 
-	l2x0_resume();
+		l2c310_enable(base, l2x0_saved_regs.aux_ctrl);
+	}
 }
 
 static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
@@ -523,7 +515,7 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 static const struct l2c_init_data l2c310_init_fns __initconst = {
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
-	.save = pl310_save,
+	.save = l2c310_save,
 	.outer_cache = {
 		.inv_range = l2x0_inv_range,
 		.clean_range = l2x0_clean_range,
@@ -531,7 +523,7 @@ static const struct l2c_init_data l2c310_init_fns __initconst = {
 		.flush_all = l2x0_flush_all,
 		.disable = l2x0_disable,
 		.sync = l2x0_cache_sync,
-		.resume = pl310_resume,
+		.resume = l2c310_resume,
 	},
 };
 
@@ -736,7 +728,7 @@ static const struct l2c_init_data of_pl310_data __initconst = {
 	.of_parse = pl310_of_parse,
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
-	.save  = pl310_save,
+	.save  = l2c310_save,
 	.outer_cache = {
 		.inv_range   = l2x0_inv_range,
 		.clean_range = l2x0_clean_range,
@@ -744,7 +736,7 @@ static const struct l2c_init_data of_pl310_data __initconst = {
 		.flush_all   = l2x0_flush_all,
 		.disable     = l2x0_disable,
 		.sync        = l2x0_cache_sync,
-		.resume      = pl310_resume,
+		.resume      = l2c310_resume,
 	},
 };
 
@@ -854,10 +846,11 @@ static void aurora_save(void __iomem *base)
 
 static void aurora_resume(void)
 {
-	if (!(readl(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
-		writel_relaxed(l2x0_saved_regs.aux_ctrl,
-				l2x0_base + L2X0_AUX_CTRL);
-		writel_relaxed(l2x0_saved_regs.ctrl, l2x0_base + L2X0_CTRL);
+	void __iomem *base = l2x0_base;
+
+	if (!(readl(base + L2X0_CTRL) & L2X0_CTRL_EN)) {
+		writel_relaxed(l2x0_saved_regs.aux_ctrl, base + L2X0_AUX_CTRL);
+		writel_relaxed(l2x0_saved_regs.ctrl, base + L2X0_CTRL);
 	}
 }
 
@@ -1082,7 +1075,7 @@ static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 	.of_parse = pl310_of_parse,
 	.enable = l2c310_enable,
 	.fixup = l2c310_fixup,
-	.save  = pl310_save,
+	.save  = l2c310_save,
 	.outer_cache = {
 		.inv_range   = bcm_inv_range,
 		.clean_range = bcm_clean_range,
@@ -1090,7 +1083,7 @@ static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 		.flush_all   = l2x0_flush_all,
 		.disable     = l2x0_disable,
 		.sync        = l2x0_cache_sync,
-		.resume      = pl310_resume,
+		.resume      = l2c310_resume,
 	},
 };
 
@@ -1104,11 +1097,13 @@ static void __init tauros3_save(void __iomem *base)
 
 static void tauros3_resume(void)
 {
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
+	void __iomem *base = l2x0_base;
+
+	if (!(readl_relaxed(base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		writel_relaxed(l2x0_saved_regs.aux2_ctrl,
-			       l2x0_base + TAUROS3_AUX2_CTRL);
+			       base + TAUROS3_AUX2_CTRL);
 		writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
-			       l2x0_base + L2X0_PREFETCH_CTRL);
+			       base + L2X0_PREFETCH_CTRL);
 	}
 
 	l2x0_resume();
-- 
1.8.3.1
