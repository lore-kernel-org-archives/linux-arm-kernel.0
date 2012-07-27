From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 27 Jul 2012 17:18:34 +0200
Subject: [PATCH] ARM: DMA-mapping: fix error path for memory allocation failure
Message-ID: <1343402314-15678-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes incorrect check in error path. When the allocation of
first page fails, the kernel ops appears due to accessing -1 element of
the pages array.

Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7a1d224..3096ed2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -977,7 +977,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size, gfp_t
 
 	return pages;
 error:
-	while (--i)
+	while (i--)
 		if (pages[i])
 			__free_pages(pages[i], 0);
 	if (array_size <= PAGE_SIZE)
-- 
1.7.1.569.g6f426
