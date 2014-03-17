From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:32 +0000
Subject: [PATCH 12/44] ARM: l2c: clean up OF initialisation a bit
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLCK-0002ce-68@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than having a boolean and other tricks to disable some bits of
l2x0_init(), split this function into two parts: a common part shared
between OF and non-OF, and the non-OF part.

The common part can take a block of function pointers, and the cache
ID (to cope with Aurora's DT specified ID.)  Eliminate the redundant
setting of l2x0_base in the OF case, moving it to the non-OF init
function.

This allows us to localise the OF-specific initialisation handling
from the non-OF handling.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 66 +++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c39602ef2cdd..0d83b24b7971 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -42,14 +42,8 @@ static u32 l2x0_way_mask;	/* Bitmask of active ways */
 static u32 l2x0_size;
 static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
 
-/* Aurora don't have the cache ID register available, so we have to
- * pass it though the device tree */
-static u32  cache_id_part_number_from_dt;
-
 struct l2x0_regs l2x0_saved_regs;
 
-static bool of_init = false;
-
 /*
  * Common code for all cache controllers.
  */
@@ -343,20 +337,26 @@ static void l2x0_unlock(u32 cache_id)
 	l2c_unlock(l2x0_base, lockregs);
 }
 
-void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
+static const struct l2c_init_data l2x0_init_fns __initconst = {
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
+static void __init __l2c_init(const struct l2c_init_data *data,
+	u32 aux_val, u32 aux_mask, u32 cache_id)
 {
 	u32 aux;
-	u32 cache_id;
 	u32 way_size = 0;
 	int ways;
 	int way_size_shift = L2X0_WAY_SIZE_SHIFT;
 	const char *type;
 
-	l2x0_base = base;
-	if (cache_id_part_number_from_dt)
-		cache_id = cache_id_part_number_from_dt;
-	else
-		cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
 	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 
 	aux &= aux_mask;
@@ -374,8 +374,6 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		/* Unmapped register. */
 		sync_reg_offset = L2X0_DUMMY_REG;
 #endif
-		if ((cache_id & L2X0_CACHE_ID_RTL_MASK) <= L310_CACHE_ID_RTL_R3P0)
-			outer_cache.set_debug = pl310_set_debug;
 		break;
 	case L2X0_CACHE_ID_PART_L210:
 		ways = (aux >> 13) & 0xf;
@@ -430,23 +428,35 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	/* Save the value for resuming. */
 	l2x0_saved_regs.aux_ctrl = aux;
 
-	if (!of_init) {
-		outer_cache.inv_range = l2x0_inv_range;
-		outer_cache.clean_range = l2x0_clean_range;
-		outer_cache.flush_range = l2x0_flush_range;
-		outer_cache.sync = l2x0_cache_sync;
-		outer_cache.flush_all = l2x0_flush_all;
-		outer_cache.disable = l2x0_disable;
-	}
+	outer_cache = data->outer_cache;
+
+	if ((cache_id & L2X0_CACHE_ID_PART_MASK) == L2X0_CACHE_ID_PART_L310 &&
+	    (cache_id & L2X0_CACHE_ID_RTL_MASK) <= L310_CACHE_ID_RTL_R3P0)
+		outer_cache.set_debug = pl310_set_debug;
 
 	pr_info("%s cache controller enabled\n", type);
 	pr_info("l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d kB\n",
 		ways, cache_id, aux, l2x0_size >> 10);
 }
 
+void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
+{
+	u32 cache_id;
+
+	l2x0_base = base;
+
+	cache_id = readl_relaxed(base + L2X0_CACHE_ID);
+
+	__l2c_init(&l2x0_init_fns, aux_val, aux_mask, cache_id);
+}
+
 #ifdef CONFIG_OF
 static int l2_wt_override;
 
+/* Aurora don't have the cache ID register available, so we have to
+ * pass it though the device tree */
+static u32 cache_id_part_number_from_dt;
+
 /*
  * Note that the end addresses passed to Linux primitives are
  * noninclusive, while the hardware cache range operations use
@@ -985,6 +995,7 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	const struct l2c_init_data *data;
 	struct device_node *np;
 	struct resource res;
+	u32 cache_id;
 
 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
@@ -1015,9 +1026,12 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	if (data->save)
 		data->save();
 
-	of_init = true;
-	memcpy(&outer_cache, &data->outer_cache, sizeof(outer_cache));
-	l2x0_init(l2x0_base, aux_val, aux_mask);
+	if (cache_id_part_number_from_dt)
+		cache_id = cache_id_part_number_from_dt;
+	else
+		cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
+
+	__l2c_init(data, aux_val, aux_mask, cache_id);
 
 	return 0;
 }
-- 
1.8.3.1
