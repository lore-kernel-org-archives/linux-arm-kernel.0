From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 13 Mar 2014 10:45:16 -0700
Subject: [PATCH 2/2] arm64: Support DMA_ATTR_WRITE_COMBINE
In-Reply-To: <5320A573.9080501@codeaurora.org>
Message-ID: <1394732716-11507-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA_ATTR_WRITE_COMBINE is currently ignored. Set the pgprot
appropriately for non coherent opperations.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 Potential addition on top of the coherent work as well. Writecombine
 and dmacoherent seem to be the same at the moment but it might be
 good practice to have the two be separate?

 arch/arm64/mm/dma-mapping.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 9a639bf..d2c0027 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -29,6 +29,15 @@
 struct dma_map_ops *dma_ops;
 EXPORT_SYMBOL(dma_ops);
 
+
+static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
+{
+	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
+			    pgprot_writecombine(prot) :
+			    pgprot_dmacoherent(prot);
+	return prot;
+}
+
 static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
 					  dma_addr_t *dma_handle, gfp_t flags,
 					  struct dma_attrs *attrs)
@@ -72,7 +81,7 @@ static void *arm64_swiotlb_alloc_noncoherent(struct device *dev, size_t size,
 	for (i = 0; i < (size >> PAGE_SHIFT); i++)
 		map[i] = page + i;
 	coherent_ptr = vmap(map, size >> PAGE_SHIFT, VM_MAP,
-			    pgprot_dmacoherent(pgprot_default));
+			    __get_dma_pgprot(attrs, pgprot_default));
 	kfree(map);
 	if (!coherent_ptr)
 		goto no_map;
@@ -232,7 +241,7 @@ static int arm64_swiotlb_mmap_coherent(struct device *dev,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		struct dma_attrs *attrs)
 {
-	vma->vm_page_prot = pgprot_dmacoherent(vma->vm_page_prot);
+	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
 	return __dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
