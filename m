From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 10 Jul 2018 18:17:19 +0100
Subject: [RFC PATCH 4/4] iommu/dma: Respect bus DMA limit for IOVAs
In-Reply-To: <cover.1531239284.git.robin.murphy@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
Message-ID: <2c0d7437ee7ccdd58da25faa283bd3c3148b961b.1531239284.git.robin.murphy@arm.com>
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

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
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
