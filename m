From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:36:54 +0100
Subject: [PATCH 070/222] ARM: l2c: add warnings for stuff modifying aux_ctrl
 register values
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeR4-0007Hp-Q3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 96a1374127de..5de7f6c56306 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -715,7 +715,15 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 {
 	struct outer_cache_fns fns;
 	unsigned way_size_bits, ways;
-	u32 aux;
+	u32 aux, old_aux;
+
+	/*
+	 * Sanity check the aux values.  aux_mask is the bits we preserve
+	 * from reading the hardware register, and aux_val is the bits we
+	 * set.
+	 */
+	if (aux_val & aux_mask)
+		pr_alert("L2C: platform provided aux values permit register corruption.\n");
 
 	/*
 	 * It is strange to save the register state before initialisation,
@@ -724,11 +732,14 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	if (data->save)
 		data->save(l2x0_base);
 
-	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
-
+	old_aux = aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 	aux &= aux_mask;
 	aux |= aux_val;
 
+	if (old_aux != aux)
+		pr_warn("L2C: DT/platform modifies aux control register: 0x%08x -> 0x%08x\n",
+		        old_aux, aux);
+
 	/* Determine the number of ways */
 	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
 	case L2X0_CACHE_ID_PART_L310:
@@ -1361,7 +1372,7 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	const struct l2c_init_data *data;
 	struct device_node *np;
 	struct resource res;
-	u32 cache_id;
+	u32 cache_id, old_aux;
 
 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
@@ -1378,6 +1389,14 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 
 	data = of_match_node(l2x0_ids, np)->data;
 
+	old_aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
+	if (old_aux != ((old_aux & aux_mask) | aux_val)) {
+		pr_warn("L2C: platform modifies aux control register: 0x%08x -> 0x%08x\n",
+		        old_aux, (old_aux & aux_mask) | aux_val);
+	} else if (aux_mask != ~0U && aux_val != 0) {
+		pr_alert("L2C: platform provided aux values match the hardware, so have no effect.  Please remove them.\n");
+	}
+
 	/* All L2 caches are unified, so this property should be specified */
 	if (!of_property_read_bool(np, "cache-unified"))
 		pr_err("L2C: device tree omits to specify unified cache\n");
-- 
1.8.3.1
