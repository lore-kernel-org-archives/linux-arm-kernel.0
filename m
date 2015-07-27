From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 27 Jul 2015 13:29:10 +0100
Subject: [PATCH 05/18] iommu: tegra-smmu: factor out common pte setting
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZJhWo-00047R-SM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Factor out the common pte setting code into a separate function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iommu/tegra-smmu.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index a7a7645fb268..53d0f15dac6f 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -541,12 +541,24 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 	}
 }
 
+static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
+			       u32 *pte, struct page *pte_page, u32 val)
+{
+	struct tegra_smmu *smmu = as->smmu;
+	unsigned long offset = offset_in_page(pte);
+
+	*pte = val;
+
+	smmu->soc->ops->flush_dcache(pte_page, offset, 4);
+	smmu_flush_ptc(smmu, pte_page, offset);
+	smmu_flush_tlb_group(smmu, as->id, iova);
+	smmu_flush(smmu);
+}
+
 static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t paddr, size_t size, int prot)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct tegra_smmu *smmu = as->smmu;
-	unsigned long offset;
 	struct page *page;
 	u32 *pte;
 
@@ -554,13 +566,8 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!pte)
 		return -ENOMEM;
 
-	*pte = __phys_to_pfn(paddr) | SMMU_PTE_ATTR;
-	offset = offset_in_page(pte);
-
-	smmu->soc->ops->flush_dcache(page, offset, 4);
-	smmu_flush_ptc(smmu, page, offset);
-	smmu_flush_tlb_group(smmu, as->id, iova);
-	smmu_flush(smmu);
+	tegra_smmu_set_pte(as, iova, pte, page,
+			   __phys_to_pfn(paddr) | SMMU_PTE_ATTR);
 
 	return 0;
 }
@@ -569,8 +576,6 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t size)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct tegra_smmu *smmu = as->smmu;
-	unsigned long offset;
 	struct page *page;
 	u32 *pte;
 
@@ -578,15 +583,7 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	if (!pte || !*pte)
 		return 0;
 
-	*pte = 0;
-
-	offset = offset_in_page(pte);
-
-	smmu->soc->ops->flush_dcache(page, offset, 4);
-	smmu_flush_ptc(smmu, page, offset);
-	smmu_flush_tlb_group(smmu, as->id, iova);
-	smmu_flush(smmu);
-
+	tegra_smmu_set_pte(as, iova, pte, page, 0);
 	tegra_smmu_pte_put_use(as, iova);
 
 	return size;
-- 
2.1.0
