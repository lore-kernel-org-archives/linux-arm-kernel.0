From: drake@endlessm.com (Daniel Drake)
Date: Tue, 24 Feb 2015 14:45:03 -0600
Subject: [PATCH] ARM: dma-mapping: support non-consistent DMA attribute
Message-ID: <1424810703-20382-1-git-send-email-drake@endlessm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently when arm_dma_mmap() is called, vm_page_prot is reset
according to DMA attributes. Currently, writecombine is the
only attribute supported; any other configuration will map uncached
memory.

Add support for the non-consistent attribute so that cachable memory
can be mapped into userspace via the dma_mmap_attrs() API.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 arch/arm/mm/dma-mapping.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 170a116..cfb7d4d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -562,10 +562,12 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 
 static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
 {
-	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
-			    pgprot_writecombine(prot) :
-			    pgprot_dmacoherent(prot);
-	return prot;
+	if (dma_get_attr(DMA_ATTR_NON_CONSISTENT, attrs))
+		return prot;
+	else if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
+		return pgprot_writecombine(prot);
+	else
+		return pgprot_dmacoherent(prot);
 }
 
 #define nommu() 0
-- 
2.1.0
