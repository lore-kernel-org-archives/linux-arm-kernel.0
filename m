From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon,  6 Jun 2016 18:17:32 -0500
Subject: [PATCH V5 5/5] irqchip/gicv3-its: Implement two-level(indirect)
 device table support
In-Reply-To: <1465255052-28045-1-git-send-email-shankerd@codeaurora.org>
References: <1465255052-28045-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <1465255052-28045-5-git-send-email-shankerd@codeaurora.org>
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

The feature is enabled automatically during driver probe if the memory
requirement is more than 2*ITS-pages and the hardware is capable of
two-level table walk.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
Changes since v3:
  Changed level-one table pointer type from 'u64 *' to '__le64 *'
  Addressed Marc's review omments.

Changes since v2:
  Fixed a porting bug device 'id' validation check in its_alloc_device_table()

Changes since v1:
  Most of this patch has been rewritten after refactoring its_alloc_tables().
  Always enable device two-level if the memory requirement is more than PAGE_SIZE.
  Fixed the coding bug that breaks on the BE machine.
  Edited the commit text.

 drivers/irqchip/irq-gic-v3-its.c   | 107 +++++++++++++++++++++++++++++++------
 include/linux/irqchip/arm-gic-v3.h |   3 ++
 2 files changed, 93 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7e1b9e0..92c2fc0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -848,7 +848,8 @@ static void its_write_baser_cache(struct its_node *its, struct its_baser *baser,
 }
 
 static int its_setup_baser(struct its_node *its, struct its_baser *baser,
-			   u64 cache, u64 shr, u32 psz, u32 order)
+			   u64 cache, u64 shr, u32 psz, u32 order,
+			   bool indirect)
 {
 	u64 val = its_read_baser(its, baser);
 	u64 esz = GITS_BASER_ENTRY_SIZE(val);
@@ -880,6 +881,8 @@ retry_baser:
 		shr						 |
 		GITS_BASER_VALID);
 
+	val |=	indirect ? GITS_BASER_INDIRECT : 0x0;
+
 	switch (psz) {
 	case SZ_4K:
 		val |= GITS_BASER_PAGE_SIZE_4K;
@@ -941,28 +944,55 @@ retry_baser:
 	baser->order = order;
 	baser->base = base;
 	baser->psz = psz;
+	tmp = indirect ? GITS_LVL1_ENTRY_SIZE : esz;
 
-	pr_info("ITS@%pa: allocated %d %s @%lx (psz %dK, shr %d)\n",
-		&its->phys_base, (int)(PAGE_ORDER_TO_SIZE(order) / esz),
+	pr_info("ITS@%pa: allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\n",
+		&its->phys_base, (int)(PAGE_ORDER_TO_SIZE(order) / tmp),
 		its_base_type_string[type],
 		(unsigned long)virt_to_phys(base),
+		indirect ? "indirect" : "flat", (int)esz,
 		psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);
 
 	return 0;
 }
 
-static void its_parse_baser_device(struct its_node *its, struct its_baser *baser,
-				   u32 *order)
+static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser,
+				   u32 psz, u32 *order)
 {
 	u64 esz = GITS_BASER_ENTRY_SIZE(its_read_baser(its, baser));
+	u64 val = GITS_BASER_InnerShareable | GITS_BASER_WaWb;
 	u32 ids = its->device_ids;
 	u32 new_order = *order;
+	bool indirect = false;
+
+	/* No need to enable Indirection if memory requirement < (psz*2)bytes */
+	if ((esz << ids) > (psz * 2)) {
+		/*
+		 * Find out whether hw supports a single or two-level table by
+		 * table by reading bit at offset '62' after writing '1' to it.
+		 */
+		its_write_baser_cache(its, baser, val | GITS_BASER_INDIRECT);
+		indirect = !!(baser->val & GITS_BASER_INDIRECT);
+
+		if (indirect) {
+			/*
+			 * The size of the lvl2 table is equal to ITS page size
+			 * which is 'psz'. For computing lvl1 table size,
+			 * subtract ID bits that sparse lvl2 table from 'ids'
+			 * which is reported by ITS hardware times lvl1 table
+			 * entry size.
+			 */
+			ids -= ilog2(psz / esz);
+			esz = GITS_LVL1_ENTRY_SIZE;
+		}
+	}
 
 	/*
 	 * Allocate as many entries as required to fit the
 	 * range of device IDs that the ITS can grok... The ID
 	 * space being incredibly sparse, this results in a
-	 * massive waste of memory.
+	 * massive waste of memory if two-level device table
+	 * feature is not supported by hardware.
 	 */
 	new_order = max_t(u32, get_order(esz << ids), new_order);
 	if (new_order >= MAX_ORDER) {
@@ -973,6 +1003,8 @@ static void its_parse_baser_device(struct its_node *its, struct its_baser *baser
 	}
 
 	*order = new_order;
+
+	return indirect;
 }
 
 static void its_free_tables(struct its_node *its)
@@ -1013,14 +1045,15 @@ static int its_alloc_tables(struct its_node *its)
 		u64 val = its_read_baser(its, baser);
 		u64 type = GITS_BASER_TYPE(val);
 		u32 order = get_order(psz);
+		bool indirect = false;
 
 		if (type == GITS_BASER_TYPE_NONE)
 			continue;
 
 		if (type == GITS_BASER_TYPE_DEVICE)
-			its_parse_baser_device(its, baser, &order);
+			indirect = its_parse_baser_device(its, baser, psz, &order);
 
-		err = its_setup_baser(its, baser, cache, shr, psz, order);
+		err = its_setup_baser(its, baser, cache, shr, psz, order, indirect);
 		if (err < 0) {
 			its_free_tables(its);
 			return err;
@@ -1220,10 +1253,57 @@ static struct its_baser *its_get_baser(struct its_node *its, u32 type)
 	return NULL;
 }
 
+static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
+{
+	struct its_baser *baser;
+	struct page *page;
+	u32 esz, idx;
+	__le64 *table;
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
+		/* Flush Lvl2 table to PoC if hw doesn't support coherency */
+		if (!(baser->val & GITS_BASER_SHAREABILITY_MASK))
+			__flush_dcache_area(page_address(page), baser->psz);
+
+		table[idx] = cpu_to_le64(page_to_phys(page) | GITS_BASER_VALID);
+
+		/* Flush Lvl1 entry to PoC if hw doesn't support coherency */
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
@@ -1234,14 +1314,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
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
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 01cf171..107eed4 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -204,6 +204,7 @@
 #define GITS_BASER_NR_REGS		8
 
 #define GITS_BASER_VALID		(1UL << 63)
+#define GITS_BASER_INDIRECT		(1UL << 62)
 #define GITS_BASER_nCnB			(0UL << 59)
 #define GITS_BASER_nC			(1UL << 59)
 #define GITS_BASER_RaWt			(2UL << 59)
@@ -239,6 +240,8 @@
 #define GITS_BASER_TYPE_RESERVED6	6
 #define GITS_BASER_TYPE_RESERVED7	7
 
+#define GITS_LVL1_ENTRY_SIZE           (8UL)
+
 /*
  * ITS commands
  */
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
