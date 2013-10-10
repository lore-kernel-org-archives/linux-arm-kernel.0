From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 10 Oct 2013 12:06:18 +0100
Subject: [RESEND PATCH] ARM: mm: Remove HugeTLB warning from dma-mapping.c
Message-ID: <1381403178-32061-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The coherant DMA allocator code contained a compile time warning
when HugeTLB support was enabled. It stated that huge pages were
not supported by the DMA allocator.

Apart from memory pressure, HugeTLB should not affect (or be
affected by) the higher order pages operated on by the DMA
allocator. Also, the user space mappings returned by arm_dma_mmap
are done via remap_pfn_range, so the Transparent Huge Page daemon
will leave them alone too.

This patch removes the huge page warning from dma-mapping.c.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
Hi, I'm resending this patch as it appears to have slipped through the
cracks. Without this patch we will get spurious compiler warnings when
building kernels with huge page support.

Cheers,
-- 
Steve
---
 arch/arm/mm/dma-mapping.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7f9b179..9486048 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -249,9 +249,6 @@ static void __dma_free_buffer(struct page *page, size_t size)
 }
 
 #ifdef CONFIG_MMU
-#ifdef CONFIG_HUGETLB_PAGE
-#warning ARM Coherent DMA allocator does not (yet) support huge TLB
-#endif
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
 				     pgprot_t prot, struct page **ret_page,
-- 
1.8.1.4
