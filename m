From: pullip.cho@samsung.com (Cho KyongHo)
Date: Fri, 05 Jul 2013 21:29:13 +0900
Subject: [PATCH v7 2/9] iommu/exynos: add missing cache flush for removed page
 table entries
Message-ID: <002a01ce797b$421b5970$c6520c50$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds cache flush for removed small and large page entries
in exynos_iommu_unmap(). Missing cache flush of removed page table
entries can cause missing page fault interrupt when a master IP
accesses an unmapped area.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 233f382..e3be3e5 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1002,6 +1002,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	if (lv2ent_small(ent)) {
 		*ent = 0;
 		size = SPAGE_SIZE;
+		pgtable_flush(ent, ent +1);
 		priv->lv2entcnt[lv1ent_offset(iova)] += 1;
 		goto done;
 	}
@@ -1010,6 +1011,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	BUG_ON(size < LPAGE_SIZE);
 
 	memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
+	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
 
 	size = LPAGE_SIZE;
 	priv->lv2entcnt[lv1ent_offset(iova)] += SPAGES_PER_LPAGE;
-- 
1.7.2.5
