From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:37 +0000
Subject: [PATCH 13/44] ARM: l2c: pass iomem address into data->save function
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLCP-0002ci-9o@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the iomem address into this function so we don't have to keep
accessing it from a global.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 0d83b24b7971..08f9cade028a 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -30,7 +30,7 @@
 
 struct l2c_init_data {
 	void (*of_parse)(const struct device_node *, u32 *, u32 *);
-	void (*save)(void);
+	void (*save)(void __iomem *);
 	struct outer_cache_fns outer_cache;
 };
 
@@ -764,47 +764,47 @@ static void __init pl310_of_parse(const struct device_node *np,
 	}
 }
 
-static void __init pl310_save(void)
+static void __init pl310_save(void __iomem *base)
 {
-	u32 l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
+	u32 l2x0_revision = readl_relaxed(base + L2X0_CACHE_ID) &
 		L2X0_CACHE_ID_RTL_MASK;
 
-	l2x0_saved_regs.tag_latency = readl_relaxed(l2x0_base +
+	l2x0_saved_regs.tag_latency = readl_relaxed(base +
 		L2X0_TAG_LATENCY_CTRL);
-	l2x0_saved_regs.data_latency = readl_relaxed(l2x0_base +
+	l2x0_saved_regs.data_latency = readl_relaxed(base +
 		L2X0_DATA_LATENCY_CTRL);
-	l2x0_saved_regs.filter_end = readl_relaxed(l2x0_base +
+	l2x0_saved_regs.filter_end = readl_relaxed(base +
 		L2X0_ADDR_FILTER_END);
-	l2x0_saved_regs.filter_start = readl_relaxed(l2x0_base +
+	l2x0_saved_regs.filter_start = readl_relaxed(base +
 		L2X0_ADDR_FILTER_START);
 
 	if (l2x0_revision >= L310_CACHE_ID_RTL_R2P0) {
 		/*
 		 * From r2p0, there is Prefetch offset/control register
 		 */
-		l2x0_saved_regs.prefetch_ctrl = readl_relaxed(l2x0_base +
+		l2x0_saved_regs.prefetch_ctrl = readl_relaxed(base +
 			L2X0_PREFETCH_CTRL);
 		/*
 		 * From r3p0, there is Power control register
 		 */
 		if (l2x0_revision >= L310_CACHE_ID_RTL_R3P0)
-			l2x0_saved_regs.pwr_ctrl = readl_relaxed(l2x0_base +
+			l2x0_saved_regs.pwr_ctrl = readl_relaxed(base +
 				L2X0_POWER_CTRL);
 	}
 }
 
-static void aurora_save(void)
+static void aurora_save(void __iomem *base)
 {
-	l2x0_saved_regs.ctrl = readl_relaxed(l2x0_base + L2X0_CTRL);
-	l2x0_saved_regs.aux_ctrl = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
+	l2x0_saved_regs.ctrl = readl_relaxed(base + L2X0_CTRL);
+	l2x0_saved_regs.aux_ctrl = readl_relaxed(base + L2X0_AUX_CTRL);
 }
 
-static void __init tauros3_save(void)
+static void __init tauros3_save(void __iomem *base)
 {
 	l2x0_saved_regs.aux2_ctrl =
-		readl_relaxed(l2x0_base + TAUROS3_AUX2_CTRL);
+		readl_relaxed(base + TAUROS3_AUX2_CTRL);
 	l2x0_saved_regs.prefetch_ctrl =
-		readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
+		readl_relaxed(base + L2X0_PREFETCH_CTRL);
 }
 
 static void l2x0_resume(void)
@@ -1024,7 +1024,7 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	}
 
 	if (data->save)
-		data->save();
+		data->save(l2x0_base);
 
 	if (cache_id_part_number_from_dt)
 		cache_id = cache_id_part_number_from_dt;
-- 
1.8.3.1
