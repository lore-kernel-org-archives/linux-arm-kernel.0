From: hch@lst.de (Christoph Hellwig)
Date: Mon,  5 Nov 2018 13:19:24 +0100
Subject: [PATCH 2/9] dma-direct: reject highmem pages from
 dma_alloc_from_contiguous
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
Message-ID: <20181105121931.13481-3-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_alloc_from_contiguous can return highmem pages depending on the
setup, which a plain non-remapping DMA allocator can't handle.  Detect
this case and try the normal page allocator instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 680287779b0a..c49849bcced6 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -162,6 +162,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
+	if (PageHighMem(page)) {
+		/*
+		 * Depending on the cma= arguments and per-arch setup
+		 * dma_alloc_from_contiguous could return highmem pages.
+		 * Without remapping there is no way to return them here,
+		 * so log an error and fail.
+		 */
+		dev_info(dev, "Rejecting highmem page from CMA.\n");
+		__dma_direct_free_pages(dev, size, page);
+		return NULL;
+	}
+
 	ret = page_address(page);
 	if (force_dma_unencrypted()) {
 		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
-- 
2.19.1
