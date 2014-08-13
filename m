From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Aug 2014 16:29:29 -0700
Subject: [PATCH 1/3] ARM: l2c: enforce use of cache-level property
In-Reply-To: <1407972571-8986-1-git-send-email-f.fainelli@gmail.com>
References: <1407972571-8986-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1407972571-8986-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that we can read the "cache-level" property from the L2 cache
controller node, and ensure its value is 2.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/cache-l2x0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 5f2c988a06ac..80488e78ce32 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1498,6 +1498,7 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	struct device_node *np;
 	struct resource res;
 	u32 cache_id, old_aux;
+	u32 cache_level = 2;
 
 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
@@ -1530,6 +1531,12 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	if (!of_property_read_bool(np, "cache-unified"))
 		pr_err("L2C: device tree omits to specify unified cache\n");
 
+	if (of_property_read_u32(np, "cache-level", &cache_level))
+		pr_err("L2C: device tree omits to specify cache-level\n");
+
+	if (cache_level != 2)
+		pr_err("L2C: device tree specifies invalid cache level\n");
+
 	/* L2 configuration can only be changed if the cache is disabled */
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN))
 		if (data->of_parse)
-- 
1.9.1
