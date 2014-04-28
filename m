From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:33:05 +0100
Subject: [PATCH 81/97] ARM: l2c: move L2 cache register saving to a more
 sensible location
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerIX-0001ZA-SN@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the L2 cache register saving to a more sensible location - after
the cache has been enabled, and fixups have been run.  We move the
saving of the auxiliary control register into the ->save function as
well which makes everything operate in a sane and maintainable way.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index ad5b6b41b4be..610fa25eff0c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -202,6 +202,11 @@ static void l2x0_disable(void)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static void l2c_save(void __iomem *base)
+{
+	l2x0_saved_regs.aux_ctrl = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
+}
+
 /*
  * L2C-210 specific code.
  *
@@ -295,6 +300,7 @@ static const struct l2c_init_data l2c210_data __initconst = {
 	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.enable = l2c_enable,
+	.save = l2c_save,
 	.outer_cache = {
 		.inv_range = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -439,6 +445,7 @@ static const struct l2c_init_data l2c220_data = {
 	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.enable = l2c_enable,
+	.save = l2c_save,
 	.outer_cache = {
 		.inv_range = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -570,6 +577,8 @@ static void __init l2c310_save(void __iomem *base)
 {
 	unsigned revision;
 
+	l2c_save(base);
+
 	l2x0_saved_regs.tag_latency = readl_relaxed(base +
 		L310_TAG_LATENCY_CTRL);
 	l2x0_saved_regs.data_latency = readl_relaxed(base +
@@ -792,13 +801,6 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	if (aux_val & aux_mask)
 		pr_alert("L2C: platform provided aux values permit register corruption.\n");
 
-	/*
-	 * It is strange to save the register state before initialisation,
-	 * but hey, this is what the DT implementations decided to do.
-	 */
-	if (data->save)
-		data->save(l2x0_base);
-
 	old_aux = aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 	aux &= aux_mask;
 	aux |= aux_val;
@@ -860,13 +862,17 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN))
 		data->enable(l2x0_base, aux, data->num_lock);
 
-	/* Re-read it in case some bits are reserved. */
-	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
+	outer_cache = fns;
 
-	/* Save the value for resuming. */
-	l2x0_saved_regs.aux_ctrl = aux;
+	/*
+	 * It is strange to save the register state before initialisation,
+	 * but hey, this is what the DT implementations decided to do.
+	 */
+	if (data->save)
+		data->save(l2x0_base);
 
-	outer_cache = fns;
+	/* Re-read it in case some bits are reserved. */
+	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 
 	pr_info("%s cache controller enabled, %d ways, %d kB\n",
 		data->type, ways, l2x0_size >> 10);
@@ -948,6 +954,7 @@ static const struct l2c_init_data of_l2c210_data __initconst = {
 	.num_lock = 1,
 	.of_parse = l2x0_of_parse,
 	.enable = l2c_enable,
+	.save = l2c_save,
 	.outer_cache = {
 		.inv_range   = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -965,6 +972,7 @@ static const struct l2c_init_data of_l2c220_data __initconst = {
 	.num_lock = 1,
 	.of_parse = l2x0_of_parse,
 	.enable = l2c_enable,
+	.save = l2c_save,
 	.outer_cache = {
 		.inv_range   = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -1378,6 +1386,8 @@ static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 
 static void __init tauros3_save(void __iomem *base)
 {
+	l2c_save(base);
+
 	l2x0_saved_regs.aux2_ctrl =
 		readl_relaxed(base + TAUROS3_AUX2_CTRL);
 	l2x0_saved_regs.prefetch_ctrl =
-- 
1.8.3.1
