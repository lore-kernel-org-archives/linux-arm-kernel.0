From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 15 Mar 2017 13:33:16 +0000
Subject: [PATCH 3/3] iommu/dma: Plumb in the per-CPU IOVA caches
In-Reply-To: <cover.1489581865.git.robin.murphy@arm.com>
References: <cover.1489581865.git.robin.murphy@arm.com>
Message-ID: <83caa72b318a3e8343e938976be687c493165434.1489581865.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With IOVA allocation suitably tidied up, we are finally free to opt in
to the per-CPU caching mechanism. The caching alone can provide a modest
improvement over walking the rbtree for weedier systems (iperf3 shows
~10% more ethernet throughput on an ARM Juno r1 constrained to a single
650MHz Cortex-A53), but the real gain will be in sidestepping the rbtree
lock contention which larger ARM-based systems with lots of parallel I/O
are starting to feel the pain of.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c03e2eb4ebbb..292008de68f0 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -282,8 +282,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	unsigned long shift, iova_len;
-	struct iova *iova = NULL;
+	unsigned long shift, iova_len, iova = 0;
 
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
 		cookie->msi_iova += size;
@@ -292,41 +291,39 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 
 	shift = iova_shift(iovad);
 	iova_len = size >> shift;
+	/*
+	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
+	 * will come back to bite us badly, so we have to waste a bit of space
+	 * rounding up anything cacheable to make sure that can't happen. The
+	 * order of the unadjusted size will still match upon freeing.
+	 */
+	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
+		iova_len = roundup_pow_of_two(iova_len);
 
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
 
 	/* Try to get PCI devices a SAC address */
 	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
-		iova = alloc_iova(iovad, iova_len, DMA_BIT_MASK(32) >> shift,
-				  true);
-	/*
-	 * Enforce size-alignment to be safe - there could perhaps be an
-	 * attribute to control this per-device, or at least per-domain...
-	 */
-	if (!iova)
-		iova = alloc_iova(iovad, iova_len, dma_limit >> shift, true);
+		iova = alloc_iova_fast(iovad, iova_len, DMA_BIT_MASK(32) >> shift);
 
-	return (dma_addr_t)iova->pfn_lo << shift;
+	if (!iova)
+		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift);
+
+	return (dma_addr_t)iova << shift;
 }
 
 static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 		dma_addr_t iova, size_t size)
 {
 	struct iova_domain *iovad = &cookie->iovad;
-	struct iova *iova_rbnode;
+	unsigned long shift = iova_shift(iovad);
 
 	/* The MSI case is only ever cleaning up its most recent allocation */
-	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
+	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
 		cookie->msi_iova -= size;
-		return;
-	}
-
-	iova_rbnode = find_iova(iovad, iova_pfn(iovad, iova));
-	if (WARN_ON(!iova_rbnode))
-		return;
-
-	__free_iova(iovad, iova_rbnode);
+	else
+		free_iova_fast(iovad, iova >> shift, size >> shift);
 }
 
 static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
-- 
2.11.0.dirty
