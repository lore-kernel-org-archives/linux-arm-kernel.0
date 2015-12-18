From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 18 Dec 2015 14:27:01 -0800
Subject: [PATCH v2 1/2] ARM: dma-mapping: Optimize allocation
Message-ID: <1450477622-30948-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __iommu_alloc_buffer() is expected to be called to allocate pretty
sizeable buffers.  Upon simple tests of video I saw it trying to
allocate 4,194,304 bytes.  The function tries to allocate large chunks
in order to optimize IOMMU TLB usage.

The current function is very, very slow.

One problem is the way it keeps trying and trying to allocate big
chunks.  Imagine a very fragmented memory that has 4M free but no
contiguous pages at all.  Further imagine allocating 4M (1024 pages).
We'll do the following memory allocations:
- For page 1:
  - Try to allocate order 10 (no retry)
  - Try to allocate order 9 (no retry)
  - ...
  - Try to allocate order 0 (with retry, but not needed)
- For page 2:
  - Try to allocate order 9 (no retry)
  - Try to allocate order 8 (no retry)
  - ...
  - Try to allocate order 0 (with retry, but not needed)
- ...
- ...

Total number of calls to alloc() calls for this case is:
  sum(int(math.log(i, 2)) + 1 for i in range(1, 1025))
  => 9228

The above is obviously worse case, but given how slow alloc can be we
really want to try to avoid even somewhat bad cases.  I timed the old
code with a device under memory pressure and it wasn't hard to see it
take more than 120 seconds to allocate 4 megs of memory! (NOTE: testing
was done on kernel 3.14, so possibly mainline would behave
differently).

A second problem is that allocating big chunks under memory pressure
when we don't need them is just not a great idea anyway unless we really
need them.  We can make due pretty well with smaller chunks so it's
probably wise to leave bigger chunks for other users once memory
pressure is on.

Let's adjust the allocation like this:

1. If a big chunk fails, stop trying to hard and bump down to lower
   order allocations.
2. Don't try useless orders.  The whole point of big chunks is to
   optimize the TLB and it can really only make use of 2M, 1M, 64K and
   4K sizes.

We'll still tend to eat up a bunch of big chunks, but that might be the
right answer for some users.  A future patch could possibly add a new
DMA_ATTR that would let the caller decide that TLB optimization isn't
important and that we should use smaller chunks.  Presumably this would
be a sane strategy for some callers.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- No longer just 1 page at a time, but gives up higher order quickly.
- Only tries important higher order allocations that might help us.

 arch/arm/mm/dma-mapping.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 492bf3efffab..9887d432cf1f 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1122,6 +1122,9 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 	spin_unlock_irqrestore(&mapping->lock, flags);
 }
 
+/* We'll try 2M, 1M, 64K, and finally 4K; array must end with 0! */
+static const int iommu_order_array[] = { 9, 8, 4, 0 };
+
 static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 					  gfp_t gfp, struct dma_attrs *attrs)
 {
@@ -1129,6 +1132,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	int count = size >> PAGE_SHIFT;
 	int array_size = count * sizeof(struct page *);
 	int i = 0;
+	int order_idx = 0;
 
 	if (array_size <= PAGE_SIZE)
 		pages = kzalloc(array_size, GFP_KERNEL);
@@ -1162,22 +1166,24 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	while (count) {
 		int j, order;
 
-		for (order = __fls(count); order > 0; --order) {
-			/*
-			 * We do not want OOM killer to be invoked as long
-			 * as we can fall back to single pages, so we force
-			 * __GFP_NORETRY for orders higher than zero.
-			 */
-			pages[i] = alloc_pages(gfp | __GFP_NORETRY, order);
-			if (pages[i])
-				break;
+		order = iommu_order_array[order_idx];
+
+		/* Drop down when we get small */
+		if (__fls(count) < order) {
+			order_idx++;
+			continue;
 		}
 
-		if (!pages[i]) {
-			/*
-			 * Fall back to single page allocation.
-			 * Might invoke OOM killer as last resort.
-			 */
+		if (order) {
+			/* See if it's easy to allocate a high-order chunk */
+			pages[i] = alloc_pages(gfp | __GFP_NORETRY, order);
+
+			/* Go down a notch@first sign of pressure */
+			if (!pages[i]) {
+				order_idx++;
+				continue;
+			}
+		} else {
 			pages[i] = alloc_pages(gfp, 0);
 			if (!pages[i])
 				goto error;
-- 
2.6.0.rc2.230.g3dd15c0
