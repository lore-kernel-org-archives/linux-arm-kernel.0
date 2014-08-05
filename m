From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Aug 2014 12:47:45 +0200
Subject: [PATCH 17/29] iommu: exynos: don't read version register on every tlb
 operation
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1407235677-26324-18-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes reading of REG_MMU_VERSION register on every tlb
operation and caches SYSMMU version in driver's internal data.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 64b3bc8..8927923 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -213,6 +213,7 @@ struct sysmmu_drvdata {
 	spinlock_t lock;
 	struct iommu_domain *domain;
 	phys_addr_t pgtable;
+	int version;
 };
 
 static bool set_sysmmu_active(struct sysmmu_drvdata *data)
@@ -239,11 +240,6 @@ static void sysmmu_unblock(void __iomem *sfrbase)
 	__raw_writel(CTRL_ENABLE, sfrbase + REG_MMU_CTRL);
 }
 
-static unsigned int __raw_sysmmu_version(struct sysmmu_drvdata *data)
-{
-	return MMU_RAW_VER(__raw_readl(data->sfrbase + REG_MMU_VERSION));
-}
-
 static bool sysmmu_block(void __iomem *sfrbase)
 {
 	int i = 120;
@@ -403,7 +399,7 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 	unsigned int cfg = CFG_LRU | CFG_QOS(15);
 	unsigned int ver;
 
-	ver = __raw_sysmmu_version(data);
+	ver = MMU_RAW_VER(__raw_readl(data->sfrbase + REG_MMU_VERSION));
 	if (MMU_MAJ_VER(ver) == 3) {
 		if (MMU_MIN_VER(ver) >= 2) {
 			cfg |= CFG_FLPDCACHE;
@@ -417,6 +413,7 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 	}
 
 	__raw_writel(cfg, data->sfrbase + REG_MMU_CFG);
+	data->version = ver;
 }
 
 static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
@@ -526,7 +523,7 @@ static bool exynos_sysmmu_disable(struct device *dev)
 static void __sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 					      sysmmu_iova_t iova)
 {
-	if (__raw_sysmmu_version(data) == MAKE_MMU_VER(3, 3))
+	if (data->version == MAKE_MMU_VER(3, 3))
 		__raw_writel(iova | 0x1, data->sfrbase + REG_MMU_FLUSH_ENTRY);
 }
 
@@ -575,7 +572,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
 		 * 1MB page can be cached in one of all sets.
 		 * 64KB page can be one of 16 consecutive sets.
 		 */
-		if (MMU_MAJ_VER(__raw_sysmmu_version(data)) == 2)
+		if (MMU_MAJ_VER(data->version) == 2)
 			num_inv = min_t(unsigned int, size / PAGE_SIZE, 64);
 
 		if (sysmmu_block(data->sfrbase)) {
-- 
1.9.2
