From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 09:00:11 +0100
Subject: [PATCH 17/33] microblaze: remove the dead !NOT_COHERENT_CACHE dma code
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
Message-ID: <20180110080027.13879-18-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/kernel/dma.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index b45d8f8967af..c91e8cef98dd 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -15,42 +15,18 @@
 #include <linux/bug.h>
 #include <asm/cacheflush.h>
 
-#define NOT_COHERENT_CACHE
-
 static void *dma_nommu_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag,
 				       unsigned long attrs)
 {
-#ifdef NOT_COHERENT_CACHE
 	return consistent_alloc(flag, size, dma_handle);
-#else
-	void *ret;
-	struct page *page;
-	int node = dev_to_node(dev);
-
-	/* ignore region specifiers */
-	flag  &= ~(__GFP_HIGHMEM);
-
-	page = alloc_pages_node(node, flag, get_order(size));
-	if (page == NULL)
-		return NULL;
-	ret = page_address(page);
-	memset(ret, 0, size);
-	*dma_handle = virt_to_phys(ret);
-
-	return ret;
-#endif
 }
 
 static void dma_nommu_free_coherent(struct device *dev, size_t size,
 				     void *vaddr, dma_addr_t dma_handle,
 				     unsigned long attrs)
 {
-#ifdef NOT_COHERENT_CACHE
 	consistent_free(size, vaddr);
-#else
-	free_pages((unsigned long)vaddr, get_order(size));
-#endif
 }
 
 static inline void __dma_sync(unsigned long paddr,
@@ -186,12 +162,8 @@ int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 	if (off >= count || user_count > (count - off))
 		return -ENXIO;
 
-#ifdef NOT_COHERENT_CACHE
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	pfn = consistent_virt_to_pfn(cpu_addr);
-#else
-	pfn = virt_to_pfn(cpu_addr);
-#endif
 	return remap_pfn_range(vma, vma->vm_start, pfn + off,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
 #else
-- 
2.14.2
