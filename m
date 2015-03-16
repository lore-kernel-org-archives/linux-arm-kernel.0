From: tfiga@chromium.org (Tomasz Figa)
Date: Mon, 16 Mar 2015 17:12:05 +0900
Subject: [PATCH] ARM: mm: Do not invoke OOM for higher order IOMMU DMA
 allocations
Message-ID: <1426493525-25502-1-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU should be able to use single pages as well as bigger blocks, so if
higher order allocations fail, we should not affect state of the system,
with events such as OOM killer, but rather fall back to order 0
allocations.

This patch changes the behavior of ARM IOMMU DMA allocator to use
__GFP_NORETRY, which bypasses OOM invocation, for positive orders and
only if that fails doing OOMable order 0 allocation as a fall back.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 arch/arm/mm/dma-mapping.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 83cd5ac..f081e9e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1145,18 +1145,31 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	}
 
 	/*
-	 * IOMMU can map any pages, so himem can also be used here
+	 * IOMMU can map any pages, so himem can also be used here.
+	 * We do not want OOM killer to be invoked as long as we can fall back
+	 * to single pages, so we use __GFP_NORETRY for positive orders.
 	 */
-	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
+	gfp |= __GFP_NOWARN | __GFP_HIGHMEM | __GFP_NORETRY;
 
 	while (count) {
-		int j, order = __fls(count);
+		int j, order;
 
-		pages[i] = alloc_pages(gfp, order);
-		while (!pages[i] && order)
-			pages[i] = alloc_pages(gfp, --order);
-		if (!pages[i])
-			goto error;
+		for (order = __fls(count); order; --order) {
+			/* Will not trigger OOM. */
+			pages[i] = alloc_pages(gfp, order);
+			if (pages[i])
+				break;
+		}
+
+		if (!pages[i]) {
+			/*
+			 * Fall back to single page allocation.
+			 * Might invoke OOM killer as last resort.
+			 */
+			pages[i] = alloc_pages(gfp & ~__GFP_NORETRY, 0);
+			if (!pages[i])
+				goto error;
+		}
 
 		if (order) {
 			split_page(pages[i], order);
-- 
2.1.2
