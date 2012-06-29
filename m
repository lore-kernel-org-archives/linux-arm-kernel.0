From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 29 Jun 2012 07:14:28 +0200
Subject: [PATCH] ARM: dma-mapping: fix build break on no-MMU platform
In-Reply-To: <1340614047-5824-3-git-send-email-m.szyprowski@samsung.com>
References: <1340614047-5824-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1340946868-18178-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following build break on no-MMU ARM architectures:

arch/arm/mm/dma-mapping.c:576:39: error: macro "__alloc_from_pool" requires 4 arguments, but only 2 given
arch/arm/mm/dma-mapping.c: In function ?__dma_alloc?:
arch/arm/mm/dma-mapping.c:576: error: ?__alloc_from_pool? undeclared (first use in this function)
arch/arm/mm/dma-mapping.c:576: error: (Each undeclared identifier is reported only once
arch/arm/mm/dma-mapping.c:576: error: for each function it appears in.)
make[1]: *** [arch/arm/mm/dma-mapping.o] Error 1

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c10dab8..c65a180 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -514,7 +514,7 @@ static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
 
 #define __get_dma_pgprot(attrs, prot)	__pgprot(0)
 #define __alloc_remap_buffer(dev, size, gfp, prot, ret, c)	NULL
-#define __alloc_from_pool(dev, size, ret_page, c)		NULL
+#define __alloc_from_pool(size, ret_page)			NULL
 #define __alloc_from_contiguous(dev, size, prot, ret)		NULL
 #define __free_from_pool(cpu_addr, size)			0
 #define __free_from_contiguous(dev, page, size)			do { } while (0)
-- 
1.7.1.569.g6f426
