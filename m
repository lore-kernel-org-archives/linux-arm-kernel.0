From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:20:39 +0000
Subject: [PATCH 73/75] ARM: l2c: move L2 cache register saving to a more
 sensible location
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYaF-0007Hv-Nv@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 49155da7a8c4..700a66260f94 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -846,13 +846,6 @@ static void __init __l2c_init(const struct l2c_init_data *data,
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
@@ -914,13 +907,17 @@ static void __init __l2c_init(const struct l2c_init_data *data,
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
-- 
1.8.3.1
