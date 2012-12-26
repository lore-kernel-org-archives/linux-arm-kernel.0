From: pullip.cho@samsung.com (Cho KyongHo)
Date: Wed, 26 Dec 2012 10:53:22 +0900
Subject: [PATCH v6 01/12] iommu/exynos: add missing cache flush for removed
 pagetable entries
Message-ID: <003401cde30b$c99d7f60$5cd87e20$%cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds cache flush for removed small page and large page
entries in exynos_iommu_unmap(). Missing cache flush of removed
page table entries can cause missing page fault interrupt when a
master IP accesses an unmapped area.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7fe44f8..b96f3b9 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1002,6 +1002,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 
 	if (lv2ent_small(ent)) {
 		*ent = 0;
+		pgtable_flush(ent, ent + 1);
 		size = SPAGE_SIZE;
 		priv->lv2entcnt[lv1ent_offset(iova)] += 1;
 		goto done;
@@ -1011,6 +1012,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	BUG_ON(size < LPAGE_SIZE);
 
 	memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
+	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
 
 	size = LPAGE_SIZE;
 	priv->lv2entcnt[lv1ent_offset(iova)] += SPAGES_PER_LPAGE;
-- 
1.8.0
