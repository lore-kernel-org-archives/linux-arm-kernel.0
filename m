From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 11 May 2012 10:33:36 +0200
Subject: [PATCH] ARM: dma-mapping: fix build break on no-MMU systems
In-Reply-To: <1334756652-30830-1-git-send-email-m.szyprowski@samsung.com>
References: <1334756652-30830-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1336725216-24434-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build issue:

arch/arm/mm/dma-mapping.c:726:42: error: 'pgprot_kernel' undeclared
(first use in this function)
make[2]: *** [arch/arm/mm/dma-mapping.o] Error 1

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 2d11aa0..686ef02 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -428,10 +428,19 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 	arm_vmregion_free(&consistent_head, c);
 }
 
+static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
+{
+	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
+			    pgprot_writecombine(prot) :
+			    pgprot_dmacoherent(prot);
+	return prot;
+}
+
 #else	/* !CONFIG_MMU */
 
 #define __dma_alloc_remap(page, size, gfp, prot, c)	page_address(page)
 #define __dma_free_remap(addr, size)			do { } while (0)
+#define __get_dma_pgprot(attrs, prot)	__pgprot(0)
 
 #endif	/* CONFIG_MMU */
 
@@ -471,14 +480,6 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	return addr;
 }
 
-static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
-{
-	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
-			    pgprot_writecombine(prot) :
-			    pgprot_dmacoherent(prot);
-	return prot;
-}
-
 /*
  * Allocate DMA-coherent memory space and return both the kernel remapped
  * virtual and bus address for that space.
-- 
1.7.1.569.g6f426
