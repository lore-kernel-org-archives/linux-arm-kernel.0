From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon,  9 May 2016 15:58:26 -0500
Subject: [PATCH V3 2/2] irqchip/gicv3-its: Implement two-level(indirect)
 device table support
In-Reply-To: <1462827506-23570-1-git-send-email-shankerd@codeaurora.org>
References: <1462827506-23570-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <1462827506-23570-3-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since device IDs are extremely sparse, the single, a.k.a flat table is
not sufficient for the following two reasons.

1) According to ARM-GIC spec, ITS hw can access maximum of 256(pages)*
   64K(pageszie) bytes. In the best case, it supports upto DEVid=21
   sparse with minimum device table entry size 8bytes.

2) The maximum memory size that is possible without memblock depends on
   MAX_ORDER. 4MB on 4K page size kernel with default MAX_ORDER, so it
   supports DEVid range 19bits.

The two-level device table feature brings us two advantages, the first
is a very high possibility of supporting upto 32bit sparse, and the
second one is the best utilization of memory allocation.

The feature is enabled automatically during driver probe if a single
ITS page is not adequate for flat table and the hardware is capable
of two-level table walk.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---

Changes since v2:
  Fixed a porting bug device 'id' validation check in its_alloc_device_table()

Changes since v1:
  Most of this patch has been rewritten after refactoring its_alloc_tables().
  Always enable device two-level if the memory requirement is more than PAGE_SIZE.
  Fixed the coding bug that breaks on the BE machine.
  Edited the commit text.

 drivers/irqchip/irq-gic-v3-its.c | 97 +++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b23e00c..60a1060 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -938,6 +938,18 @@ retry_baser:
 	return 0;
 }
 
+/**
+ * Find out whether an implemented baser register supports a single, flat table
+ * or a two-level table by reading bit offset at '62' after writing '1' to it.
+ */
+static u64 its_baser_check_indirect(struct its_baser *baser)
+{
+	u64 val = GITS_BASER_InnerShareable | GITS_BASER_WaWb;
+
+	writeq_relaxed(val | GITS_BASER_INDIRECT, baser->hwreg);
+	return (readq_relaxed(baser->hwreg) & GITS_BASER_INDIRECT);
+}
+
 static int its_alloc_tables(const char *node_name, struct its_node *its)
 {
 	u64 typer = readq_relaxed(its->base + GITS_TYPER);
@@ -964,6 +976,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
 		int order = get_order(psz);
 		struct its_baser *baser = its->tables + i;
+		u64 indirect = 0;
 
 		if (type == GITS_BASER_TYPE_NONE)
 			continue;
@@ -977,17 +990,27 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		 * Allocate as many entries as required to fit the
 		 * range of device IDs that the ITS can grok... The ID
 		 * space being incredibly sparse, this results in a
-		 * massive waste of memory.
+		 * massive waste of memory if two-level device table
+		 * feature is not supported by hardware.
 		 *
 		 * For other tables, only allocate a single page.
 		 */
 		if (type == GITS_BASER_TYPE_DEVICE) {
-			/*
-			 * 'order' was initialized earlier to the default page
-			 * granule of the the ITS.  We can't have an allocation
-			 * smaller than that.  If the requested allocation
-			 * is smaller, round up to the default page granule.
-			 */
+			if ((entry_size << ids) > psz)
+				indirect = its_baser_check_indirect(baser);
+
+			if (indirect) {
+				/*
+				 * The size of the lvl2 table is equal to ITS
+				 * page size which is 'psz'. For computing lvl1
+				 * table size, subtract ID bits that sparse
+				 * lvl2 table from 'ids' which is reported by
+				 * ITS hardware times lvl1 table entry size.
+				 */
+				ids -= ilog2(psz / entry_size);
+				entry_size = GITS_LVL1_ENTRY_SIZE;
+			}
+
 			order = max(get_order(entry_size << ids), order);
 			if (order >= MAX_ORDER) {
 				order = MAX_ORDER - 1;
@@ -997,7 +1020,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 			}
 		}
 
-		err = its_baser_setup(its, baser, order, 0);
+		err = its_baser_setup(its, baser, order, indirect);
 		if (err < 0) {
 			its_free_tables(its);
 			return err;
@@ -1187,10 +1210,57 @@ static struct its_baser *its_get_baser(struct its_node *its, u32 type)
 	return NULL;
 }
 
+static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
+{
+	struct its_baser *baser;
+	struct page *page;
+	u32 esz, idx;
+	u64 *table;
+
+	baser = its_get_baser(its, GITS_BASER_TYPE_DEVICE);
+
+	/* Don't allow device id that exceeds ITS hardware limit */
+	if (!baser)
+		return (ilog2(dev_id) < its->device_ids);
+
+	/* Don't allow device id that exceeds single, flat table limit */
+	esz = GITS_BASER_ENTRY_SIZE(baser->val);
+	if (!(baser->val & GITS_BASER_INDIRECT))
+		return (dev_id < (PAGE_ORDER_TO_SIZE(baser->order) / esz));
+
+	/* Compute 1st level table index & check if that exceeds table limit */
+	idx = dev_id >> ilog2(baser->psz / esz);
+	if (idx >= (PAGE_ORDER_TO_SIZE(baser->order) / GITS_LVL1_ENTRY_SIZE))
+		return false;
+
+	table = baser->base;
+
+	/* Allocate memory for 2nd level table */
+	if (!table[idx]) {
+		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(baser->psz));
+		if (!page)
+			return false;
+
+		/* Flush memory to PoC if hardware doesn't support coherency */
+		if (!(baser->val & GITS_BASER_SHAREABILITY_MASK))
+			__flush_dcache_area(page_address(page), baser->psz);
+
+		table[idx] = cpu_to_le64(page_to_phys(page) | GITS_BASER_VALID);
+
+		/* Flush memory to PoC if hardware doesn't support coherency */
+		if (!(baser->val & GITS_BASER_SHAREABILITY_MASK))
+			__flush_dcache_area(table + idx, GITS_LVL1_ENTRY_SIZE);
+
+		/* Ensure updated table contents are visible to ITS hardware */
+		dsb(sy);
+	}
+
+	return true;
+}
+
 static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 					    int nvecs)
 {
-	struct its_baser *baser;
 	struct its_device *dev;
 	unsigned long *lpi_map;
 	unsigned long flags;
@@ -1201,14 +1271,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	int nr_ites;
 	int sz;
 
-	baser = its_get_baser(its, GITS_BASER_TYPE_DEVICE);
-
-	/* Don't allow 'dev_id' that exceeds single, flat table limit */
-	if (baser) {
-		if (dev_id >= (PAGE_ORDER_TO_SIZE(baser->order) /
-			      GITS_BASER_ENTRY_SIZE(baser->val)))
-			return NULL;
-	} else if (ilog2(dev_id) >= its->device_ids)
+	if (!its_alloc_device_table(its, dev_id))
 		return NULL;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
