From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:57 +0000
Subject: [PATCH 17/44] ARM: l2c: group implementation specific code together
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLCj-0002cz-OZ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Back in the mists of time, someone decided that it would be a good idea
to group like functions together - so all the save functions in one
place, all the resume functions in another, all the OF parsing functions
some place else.

This makes it difficult to get an overview on what a particular
implementation is doing - grouping an implementations specific functions
together makes more sense, because you can see what it's doing without
the clutter of other implementations.

Organise it according to implementation.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 536 +++++++++++++++++++++++------------------------
 1 file changed, 268 insertions(+), 268 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index d38591aabb35..9bd41f0e3b8a 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -487,6 +487,177 @@ static int l2_wt_override;
  * pass it though the device tree */
 static u32 cache_id_part_number_from_dt;
 
+static void __init l2x0_of_parse(const struct device_node *np,
+				 u32 *aux_val, u32 *aux_mask)
+{
+	u32 data[2] = { 0, 0 };
+	u32 tag = 0;
+	u32 dirty = 0;
+	u32 val = 0, mask = 0;
+
+	of_property_read_u32(np, "arm,tag-latency", &tag);
+	if (tag) {
+		mask |= L2X0_AUX_CTRL_TAG_LATENCY_MASK;
+		val |= (tag - 1) << L2X0_AUX_CTRL_TAG_LATENCY_SHIFT;
+	}
+
+	of_property_read_u32_array(np, "arm,data-latency",
+				   data, ARRAY_SIZE(data));
+	if (data[0] && data[1]) {
+		mask |= L2X0_AUX_CTRL_DATA_RD_LATENCY_MASK |
+			L2X0_AUX_CTRL_DATA_WR_LATENCY_MASK;
+		val |= ((data[0] - 1) << L2X0_AUX_CTRL_DATA_RD_LATENCY_SHIFT) |
+		       ((data[1] - 1) << L2X0_AUX_CTRL_DATA_WR_LATENCY_SHIFT);
+	}
+
+	of_property_read_u32(np, "arm,dirty-latency", &dirty);
+	if (dirty) {
+		mask |= L2X0_AUX_CTRL_DIRTY_LATENCY_MASK;
+		val |= (dirty - 1) << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
+	}
+
+	*aux_val &= ~mask;
+	*aux_val |= val;
+	*aux_mask &= ~mask;
+}
+
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
+static const struct l2c_init_data of_l2x0_data __initconst = {
+	.of_parse = l2x0_of_parse,
+	.enable = l2x0_enable,
+	.outer_cache = {
+		.inv_range   = l2x0_inv_range,
+		.clean_range = l2x0_clean_range,
+		.flush_range = l2x0_flush_range,
+		.flush_all   = l2x0_flush_all,
+		.disable     = l2x0_disable,
+		.sync        = l2x0_cache_sync,
+		.resume      = l2x0_resume,
+	},
+};
+
+static void __init pl310_of_parse(const struct device_node *np,
+				  u32 *aux_val, u32 *aux_mask)
+{
+	u32 data[3] = { 0, 0, 0 };
+	u32 tag[3] = { 0, 0, 0 };
+	u32 filter[2] = { 0, 0 };
+
+	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
+	if (tag[0] && tag[1] && tag[2])
+		writel_relaxed(
+			((tag[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
+			((tag[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
+			((tag[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
+			l2x0_base + L2X0_TAG_LATENCY_CTRL);
+
+	of_property_read_u32_array(np, "arm,data-latency",
+				   data, ARRAY_SIZE(data));
+	if (data[0] && data[1] && data[2])
+		writel_relaxed(
+			((data[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
+			((data[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
+			((data[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
+			l2x0_base + L2X0_DATA_LATENCY_CTRL);
+
+	of_property_read_u32_array(np, "arm,filter-ranges",
+				   filter, ARRAY_SIZE(filter));
+	if (filter[1]) {
+		writel_relaxed(ALIGN(filter[0] + filter[1], SZ_1M),
+			       l2x0_base + L2X0_ADDR_FILTER_END);
+		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L2X0_ADDR_FILTER_EN,
+			       l2x0_base + L2X0_ADDR_FILTER_START);
+	}
+}
+
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
+static const struct l2c_init_data of_pl310_data __initconst = {
+	.of_parse = pl310_of_parse,
+	.enable = l2x0_enable,
+	.save  = pl310_save,
+	.outer_cache = {
+		.inv_range   = l2x0_inv_range,
+		.clean_range = l2x0_clean_range,
+		.flush_range = l2x0_flush_range,
+		.flush_all   = l2x0_flush_all,
+		.disable     = l2x0_disable,
+		.sync        = l2x0_cache_sync,
+		.resume      = pl310_resume,
+	},
+};
+
 /*
  * Note that the end addresses passed to Linux primitives are
  * noninclusive, while the hardware cache range operations use
@@ -585,6 +756,89 @@ static void aurora_flush_range(unsigned long start, unsigned long end)
 	}
 }
 
+static void aurora_save(void __iomem *base)
+{
+	l2x0_saved_regs.ctrl = readl_relaxed(base + L2X0_CTRL);
+	l2x0_saved_regs.aux_ctrl = readl_relaxed(base + L2X0_AUX_CTRL);
+}
+
+static void aurora_resume(void)
+{
+	if (!(readl(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
+		writel_relaxed(l2x0_saved_regs.aux_ctrl,
+				l2x0_base + L2X0_AUX_CTRL);
+		writel_relaxed(l2x0_saved_regs.ctrl, l2x0_base + L2X0_CTRL);
+	}
+}
+
+static void aurora_enable(void __iomem *base, u32 aux)
+{
+	l2c_enable(base, aux, 4);
+}
+
+/*
+ * For Aurora cache in no outer mode, enable via the CP15 coprocessor
+ * broadcasting of cache commands to L2.
+ */
+static void __init aurora_enable_no_outer(void __iomem *base, u32 aux)
+{
+	u32 u;
+
+	asm volatile("mrc p15, 1, %0, c15, c2, 0" : "=r" (u));
+	u |= AURORA_CTRL_FW;		/* Set the FW bit */
+	asm volatile("mcr p15, 1, %0, c15, c2, 0" : : "r" (u));
+
+	isb();
+
+	aurora_enable(base, aux);
+}
+
+static void __init aurora_of_parse(const struct device_node *np,
+				u32 *aux_val, u32 *aux_mask)
+{
+	u32 val = AURORA_ACR_REPLACEMENT_TYPE_SEMIPLRU;
+	u32 mask =  AURORA_ACR_REPLACEMENT_MASK;
+
+	of_property_read_u32(np, "cache-id-part",
+			&cache_id_part_number_from_dt);
+
+	/* Determine and save the write policy */
+	l2_wt_override = of_property_read_bool(np, "wt-override");
+
+	if (l2_wt_override) {
+		val |= AURORA_ACR_FORCE_WRITE_THRO_POLICY;
+		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
+	}
+
+	*aux_val &= ~mask;
+	*aux_val |= val;
+	*aux_mask &= ~mask;
+}
+
+static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
+	.of_parse = aurora_of_parse,
+	.enable = aurora_enable,
+	.save  = aurora_save,
+	.outer_cache = {
+		.inv_range   = aurora_inv_range,
+		.clean_range = aurora_clean_range,
+		.flush_range = aurora_flush_range,
+		.flush_all   = l2x0_flush_all,
+		.disable     = l2x0_disable,
+		.sync        = l2x0_cache_sync,
+		.resume      = aurora_resume,
+	},
+};
+
+static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
+	.of_parse = aurora_of_parse,
+	.enable = aurora_enable_no_outer,
+	.save  = aurora_save,
+	.outer_cache = {
+		.resume      = aurora_resume,
+	},
+};
+
 /*
  * For certain Broadcom SoCs, depending on the address range, different offsets
  * need to be added to the address before passing it to L2 for
@@ -726,108 +980,20 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 		new_end);
 }
 
-static void __init l2x0_of_parse(const struct device_node *np,
-				 u32 *aux_val, u32 *aux_mask)
-{
-	u32 data[2] = { 0, 0 };
-	u32 tag = 0;
-	u32 dirty = 0;
-	u32 val = 0, mask = 0;
-
-	of_property_read_u32(np, "arm,tag-latency", &tag);
-	if (tag) {
-		mask |= L2X0_AUX_CTRL_TAG_LATENCY_MASK;
-		val |= (tag - 1) << L2X0_AUX_CTRL_TAG_LATENCY_SHIFT;
-	}
-
-	of_property_read_u32_array(np, "arm,data-latency",
-				   data, ARRAY_SIZE(data));
-	if (data[0] && data[1]) {
-		mask |= L2X0_AUX_CTRL_DATA_RD_LATENCY_MASK |
-			L2X0_AUX_CTRL_DATA_WR_LATENCY_MASK;
-		val |= ((data[0] - 1) << L2X0_AUX_CTRL_DATA_RD_LATENCY_SHIFT) |
-		       ((data[1] - 1) << L2X0_AUX_CTRL_DATA_WR_LATENCY_SHIFT);
-	}
-
-	of_property_read_u32(np, "arm,dirty-latency", &dirty);
-	if (dirty) {
-		mask |= L2X0_AUX_CTRL_DIRTY_LATENCY_MASK;
-		val |= (dirty - 1) << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
-	}
-
-	*aux_val &= ~mask;
-	*aux_val |= val;
-	*aux_mask &= ~mask;
-}
-
-static void __init pl310_of_parse(const struct device_node *np,
-				  u32 *aux_val, u32 *aux_mask)
-{
-	u32 data[3] = { 0, 0, 0 };
-	u32 tag[3] = { 0, 0, 0 };
-	u32 filter[2] = { 0, 0 };
-
-	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
-	if (tag[0] && tag[1] && tag[2])
-		writel_relaxed(
-			((tag[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
-			((tag[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
-			((tag[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
-			l2x0_base + L2X0_TAG_LATENCY_CTRL);
-
-	of_property_read_u32_array(np, "arm,data-latency",
-				   data, ARRAY_SIZE(data));
-	if (data[0] && data[1] && data[2])
-		writel_relaxed(
-			((data[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
-			((data[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
-			((data[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
-			l2x0_base + L2X0_DATA_LATENCY_CTRL);
-
-	of_property_read_u32_array(np, "arm,filter-ranges",
-				   filter, ARRAY_SIZE(filter));
-	if (filter[1]) {
-		writel_relaxed(ALIGN(filter[0] + filter[1], SZ_1M),
-			       l2x0_base + L2X0_ADDR_FILTER_END);
-		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L2X0_ADDR_FILTER_EN,
-			       l2x0_base + L2X0_ADDR_FILTER_START);
-	}
-}
-
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
-static void aurora_save(void __iomem *base)
-{
-	l2x0_saved_regs.ctrl = readl_relaxed(base + L2X0_CTRL);
-	l2x0_saved_regs.aux_ctrl = readl_relaxed(base + L2X0_AUX_CTRL);
-}
+static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
+	.of_parse = pl310_of_parse,
+	.enable = l2x0_enable,
+	.save  = pl310_save,
+	.outer_cache = {
+		.inv_range   = bcm_inv_range,
+		.clean_range = bcm_clean_range,
+		.flush_range = bcm_flush_range,
+		.flush_all   = l2x0_flush_all,
+		.disable     = l2x0_disable,
+		.sync        = l2x0_cache_sync,
+		.resume      = pl310_resume,
+	},
+};
 
 static void __init tauros3_save(void __iomem *base)
 {
@@ -837,60 +1003,6 @@ static void __init tauros3_save(void __iomem *base)
 		readl_relaxed(base + L2X0_PREFETCH_CTRL);
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
-static void aurora_resume(void)
-{
-	if (!(readl(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
-		writel_relaxed(l2x0_saved_regs.aux_ctrl,
-				l2x0_base + L2X0_AUX_CTRL);
-		writel_relaxed(l2x0_saved_regs.ctrl, l2x0_base + L2X0_CTRL);
-	}
-}
-
 static void tauros3_resume(void)
 {
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
@@ -903,103 +1015,6 @@ static void tauros3_resume(void)
 	l2x0_resume();
 }
 
-static void aurora_enable(void __iomem *base, u32 aux)
-{
-	l2c_enable(base, aux, 4);
-}
-
-/*
- * For Aurora cache in no outer mode, enable via the CP15 coprocessor
- * broadcasting of cache commands to L2.
- */
-static void __init aurora_enable_no_outer(void __iomem *base, u32 aux)
-{
-	u32 u;
-
-	asm volatile("mrc p15, 1, %0, c15, c2, 0" : "=r" (u));
-	u |= AURORA_CTRL_FW;		/* Set the FW bit */
-	asm volatile("mcr p15, 1, %0, c15, c2, 0" : : "r" (u));
-
-	isb();
-
-	aurora_enable(base, aux);
-}
-
-static void __init aurora_of_parse(const struct device_node *np,
-				u32 *aux_val, u32 *aux_mask)
-{
-	u32 val = AURORA_ACR_REPLACEMENT_TYPE_SEMIPLRU;
-	u32 mask =  AURORA_ACR_REPLACEMENT_MASK;
-
-	of_property_read_u32(np, "cache-id-part",
-			&cache_id_part_number_from_dt);
-
-	/* Determine and save the write policy */
-	l2_wt_override = of_property_read_bool(np, "wt-override");
-
-	if (l2_wt_override) {
-		val |= AURORA_ACR_FORCE_WRITE_THRO_POLICY;
-		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
-	}
-
-	*aux_val &= ~mask;
-	*aux_val |= val;
-	*aux_mask &= ~mask;
-}
-
-static const struct l2c_init_data of_pl310_data __initconst = {
-	.of_parse = pl310_of_parse,
-	.enable = l2x0_enable,
-	.save  = pl310_save,
-	.outer_cache = {
-		.inv_range   = l2x0_inv_range,
-		.clean_range = l2x0_clean_range,
-		.flush_range = l2x0_flush_range,
-		.flush_all   = l2x0_flush_all,
-		.disable     = l2x0_disable,
-		.sync        = l2x0_cache_sync,
-		.resume      = pl310_resume,
-	},
-};
-
-static const struct l2c_init_data of_l2x0_data __initconst = {
-	.of_parse = l2x0_of_parse,
-	.enable = l2x0_enable,
-	.outer_cache = {
-		.inv_range   = l2x0_inv_range,
-		.clean_range = l2x0_clean_range,
-		.flush_range = l2x0_flush_range,
-		.flush_all   = l2x0_flush_all,
-		.disable     = l2x0_disable,
-		.sync        = l2x0_cache_sync,
-		.resume      = l2x0_resume,
-	},
-};
-
-static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
-	.of_parse = aurora_of_parse,
-	.enable = aurora_enable,
-	.save  = aurora_save,
-	.outer_cache = {
-		.inv_range   = aurora_inv_range,
-		.clean_range = aurora_clean_range,
-		.flush_range = aurora_flush_range,
-		.flush_all   = l2x0_flush_all,
-		.disable     = l2x0_disable,
-		.sync        = l2x0_cache_sync,
-		.resume      = aurora_resume,
-	},
-};
-
-static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
-	.of_parse = aurora_of_parse,
-	.enable = aurora_enable_no_outer,
-	.save  = aurora_save,
-	.outer_cache = {
-		.resume      = aurora_resume,
-	},
-};
-
 static const struct l2c_init_data of_tauros3_data __initconst = {
 	.enable = l2x0_enable,
 	.save  = tauros3_save,
@@ -1009,21 +1024,6 @@ static const struct l2c_init_data of_tauros3_data __initconst = {
 	},
 };
 
-static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
-	.of_parse = pl310_of_parse,
-	.enable = l2x0_enable,
-	.save  = pl310_save,
-	.outer_cache = {
-		.inv_range   = bcm_inv_range,
-		.clean_range = bcm_clean_range,
-		.flush_range = bcm_flush_range,
-		.flush_all   = l2x0_flush_all,
-		.disable     = l2x0_disable,
-		.sync        = l2x0_cache_sync,
-		.resume      = pl310_resume,
-	},
-};
-
 #define L2C_ID(name, fns) { .compatible = name, .data = (void *)&fns }
 static const struct of_device_id l2x0_ids[] __initconst = {
 	L2C_ID("arm,l210-cache", of_l2x0_data),
-- 
1.8.3.1
