From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Sun, 27 Apr 2014 13:07:34 +0530
Subject: [PATCH v12 02/31] iommu/exynos: add missing cache flush for removed
 page table entries
In-Reply-To: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1398584283-22846-3-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

This commit adds cache flush for removed small and large page entries
in exynos_iommu_unmap(). Missing cache flush of removed page table
entries can cause missing page fault interrupt when a master IP
accesses an unmapped area.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Tested-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 46f0ca1..34e4273 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -957,6 +957,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	if (lv2ent_small(ent)) {
 		*ent = 0;
 		size = SPAGE_SIZE;
+		pgtable_flush(ent, ent + 1);
 		priv->lv2entcnt[lv1ent_offset(iova)] += 1;
 		goto done;
 	}
@@ -965,6 +966,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
 	BUG_ON(size < LPAGE_SIZE);
 
 	memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
+	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
 
 	size = LPAGE_SIZE;
 	priv->lv2entcnt[lv1ent_offset(iova)] += SPAGES_PER_LPAGE;
-- 
1.7.9.5
