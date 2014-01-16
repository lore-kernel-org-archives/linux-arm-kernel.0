From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 16 Jan 2014 10:07:43 +0000
Subject: [PATCH V2] arm: mm: Remove hugetlb warning from Coherent DMA allocator
Message-ID: <1389866863-24460-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Coherant DMA allocator allocates pages of high order then splits
them up into smaller pages.

This splitting logic would run into problems if the allocator was
given compound pages. Thus the Coherant DMA allocator was originally
incompatible with compound pages existing and, by extension, huge
pages. A compile #error was put in place whenever huge pages were
enabled.

Compatibility with compound pages has since been introduced by the
following commit (which merely excludes GFP_COMP pages from being
requested by the coherant DMA allocator):
  ea2e705 ARM: 7172/1: dma: Drop GFP_COMP for DMA memory allocations

When huge page support was introduced to ARM, the compile #error in
dma-mapping.c was replaced by a #warning when it should have been
removed instead.

This patch removes the compile #warning in dma-mapping.c when huge
pages are enabled.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
Changed in V2: commit message completely re-written to give a better
justification.
---
 arch/arm/mm/dma-mapping.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f61a570..8edd1b5 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -284,9 +284,6 @@ static void __dma_free_buffer(struct page *page, size_t size)
 }
 
 #ifdef CONFIG_MMU
-#ifdef CONFIG_HUGETLB_PAGE
-#warning ARM Coherent DMA allocator does not (yet) support huge TLB
-#endif
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
 				     pgprot_t prot, struct page **ret_page,
-- 
1.8.1.4
