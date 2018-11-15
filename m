From: rrichter@cavium.com (Robert Richter)
Date: Thu, 15 Nov 2018 21:51:04 +0000
Subject: [PATCH 2/2] irqchip/gic-v3-its: Use CMA for allocation of large
 device tables
In-Reply-To: <20181115215012.23922-1-rrichter@cavium.com>
References: <20181115215012.23922-1-rrichter@cavium.com>
Message-ID: <20181115215012.23922-3-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gicv3-its device table may have a size of up to 16MB. With 4k
pagesize the maximum size of memory allocation is 4MB. Use CMA for
allocation of large tables.

We use the device managed version of dma_alloc_coherent(). Thus, we
don't need to release it manually on device removal.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 113 ++++++++++++++++++++++++++++-----------
 1 file changed, 82 insertions(+), 31 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a4b1b2fcb60f..6ba221aa27b9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
+#include <linux/dma-mapping.h>
 #include <linux/efi.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
@@ -1732,6 +1733,41 @@ static void its_write_baser(struct its_node *its, struct its_baser *baser,
 	baser->val = its_read_baser(its, baser);
 }
 
+static void *its_alloc_table(struct its_node *its, u32 order,
+			u64 *baser_phys)
+{
+	dma_addr_t dma_handle;
+	void *base;
+
+	if (order < MAX_ORDER) {
+		base = (void *)devm_get_free_pages(&its->dev,
+						GFP_KERNEL | __GFP_ZERO,
+						order);
+		*baser_phys = virt_to_phys(base);
+		return base;
+	}
+
+	/* try using CMA */
+	base = dmam_alloc_coherent(&its->dev,
+				PAGE_ORDER_TO_SIZE(order),
+				&dma_handle,
+				GFP_KERNEL | __GFP_ZERO);
+	*baser_phys = base ? dma_handle : 0;
+	return base;
+}
+
+static void its_free_table(struct its_node *its, u32 order, void *base,
+			u64 baser_phys)
+{
+	if (order < MAX_ORDER) {
+		devm_get_free_pages(&its->dev, GFP_KERNEL | __GFP_ZERO, order);
+		return;
+	}
+
+	dmam_free_coherent(&its->dev, PAGE_ORDER_TO_SIZE(order), base,
+			(dma_addr_t)baser_phys);
+}
+
 static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 			   u64 cache, u64 shr, u32 psz, u32 order,
 			   bool indirect)
@@ -1753,12 +1789,20 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		order = get_order(GITS_BASER_PAGES_MAX * psz);
 	}
 
-	base = (void *)devm_get_free_pages(&its->dev, GFP_KERNEL | __GFP_ZERO,
-					   order);
-	if (!base)
-		return -ENOMEM;
+	base = its_alloc_table(its, order, &baser_phys);
 
-	baser_phys = virt_to_phys(base);
+	if (!base && order >= MAX_ORDER) {
+		order = MAX_ORDER - 1;
+		dev_warn(&its->dev, "%s Table too large, reduce ids %u->%u, no CMA memory available\n",
+			its_base_type_string[type], its->device_ids,
+			ilog2(PAGE_ORDER_TO_SIZE(order) / (int)esz));
+		goto retry_alloc_baser;
+	}
+
+	if (!base) {
+		dev_err(&its->dev, "Failed to allocate device table\n");
+		return -ENOMEM;
+	}
 
 	/* Check if the physical address of the memory is above 48bits */
 	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES) && (baser_phys >> 48)) {
@@ -1816,29 +1860,27 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		goto retry_baser;
 	}
 
-	if ((val ^ tmp) & GITS_BASER_PAGE_SIZE_MASK) {
-		/*
-		 * Page size didn't stick. Let's try a smaller
-		 * size and retry. If we reach 4K, then
-		 * something is horribly wrong...
-		 */
-		devm_free_pages(&its->dev, (unsigned long)base);
-		baser->base = NULL;
-
-		switch (psz) {
-		case SZ_16K:
-			psz = SZ_4K;
-			goto retry_alloc_baser;
-		case SZ_64K:
-			psz = SZ_16K;
-			goto retry_alloc_baser;
+	if (val != tmp) {
+		its_free_table(its, order, base, baser_phys);
+
+		if ((val ^ tmp) & GITS_BASER_PAGE_SIZE_MASK) {
+			/*
+			 * Page size didn't stick. Let's try a smaller
+			 * size and retry. If we reach 4K, then
+			 * something is horribly wrong...
+			 */
+			switch (psz) {
+			case SZ_16K:
+				psz = SZ_4K;
+				goto retry_alloc_baser;
+			case SZ_64K:
+				psz = SZ_16K;
+				goto retry_alloc_baser;
+			}
 		}
-	}
 
-	if (val != tmp) {
 		dev_err(&its->dev, "%s doesn't stick: %llx %llx\n",
 		       its_base_type_string[type], val, tmp);
-		devm_free_pages(&its->dev, (unsigned long)base);
 		return -ENXIO;
 	}
 
@@ -1862,7 +1904,6 @@ static bool its_parse_indirect_baser(struct its_node *its,
 				     u32 psz, u32 *order, u32 ids)
 {
 	u64 tmp = its_read_baser(its, baser);
-	u64 type = GITS_BASER_TYPE(tmp);
 	u64 esz = GITS_BASER_ENTRY_SIZE(tmp);
 	u64 val = GITS_BASER_InnerShareable | GITS_BASER_RaWaWb;
 	u32 new_order = *order;
@@ -1898,12 +1939,6 @@ static bool its_parse_indirect_baser(struct its_node *its,
 	 * feature is not supported by hardware.
 	 */
 	new_order = max_t(u32, get_order(esz << ids), new_order);
-	if (new_order >= MAX_ORDER) {
-		new_order = MAX_ORDER - 1;
-		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
-		dev_warn(&its->dev, "%s Table too large, reduce ids %u->%u\n",
-			its_base_type_string[type], its->device_ids, ids);
-	}
 
 	*order = new_order;
 
@@ -3522,6 +3557,22 @@ static int __init its_init_one(struct its_node *its)
 		return err;
 	}
 
+	/*
+	 * Setup dma_ops to be used with dmam_alloc_coherent() for its
+	 * device table allocation. Since the device table is
+	 * exclusively used by the device only we can mark this mem as
+	 * coherent.
+	 */
+	arch_setup_dma_ops(&its->dev, 0, 0, NULL, true);
+
+	err = dma_coerce_mask_and_coherent(&its->dev, DMA_BIT_MASK(64));
+	if (err)
+		err = dma_coerce_mask_and_coherent(&its->dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_warn(&its->dev, "Unable to set DMA mask\n");
+		goto fail;
+	}
+
 	its_base = devm_ioremap(&its->dev, its->phys_base, its->phys_size);
 	if (!its_base) {
 		dev_warn(&its->dev, "Unable to map ITS registers\n");
-- 
2.11.0
