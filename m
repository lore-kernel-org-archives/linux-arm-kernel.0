From: will.deacon@arm.com (Will Deacon)
Date: Mon,  3 Aug 2015 14:25:50 +0100
Subject: [PATCH 08/13] iommu/ipmmu-vmsa: Clean up DMA API usage
In-Reply-To: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
Message-ID: <1438608355-7335-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <Robin.Murphy@arm.com>

With the correct DMA API calls now integrated into the io-pgtable code,
let that handle the flushing of non-coherent page table updates.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/ipmmu-vmsa.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 1a67c531a07e..8cf605fa9946 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -283,24 +283,10 @@ static void ipmmu_tlb_add_flush(unsigned long iova, size_t size, bool leaf,
 	/* The hardware doesn't support selective TLB flush. */
 }
 
-static void ipmmu_flush_pgtable(void *ptr, size_t size, void *cookie)
-{
-	unsigned long offset = (unsigned long)ptr & ~PAGE_MASK;
-	struct ipmmu_vmsa_domain *domain = cookie;
-
-	/*
-	 * TODO: Add support for coherent walk through CCI with DVM and remove
-	 * cache handling.
-	 */
-	dma_map_page(domain->mmu->dev, virt_to_page(ptr), offset, size,
-		     DMA_TO_DEVICE);
-}
-
 static struct iommu_gather_ops ipmmu_gather_ops = {
 	.tlb_flush_all = ipmmu_tlb_flush_all,
 	.tlb_add_flush = ipmmu_tlb_add_flush,
 	.tlb_sync = ipmmu_tlb_flush_all,
-	.flush_pgtable = ipmmu_flush_pgtable,
 };
 
 /* -----------------------------------------------------------------------------
@@ -327,6 +313,11 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 	domain->cfg.ias = 32;
 	domain->cfg.oas = 40;
 	domain->cfg.tlb = &ipmmu_gather_ops;
+	/*
+	 * TODO: Add support for coherent walk through CCI with DVM and remove
+	 * cache handling. For now, delegate it to the io-pgtable code.
+	 */
+	domain->cfg.iommu_dev = domain->mmu->dev;
 
 	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
 					   domain);
-- 
2.1.4
