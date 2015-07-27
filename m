From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 27 Jul 2015 13:29:31 +0100
Subject: [PATCH 09/18] iommu: tegra-smmu: use kcalloc() to allocate counter
 array
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZJhX9-00047r-Dq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use kcalloc() to allocate the use-counter array for the page directory
entries/page tables.  Using kcalloc() allows us to be provided with
zero-initialised memory from the allocators, rather than initialising
it ourselves.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iommu/tegra-smmu.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 8ec5ac45caab..d649b06cc4ca 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -40,7 +40,7 @@ struct tegra_smmu_as {
 	struct iommu_domain domain;
 	struct tegra_smmu *smmu;
 	unsigned int use_count;
-	struct page *count;
+	u32 *count;
 	struct page **pts;
 	struct page *pd;
 	unsigned id;
@@ -265,7 +265,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
-	as->count = alloc_page(GFP_KERNEL);
+	as->count = kcalloc(SMMU_NUM_PDE, sizeof(u32), GFP_KERNEL);
 	if (!as->count) {
 		__free_page(as->pd);
 		kfree(as);
@@ -274,7 +274,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 
 	as->pts = kcalloc(SMMU_NUM_PDE, sizeof(*as->pts), GFP_KERNEL);
 	if (!as->pts) {
-		__free_page(as->count);
+		kfree(as->count);
 		__free_page(as->pd);
 		kfree(as);
 		return NULL;
@@ -287,13 +287,6 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 	for (i = 0; i < SMMU_NUM_PDE; i++)
 		pd[i] = 0;
 
-	/* clear PDE usage counters */
-	pd = page_address(as->count);
-	SetPageReserved(as->count);
-
-	for (i = 0; i < SMMU_NUM_PDE; i++)
-		pd[i] = 0;
-
 	/* setup aperture */
 	as->domain.geometry.aperture_start = 0;
 	as->domain.geometry.aperture_end = 0xffffffff;
@@ -509,7 +502,7 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		       struct page **pagep)
 {
-	u32 *pd = page_address(as->pd), *pt, *count;
+	u32 *pd = page_address(as->pd), *pt;
 	unsigned int pde = iova_pd_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
 	struct page *page;
@@ -545,9 +538,8 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 	pt = page_address(page);
 
 	/* Keep track of entries in this page table. */
-	count = page_address(as->count);
 	if (pt[iova_pt_index(iova)] == 0)
-		count[pde]++;
+		as->count[pde]++;
 
 	return tegra_smmu_pte_offset(page, iova);
 }
@@ -556,7 +548,6 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 {
 	struct tegra_smmu *smmu = as->smmu;
 	unsigned int pde = iova_pd_index(iova);
-	u32 *count = page_address(as->count);
 	u32 *pd = page_address(as->pd);
 	struct page *page = as->pts[pde];
 
@@ -564,7 +555,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 	 * When no entries in this page table are used anymore, return the
 	 * memory page to the system.
 	 */
-	if (--count[pde] == 0) {
+	if (--as->count[pde] == 0) {
 		unsigned int offset = pde * sizeof(*pd);
 
 		/* Clear the page directory entry first */
-- 
2.1.0
