From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 23 Jul 2018 23:16:10 +0100
Subject: [PATCH v2 5/7] iommu/dma: Respect bus DMA limit for IOVAs
In-Reply-To: <cover.1532382222.git.robin.murphy@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
Message-ID: <d370670edae9c9c537a5280c5e7c96bf3ec7ed8f.1532382222.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take the new bus limit into account (when present) for IOVA allocations,
to accommodate those SoCs which integrate off-the-shelf IP blocks with
narrower interconnects such that the link between a device output and an
IOMMU input can truncate DMA addresses to even fewer bits than the
native size of either block's interface would imply.

Eventually it might make sense for the DMA core to apply this constraint
up-front in dma_set_mask() and friends, but for now this seems like the
least risky approach.

CC: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Bonus question: Now that we're collecing DMA API code in kernel/dma/
do we want to reevaluate dma-iommu? On the one hand it's the bulk of a
dma_ops implementation so should perhaps move, but on the other it's
entirely IOMMU-specific code so should perhaps stay where it is... :/

 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ddcbbdb5d658..511ff9a1d6d9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -367,6 +367,9 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
 		iova_len = roundup_pow_of_two(iova_len);
 
+	if (dev->bus_dma_mask)
+		dma_limit &= dev->bus_dma_mask;
+
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
 
-- 
2.17.1.dirty
