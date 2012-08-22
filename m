From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 22 Aug 2012 10:20:54 -0000
Subject: [RFC 2/4] ARM: dma-mapping: IOMMU allocates pages from pool with
 GFP_ATOMIC
In-Reply-To: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
References: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1345630830-9586-3-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Makes use of the same atomic pool from DMA, and skips kernel page
mapping which can involves sleep'able operation at allocating a kernel
page table.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index aec0c06..9260107 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1028,7 +1028,6 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	struct page **pages;
 	int count = size >> PAGE_SHIFT;
 	int array_size = count * sizeof(struct page *);
-	int err;
 
 	if (array_size <= PAGE_SIZE)
 		pages = kzalloc(array_size, gfp);
@@ -1037,9 +1036,20 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	if (!pages)
 		return NULL;
 
-	err = __alloc_fill_pages(&pages, count, gfp);
-	if (err)
-		goto error
+	if (gfp & GFP_ATOMIC) {
+		struct page *page;
+		int i;
+		void *addr = __alloc_from_pool(size, &page);
+		if (!addr)
+			goto err_out;
+
+		for (i = 0; i < count; i++)
+			pages[i] = page + i;
+	} else {
+		int err = __alloc_fill_pages(&pages, count, gfp);
+		if (err)
+			goto error;
+	}
 
 	return pages;
 error:
@@ -1055,6 +1065,10 @@ static int __iommu_free_buffer(struct device *dev, struct page **pages, size_t s
 	int count = size >> PAGE_SHIFT;
 	int array_size = count * sizeof(struct page *);
 	int i;
+
+	if (__free_from_pool(page_address(pages[0]), size))
+		return 0;
+
 	for (i = 0; i < count; i++)
 		if (pages[i])
 			__free_pages(pages[i], 0);
-- 
1.7.5.4
