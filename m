From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 27 Jul 2015 13:30:02 +0100
Subject: [PATCH 15/18] iommu: tegra-smmu: use __GFP_ZERO to allocate zeroed
 pages
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZJhXe-00048y-9l@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than explicitly zeroing pages allocated via alloc_page(), add
__GFP_ZERO to the gfp mask to ask the allocator for zeroed pages.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iommu/tegra-smmu.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index b826362ce96b..bc179c759805 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -260,8 +260,6 @@ static bool tegra_smmu_capable(enum iommu_cap cap)
 static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 {
 	struct tegra_smmu_as *as;
-	unsigned int i;
-	uint32_t *pd;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
@@ -272,7 +270,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 
 	as->attr = SMMU_PD_READABLE | SMMU_PD_WRITABLE | SMMU_PD_NONSECURE;
 
-	as->pd = alloc_page(GFP_KERNEL | __GFP_DMA);
+	as->pd = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
 	if (!as->pd) {
 		kfree(as);
 		return NULL;
@@ -293,12 +291,6 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
-	/* clear PDEs */
-	pd = page_address(as->pd);
-
-	for (i = 0; i < SMMU_NUM_PDE; i++)
-		pd[i] = 0;
-
 	/* setup aperture */
 	as->domain.geometry.aperture_start = 0;
 	as->domain.geometry.aperture_end = 0xffffffff;
@@ -535,21 +527,15 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 	u32 *pd = page_address(as->pd), *pt;
 	unsigned int pde = iova_pd_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
-	unsigned int i;
 
 	if (!as->pts[pde]) {
 		struct page *page;
 		dma_addr_t dma;
 
-		page = alloc_page(GFP_KERNEL | __GFP_DMA);
+		page = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
 		if (!page)
 			return NULL;
 
-		pt = page_address(page);
-
-		for (i = 0; i < SMMU_NUM_PTE; i++)
-			pt[i] = 0;
-
 		dma = dma_map_page(smmu->dev, page, 0, SMMU_SIZE_PT,
 				   DMA_TO_DEVICE);
 		if (dma_mapping_error(smmu->dev, dma)) {
-- 
2.1.0
