From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 24 Apr 2017 11:16:57 +0100
Subject: [PATCH v4 7/7] ARM: dma-mapping: Remove traces of NOMMU code
In-Reply-To: <1493029017-31382-1-git-send-email-vladimir.murzin@arm.com>
References: <1493029017-31382-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1493029017-31382-8-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA operations for NOMMU case have been just factored out into
separate compilation unit, so don't keep dead code.

Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Andras Szemzo <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/dma-mapping.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 475811f..cd90338 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -344,8 +344,6 @@ static void __dma_free_buffer(struct page *page, size_t size)
 	}
 }
 
-#ifdef CONFIG_MMU
-
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
 				     pgprot_t prot, struct page **ret_page,
 				     const void *caller, bool want_vaddr,
@@ -647,22 +645,6 @@ static inline pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot)
 	return prot;
 }
 
-#define nommu() 0
-
-#else	/* !CONFIG_MMU */
-
-#define nommu() 1
-
-#define __get_dma_pgprot(attrs, prot)				__pgprot(0)
-#define __alloc_remap_buffer(dev, size, gfp, prot, ret, c, wv)	NULL
-#define __alloc_from_pool(size, ret_page)			NULL
-#define __alloc_from_contiguous(dev, size, prot, ret, c, wv, coherent_flag, gfp)	NULL
-#define __free_from_pool(cpu_addr, size)			do { } while (0)
-#define __free_from_contiguous(dev, page, cpu_addr, size, wv)	do { } while (0)
-#define __dma_free_remap(cpu_addr, size)			do { } while (0)
-
-#endif	/* CONFIG_MMU */
-
 static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t gfp,
 				   struct page **ret_page)
 {
@@ -805,7 +787,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	if (cma)
 		buf->allocator = &cma_allocator;
-	else if (nommu() || is_coherent)
+	else if (is_coherent)
 		buf->allocator = &simple_allocator;
 	else if (allowblock)
 		buf->allocator = &remap_allocator;
@@ -854,8 +836,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		 unsigned long attrs)
 {
-	int ret = -ENXIO;
-#ifdef CONFIG_MMU
+	int ret;
 	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
@@ -870,10 +851,6 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 				      vma->vm_end - vma->vm_start,
 				      vma->vm_page_prot);
 	}
-#else
-	ret = vm_iomap_memory(vma, vma->vm_start,
-			      (vma->vm_end - vma->vm_start));
-#endif	/* CONFIG_MMU */
 
 	return ret;
 }
@@ -892,9 +869,7 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		 unsigned long attrs)
 {
-#ifdef CONFIG_MMU
 	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
-#endif	/* CONFIG_MMU */
 	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
-- 
2.0.0
