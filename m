From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 27 Jul 2015 13:29:21 +0100
Subject: [PATCH 07/18] iommu: tegra-smmu: fix page table lookup in
 unmap/iova_to_phys methods
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZJhWz-00047f-5D@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the page table lookup in the unmap and iova_to_phys methods.
Neither of these methods should allocate a page table; a missing page
table should be treated the same as no mapping present.

More importantly, using as_get_pte() for an IOVA corresponding with a
non-present page table entry increments the use-count for the page
table, on the assumption that the caller of as_get_pte() is going to
setup a mapping.  This is an incorrect assumption.

Fix both of these bugs by providing a separate helper which only looks
up the page table, but never allocates it.  This is akin to pte_offset()
for CPU page tables.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iommu/tegra-smmu.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 4c4bc7966046..bbff5b647183 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -475,12 +475,36 @@ static void tegra_smmu_detach_dev(struct iommu_domain *domain, struct device *de
 	}
 }
 
+static u32 *tegra_smmu_pte_offset(struct page *pt_page, unsigned long iova)
+{
+	u32 *pt = page_address(pt_page);
+
+	return pt + iova_pt_index(iova);
+}
+
+static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
+				  struct page **pagep)
+{
+	unsigned int pd_index = iova_pd_index(iova);
+	struct page *pt_page;
+	u32 *pd;
+
+	pd = page_address(as->pd);
+
+	if (!pd[pd_index])
+		return NULL;
+
+	pt_page = pfn_to_page(pd[pd_index] & as->smmu->pfn_mask);
+	*pagep = pt_page;
+
+	return tegra_smmu_pte_offset(pt_page, iova);
+}
+
 static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		       struct page **pagep)
 {
 	u32 *pd = page_address(as->pd), *pt, *count;
 	unsigned int pde = iova_pd_index(iova);
-	unsigned int pte = iova_pt_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
 	struct page *page;
 	unsigned int i;
@@ -506,17 +530,18 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		smmu_flush(smmu);
 	} else {
 		page = pfn_to_page(pd[pde] & smmu->pfn_mask);
-		pt = page_address(page);
 	}
 
 	*pagep = page;
 
+	pt = page_address(page);
+
 	/* Keep track of entries in this page table. */
 	count = page_address(as->count);
-	if (pt[pte] == 0)
+	if (pt[iova_pt_index(iova)] == 0)
 		count[pde]++;
 
-	return &pt[pte];
+	return tegra_smmu_pte_offset(page, iova);
 }
 
 static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
@@ -586,14 +611,14 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t size)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct page *page;
+	struct page *pte_page;
 	u32 *pte;
 
-	pte = as_get_pte(as, iova, &page);
+	pte = tegra_smmu_pte_lookup(as, iova, &pte_page);
 	if (!pte || !*pte)
 		return 0;
 
-	tegra_smmu_set_pte(as, iova, pte, page, 0);
+	tegra_smmu_set_pte(as, iova, pte, pte_page, 0);
 	tegra_smmu_pte_put_use(as, iova);
 
 	return size;
@@ -603,11 +628,11 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct page *page;
+	struct page *pte_page;
 	unsigned long pfn;
 	u32 *pte;
 
-	pte = as_get_pte(as, iova, &page);
+	pte = tegra_smmu_pte_lookup(as, iova, &pte_page);
 	if (!pte || !*pte)
 		return 0;
 
-- 
2.1.0
