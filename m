From: rrichter@cavium.com (Robert Richter)
Date: Thu, 15 Nov 2018 21:51:01 +0000
Subject: [PATCH 1/2] irqchip/gic-v3-its: Handle its nodes as kernel devices
In-Reply-To: <20181115215012.23922-1-rrichter@cavium.com>
References: <20181115215012.23922-1-rrichter@cavium.com>
Message-ID: <20181115215012.23922-2-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manage its nodes as kernel devices. We can then use the kernel's
device resource management for memory allocation. Freeing memory
becomes much easier now. This also allows us to use CMA for the
allocation of large its tables.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 123 +++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 64 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 13cf56c66483..a4b1b2fcb60f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -21,6 +21,7 @@
 #include <linux/cpu.h>
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/efi.h>
 #include <linux/interrupt.h>
@@ -99,6 +100,7 @@ struct its_device;
  * list of devices writing to it.
  */
 struct its_node {
+	struct device		dev;
 	raw_spinlock_t		lock;
 	struct list_head	entry;
 	void __iomem		*base;
@@ -697,7 +699,7 @@ static struct its_cmd_block *its_allocate_entry(struct its_node *its)
 	while (its_queue_full(its)) {
 		count--;
 		if (!count) {
-			pr_err_ratelimited("ITS queue not draining\n");
+			dev_err_ratelimited(&its->dev, "ITS queue not draining\n");
 			return NULL;
 		}
 		cpu_relax();
@@ -763,7 +765,7 @@ static int its_wait_for_range_completion(struct its_node *its,
 
 		count--;
 		if (!count) {
-			pr_err_ratelimited("ITS queue timeout (%llu %llu %llu)\n",
+			dev_err_ratelimited(&its->dev, "ITS queue timeout (%llu %llu %llu)\n",
 					   from_idx, to_idx, rd_idx);
 			return -1;
 		}
@@ -1744,14 +1746,15 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 retry_alloc_baser:
 	alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
 	if (alloc_pages > GITS_BASER_PAGES_MAX) {
-		pr_warn("ITS@%pa: %s too large, reduce ITS pages %u->%u\n",
-			&its->phys_base, its_base_type_string[type],
-			alloc_pages, GITS_BASER_PAGES_MAX);
+		dev_warn(&its->dev, "%s Table too large, reduce ITS pages %u->%u\n",
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
 
@@ -1819,7 +1822,7 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		 * size and retry. If we reach 4K, then
 		 * something is horribly wrong...
 		 */
-		free_pages((unsigned long)base, order);
+		devm_free_pages(&its->dev, (unsigned long)base);
 		baser->base = NULL;
 
 		switch (psz) {
@@ -1833,10 +1836,9 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
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
 
@@ -1845,8 +1847,8 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	baser->psz = psz;
 	tmp = indirect ? GITS_LVL1_ENTRY_SIZE : esz;
 
-	pr_info("ITS@%pa: allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\n",
-		&its->phys_base, (int)(PAGE_ORDER_TO_SIZE(order) / (int)tmp),
+	dev_info(&its->dev, "allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\n",
+		(int)(PAGE_ORDER_TO_SIZE(order) / (int)tmp),
 		its_base_type_string[type],
 		(unsigned long)virt_to_phys(base),
 		indirect ? "indirect" : "flat", (int)esz,
@@ -1899,9 +1901,8 @@ static bool its_parse_indirect_baser(struct its_node *its,
 	if (new_order >= MAX_ORDER) {
 		new_order = MAX_ORDER - 1;
 		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
-		pr_warn("ITS@%pa: %s Table too large, reduce ids %u->%u\n",
-			&its->phys_base, its_base_type_string[type],
-			its->device_ids, ids);
+		dev_warn(&its->dev, "%s Table too large, reduce ids %u->%u\n",
+			its_base_type_string[type], its->device_ids, ids);
 	}
 
 	*order = new_order;
@@ -1909,19 +1910,6 @@ static bool its_parse_indirect_baser(struct its_node *its,
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
 	u64 shr = GITS_BASER_InnerShareable;
@@ -1956,10 +1944,8 @@ static int its_alloc_tables(struct its_node *its)
 		}
 
 		err = its_setup_baser(its, baser, cache, shr, psz, order, indirect);
-		if (err < 0) {
-			its_free_tables(its);
+		if (err < 0)
 			return err;
-		}
 
 		/* Update settings which will be used for next BASERn */
 		psz = baser->psz;
@@ -2369,6 +2355,9 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 
 	gic_flush_dcache_to_poc(itt, sz);
 
+	/* prevent its from being released */
+	get_device(&its->dev);
+
 	dev->its = its;
 	dev->itt = itt;
 	dev->nr_ites = nr_ites;
@@ -2452,7 +2441,7 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 		 * another alias (PCI bridge of some sort). No need to
 		 * create the device.
 		 */
-		pr_debug("Reusing ITT for devID %x\n", dev_id);
+		dev_dbg(&its->dev, "Reusing ITT for devID %x\n", dev_id);
 		goto out;
 	}
 
@@ -2460,7 +2449,7 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 	if (!its_dev)
 		return -ENOMEM;
 
-	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
+	dev_dbg(&its->dev, "ITT %d entries, %d bits\n", nvec, ilog2(nvec));
 out:
 	info->scratchpad[0].ptr = its_dev;
 	return 0;
@@ -3481,8 +3470,9 @@ static int __init its_compute_its_list_map(struct its_node *its)
 	return its_number;
 }
 
-static void its_free(struct its_node *its)
-{
+static void its_device_release(struct device *dev) {
+	struct its_node *its = container_of(dev, struct its_node, dev);
+
 	kfree(its);
 }
 
@@ -3519,24 +3509,37 @@ static int __init its_init_one(struct its_node *its)
 	u64 baser, tmp, typer;
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
 
 	typer = gic_read_typer(its_base + GITS_TYPER);
@@ -3548,23 +3551,21 @@ static int __init its_init_one(struct its_node *its)
 		if (!(typer & GITS_TYPER_VMOVP)) {
 			err = its_compute_its_list_map(its);
 			if (err < 0)
-				goto out_unmap;
+				goto fail;
 
 			its->list_nr = err;
 
-			pr_info("ITS@%pa: Using ITS number %d\n",
-				&its->phys_base, err);
+			dev_info(&its->dev, "Using ITS number %d\n", err);
 		} else {
-			pr_info("ITS@%pa: Single VMOVP capable\n",
-				&its->phys_base);
+			dev_info(&its->dev, "Single VMOVP capable\n");
 		}
 	}
 
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
 	its->get_msi_base = its_irq_get_msi_base;
@@ -3574,11 +3575,11 @@ static int __init its_init_one(struct its_node *its)
 
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
@@ -3601,7 +3602,7 @@ static int __init its_init_one(struct its_node *its)
 			baser |= GITS_CBASER_nC;
 			gits_write_cbaser(baser, its->base + GITS_CBASER);
 		}
-		pr_info("ITS: using cache flushing for cmd queue\n");
+		dev_info(&its->dev, "using cache flushing for cmd queue\n");
 		its->flags |= ITS_FLAGS_CMDQ_NEEDS_FLUSHING;
 	}
 
@@ -3617,20 +3618,14 @@ static int __init its_init_one(struct its_node *its)
 
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
+	dev_err(&its->dev, "failed probing (%d)\n", err);
+	device_del(&its->dev);
 	return err;
 }
 
@@ -3939,7 +3934,7 @@ static int __init its_init(void)
 		/* Needs to be called in non-atomic context */
 		err = its_init_one(its);
 		if (err)
-			its_free(its);
+			put_device(&its->dev);
 
 		raw_spin_lock(&its_lock);
 
-- 
2.11.0
