From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 27 Jul 2015 13:29:26 +0100
Subject: [PATCH 08/18] iommu: tegra-smmu: store struct page pointer for page
 tables
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZJhX4-00047l-98@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Store the struct page pointer for the second level page tables, rather
than working back from the page directory entry.  This is necessary as
we want to eliminate the use of physical addresses used with
arch-private functions, switching instead to use the streaming DMA API.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iommu/tegra-smmu.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index bbff5b647183..8ec5ac45caab 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -41,6 +41,7 @@ struct tegra_smmu_as {
 	struct tegra_smmu *smmu;
 	unsigned int use_count;
 	struct page *count;
+	struct page **pts;
 	struct page *pd;
 	unsigned id;
 	u32 attr;
@@ -271,6 +272,14 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	as->pts = kcalloc(SMMU_NUM_PDE, sizeof(*as->pts), GFP_KERNEL);
+	if (!as->pts) {
+		__free_page(as->count);
+		__free_page(as->pd);
+		kfree(as);
+		return NULL;
+	}
+
 	/* clear PDEs */
 	pd = page_address(as->pd);
 	SetPageReserved(as->pd);
@@ -487,14 +496,11 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 {
 	unsigned int pd_index = iova_pd_index(iova);
 	struct page *pt_page;
-	u32 *pd;
 
-	pd = page_address(as->pd);
-
-	if (!pd[pd_index])
+	pt_page = as->pts[pd_index];
+	if (!pt_page)
 		return NULL;
 
-	pt_page = pfn_to_page(pd[pd_index] & as->smmu->pfn_mask);
 	*pagep = pt_page;
 
 	return tegra_smmu_pte_offset(pt_page, iova);
@@ -509,7 +515,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 	struct page *page;
 	unsigned int i;
 
-	if (pd[pde] == 0) {
+	if (!as->pts[pde]) {
 		page = alloc_page(GFP_KERNEL | __GFP_DMA);
 		if (!page)
 			return NULL;
@@ -520,6 +526,8 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		for (i = 0; i < SMMU_NUM_PTE; i++)
 			pt[i] = 0;
 
+		as->pts[pde] = page;
+
 		smmu->soc->ops->flush_dcache(page, 0, SMMU_SIZE_PT);
 
 		pd[pde] = SMMU_MK_PDE(page, SMMU_PDE_ATTR | SMMU_PDE_NEXT);
@@ -529,7 +537,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		smmu_flush_tlb_section(smmu, as->id, iova);
 		smmu_flush(smmu);
 	} else {
-		page = pfn_to_page(pd[pde] & smmu->pfn_mask);
+		page = as->pts[pde];
 	}
 
 	*pagep = page;
@@ -550,9 +558,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 	unsigned int pde = iova_pd_index(iova);
 	u32 *count = page_address(as->count);
 	u32 *pd = page_address(as->pd);
-	struct page *page;
-
-	page = pfn_to_page(pd[pde] & smmu->pfn_mask);
+	struct page *page = as->pts[pde];
 
 	/*
 	 * When no entries in this page table are used anymore, return the
@@ -573,6 +579,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 		/* Finally, free the page */
 		ClearPageReserved(page);
 		__free_page(page);
+		as->pts[pde] = NULL;
 	}
 }
 
-- 
2.1.0
