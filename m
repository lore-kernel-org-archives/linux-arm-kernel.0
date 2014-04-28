From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:31:38 +0100
Subject: [PATCH 64/97] ARM: l2c: prima2: remove cache size override
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerH8-0001Y4-VE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-prima2/l2x0.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
index 2db82742fb74..dbd837bdb7f7 100644
--- a/arch/arm/mach-prima2/l2x0.c
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -11,21 +11,6 @@
 #include <linux/of.h>
 #include <asm/hardware/cache-l2x0.h>
 
-struct l2x0_aux {
-	u32 val;
-	u32 mask;
-};
-
-static const struct l2x0_aux prima2_l2x0_aux __initconst = {
-	.val = L2C_AUX_CTRL_WAY_SIZE(2),
-	.mask =	0,
-};
-
-static const struct l2x0_aux marco_l2x0_aux __initconst = {
-	.val = L2C_AUX_CTRL_WAY_SIZE(2) | L310_AUX_CTRL_ASSOCIATIVITY_16,
-	.mask = L2X0_AUX_CTRL_MASK,
-};
-
 static const struct of_device_id sirf_l2x0_ids[] __initconst = {
 	{ .compatible = "sirf,prima2-pl310-cache", .data = &prima2_l2x0_aux, },
 	{ .compatible = "sirf,marco-pl310-cache", .data = &marco_l2x0_aux, },
@@ -35,13 +20,10 @@ static const struct of_device_id sirf_l2x0_ids[] __initconst = {
 static int __init sirfsoc_l2x0_init(void)
 {
 	struct device_node *np;
-	const struct l2x0_aux *aux;
 
 	np = of_find_matching_node(NULL, sirf_l2x0_ids);
-	if (np) {
-		aux = of_match_node(sirf_l2x0_ids, np)->data;
-		return l2x0_of_init(aux->val, aux->mask);
-	}
+	if (np)
+		return l2x0_of_init(0, ~0);
 
 	return 0;
 }
-- 
1.8.3.1
