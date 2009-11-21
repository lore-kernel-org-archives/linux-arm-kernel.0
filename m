From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 19:39:05 +0000
Subject: [PATCH 08/10] ARM: dma-mapping: Factor out noMMU dma buffer
	allocation code
In-Reply-To: <20091121193539.GG13956@n2100.arm.linux.org.uk>
References: <20091121193539.GG13956@n2100.arm.linux.org.uk>
Message-ID: <E1NBvnV-0007qx-91@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This entirely separates the DMA coherent buffer remapping code from
the allocation code, and gets rid of the duplicate copy in the !MMU
section.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/dma-mapping.c |   45 +++++++++++++++------------------------------
 1 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index dac44f0..f3c0fc8 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -183,27 +183,13 @@ static int __init consistent_init(void)
 core_initcall(consistent_init);
 
 static void *
-__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
-	    pgprot_t prot)
+__dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
 {
-	struct page *page;
 	struct arm_vmregion *c;
 
-	size = PAGE_ALIGN(size);
-
-	page = __dma_alloc_buffer(dev, size, gfp);
-	if (!page)
-		goto no_page;
-
-	if (arch_is_coherent()) {
-		*handle = page_to_dma(dev, page);
-		return page_address(page);
-	}
-
 	if (!consistent_pte[0]) {
 		printk(KERN_ERR "%s: not initialised\n", __func__);
 		dump_stack();
-		__dma_free_buffer(page, size);
 		return NULL;
 	}
 
@@ -220,11 +206,6 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 		pte = consistent_pte[idx] + off;
 		c->vm_pages = page;
 
-		/*
-		 * Set the "dma handle"
-		 */
-		*handle = page_to_dma(dev, page);
-
 		do {
 			BUG_ON(!pte_none(*pte));
 
@@ -244,11 +225,6 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 
 		return (void *)c->vm_start;
 	}
-
-	if (page)
-		__dma_free_buffer(page, size);
- no_page:
-	*handle = ~0;
 	return NULL;
 }
 
@@ -315,11 +291,17 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 
 #else	/* !CONFIG_MMU */
 
+#define __dma_alloc_remap(page, size, gfp, prot)	page_address(page)
+#define __dma_free_remap(addr, size)			do { } while (0)
+
+#endif	/* CONFIG_MMU */
+
 static void *
 __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	    pgprot_t prot)
 {
 	struct page *page;
+	void *addr;
 
 	*handle = ~0;
 	size = PAGE_ALIGN(size);
@@ -328,13 +310,16 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	if (!page)
 		return NULL;
 
-	*handle = page_to_dma(dev, page);
-	return page_address(page);
-}
+	if (!arch_is_coherent())
+		addr = __dma_alloc_remap(page, size, gfp, prot);
+	else
+		addr = page_address(page);
 
-#define __dma_free_remap(addr, size)	do { } while (0)
+	if (addr)
+		*handle = page_to_dma(dev, page);
 
-#endif	/* CONFIG_MMU */
+	return addr;
+}
 
 /*
  * Allocate DMA-coherent memory space and return both the kernel remapped
-- 
1.6.2.5
