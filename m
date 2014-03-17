From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:15:02 +0000
Subject: [PATCH 18/44] ARM: l2c: implement fixups for L2 cache controller
 quirks/errata
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLCo-0002d3-Rd@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than putting quirk handling in __l2c_init(), move it out to a
separate function which individual implementations can specify.  This
helps to localise the quirks to those implementations which require
them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 111 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 100 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9bd41f0e3b8a..9d2b55b05f71 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -31,6 +31,7 @@
 struct l2c_init_data {
 	void (*of_parse)(const struct device_node *, u32 *, u32 *);
 	void (*enable)(void __iomem *, u32);
+	void (*fixup)(void __iomem *, u32, struct outer_cache_fns *);
 	void (*save)(void __iomem *);
 	struct outer_cache_fns outer_cache;
 };
@@ -382,9 +383,79 @@ static const struct l2c_init_data l2x0_init_fns __initconst = {
 	},
 };
 
+/*
+ * L2C-310 specific code.
+ *
+ * Errata:
+ * 588369: PL310 R0P0->R1P0, fixed R2P0.
+ *	Affects: all clean+invalidate operations
+ *	clean and invalidate skips the invalidate step, so we need to issue
+ *	separate operations.  We also require the above debug workaround
+ *	enclosing this code fragment on affected parts.  On unaffected parts,
+ *	we must not use this workaround without the debug register writes
+ *	to avoid exposing a problem similar to 727915.
+ *
+ * 727915: PL310 R2P0->R3P0, fixed R3P1.
+ *	Affects: clean+invalidate by way
+ *	clean and invalidate by way runs in the background, and a store can
+ *	hit the line between the clean operation and invalidate operation,
+ *	resulting in the store being lost.
+ *
+ * 753970: PL310 R3P0, fixed R3P1.
+ *	Affects: sync
+ *	prevents merging writes after the sync operation, until another L2C
+ *	operation is performed (or a number of other conditions.)
+ *
+ * 769419: PL310 R0P0->R3P1, fixed R3P2.
+ *	Affects: store buffer
+ *	store buffer is not automatically drained.
+ */
+static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
+	struct outer_cache_fns *fns)
+{
+	unsigned revision = cache_id & L2X0_CACHE_ID_RTL_MASK;
+	const char *errata[4];
+	unsigned n = 0;
+
+	if (revision <= L310_CACHE_ID_RTL_R3P0)
+		fns->set_debug = pl310_set_debug;
+
+	if (IS_ENABLED(CONFIG_PL310_ERRATA_753970) &&
+	    revision == L310_CACHE_ID_RTL_R3P0) {
+		sync_reg_offset = L2X0_DUMMY_REG;
+		errata[n++] = "753970";
+	}
+
+	if (IS_ENABLED(CONFIG_PL310_ERRATA_769419))
+		errata[n++] = "769419";
+
+	if (n) {
+		unsigned i;
+
+		pr_info("L2C-310 errat%s", n > 1 ? "a" : "um");
+		for (i = 0; i < n; i++)
+			pr_cont(" %s", errata[i]);
+		pr_cont(" enabled\n");
+	}
+}
+
+static const struct l2c_init_data l2c310_init_fns __initconst = {
+	.enable = l2x0_enable,
+	.fixup = l2c310_fixup,
+	.outer_cache = {
+		.inv_range = l2x0_inv_range,
+		.clean_range = l2x0_clean_range,
+		.flush_range = l2x0_flush_range,
+		.flush_all = l2x0_flush_all,
+		.disable = l2x0_disable,
+		.sync = l2x0_cache_sync,
+	},
+};
+
 static void __init __l2c_init(const struct l2c_init_data *data,
 	u32 aux_val, u32 aux_mask, u32 cache_id)
 {
+	struct outer_cache_fns fns;
 	u32 aux;
 	u32 way_size = 0;
 	int ways;
@@ -411,23 +482,20 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 		else
 			ways = 8;
 		type = "L310";
-#ifdef CONFIG_PL310_ERRATA_753970
-		/* Unmapped register. */
-		sync_reg_offset = L2X0_DUMMY_REG;
-#endif
 		break;
+
 	case L2X0_CACHE_ID_PART_L210:
 		ways = (aux >> 13) & 0xf;
 		type = "L210";
 		break;
 
 	case AURORA_CACHE_ID:
-		sync_reg_offset = AURORA_SYNC_REG;
 		ways = (aux >> 13) & 0xf;
 		ways = 2 << ((ways + 1) >> 2);
 		way_size_shift = AURORA_WAY_SIZE_SHIFT;
 		type = "Aurora";
 		break;
+
 	default:
 		/* Assume unknown chips have 8 ways */
 		ways = 8;
@@ -445,6 +513,10 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 
 	l2x0_size = ways * way_size * SZ_1K;
 
+	fns = data->outer_cache;
+	if (data->fixup)
+		data->fixup(l2x0_base, cache_id, &fns);
+
 	/*
 	 * Check if l2x0 controller is already enabled.  If we are booting
 	 * in non-secure mode accessing the below registers will fault.
@@ -458,11 +530,7 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	/* Save the value for resuming. */
 	l2x0_saved_regs.aux_ctrl = aux;
 
-	outer_cache = data->outer_cache;
-
-	if ((cache_id & L2X0_CACHE_ID_PART_MASK) == L2X0_CACHE_ID_PART_L310 &&
-	    (cache_id & L2X0_CACHE_ID_RTL_MASK) <= L310_CACHE_ID_RTL_R3P0)
-		outer_cache.set_debug = pl310_set_debug;
+	outer_cache = fns;
 
 	pr_info("%s cache controller enabled\n", type);
 	pr_info("l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d kB\n",
@@ -471,13 +539,24 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 
 void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 {
+	const struct l2c_init_data *data;
 	u32 cache_id;
 
 	l2x0_base = base;
 
 	cache_id = readl_relaxed(base + L2X0_CACHE_ID);
 
-	__l2c_init(&l2x0_init_fns, aux_val, aux_mask, cache_id);
+	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
+	default:
+		data = &l2x0_init_fns;
+		break;
+
+	case L2X0_CACHE_ID_PART_L310:
+		data = &l2c310_init_fns;
+		break;
+	}
+
+	__l2c_init(data, aux_val, aux_mask, cache_id);
 }
 
 #ifdef CONFIG_OF
@@ -646,6 +725,7 @@ static void pl310_resume(void)
 static const struct l2c_init_data of_pl310_data __initconst = {
 	.of_parse = pl310_of_parse,
 	.enable = l2x0_enable,
+	.fixup = l2c310_fixup,
 	.save  = pl310_save,
 	.outer_cache = {
 		.inv_range   = l2x0_inv_range,
@@ -793,6 +873,12 @@ static void __init aurora_enable_no_outer(void __iomem *base, u32 aux)
 	aurora_enable(base, aux);
 }
 
+static void __init aurora_fixup(void __iomem *base, u32 cache_id,
+	struct outer_cache_fns *fns)
+{
+	sync_reg_offset = AURORA_SYNC_REG;
+}
+
 static void __init aurora_of_parse(const struct device_node *np,
 				u32 *aux_val, u32 *aux_mask)
 {
@@ -818,6 +904,7 @@ static void __init aurora_of_parse(const struct device_node *np,
 static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 	.of_parse = aurora_of_parse,
 	.enable = aurora_enable,
+	.fixup = aurora_fixup,
 	.save  = aurora_save,
 	.outer_cache = {
 		.inv_range   = aurora_inv_range,
@@ -833,6 +920,7 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
 	.of_parse = aurora_of_parse,
 	.enable = aurora_enable_no_outer,
+	.fixup = aurora_fixup,
 	.save  = aurora_save,
 	.outer_cache = {
 		.resume      = aurora_resume,
@@ -983,6 +1071,7 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 	.of_parse = pl310_of_parse,
 	.enable = l2x0_enable,
+	.fixup = l2c310_fixup,
 	.save  = pl310_save,
 	.outer_cache = {
 		.inv_range   = bcm_inv_range,
-- 
1.8.3.1
