From: robin.murphy@arm.com (Robin Murphy)
Date: Mon,  4 Jan 2016 16:19:42 +0000
Subject: [PATCH RESEND] iommu/dma: Use correct offset in map_sg
In-Reply-To: <4812a34857b081e45c36d7e887840f3675da74dc.1450457730.git.robin.murphy@arm.com>
Message-ID: <8317d001da4f48831fa23d8d7729a4659ac72b49.1451924092.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When mapping a non-page-aligned scatterlist entry, we copy the original
offset to the output DMA address before aligning it to hand off to
iommu_map_sg(), then later adding the IOVA page address portion to get
the final mapped address. However, when the IOVA page size is smaller
than the CPU page size, it is the offset within the IOVA page we want,
not that within the CPU page, which can easily be larger than an IOVA
page and thus result in an incorrect final address.

Fix the bug by taking only the IOVA-aligned part of the offset as the
basis of the DMA address, not the whole thing.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Rebased onto iommu/fixes.

 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2e7417f..72d6182 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -458,7 +458,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		size_t s_offset = iova_offset(iovad, s->offset);
 		size_t s_length = s->length;
 
-		sg_dma_address(s) = s->offset;
+		sg_dma_address(s) = s_offset;
 		sg_dma_len(s) = s_length;
 		s->offset -= s_offset;
 		s_length = iova_align(iovad, s_length + s_offset);
-- 
1.9.1
