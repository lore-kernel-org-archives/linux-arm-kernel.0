From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 27 Jul 2015 13:29:57 +0100
Subject: [PATCH 14/18] iommu: tegra-smmu: remove PageReserved manipulation
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZJhXZ-00048L-5P@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the unnecessary manipulation of the PageReserved flags in the
Tegra SMMU driver.  None of this is required as the page(s) remain
private to the SMMU driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iommu/tegra-smmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index d4264e2bdd69..b826362ce96b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -295,7 +295,6 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 
 	/* clear PDEs */
 	pd = page_address(as->pd);
-	SetPageReserved(as->pd);
 
 	for (i = 0; i < SMMU_NUM_PDE; i++)
 		pd[i] = 0;
@@ -313,7 +312,6 @@ static void tegra_smmu_domain_free(struct iommu_domain *domain)
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 
 	/* TODO: free page directory and page tables */
-	ClearPageReserved(as->pd);
 
 	kfree(as);
 }
@@ -568,8 +566,6 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 
 		as->pts[pde] = page;
 
-		SetPageReserved(page);
-
 		pd[pde] = SMMU_MK_PDE(dma, SMMU_PDE_ATTR | SMMU_PDE_NEXT);
 
 		dma_sync_single_range_for_device(smmu->dev, as->pd_dma,
@@ -619,7 +615,6 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 
 		/* Finally, free the page */
 		dma_unmap_page(smmu->dev, pte_dma, SMMU_SIZE_PT, DMA_TO_DEVICE);
-		ClearPageReserved(page);
 		__free_page(page);
 		as->pts[pde] = NULL;
 	}
-- 
2.1.0
