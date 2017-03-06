From: rrichter@cavium.com (Robert Richter)
Date: Mon,  6 Mar 2017 13:57:38 +0100
Subject: [PATCH v2 7/8] irqchip/gic-v3-its: Handle its nodes as kernel devices
In-Reply-To: <20170306125739.19445-1-rrichter@cavium.com>
References: <20170306125739.19445-1-rrichter@cavium.com>
Message-ID: <20170306125739.19445-8-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manage its nodes as kernel devices. We can then use the kernel's
device resource management for memory allocation. Freeing memory
becomes much easier now. This also allows us to use CMA for the
allocation of large its tables.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 118 ++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 58 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c0eaae35c631..6625b3a505f0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -19,6 +19,7 @@
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
@@ -75,6 +76,7 @@ struct its_baser {
  * list of devices writing to it.
  */
 struct its_node {
+	struct device		dev;
 	struct fwnode_handle	*fwnode;
 	raw_spinlock_t		lock;
 	struct list_head	entry;
@@ -400,7 +402,7 @@ static struct its_cmd_block *its_allocate_entry(struct its_node *its)
 	while (its_queue_full(its)) {
 		count--;
 		if (!count) {
-			pr_err_ratelimited("ITS queue not draining\n");
+			dev_err_ratelimited(&its->dev, "ITS queue not draining\n");
 			return NULL;
 		}
 		cpu_relax();
@@ -460,7 +462,7 @@ static void its_wait_for_range_completion(struct its_node *its,
 
 		count--;
 		if (!count) {
-			pr_err_ratelimited("ITS queue timeout\n");
+			dev_err_ratelimited(&its->dev, "ITS queue timeout\n");
 			return;
 		}
 		cpu_relax();
@@ -480,7 +482,7 @@ static void its_send_single_command(struct its_node *its,
 
 	cmd = its_allocate_entry(its);
 	if (!cmd) {		/* We're soooooo screewed... */
-		pr_err_ratelimited("ITS can't allocate, dropping command\n");
+		dev_err_ratelimited(&its->dev, "ITS can't allocate, dropping command\n");
 		raw_spin_unlock_irqrestore(&its->lock, flags);
 		return;
 	}
@@ -490,7 +492,7 @@ static void its_send_single_command(struct its_node *its,
 	if (sync_col) {
 		sync_cmd = its_allocate_entry(its);
 		if (!sync_cmd) {
-			pr_err_ratelimited("ITS can't SYNC, skipping\n");
+			dev_err_ratelimited(&its->dev, "ITS can't SYNC, skipping\n");
 			goto post;
 		}
 		its_encode_cmd(sync_cmd, GITS_CMD_SYNC);
@@ -867,14 +869,15 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 retry_alloc_baser:
 	alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
 	if (alloc_pages > GITS_BASER_PAGES_MAX) {
-		pr_warn("ITS@%pa: %s too large, reduce ITS pages %u->%u\n",
-			&its->phys_base, its_base_type_string[type],
-			alloc_pages, GITS_BASER_PAGES_MAX);
+		dev_warn(&its->dev, "%s too large, reduce ITS pages %u->%u\n",
+			its_base_type_string[type], alloc_pages,
+			GITS_BASER_PAGES_MAX);
 		alloc_pages = GITS_BASER_PAGES_MAX;
 		order = get_order(GITS_BASER_PAGES_MAX * psz);
 	}
 
-	base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+	base = (void *)devm_get_free_pages(&its->dev, GFP_KERNEL | __GFP_ZERO,
+					   order);
 	if (!base)
 		return -ENOMEM;
 
@@ -926,7 +929,7 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		 * size and retry. If we reach 4K, then
 		 * something is horribly wrong...
 		 */
-		free_pages((unsigned long)base, order);
+		devm_free_pages(&its->dev, (unsigned long)base);
 		baser->base = NULL;
 
 		switch (psz) {
@@ -940,10 +943,9 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	}
 
 	if (val != tmp) {
-		pr_err("ITS@%pa: %s doesn't stick: %llx %llx\n",
-		       &its->phys_base, its_base_type_string[type],
-		       val, tmp);
-		free_pages((unsigned long)base, order);
+		dev_err(&its->dev, "%s doesn't stick: %llx %llx\n",
+		       its_base_type_string[type], val, tmp);
+		devm_free_pages(&its->dev, (unsigned long)base);
 		return -ENXIO;
 	}
 
@@ -952,8 +954,8 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	baser->psz = psz;
 	tmp = indirect ? GITS_LVL1_ENTRY_SIZE : esz;
 
-	pr_info("ITS@%pa: allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\n",
-		&its->phys_base, (int)(PAGE_ORDER_TO_SIZE(order) / (int)tmp),
+	dev_info(&its->dev, "allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\n",
+		(int)(PAGE_ORDER_TO_SIZE(order) / (int)tmp),
 		its_base_type_string[type],
 		(unsigned long)virt_to_phys(base),
 		indirect ? "indirect" : "flat", (int)esz,
@@ -1004,8 +1006,8 @@ static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser
 	if (new_order >= MAX_ORDER) {
 		new_order = MAX_ORDER - 1;
 		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
-		pr_warn("ITS@%pa: Device Table too large, reduce ids %u->%u\n",
-			&its->phys_base, its->device_ids, ids);
+		dev_warn(&its->dev, "Device Table too large, reduce ids %u->%u\n",
+			its->device_ids, ids);
 	}
 
 	*order = new_order;
@@ -1013,19 +1015,6 @@ static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser
 	return indirect;
 }
 
-static void its_free_tables(struct its_node *its)
-{
-	int i;
-
-	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
-		if (its->tables[i].base) {
-			free_pages((unsigned long)its->tables[i].base,
-				   its->tables[i].order);
-			its->tables[i].base = NULL;
-		}
-	}
-}
-
 static int its_alloc_tables(struct its_node *its)
 {
 	u64 typer = gic_read_typer(its->base + GITS_TYPER);
@@ -1060,10 +1049,8 @@ static int its_alloc_tables(struct its_node *its)
 			indirect = its_parse_baser_device(its, baser, psz, &order);
 
 		err = its_setup_baser(its, baser, cache, shr, psz, order, indirect);
-		if (err < 0) {
-			its_free_tables(its);
+		if (err < 0)
 			return err;
-		}
 
 		/* Update settings which will be used for next BASERn */
 		psz = baser->psz;
@@ -1347,6 +1334,9 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 
 	gic_flush_dcache_to_poc(itt, sz);
 
+	/* prevent its from being released */
+	get_device(&its->dev);
+
 	dev->its = its;
 	dev->itt = itt;
 	dev->nr_ites = nr_ites;
@@ -1656,8 +1646,9 @@ static int its_init_domain(struct its_node *its)
 	return 0;
 }
 
-static void its_free(struct its_node *its)
-{
+static void its_device_release(struct device *dev) {
+	struct its_node *its = container_of(dev, struct its_node, dev);
+
 	kfree(its);
 }
 
@@ -1694,34 +1685,47 @@ static int __init its_init_one(struct its_node *its)
 	u64 baser, tmp;
 	int err;
 
-	its_base = ioremap(its->phys_base, its->phys_size);
+	/* On error always use put_device() to free devices */
+	device_initialize(&its->dev);
+	its->dev.release = its_device_release;
+
+	err = dev_set_name(&its->dev, "its@%pa", &its->phys_base);
+	if (!err)
+		err = device_add(&its->dev);
+
+	if (err) {
+		pr_warn("ITS@%pa: Unable to register device\n", &its->phys_base);
+		return err;
+	}
+
+	its_base = devm_ioremap(&its->dev, its->phys_base, its->phys_size);
 	if (!its_base) {
-		pr_warn("ITS@%pa: Unable to map ITS registers\n", &its->phys_base);
+		dev_warn(&its->dev, "Unable to map ITS registers\n");
 		err = -ENOMEM;
 		goto fail;
 	}
 
 	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
 	if (val != 0x30 && val != 0x40) {
-		pr_warn("ITS@%pa: No ITS detected, giving up\n", &its->phys_base);
+		dev_warn(&its->dev, "No ITS detected, giving up\n");
 		err = -ENODEV;
-		goto out_unmap;
+		goto fail;
 	}
 
 	err = its_force_quiescent(its_base);
 	if (err) {
-		pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &its->phys_base);
-		goto out_unmap;
+		dev_warn(&its->dev, "Failed to quiesce, giving up\n");
+		goto fail;
 	}
 
 	its->base = its_base;
 	its->ite_size = ((gic_read_typer(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
 
-	its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						get_order(ITS_CMD_QUEUE_SZ));
+	its->cmd_base = (void *)devm_get_free_pages(&its->dev,
+		GFP_KERNEL | __GFP_ZERO, get_order(ITS_CMD_QUEUE_SZ));
 	if (!its->cmd_base) {
 		err = -ENOMEM;
-		goto out_unmap;
+		goto fail;
 	}
 	its->cmd_write = its->cmd_base;
 
@@ -1729,11 +1733,11 @@ static int __init its_init_one(struct its_node *its)
 
 	err = its_alloc_tables(its);
 	if (err)
-		goto out_free_cmd;
+		goto fail;
 
 	err = its_alloc_collections(its);
 	if (err)
-		goto out_free_tables;
+		goto fail;
 
 	baser = (virt_to_phys(its->cmd_base)	|
 		 GITS_CBASER_RaWaWb		|
@@ -1756,7 +1760,7 @@ static int __init its_init_one(struct its_node *its)
 			baser |= GITS_CBASER_nC;
 			gits_write_cbaser(baser, its->base + GITS_CBASER);
 		}
-		pr_info("ITS: using cache flushing for cmd queue\n");
+		dev_info(&its->dev, "using cache flushing for cmd queue\n");
 		its->flags |= ITS_FLAGS_CMDQ_NEEDS_FLUSHING;
 	}
 
@@ -1765,20 +1769,14 @@ static int __init its_init_one(struct its_node *its)
 
 	err = its_init_domain(its);
 	if (err)
-		goto out_free_tables;
+		goto fail;
 
-	pr_info("ITS@%pa: ITS node added\n", &its->phys_base);
+	dev_info(&its->dev, "ITS node added\n");
 
 	return 0;
-
-out_free_tables:
-	its_free_tables(its);
-out_free_cmd:
-	free_pages((unsigned long)its->cmd_base, get_order(ITS_CMD_QUEUE_SZ));
-out_unmap:
-	iounmap(its_base);
 fail:
-	pr_err("ITS@%pa: failed probing (%d)\n", &its->phys_base, err);
+	device_del(&its->dev);
+	dev_err(&its->dev, "failed probing (%d)\n", err);
 	return err;
 }
 
@@ -1912,6 +1910,10 @@ static int __init its_init(void)
 
 	spin_lock(&its_lock);
 
+	/*
+	 * Call this for all entries. We can then use put_device() to
+	 * release the nodes on error.
+	 */
 	list_for_each_entry(its, &its_nodes, entry) {
 		err2 = its_init_one(its);
 		if (!err && err2)
@@ -1923,7 +1925,7 @@ static int __init its_init(void)
 
 	list_for_each_entry_safe(its, tmp, &its_nodes, entry) {
 		list_del(&its->entry);
-		its_free(its);
+		put_device(&its->dev);
 	}
 unlock:
 	spin_unlock(&its_lock);
-- 
2.11.0
