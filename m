From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 27 Jul 2015 13:30:07 +0100
Subject: [PATCH 16/18] iommu: tegra-smmu: get_use
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZJhXj-0004CY-DQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iommu/tegra-smmu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index bc179c759805..8bf38b95cdd5 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -524,7 +524,7 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		       dma_addr_t *dmap)
 {
-	u32 *pd = page_address(as->pd), *pt;
+	u32 *pd = page_address(as->pd);
 	unsigned int pde = iova_pd_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
 
@@ -565,13 +565,14 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		*dmap = smmu_pde_to_dma(pd[pde]);
 	}
 
-	pt = page_address(as->pts[pde]);
+	return tegra_smmu_pte_offset(as->pts[pde], iova);
+}
 
-	/* Keep track of entries in this page table. */
-	if (pt[iova_pt_index(iova)] == 0)
-		as->count[pde]++;
+static void tegra_smmu_pte_get_use(struct tegra_smmu_as *as, unsigned long iova)
+{
+	unsigned int pd_index = iova_pd_index(iova);
 
-	return tegra_smmu_pte_offset(as->pts[pde], iova);
+	as->count[pd_index]++;
 }
 
 static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
@@ -632,6 +633,10 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!pte)
 		return -ENOMEM;
 
+	/* If we aren't overwriting a pre-existing entry, increment use */
+	if (!*pte)
+		tegra_smmu_pte_get_use(as, iova);
+
 	tegra_smmu_set_pte(as, iova, pte, pte_dma,
 			   __phys_to_pfn(paddr) | SMMU_PTE_ATTR);
 
-- 
2.1.0
