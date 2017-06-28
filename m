From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:03:28 +0100
Subject: [PATCH v2 09/52] irqchip/gic-v3-its: Allow use of indirect VCPU tables
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-10-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VCPU tables can be quite sparse as well, and it makes sense
to use indirect tables as well if possible.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2feecdf40216..27f57c528026 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1068,10 +1068,13 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	return 0;
 }
 
-static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser,
-				   u32 psz, u32 *order)
+static bool its_parse_indirect_baser(struct its_node *its,
+				     struct its_baser *baser,
+				     u32 psz, u32 *order)
 {
-	u64 esz = GITS_BASER_ENTRY_SIZE(its_read_baser(its, baser));
+	u64 tmp = its_read_baser(its, baser);
+	u64 type = GITS_BASER_TYPE(tmp);
+	u64 esz = GITS_BASER_ENTRY_SIZE(tmp);
 	u64 val = GITS_BASER_InnerShareable | GITS_BASER_RaWaWb;
 	u32 ids = its->device_ids;
 	u32 new_order = *order;
@@ -1110,8 +1113,9 @@ static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser
 	if (new_order >= MAX_ORDER) {
 		new_order = MAX_ORDER - 1;
 		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
-		pr_warn("ITS@%pa: Device Table too large, reduce ids %u->%u\n",
-			&its->phys_base, its->device_ids, ids);
+		pr_warn("ITS@%pa: %s Table too large, reduce ids %u->%u\n",
+			&its->phys_base, its_base_type_string[type],
+			its->device_ids, ids);
 	}
 
 	*order = new_order;
@@ -1159,11 +1163,16 @@ static int its_alloc_tables(struct its_node *its)
 		u32 order = get_order(psz);
 		bool indirect = false;
 
-		if (type == GITS_BASER_TYPE_NONE)
+		switch (type) {
+		case GITS_BASER_TYPE_NONE:
 			continue;
 
-		if (type == GITS_BASER_TYPE_DEVICE)
-			indirect = its_parse_baser_device(its, baser, psz, &order);
+		case GITS_BASER_TYPE_DEVICE:
+		case GITS_BASER_TYPE_VCPU:
+			indirect = its_parse_indirect_baser(its, baser,
+							    psz, &order);
+			break;
+		}
 
 		err = its_setup_baser(its, baser, cache, shr, psz, order, indirect);
 		if (err < 0) {
-- 
2.11.0
