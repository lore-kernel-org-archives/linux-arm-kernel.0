From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 31 May 2018 15:42:43 +0800
Subject: [PATCH 1/7] iommu/dma: fix trival coding style mistake
In-Reply-To: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1527752569-18020-2-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The static function iova_reserve_iommu_regions is only called by function
iommu_dma_init_domain, and the 'if (!dev)' check in iommu_dma_init_domain
affect it only, so we can safely move the check into it. I think it looks
more natural.

In addition, the local variable 'ret' is only assigned in the branch of
'if (region->type == IOMMU_RESV_MSI)', so the 'if (ret)' should also only
take effect in the branch, add a brace to enclose it.

No functional changes.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/dma-iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ddcbbdb..4e885f7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -231,6 +231,9 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	LIST_HEAD(resv_regions);
 	int ret = 0;
 
+	if (!dev)
+		return 0;
+
 	if (dev_is_pci(dev))
 		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
 
@@ -246,11 +249,12 @@ static int iova_reserve_iommu_regions(struct device *dev,
 		hi = iova_pfn(iovad, region->start + region->length - 1);
 		reserve_iova(iovad, lo, hi);
 
-		if (region->type == IOMMU_RESV_MSI)
+		if (region->type == IOMMU_RESV_MSI) {
 			ret = cookie_init_hw_msi_region(cookie, region->start,
 					region->start + region->length);
-		if (ret)
-			break;
+			if (ret)
+				break;
+		}
 	}
 	iommu_put_resv_regions(dev, &resv_regions);
 
@@ -308,8 +312,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
-	if (!dev)
-		return 0;
 
 	return iova_reserve_iommu_regions(dev, domain);
 }
-- 
1.8.3
