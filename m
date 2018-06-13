From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 13 Jun 2018 10:58:37 +0200
Subject: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
Message-ID: <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cma_alloc() function has gfp mask parameter, so users expect that it
honors typical memory allocation related flags. The most imporant from
the security point of view is handling of __GFP_ZERO flag, because memory
allocated by this function usually can be directly remapped to userspace
by device drivers as a part of multimedia processing and ignoring this
flag might lead to leaking some kernel structures to userspace.
Some callers of this function (for example arm64 dma-iommu glue code)
already assumed that the allocated buffers are cleared when this flag
is set. To avoid such issues, add simple code for clearing newly
allocated buffer when __GFP_ZERO flag is set. Callers will be then
updated to skip implicit clearing or adjust passed gfp flags.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 mm/cma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 5809bbe360d7..1106d5aef2cc 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -464,6 +464,13 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		start = bitmap_no + mask + 1;
 	}
 
+	if (ret == 0 && gfp_mask & __GFP_ZERO) {
+		int i;
+
+		for (i = 0; i < count; i++)
+			clear_highpage(page + i);
+	}
+
 	trace_cma_alloc(pfn, page, count, align);
 
 	if (ret && !(gfp_mask & __GFP_NOWARN)) {
-- 
2.17.1
