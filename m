From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 21 Oct 2016 10:36:35 +0100
Subject: [RFC PATCH 2/8] irqchip/gic-v3-its: narrow down Entry Size when used
 as a divider
In-Reply-To: <1477042601-15227-1-git-send-email-vladimir.murzin@arm.com>
References: <1477042601-15227-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1477042601-15227-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GITS_BASER<n>'s Entry Size is much smaller than 64-bit, but when it
used as a divider it forces compiler to generate __aeabi_uldivmod if
build in 32-bit mode. So, casting it to int (like it is done in other
places) where used as a divider would give a hint to compiler that
32-bit division can be used.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index dcc8c76..e992b01 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -948,7 +948,7 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	tmp = indirect ? GITS_LVL1_ENTRY_SIZE : esz;
 
 	pr_info("ITS@%pa: allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\n",
-		&its->phys_base, (int)(PAGE_ORDER_TO_SIZE(order) / tmp),
+		&its->phys_base, (int)(PAGE_ORDER_TO_SIZE(order) / (int)tmp),
 		its_base_type_string[type],
 		(unsigned long)virt_to_phys(base),
 		indirect ? "indirect" : "flat", (int)esz,
@@ -983,7 +983,7 @@ static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser
 			 * which is reported by ITS hardware times lvl1 table
 			 * entry size.
 			 */
-			ids -= ilog2(psz / esz);
+			ids -= ilog2(psz / (int)esz);
 			esz = GITS_LVL1_ENTRY_SIZE;
 		}
 	}
@@ -998,7 +998,7 @@ static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser
 	new_order = max_t(u32, get_order(esz << ids), new_order);
 	if (new_order >= MAX_ORDER) {
 		new_order = MAX_ORDER - 1;
-		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / esz);
+		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
 		pr_warn("ITS@%pa: Device Table too large, reduce ids %u->%u\n",
 			&its->phys_base, its->device_ids, ids);
 	}
-- 
1.7.9.5
