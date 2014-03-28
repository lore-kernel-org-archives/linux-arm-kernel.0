From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:20:19 +0000
Subject: [PATCH 69/75] ARM: l2c: check that DT files specify the required
 "cache-unified" property
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYZv-0007HZ-AY@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a required property, and should always be specified.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 655a363918f5..dd3de310b4ea 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1380,6 +1380,10 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 
 	data = of_match_node(l2x0_ids, np)->data;
 
+	/* All L2 caches are unified, so this property should be specified */
+	if (!of_property_read_bool(np, "cache-unified"))
+		pr_err("L2C: device tree omits to specify unified cache\n");
+
 	/* L2 configuration can only be changed if the cache is disabled */
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN))
 		if (data->of_parse)
-- 
1.8.3.1
