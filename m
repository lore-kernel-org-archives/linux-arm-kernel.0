From: rrichter@cavium.com (Robert Richter)
Date: Wed, 1 Feb 2017 18:38:33 +0100
Subject: [PATCH 9/9] irqchip, gicv3-its,
 cma: Use CMA for allocation of large device tables
In-Reply-To: <20170201173833.12630-1-rrichter@cavium.com>
References: <20170201173833.12630-1-rrichter@cavium.com>
Message-ID: <20170201173833.12630-10-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gicv3-its device table may have a size of up to 16MB. With 4k
pagesize the maximum size of memory allocation is 4MB. Use CMA for
allocation of large tables.

We use the device managed version of dma_alloc_coherent(). Thus, we
don't need to release it manually on device removal.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 69 +++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 86b8b9f79f68..e44547c7a2d2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
+#include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/acpi_iort.h>
@@ -860,6 +861,7 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	u64 type = GITS_BASER_TYPE(val);
 	u32 alloc_pages;
 	void *base;
+	dma_addr_t dma_handle;
 	u64 tmp;
 
 retry_alloc_baser:
@@ -872,13 +874,26 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		order = get_order(GITS_BASER_PAGES_MAX * psz);
 	}
 
-	base = (void *)devm_get_free_pages(&its->dev, GFP_KERNEL | __GFP_ZERO,
-					   order);
-	if (!base)
+	base = dmam_alloc_coherent(&its->dev,
+				PAGE_ORDER_TO_SIZE(order),
+				&dma_handle,
+				GFP_KERNEL | __GFP_ZERO);
+
+	if (!base && order >= MAX_ORDER) {
+		order = MAX_ORDER - 1;
+		dev_warn(&its->dev, "Device Table too large, reduce ids %u->%u, no CMA memory available\n",
+			its->device_ids,
+			ilog2(PAGE_ORDER_TO_SIZE(order) / (int)esz));
+		goto retry_alloc_baser;
+	}
+
+	if (!base) {
+		dev_err(&its->dev, "Failed to allocate device table\n");
 		return -ENOMEM;
+	}
 
 retry_baser:
-	val = (virt_to_phys(base)				 |
+	val = (dma_handle					 |
 		(type << GITS_BASER_TYPE_SHIFT)			 |
 		((esz - 1) << GITS_BASER_ENTRY_SIZE_SHIFT)	 |
 		((alloc_pages - 1) << GITS_BASER_PAGES_SHIFT)	 |
@@ -919,29 +934,28 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
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
+		dmam_free_coherent(&its->dev, PAGE_ORDER_TO_SIZE(order),
+				base, dma_handle);
+
+		if (GITS_BASER_PAGE_SIZE_MASK) {
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
 
@@ -999,12 +1013,6 @@ static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser
 	 * feature is not supported by hardware.
 	 */
 	new_order = max_t(u32, get_order(esz << ids), new_order);
-	if (new_order >= MAX_ORDER) {
-		new_order = MAX_ORDER - 1;
-		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
-		dev_warn(&its->dev, "Device Table too large, reduce ids %u->%u\n",
-			its->device_ids, ids);
-	}
 
 	*order = new_order;
 
@@ -1691,6 +1699,9 @@ static int __init its_init_one(struct its_node *its)
 		return err;
 	}
 
+	/* Setup dma_ops for dmam_alloc_coherent() */
+	arch_setup_dma_ops(&its->dev, 0, 0, NULL, true);
+
 	its_base = devm_ioremap(&its->dev, its->phys_base, its->phys_size);
 	if (!its_base) {
 		dev_warn(&its->dev, "Unable to map ITS registers\n");
-- 
2.11.0
