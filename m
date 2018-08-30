From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 30 Aug 2018 13:31:13 +0300
Subject: [PATCH v1 1/2] irqchip/gic-v3: Switch to bitmap_zalloc()
Message-ID: <20180830103114.60601-1-andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 9 ++++-----
 drivers/irqchip/irq-gic-v3-mbi.c | 5 ++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 316a57530f6d..497589ebd950 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1577,7 +1577,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 	if (err)
 		goto out;
 
-	bitmap = kcalloc(BITS_TO_LONGS(nr_irqs), sizeof (long), GFP_ATOMIC);
+	bitmap = bitmap_zalloc(nr_irqs, GFP_ATOMIC);
 	if (!bitmap)
 		goto out;
 
@@ -1593,7 +1593,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 static void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
 {
 	WARN_ON(free_lpi_range(base, nr_ids));
-	kfree(bitmap);
+	bitmap_free(bitmap);
 }
 
 static struct page *its_allocate_prop_table(gfp_t gfp_flags)
@@ -2215,8 +2215,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	if (alloc_lpis) {
 		lpi_map = its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
 		if (lpi_map)
-			col_map = kcalloc(nr_lpis, sizeof(*col_map),
-					  GFP_KERNEL);
+			col_map = kcalloc(nr_lpis, sizeof(*col_map), GFP_KERNEL);
 	} else {
 		col_map = kcalloc(nr_ites, sizeof(*col_map), GFP_KERNEL);
 		nr_lpis = 0;
@@ -2226,7 +2225,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	if (!dev || !itt ||  !col_map || (!lpi_map && alloc_lpis)) {
 		kfree(dev);
 		kfree(itt);
-		kfree(lpi_map);
+		bitmap_free(lpi_map);
 		kfree(col_map);
 		return NULL;
 	}
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index ad70e7c416e3..7d783fc56169 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -284,8 +284,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
 		if (ret)
 			goto err_free_mbi;
 
-		mbi_ranges[n].bm = kcalloc(BITS_TO_LONGS(mbi_ranges[n].nr_spis),
-					   sizeof(long), GFP_KERNEL);
+		mbi_ranges[n].bm = bitmap_zalloc(mbi_ranges[n].nr_spis, GFP_KERNEL);
 		if (!mbi_ranges[n].bm) {
 			ret = -ENOMEM;
 			goto err_free_mbi;
@@ -323,7 +322,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
 err_free_mbi:
 	if (mbi_ranges) {
 		for (n = 0; n < mbi_range_nr; n++)
-			kfree(mbi_ranges[n].bm);
+			bitmap_free(mbi_ranges[n].bm);
 		kfree(mbi_ranges);
 	}
 
-- 
2.18.0
