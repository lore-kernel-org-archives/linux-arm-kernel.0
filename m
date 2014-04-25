From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:36:49 +0100
Subject: [PATCH 069/222] ARM: l2c: check that DT files specify the required
 "cache-unified" property
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeQz-0007Hl-Fi@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a required property, and should always be specified.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 8a5110deb657..96a1374127de 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1378,6 +1378,10 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 
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
