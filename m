From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 16 Jan 2013 16:31:23 +0100
Subject: [PATCH 2/2] ARM: dma-mapping: use himem for DMA buffers for
 IOMMU-mapped devices
In-Reply-To: <1358350284-6972-1-git-send-email-m.szyprowski@samsung.com>
References: <1358350284-6972-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1358350284-6972-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU can provide access to any memory page, so there is no point in
limiting the allocated pages only to lowmem, once other parts of
dma-mapping subsystem correctly supports himem pages.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4080c37..9a6c8ce 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1095,12 +1095,17 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 		return pages;
 	}
 
+	/*
+	 * IOMMU can map any pages, so himem can also be used here
+	 */
+	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
+
 	while (count) {
 		int j, order = __fls(count);
 
-		pages[i] = alloc_pages(gfp | __GFP_NOWARN, order);
+		pages[i] = alloc_pages(gfp, order);
 		while (!pages[i] && order)
-			pages[i] = alloc_pages(gfp | __GFP_NOWARN, --order);
+			pages[i] = alloc_pages(gfp, --order);
 		if (!pages[i])
 			goto error;
 
-- 
1.7.9.5
