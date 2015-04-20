From: tfiga@chromium.org (Tomasz Figa)
Date: Mon, 20 Apr 2015 20:43:44 +0900
Subject: [PATCH v2] CHROMIUM: iommu: rockchip: Make sure that page table state
 is coherent
Message-ID: <1429530224-24719-1-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To flush created mappings, current mapping code relies on the fact that
during unmap the driver zaps every IOVA being unmapped and that it is
enough to zap a single IOVA of page table to remove the entire page
table from IOMMU cache. Based on these assumptions the driver was made to
simply zap the first IOVA of the mapping being created. This is enough
to invalidate first page table, which could be shared with another
mapping (and thus could be already present in IOMMU cache), but
unfortunately it does not do anything about the last page table that
could be shared with other mappings as well.

Moreover, the flushing is performed before page table contents are
actually modified, so there is a race between the CPU updating the page
tables and hardware that could be possibly running at the same time and
triggering IOMMU look-ups, which could bring back the page tables back
to the cache.

To fix both issues, this patch makes the mapping code zap first and last
(if they are different) IOVAs of new mapping after the page table is
updated.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/iommu/rockchip-iommu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4015560..31004c0 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -551,6 +551,15 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 }
 
+static void rk_iommu_zap_iova_first_last(struct rk_iommu_domain *rk_domain,
+					 dma_addr_t iova, size_t size)
+{
+	rk_iommu_zap_iova(rk_domain, iova, SPAGE_SIZE);
+	if (size > SPAGE_SIZE)
+		rk_iommu_zap_iova(rk_domain, iova + size - SPAGE_SIZE,
+					SPAGE_SIZE);
+}
+
 static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 				  dma_addr_t iova)
 {
@@ -575,12 +584,6 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	rk_table_flush(page_table, NUM_PT_ENTRIES);
 	rk_table_flush(dte_addr, 1);
 
-	/*
-	 * Zap the first iova of newly allocated page table so iommu evicts
-	 * old cached value of new dte from the iotlb.
-	 */
-	rk_iommu_zap_iova(rk_domain, iova, SPAGE_SIZE);
-
 done:
 	pt_phys = rk_dte_pt_address(dte);
 	return (u32 *)phys_to_virt(pt_phys);
@@ -630,6 +633,14 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
 
 	rk_table_flush(pte_addr, pte_count);
 
+	/*
+	 * Zap the first and last iova to evict from iotlb any previously
+	 * mapped cachelines holding stale values for its dte and pte.
+	 * We only zap the first and last iova, since only they could have
+	 * dte or pte shared with an existing mapping.
+	 */
+	rk_iommu_zap_iova_first_last(rk_domain, iova, size);
+
 	return 0;
 unwind:
 	/* Unmap the range of iovas that we just mapped */
-- 
2.2.0.rc0.207.ga3a616c
