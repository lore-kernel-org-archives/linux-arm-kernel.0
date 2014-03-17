From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:52 +0000
Subject: [PATCH 16/44] ARM: l2c: move aurora broadcast setup to enable function
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLCe-0002cv-L3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than having this hacked into the OF initialiation function, we
can handle this via the enable function instead.  While here, clean
up that code and comments a little.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index ee60a53357d9..d38591aabb35 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -908,14 +908,21 @@ static void aurora_enable(void __iomem *base, u32 aux)
 	l2c_enable(base, aux, 4);
 }
 
-static void __init aurora_broadcast_l2_commands(void)
+/*
+ * For Aurora cache in no outer mode, enable via the CP15 coprocessor
+ * broadcasting of cache commands to L2.
+ */
+static void __init aurora_enable_no_outer(void __iomem *base, u32 aux)
 {
-	__u32 u;
-	/* Enable Broadcasting of cache commands to L2*/
-	__asm__ __volatile__("mrc p15, 1, %0, c15, c2, 0" : "=r"(u));
+	u32 u;
+
+	asm volatile("mrc p15, 1, %0, c15, c2, 0" : "=r" (u));
 	u |= AURORA_CTRL_FW;		/* Set the FW bit */
-	__asm__ __volatile__("mcr p15, 1, %0, c15, c2, 0\n" : : "r"(u));
+	asm volatile("mcr p15, 1, %0, c15, c2, 0" : : "r" (u));
+
 	isb();
+
+	aurora_enable(base, aux);
 }
 
 static void __init aurora_of_parse(const struct device_node *np,
@@ -986,7 +993,7 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 
 static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
 	.of_parse = aurora_of_parse,
-	.enable = aurora_enable,
+	.enable = aurora_enable_no_outer,
 	.save  = aurora_save,
 	.outer_cache = {
 		.resume      = aurora_resume,
@@ -1054,16 +1061,10 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	data = of_match_node(l2x0_ids, np)->data;
 
 	/* L2 configuration can only be changed if the cache is disabled */
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN))
 		if (data->of_parse)
 			data->of_parse(np, &aux_val, &aux_mask);
 
-		/* For aurora cache in no outer mode select the
-		 * correct mode using the coprocessor*/
-		if (data == &of_aurora_no_outer_data)
-			aurora_broadcast_l2_commands();
-	}
-
 	if (cache_id_part_number_from_dt)
 		cache_id = cache_id_part_number_from_dt;
 	else
-- 
1.8.3.1
