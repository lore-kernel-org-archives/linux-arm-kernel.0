From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 19:38:11 +0000
Subject: [PATCH 04/10] ARM: dma-mapping: fix nommu dma_alloc_coherent()
In-Reply-To: <20091121193539.GG13956@n2100.arm.linux.org.uk>
References: <20091121193539.GG13956@n2100.arm.linux.org.uk>
Message-ID: <E1NBvmd-0007ql-7Q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nommu version of dma_alloc_coherent was using kmalloc/kfree to manage
the memory.  dma_alloc_coherent() is expected to work with a granularity
of a page, so this is wrong.  Fix it by using the helper functions now
provided.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/dma-mapping.c |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 49e0284..44be5ad 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -212,24 +212,17 @@ static void *
 __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	    pgprot_t prot)
 {
-	void *virt;
-	u64 mask = get_coherent_dma_mask(dev);
-
-	if (!mask)
-		goto error;
+	struct page *page;
 
-	if (mask < 0xffffffffULL)
-		gfp |= GFP_DMA;
-	virt = kmalloc(size, gfp);
-	if (!virt)
-		goto error;
+	*handle = ~0;
+	size = PAGE_ALIGN(size);
 
-	*handle =  virt_to_dma(dev, virt);
-	return virt;
+	page = __dma_alloc_buffer(dev, size, gfp);
+	if (!page)
+		return NULL;
 
-error:
-	*handle = ~0;
-	return NULL;
+	*handle = page_to_dma(dev, page);
+	return page_address(page);
 }
 #endif	/* CONFIG_MMU */
 
@@ -406,7 +399,7 @@ void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr
 {
 	if (dma_release_from_coherent(dev, get_order(size), cpu_addr))
 		return;
-	kfree(cpu_addr);
+	__dma_free_buffer(dma_to_page(dev, handle), PAGE_ALIGN(size));
 }
 #endif	/* CONFIG_MMU */
 EXPORT_SYMBOL(dma_free_coherent);
-- 
1.6.2.5
