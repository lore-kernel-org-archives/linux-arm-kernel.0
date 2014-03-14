From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 14 Mar 2014 12:52:25 -0700
Subject: [PATCHv2 3/3] arm64: Use arm64 coherent APIs for non-coherent freeing
In-Reply-To: <1394732716-11507-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <1394826745-24191-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The noncoherent free function currently unconditionally frees
back to the page allocator which is incorrect for CMA pages.
call the coherent free function to correctly differentiate
between pages.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 608c343..99ff063 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -104,7 +104,7 @@ static void arm64_swiotlb_free_noncoherent(struct device *dev, size_t size,
 	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
 
 	vunmap(vaddr);
-	swiotlb_free_coherent(dev, size, swiotlb_addr, dma_handle);
+	arm64_swiotlb_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);
 }
 
 static dma_addr_t arm64_swiotlb_map_page(struct device *dev,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
