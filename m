From: pullip.cho@samsung.com (Cho KyongHo)
Date: Fri, 14 Mar 2014 14:02:54 +0900
Subject: [PATCH v11 04/27] iommu/exynos: fix L2TLB invalidation
Message-ID: <20140314140254.32dbc0cd8cde8f4ffcf71c9f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

L2TLB is 8-way set-associative TLB with 512 entries. The number of
sets is 64.
A single 4KB(small page) translation information is cached
only to a set whose index is the same with the lower 6 bits of the page
frame number.
A single 64KB(large page) translation information can be
cached to any 16 sets whose top two bits of their indices are the same
with the bit [5:4] of the page frame number.
A single 1MB(section) or larger translation information can be cached to
any set in the TLB.

It is required to invalidate entire sets that may cache the target
translation information to guarantee that the L2TLB has no stale data.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 4a74ed8..0d26aeb 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -225,9 +225,14 @@ static void __sysmmu_tlb_invalidate(void __iomem *sfrbase)
 }
 
 static void __sysmmu_tlb_invalidate_entry(void __iomem *sfrbase,
-						unsigned long iova)
+				unsigned long iova, unsigned int num_inv)
 {
-	__raw_writel((iova & SPAGE_MASK) | 1, sfrbase + REG_MMU_FLUSH_ENTRY);
+	unsigned int i;
+	for (i = 0; i < num_inv; i++) {
+		__raw_writel((iova & SPAGE_MASK) | 1,
+				sfrbase + REG_MMU_FLUSH_ENTRY);
+		iova += SPAGE_SIZE;
+	}
 }
 
 static void __sysmmu_set_ptbase(void __iomem *sfrbase,
@@ -477,7 +482,8 @@ static bool exynos_sysmmu_disable(struct device *dev)
 	return disabled;
 }
 
-static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
+static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
+					size_t size)
 {
 	unsigned long flags;
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
@@ -487,9 +493,24 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
 	if (is_sysmmu_active(data)) {
 		int i;
 		for (i = 0; i < data->nsfrs; i++) {
+			unsigned int maj;
+			unsigned int num_inv = 1;
+			maj = __raw_readl(data->sfrbases[i] + REG_MMU_VERSION);
+			/*
+			 * L2TLB invalidation required
+			 * 4KB page: 1 invalidation
+			 * 64KB page: 16 invalidation
+			 * 1MB page: 64 invalidation
+			 * because it is set-associative TLB
+			 * with 8-way and 64 sets.
+			 * 1MB page can be cached in one of all sets.
+			 * 64KB page can be one of 16 consecutive sets.
+			 */
+			if ((maj >> 28) == 2) /* major version number */
+				num_inv = min_t(unsigned int, size / PAGE_SIZE, 64);
 			if (sysmmu_block(data->sfrbases[i])) {
 				__sysmmu_tlb_invalidate_entry(
-						data->sfrbases[i], iova);
+					data->sfrbases[i], iova, num_inv);
 				sysmmu_unblock(data->sfrbases[i]);
 			}
 		}
@@ -999,7 +1020,7 @@ done:
 
 	spin_lock_irqsave(&priv->lock, flags);
 	list_for_each_entry(data, &priv->clients, node)
-		sysmmu_tlb_invalidate_entry(data->dev, iova);
+		sysmmu_tlb_invalidate_entry(data->dev, iova, size);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return size;
-- 
1.7.9.5
