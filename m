From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 10 Nov 2018 21:38:16 +0100
Subject: [PATCH] ARM: cache-l2x0: remove duplicate warning
Message-ID: <7be3eaf2ac9db2e2e74900a2d2fa7d085b3d77f4.1541882244.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning abount changing of AUX register in l2x0_of_init() is later
repeated in __l2c_init().  Move whole thing over to __l2c_init().

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/mm/cache-l2x0.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 808efbb89b88..ea1e70ff4568 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -819,6 +819,8 @@ static int __init __l2c_init(const struct l2c_init_data *data,
 	if (old_aux != aux)
 		pr_warn("L2C: DT/platform modifies aux control register: 0x%08x -> 0x%08x\n",
 		        old_aux, aux);
+	else if (aux_mask != ~0U && aux_val != 0)
+		pr_alert("L2C: platform-provided aux values match the hardware, so have no effect.  Please remove them.\n");
 
 	/* Determine the number of ways */
 	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
@@ -1755,7 +1757,7 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	const struct l2c_init_data *data;
 	struct device_node *np;
 	struct resource res;
-	u32 cache_id, old_aux;
+	u32 cache_id;
 	u32 cache_level = 2;
 	bool nosync = false;
 
@@ -1778,14 +1780,6 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	    of_property_read_bool(np, "arm,io-coherent"))
 		data = &of_l2c310_coherent_data;
 
-	old_aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
-	if (old_aux != ((old_aux & aux_mask) | aux_val)) {
-		pr_warn("L2C: platform modifies aux control register: 0x%08x -> 0x%08x\n",
-		        old_aux, (old_aux & aux_mask) | aux_val);
-	} else if (aux_mask != ~0U && aux_val != 0) {
-		pr_alert("L2C: platform provided aux values match the hardware, so have no effect.  Please remove them.\n");
-	}
-
 	/* All L2 caches are unified, so this property should be specified */
 	if (!of_property_read_bool(np, "cache-unified"))
 		pr_err("L2C: device tree omits to specify unified cache\n");
-- 
2.19.1
