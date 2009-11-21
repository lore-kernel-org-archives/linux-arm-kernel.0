From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 19:37:50 +0000
Subject: [PATCH 03/10] ARM: dma-mapping: fix coherent arch dma_alloc_coherent()
In-Reply-To: <20091121193539.GG13956@n2100.arm.linux.org.uk>
References: <20091121193539.GG13956@n2100.arm.linux.org.uk>
Message-ID: <E1NBvmI-0007qi-N3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The coherent architecture dma_alloc_coherent was using kmalloc/kfree to
manage the memory.  dma_alloc_coherent() is expected to work with a
granularity of a page, so this is wrong.  Fix it by using the helper
functions now provided.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/dma-mapping.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index a39ec89..49e0284 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -246,14 +246,16 @@ dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gf
 		return memory;
 
 	if (arch_is_coherent()) {
-		void *virt;
+		struct page *page;
 
-		virt = kmalloc(size, gfp);
-		if (!virt)
+		page = __dma_alloc_buffer(dev, PAGE_ALIGN(size), gfp);
+		if (!page) {
+			*handle = ~0;
 			return NULL;
-		*handle =  virt_to_dma(dev, virt);
+		}
 
-		return virt;
+		*handle = page_to_dma(dev, page);
+		return page_address(page);
 	}
 
 	return __dma_alloc(dev, size, handle, gfp,
@@ -336,13 +338,13 @@ void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr
 	if (dma_release_from_coherent(dev, get_order(size), cpu_addr))
 		return;
 
+	size = PAGE_ALIGN(size);
+
 	if (arch_is_coherent()) {
-		kfree(cpu_addr);
+		__dma_free_buffer(dma_to_page(dev, handle), size);
 		return;
 	}
 
-	size = PAGE_ALIGN(size);
-
 	c = arm_vmregion_find_remove(&consistent_head, (unsigned long)cpu_addr);
 	if (!c)
 		goto no_area;
-- 
1.6.2.5
