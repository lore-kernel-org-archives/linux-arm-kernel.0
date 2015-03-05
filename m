From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed,  4 Mar 2015 16:18:05 -0800
Subject: [PATCH] iommu/arm-smmu: fix leak in arm_smmu_flush_pgtable
Message-ID: <1425514685-23831-1-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're currently mapping a page in arm_smmu_flush_pgtable without ever
unmapping it.  Fix this by calling dma_unmap_page on the returned dma
address.  Since the only reason we're calling dma_map_page is to make
sure it actually gets flushed out to RAM, we can just call
dma_unmap_page immediately following the map.

Without this, eventually swiotlb runs out of memory and starts printing
things like:

    [   35.545076] arm-smmu d00000.arm,smmu: swiotlb buffer is full (sz: 128 bytes)

Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fc13dd56953e..2ff8f35cf533 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -627,8 +627,13 @@ static void arm_smmu_flush_pgtable(void *addr, size_t size, void *cookie)
 		 * recursion here as the SMMU table walker will not be wired
 		 * through another SMMU.
 		 */
-		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
-			     DMA_TO_DEVICE);
+		dma_addr_t handle = dma_map_page(smmu->dev, virt_to_page(addr),
+						offset, size, DMA_TO_DEVICE);
+		if (handle == DMA_ERROR_CODE)
+			dev_err(smmu->dev,
+				"Couldn't flush page tables at %p!\n", addr);
+		else
+			dma_unmap_page(smmu->dev, handle, size, DMA_TO_DEVICE);
 	}
 }
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
