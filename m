From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sun, 25 Jun 2017 10:46:09 -0500
Subject: [PATCH] irqchip: gicv3-its: Use NUMA aware memory allocation for ITS
 tables
Message-ID: <1498405569-463-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NUMA node information is visible to ITS driver but not being used
other than handling errata. This patch allocates the memory for ITS
tables from the corresponding NUMA node using the appropriate NUMA
aware functions.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fed99c5..e45add2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -860,8 +860,8 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	u64 val = its_read_baser(its, baser);
 	u64 esz = GITS_BASER_ENTRY_SIZE(val);
 	u64 type = GITS_BASER_TYPE(val);
+	struct page *page;
 	u32 alloc_pages;
-	void *base;
 	u64 tmp;
 
 retry_alloc_baser:
@@ -874,12 +874,12 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		order = get_order(GITS_BASER_PAGES_MAX * psz);
 	}
 
-	base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!base)
+	page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO, order);
+	if (!page)
 		return -ENOMEM;
 
 retry_baser:
-	val = (virt_to_phys(base)				 |
+	val = (page_to_phys(page)				 |
 		(type << GITS_BASER_TYPE_SHIFT)			 |
 		((esz - 1) << GITS_BASER_ENTRY_SIZE_SHIFT)	 |
 		((alloc_pages - 1) << GITS_BASER_PAGES_SHIFT)	 |
@@ -915,7 +915,8 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		shr = tmp & GITS_BASER_SHAREABILITY_MASK;
 		if (!shr) {
 			cache = GITS_BASER_nC;
-			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
+			gic_flush_dcache_to_poc(page_to_virt(page),
+						PAGE_ORDER_TO_SIZE(order));
 		}
 		goto retry_baser;
 	}
@@ -926,7 +927,7 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		 * size and retry. If we reach 4K, then
 		 * something is horribly wrong...
 		 */
-		free_pages((unsigned long)base, order);
+		__free_pages(page, order);
 		baser->base = NULL;
 
 		switch (psz) {
@@ -943,19 +944,19 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		pr_err("ITS@%pa: %s doesn't stick: %llx %llx\n",
 		       &its->phys_base, its_base_type_string[type],
 		       val, tmp);
-		free_pages((unsigned long)base, order);
+		__free_pages(page, order);
 		return -ENXIO;
 	}
 
 	baser->order = order;
-	baser->base = base;
+	baser->base = page_to_virt(page);
 	baser->psz = psz;
 	tmp = indirect ? GITS_LVL1_ENTRY_SIZE : esz;
 
 	pr_info("ITS@%pa: allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\n",
 		&its->phys_base, (int)(PAGE_ORDER_TO_SIZE(order) / (int)tmp),
 		its_base_type_string[type],
-		(unsigned long)virt_to_phys(base),
+		(unsigned long)page_to_phys(page),
 		indirect ? "indirect" : "flat", (int)esz,
 		psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);
 
@@ -1019,7 +1020,7 @@ static void its_free_tables(struct its_node *its)
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
 		if (its->tables[i].base) {
-			free_pages((unsigned long)its->tables[i].base,
+			__free_pages(virt_to_page(its->tables[i].base),
 				   its->tables[i].order);
 			its->tables[i].base = NULL;
 		}
@@ -1286,7 +1287,8 @@ static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
 
 	/* Allocate memory for 2nd level table */
 	if (!table[idx]) {
-		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(baser->psz));
+		page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
+					get_order(baser->psz));
 		if (!page)
 			return false;
 
@@ -1332,7 +1334,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
-	itt = kzalloc(sz, GFP_KERNEL);
+	itt = kzalloc_node(sz, GFP_KERNEL, its->numa_node);
 	lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
 	if (lpi_map)
 		col_map = kzalloc(sizeof(*col_map) * nr_lpis, GFP_KERNEL);
@@ -1677,6 +1679,7 @@ static int __init its_probe_one(struct resource *res,
 {
 	struct its_node *its;
 	void __iomem *its_base;
+	struct page *page;
 	u32 val;
 	u64 baser, tmp;
 	int err;
@@ -1716,12 +1719,13 @@ static int __init its_probe_one(struct resource *res,
 	its->ite_size = ((gic_read_typer(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
 	its->numa_node = numa_node;
 
-	its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						get_order(ITS_CMD_QUEUE_SZ));
-	if (!its->cmd_base) {
+	page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
+				get_order(ITS_CMD_QUEUE_SZ));
+	if (!page) {
 		err = -ENOMEM;
 		goto out_free_its;
 	}
+	its->cmd_base = page_to_virt(page);
 	its->cmd_write = its->cmd_base;
 
 	its_enable_quirks(its);
@@ -1775,7 +1779,7 @@ static int __init its_probe_one(struct resource *res,
 out_free_tables:
 	its_free_tables(its);
 out_free_cmd:
-	free_pages((unsigned long)its->cmd_base, get_order(ITS_CMD_QUEUE_SZ));
+	__free_pages(virt_to_page(its->cmd_base), get_order(ITS_CMD_QUEUE_SZ));
 out_free_its:
 	kfree(its);
 out_unmap:
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
