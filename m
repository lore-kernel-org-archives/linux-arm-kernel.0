From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 26 Oct 2016 19:19:31 +0100
Subject: [PATCH] arm64: Remove pointless WARN_ON in DMA teardown
Message-ID: <74f5ae2ead8bb8fa9fabcf88b5962885b29eb2d5.1477505971.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We expect arch_teardown_dma_ops() to be called very late in a device's
life, after it has been removed from its bus, and thus after the IOMMU
bus notifier has run. As such, even if this funny little check did make
sense, it's unlikely to achieve what it thinks it's trying to do anyway.
It's a residual trace of an earlier implementation which didn't belong
here from the start; belatedly snuff it out.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 5cd0a383b14b..290a84f3351f 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -940,11 +940,6 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 void arch_teardown_dma_ops(struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-
-	if (WARN_ON(domain))
-		iommu_detach_device(domain, dev);
-
 	dev->archdata.dma_ops = NULL;
 }
 
-- 
1.9.1
