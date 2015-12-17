From: dianders@chromium.org (Douglas Anderson)
Date: Thu, 17 Dec 2015 12:30:53 -0800
Subject: [PATCH] ARM: dma-mapping: Just allocate one chunk at a time
Message-ID: <1450384253-1067-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __iommu_alloc_buffer() is expected to be called to allocate pretty
sizeable buffers.  Upon simple tests of video I saw it trying to
allocate 4,194,304 bytes.  The function tries to be efficient about this
by starting out allocating large chunks and then moving to smaller and
smaller chunk sizes until it succeeds.

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
take more than 24 seconds to allocate 4 megs of memory (!!).

A second problem (and maybe even more important) is that allocating big
chunks when we don't need them is just not a good idea anyway.  The
first thing we do with these big chunks is break them into smaller
chunks!  If we allocate small chunks:
- The memory manager doesn't need to work so hard to give us big chunks.
- We can save the big chunks for those that really need them and this
  code can make great use of all the small chunks sitting around.

Let's simplify by just allocating one page at a time.  We may make more
total allocate calls but it works way better.  In real world tests that
used to sometimes see a 24 second allocation call I can now see at most
250 ms.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm/mm/dma-mapping.c | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 492bf3efffab..7efeb2d4801b 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1160,39 +1160,13 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
 
 	while (count) {
-		int j, order;
-
-		for (order = __fls(count); order > 0; --order) {
-			/*
-			 * We do not want OOM killer to be invoked as long
-			 * as we can fall back to single pages, so we force
-			 * __GFP_NORETRY for orders higher than zero.
-			 */
-			pages[i] = alloc_pages(gfp | __GFP_NORETRY, order);
-			if (pages[i])
-				break;
-		}
-
-		if (!pages[i]) {
-			/*
-			 * Fall back to single page allocation.
-			 * Might invoke OOM killer as last resort.
-			 */
-			pages[i] = alloc_pages(gfp, 0);
-			if (!pages[i])
-				goto error;
-		}
-
-		if (order) {
-			split_page(pages[i], order);
-			j = 1 << order;
-			while (--j)
-				pages[i + j] = pages[i] + j;
-		}
+		pages[i] = alloc_pages(gfp, 0);
+		if (!pages[i])
+			goto error;
 
-		__dma_clear_buffer(pages[i], PAGE_SIZE << order);
-		i += 1 << order;
-		count -= 1 << order;
+		__dma_clear_buffer(pages[i], PAGE_SIZE);
+		i += 1;
+		count -= 1;
 	}
 
 	return pages;
-- 
2.6.0.rc2.230.g3dd15c0
