From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue,  5 Feb 2013 16:02:25 +0100
Subject: [PATCH] ARM: dma-mapping: Fix non-MMU builds
Message-ID: <1360076545-1943-1-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8cdf82d (ARM: dma-mapping: add support for CMA regions placed in
highmem zone) changed the signature of the__alloc_from_contiguous() and
__free_from_contiguous() functions but forgot to update the dummy macro
equivalents for non-MMU.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/mm/dma-mapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index a064e9d..2163af4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -610,9 +610,9 @@ static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
 #define __get_dma_pgprot(attrs, prot)	__pgprot(0)
 #define __alloc_remap_buffer(dev, size, gfp, prot, ret, c)	NULL
 #define __alloc_from_pool(size, ret_page)			NULL
-#define __alloc_from_contiguous(dev, size, prot, ret)		NULL
+#define __alloc_from_contiguous(dev, size, prot, ret, c)	NULL
 #define __free_from_pool(cpu_addr, size)			0
-#define __free_from_contiguous(dev, page, size)			do { } while (0)
+#define __free_from_contiguous(dev, page, cpu_addr, size)	do { } while (0)
 #define __dma_free_remap(cpu_addr, size)			do { } while (0)
 
 #endif	/* CONFIG_MMU */
-- 
1.8.1.2
