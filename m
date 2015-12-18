From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 18 Dec 2015 17:01:48 +0000
Subject: [PATCH 3/3] iommu/dma: Avoid unlikely high-order allocations
In-Reply-To: <9a84191ed813c23db7901f8c73f514d081495bdf.1450457730.git.robin.murphy@arm.com>
References: <9a84191ed813c23db7901f8c73f514d081495bdf.1450457730.git.robin.murphy@arm.com>
Message-ID: <8014a146e90282b8cbc5868cee0d01776670d9a6.1450457730.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug reports that the equivalent page allocator on 32-bit ARM exhibits
particularly pathalogical behaviour under memory pressure when
fragmentation is high, where allocating a 4MB buffer takes tens of
seconds and the number of calls to alloc_pages() is over 9000![1]

We can drastically improve that situation without losing the other
benefits of high-order allocations when they would succeed, by assuming
memory pressure is relatively constant over the course of an allocation,
and not retrying allocations at orders we know to have failed before.
This way, the best-case behaviour remains unchanged, and in the worst
case we should see at most a dozen or so (MAX_ORDER - 1) failed attempts
before falling back to single pages for the remainder of the buffer.

[1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/394660.html

Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 03811e3..e37516a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -194,6 +194,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
 {
 	struct page **pages;
 	unsigned int i = 0, array_size = count * sizeof(*pages);
+	unsigned int order = MAX_ORDER;
 
 	if (array_size <= PAGE_SIZE)
 		pages = kzalloc(array_size, GFP_KERNEL);
@@ -207,14 +208,15 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
 
 	while (count) {
 		struct page *page = NULL;
-		int j, order = __fls(count);
+		int j;
 
 		/*
 		 * Higher-order allocations are a convenience rather
 		 * than a necessity, hence using __GFP_NORETRY until
 		 * falling back to single-page allocations.
 		 */
-		for (order = min(order, MAX_ORDER); order > 0; order--) {
+		for (order = min_t(unsigned int, order, __fls(count));
+		     order > 0; order--) {
 			page = alloc_pages(gfp | __GFP_NORETRY, order);
 			if (!page)
 				continue;
-- 
1.9.1
