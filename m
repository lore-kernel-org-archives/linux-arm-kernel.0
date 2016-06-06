From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon,  6 Jun 2016 00:40:33 -0500
Subject: [PATCH V4 2/5] irqchip/gicv3-its: Add a new function for parsing
 device table BASERn
In-Reply-To: <1465191636-6823-1-git-send-email-shankerd@codeaurora.org>
References: <1465191636-6823-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <1465191636-6823-3-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only the device table BASERn needs to be handled differently as
compared to all other tables. So, adding a separate function for
easy code maintenance and improved code readability.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 49 +++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6392c82..4bd9381 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -836,6 +836,30 @@ static void its_write_baser(struct its_node *its, struct its_baser *baser,
 	writeq_relaxed(val, its->base + GITS_BASER + (baser->idx << 3));
 }
 
+static void its_parse_baser_device(struct its_node *its, struct its_baser *baser,
+				   u32 *order)
+{
+	u64 esz = GITS_BASER_ENTRY_SIZE(its_read_baser(its, baser));
+	u32 ids = its->device_ids;
+	u32 new_order = *order;
+
+	/*
+	 * Allocate as many entries as required to fit the
+	 * range of device IDs that the ITS can grok... The ID
+	 * space being incredibly sparse, this results in a
+	 * massive waste of memory.
+	 */
+	new_order = max_t(u32, get_order(esz << ids), new_order);
+	if (new_order >= MAX_ORDER) {
+		new_order = MAX_ORDER - 1;
+		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / esz);
+		pr_warn("ITS@%pa: Device Table too large, reduce ids %u->%u\n",
+			&its->phys_base, its->device_ids, ids);
+	}
+
+	*order = new_order;
+}
+
 static void its_free_tables(struct its_node *its)
 {
 	int i;
@@ -892,29 +916,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		if (type == GITS_BASER_TYPE_NONE)
 			continue;
 
-		/*
-		 * Allocate as many entries as required to fit the
-		 * range of device IDs that the ITS can grok... The ID
-		 * space being incredibly sparse, this results in a
-		 * massive waste of memory.
-		 *
-		 * For other tables, only allocate a single page.
-		 */
-		if (type == GITS_BASER_TYPE_DEVICE) {
-			/*
-			 * 'order' was initialized earlier to the default page
-			 * granule of the the ITS.  We can't have an allocation
-			 * smaller than that.  If the requested allocation
-			 * is smaller, round up to the default page granule.
-			 */
-			order = max(get_order((1UL << ids) * entry_size),
-				    order);
-			if (order >= MAX_ORDER) {
-				order = MAX_ORDER - 1;
-				pr_warn("%s: Device Table too large, reduce its page order to %u\n",
-					node_name, order);
-			}
-		}
+		if (type == GITS_BASER_TYPE_DEVICE)
+			its_parse_baser_device(its, baser, &order);
 
 retry_alloc_baser:
 		alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
