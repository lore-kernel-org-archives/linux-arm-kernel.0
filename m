From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Fri, 18 Mar 2016 10:26:07 +0800
Subject: [PATCH v2 1/1] arm64/dma-mapping: reduce an unnecessary conversion
 for coherent DMA
In-Reply-To: <1458267967-6332-1-git-send-email-thunder.leizhen@huawei.com>
References: <1458267967-6332-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1458267967-6332-2-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1.For coherent DMA
  In swiotlb_alloc_coherent, it directly return vaddr on success, and
pass vaddr to free_pages on failure. So, we can directly transparent pass
vaddr from __dma_free to swiotlb_free_coherent.

2.Keep no change for non-coherent DMA.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/dma-mapping.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a6e757c..ceb2018 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -187,16 +187,22 @@ static void __dma_free(struct device *dev, size_t size,
 		       void *vaddr, dma_addr_t dma_handle,
 		       struct dma_attrs *attrs)
 {
-	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
-
 	size = PAGE_ALIGN(size);

 	if (!is_device_dma_coherent(dev)) {
 		if (__free_from_pool(vaddr, size))
 			return;
 		vunmap(vaddr);
+
+		/*
+		 * For non-coherent DMA, the vaddr is not part of the linear
+		 * mapping as it has been remapped by __dma_alloc() via
+		 * dma_common_contiguous_remap(), hence for swiotlb freeing we
+		 * need the actual linear map address.
+		 */
+		vaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
 	}
-	__dma_free_coherent(dev, size, swiotlb_addr, dma_handle, attrs);
+	__dma_free_coherent(dev, size, vaddr, dma_handle, attrs);
 }

 static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
--
2.5.0
