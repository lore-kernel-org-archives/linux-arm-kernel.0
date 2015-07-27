From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 27 Jul 2015 13:29:16 +0100
Subject: [PATCH 06/18] iommu: tegra-smmu: add iova_pd_index() and
 iova_pt_index() helpers
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZJhWu-00047X-13@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pair of helpers to get the page directory and page table indexes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iommu/tegra-smmu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 53d0f15dac6f..4c4bc7966046 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -134,6 +134,16 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 #define SMMU_PTE_ATTR		(SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
 				 SMMU_PTE_NONSECURE)
 
+static unsigned int iova_pd_index(unsigned long iova)
+{
+	return (iova >> SMMU_PDE_SHIFT) & (SMMU_NUM_PDE - 1);
+}
+
+static unsigned int iova_pt_index(unsigned long iova)
+{
+	return (iova >> SMMU_PTE_SHIFT) & (SMMU_NUM_PTE - 1);
+}
+
 static inline void smmu_flush_ptc(struct tegra_smmu *smmu, struct page *page,
 				  unsigned long offset)
 {
@@ -469,8 +479,8 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		       struct page **pagep)
 {
 	u32 *pd = page_address(as->pd), *pt, *count;
-	u32 pde = (iova >> SMMU_PDE_SHIFT) & 0x3ff;
-	u32 pte = (iova >> SMMU_PTE_SHIFT) & 0x3ff;
+	unsigned int pde = iova_pd_index(iova);
+	unsigned int pte = iova_pt_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
 	struct page *page;
 	unsigned int i;
@@ -512,7 +522,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 {
 	struct tegra_smmu *smmu = as->smmu;
-	u32 pde = (iova >> SMMU_PDE_SHIFT) & 0x3ff;
+	unsigned int pde = iova_pd_index(iova);
 	u32 *count = page_address(as->count);
 	u32 *pd = page_address(as->pd);
 	struct page *page;
-- 
2.1.0
