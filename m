From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Mon, 12 May 2014 11:44:50 +0530
Subject: [PATCH v13 05/19] iommu/exynos: remove prefetch buffer setting
In-Reply-To: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
References: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399875304-19948-6-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

Prefetch buffer is a cache of System MMU 3.x and caches a block of
page table entries to make effect of larger page with small pages.
However, how to control prefetch buffers and the specifications of
prefetch buffers different from minor versions of System MMU v3.
Prefetch buffers must be controled with care because there are some
restrictions in H/W design.

The interface and implementation to initiate prefetch buffers will
be prepared later.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 06fc70e..4fc31fc 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -245,13 +245,6 @@ static void __sysmmu_set_ptbase(void __iomem *sfrbase,
 	__sysmmu_tlb_invalidate(sfrbase);
 }
 
-static void __sysmmu_set_prefbuf(void __iomem *sfrbase, unsigned long base,
-						unsigned long size, int idx)
-{
-	__raw_writel(base, sfrbase + REG_PB0_SADDR + idx * 8);
-	__raw_writel(size - 1 + base,  sfrbase + REG_PB0_EADDR + idx * 8);
-}
-
 static void __set_fault_handler(struct sysmmu_drvdata *data,
 					sysmmu_fault_handler_t handler)
 {
@@ -401,13 +394,6 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 	data->pgtable = pgtable;
 
 	__sysmmu_set_ptbase(data->sfrbase, pgtable);
-	if ((readl(data->sfrbase + REG_MMU_VERSION) >> 28) == 3) {
-		/* System MMU version is 3.x */
-		__raw_writel((1 << 12) | (2 << 28),
-				data->sfrbase + REG_MMU_CFG);
-		__sysmmu_set_prefbuf(data->sfrbase, 0, -1, 0);
-		__sysmmu_set_prefbuf(data->sfrbase, 0, -1, 1);
-	}
 
 	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 
-- 
1.7.9.5
