From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  3 Mar 2015 10:55:41 -0800
Subject: [PATCH] ARM: l2c: enforce use of cache-level property
Message-ID: <1425408941-9897-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that we can read the "cache-level" property from the L2 cache
controller node, and ensure its value is 2.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Russell, Linus,

You may have seen that patch earlier, it was part of my attempt
to parse the 'cache-size' and 'cache-sets' properties, and ultimately
Linus' series went it, and this patch was lost ast see.

Thanks!

 arch/arm/mm/cache-l2x0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c6c7696b8db9..8b933dc43e24 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1648,6 +1648,7 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	struct device_node *np;
 	struct resource res;
 	u32 cache_id, old_aux;
+	u32 cache_level = 2;
 
 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
@@ -1680,6 +1681,12 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	if (!of_property_read_bool(np, "cache-unified"))
 		pr_err("L2C: device tree omits to specify unified cache\n");
 
+	if (of_property_read_u32(np, "cache-level", &cache_level))
+		pr_err("L2C: device tree omits to specify cache-level\n");
+
+	if (cache_level != 2)
+		pr_err("L2C: device tree specifies invalid cache level\n");
+
 	/* Read back current (default) hardware configuration */
 	if (data->save)
 		data->save(l2x0_base);
-- 
2.1.0
