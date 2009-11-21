From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 19:38:53 +0000
Subject: [PATCH 07/10] ARM: dma-mapping: clean up coherent arch dma allocation
In-Reply-To: <20091121193539.GG13956@n2100.arm.linux.org.uk>
References: <20091121193539.GG13956@n2100.arm.linux.org.uk>
Message-ID: <E1NBvnJ-0007qu-3W@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IXP23xx added support for dma_alloc_coherent() for DMA arches with an
exception in dma_alloc_coherent().  This is a subset of what goes on
in __dma_alloc(), and there is no reason why dma_alloc_writecombine()
should not be given the same treatment (except, maybe, that IXP23xx
doesn't use it.)

We can better deal with this by moving the arch_is_coherent() test
inside __dma_alloc() and killing the code duplication.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/dma-mapping.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7e8f150..dac44f0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -189,18 +189,24 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	struct page *page;
 	struct arm_vmregion *c;
 
-	if (!consistent_pte[0]) {
-		printk(KERN_ERR "%s: not initialised\n", __func__);
-		dump_stack();
-		return NULL;
-	}
-
 	size = PAGE_ALIGN(size);
 
 	page = __dma_alloc_buffer(dev, size, gfp);
 	if (!page)
 		goto no_page;
 
+	if (arch_is_coherent()) {
+		*handle = page_to_dma(dev, page);
+		return page_address(page);
+	}
+
+	if (!consistent_pte[0]) {
+		printk(KERN_ERR "%s: not initialised\n", __func__);
+		dump_stack();
+		__dma_free_buffer(page, size);
+		return NULL;
+	}
+
 	/*
 	 * Allocate a virtual address in the consistent mapping region.
 	 */
@@ -342,19 +348,6 @@ dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gf
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
 		return memory;
 
-	if (arch_is_coherent()) {
-		struct page *page;
-
-		page = __dma_alloc_buffer(dev, PAGE_ALIGN(size), gfp);
-		if (!page) {
-			*handle = ~0;
-			return NULL;
-		}
-
-		*handle = page_to_dma(dev, page);
-		return page_address(page);
-	}
-
 	return __dma_alloc(dev, size, handle, gfp,
 			   pgprot_noncached(pgprot_kernel));
 }
-- 
1.6.2.5
