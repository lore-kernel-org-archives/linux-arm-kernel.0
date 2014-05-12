From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Mon, 12 May 2014 11:44:48 +0530
Subject: [PATCH v13 03/19] iommu/exynos: allocate lv2 page table from own slab
In-Reply-To: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
References: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399875304-19948-4-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

Since kmalloc() does not guarantee that the allignment of 1KiB when it
allocates 1KiB, it is required to allocate lv2 page table from own
slab that guarantees alignment of 1KiB

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index aec7fd7..4ff4b0b 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -99,6 +99,8 @@
 #define REG_PB1_SADDR		0x054
 #define REG_PB1_EADDR		0x058
 
+static struct kmem_cache *lv2table_kmem_cache;
+
 static unsigned long *section_entry(unsigned long *pgtable, unsigned long iova)
 {
 	return pgtable + lv1ent_offset(iova);
@@ -637,7 +639,8 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
 		if (lv1ent_page(priv->pgtable + i))
-			kfree(phys_to_virt(lv2table_base(priv->pgtable + i)));
+			kmem_cache_free(lv2table_kmem_cache,
+				phys_to_virt(lv2table_base(priv->pgtable + i)));
 
 	free_pages((unsigned long)priv->pgtable, 2);
 	free_pages((unsigned long)priv->lv2entcnt, 1);
@@ -736,7 +739,7 @@ static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
 	if (lv1ent_fault(sent)) {
 		unsigned long *pent;
 
-		pent = kzalloc(LV2TABLE_SIZE, GFP_ATOMIC);
+		pent = kmem_cache_zalloc(lv2table_kmem_cache, GFP_ATOMIC);
 		BUG_ON((unsigned long)pent & (LV2TABLE_SIZE - 1));
 		if (!pent)
 			return ERR_PTR(-ENOMEM);
@@ -766,8 +769,7 @@ static int lv1set_section(unsigned long *sent, unsigned long iova,
 			return -EADDRINUSE;
 		}
 
-		kfree(page_entry(sent, 0));
-
+		kmem_cache_free(lv2table_kmem_cache, page_entry(sent, 0));
 		*pgcnt = 0;
 	}
 
@@ -970,11 +972,31 @@ static int __init exynos_iommu_init(void)
 {
 	int ret;
 
+	lv2table_kmem_cache = kmem_cache_create("exynos-iommu-lv2table",
+				LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
+	if (!lv2table_kmem_cache) {
+		pr_err("%s: Failed to create kmem cache\n", __func__);
+		return -ENOMEM;
+	}
+
 	ret = platform_driver_register(&exynos_sysmmu_driver);
+	if (ret) {
+		pr_err("%s: Failed to register driver\n", __func__);
+		goto err_reg_driver;
+	}
 
-	if (ret == 0)
-		bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
+	ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
+	if (ret) {
+		pr_err("%s: Failed to register exynos-iommu driver.\n",
+								__func__);
+		goto err_set_iommu;
+	}
 
+	return 0;
+err_set_iommu:
+	platform_driver_unregister(&exynos_sysmmu_driver);
+err_reg_driver:
+	kmem_cache_destroy(lv2table_kmem_cache);
 	return ret;
 }
 subsys_initcall(exynos_iommu_init);
-- 
1.7.9.5
