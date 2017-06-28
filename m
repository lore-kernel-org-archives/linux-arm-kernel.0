From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:03:31 +0100
Subject: [PATCH v2 12/52] irqchip/gic-v3-its: Generalize device table
 allocation
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-13-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we want to use 2-level tables for VCPUs, let's hack the device
table allocator in order to make it slightly more generic. It
will get reused in subsequent patches.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3011403438c3..40682f2a5e1f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1383,26 +1383,19 @@ static struct its_baser *its_get_baser(struct its_node *its, u32 type)
 	return NULL;
 }
 
-static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
+static bool its_alloc_table_entry(struct its_baser *baser, u32 id)
 {
-	struct its_baser *baser;
 	struct page *page;
 	u32 esz, idx;
 	__le64 *table;
 
-	baser = its_get_baser(its, GITS_BASER_TYPE_DEVICE);
-
-	/* Don't allow device id that exceeds ITS hardware limit */
-	if (!baser)
-		return (ilog2(dev_id) < its->device_ids);
-
 	/* Don't allow device id that exceeds single, flat table limit */
 	esz = GITS_BASER_ENTRY_SIZE(baser->val);
 	if (!(baser->val & GITS_BASER_INDIRECT))
-		return (dev_id < (PAGE_ORDER_TO_SIZE(baser->order) / esz));
+		return (id < (PAGE_ORDER_TO_SIZE(baser->order) / esz));
 
 	/* Compute 1st level table index & check if that exceeds table limit */
-	idx = dev_id >> ilog2(baser->psz / esz);
+	idx = id >> ilog2(baser->psz / esz);
 	if (idx >= (PAGE_ORDER_TO_SIZE(baser->order) / GITS_LVL1_ENTRY_SIZE))
 		return false;
 
@@ -1431,6 +1424,19 @@ static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
 	return true;
 }
 
+static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
+{
+	struct its_baser *baser;
+
+	baser = its_get_baser(its, GITS_BASER_TYPE_DEVICE);
+
+	/* Don't allow device id that exceeds ITS hardware limit */
+	if (!baser)
+		return (ilog2(dev_id) < its->device_ids);
+
+	return its_alloc_table_entry(baser, dev_id);
+}
+
 static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 					    int nvecs)
 {
-- 
2.11.0
