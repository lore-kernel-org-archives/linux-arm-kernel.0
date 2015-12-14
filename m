From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Dec 2015 21:53:05 +0100
Subject: [PATCH 1/2 v2] ARM: l2x0: make it possible to disable outer sync from
 DT
Message-ID: <1450126385-14517-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to commit 2503a5ecd86c002506001eba432c524ea009fe7f
"ARM: 6201/1: RealView: Do not use outer_sync() on ARM11MPCore
boards with L220" Some PB11MPCore RealView core tiles have broken
outer_sync.

We got rid of the custom barriers from the machine by disabling
outer sync, but that was just for the boardfile case. We have
to be able to do the same in the device tree case.

Since __l2c_init() is cloning and copying the L2C vtable,
we pass an argument to this function to optionally numb
the outer sync operation if desired, before initializing
the cache.

After this we can set up the cache correctly on the RealView
PB11MPCore. This was tested on a PB11MPCore known to have the
issue. Before this, spurious crashes would occur if we try to
set up the cache properly, after this it boots rock solid.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: devicetree at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Update description, reference Catalins initial commit in the
  commit blurb.
---
 Documentation/devicetree/bindings/arm/l2cc.txt |  3 +++
 arch/arm/mm/cache-l2x0.c                       | 13 ++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index d181b7c4c522..416864e9dc92 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -75,6 +75,9 @@ Optional properties:
   specified to indicate that such transforms are precluded.
 - arm,parity-enable : enable parity checking on the L2 cache (L220 or PL310).
 - arm,parity-disable : disable parity checking on the L2 cache (L220 or PL310).
+- arm,outer-sync-disable : disable the outer sync operation on the L2 cache.
+  Some core tiles, especially ARM PB11MPCore have a faulty L220 cache that
+  will randomly hang unless outer sync operations are disabled.
 - prefetch-data : Data prefetch. Value: <0> (forcibly disable), <1>
   (forcibly enable), property absent (retain settings set by firmware)
 - prefetch-instr : Instruction prefetch. Value: <0> (forcibly disable),
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 3f3008e5c662..9f9d54271aad 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -790,7 +790,7 @@ static const struct l2c_init_data l2c310_init_fns __initconst = {
 };
 
 static int __init __l2c_init(const struct l2c_init_data *data,
-			     u32 aux_val, u32 aux_mask, u32 cache_id)
+			     u32 aux_val, u32 aux_mask, u32 cache_id, bool nosync)
 {
 	struct outer_cache_fns fns;
 	unsigned way_size_bits, ways;
@@ -866,6 +866,10 @@ static int __init __l2c_init(const struct l2c_init_data *data,
 	fns.configure = outer_cache.configure;
 	if (data->fixup)
 		data->fixup(l2x0_base, cache_id, &fns);
+	if (nosync) {
+		pr_info("L2C: disabling outer sync\n");
+		fns.sync = NULL;
+	}
 
 	/*
 	 * Check if l2x0 controller is already enabled.  If we are booting
@@ -925,7 +929,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	if (data->save)
 		data->save(l2x0_base);
 
-	__l2c_init(data, aux_val, aux_mask, cache_id);
+	__l2c_init(data, aux_val, aux_mask, cache_id, false);
 }
 
 #ifdef CONFIG_OF
@@ -1724,6 +1728,7 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	struct resource res;
 	u32 cache_id, old_aux;
 	u32 cache_level = 2;
+	bool nosync = false;
 
 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
@@ -1762,6 +1767,8 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	if (cache_level != 2)
 		pr_err("L2C: device tree specifies invalid cache level\n");
 
+	nosync = of_property_read_bool(np, "arm,outer-sync-disable");
+
 	/* Read back current (default) hardware configuration */
 	if (data->save)
 		data->save(l2x0_base);
@@ -1776,6 +1783,6 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	else
 		cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
 
-	return __l2c_init(data, aux_val, aux_mask, cache_id);
+	return __l2c_init(data, aux_val, aux_mask, cache_id, nosync);
 }
 #endif
-- 
2.4.3
