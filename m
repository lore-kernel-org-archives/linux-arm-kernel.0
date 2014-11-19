From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 19 Nov 2014 12:15:32 +0100
Subject: [PATCH v3 03/19] arm: dma-mapping: add missing check for iommu
In-Reply-To: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1416395748-10731-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point trying to initialize dma_ops with
arm_get_iommu_dma_map_ops() if no iommu has been provided.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f15eae5e0513..68040fd62166 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2050,7 +2050,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 {
 	struct dma_map_ops *dma_ops;
 
-	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
+	if (iommu && arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
 		dma_ops = arm_get_iommu_dma_map_ops(coherent);
 	else
 		dma_ops = arm_get_dma_map_ops(coherent);
-- 
1.9.2
