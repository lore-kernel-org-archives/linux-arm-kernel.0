From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed,  3 May 2017 15:57:48 +0100
Subject: [PATCH v2] drivers: dma-mapping: Do not leave an invalid area->pages
 pointer in dma_common_contiguous_remap()
Message-ID: <1493823468-19470-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_common_pages_remap() function allocates a vm_struct object and
initialises the pages pointer to value passed as argument. However, when
this function is called dma_common_contiguous_remap(), the pages array
is only temporarily allocated, being freed shortly after
dma_common_contiguous_remap() returns. Architecture code checking the
validity of an area->pages pointer would incorrectly dereference already
freed pointers. This has been exposed by the arm64 commit 44176bb38fa4
("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU").

Fixes: 513510ddba96 ("common: dma-mapping: introduce common remapping functions")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Laura Abbott <labbott@redhat.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Greg,

Please merge this patch via your tree (and therefore I haven't added
your ack). Thanks.

Changes since v1:

- Kept the original comment near the dma_common_pages_remap() function

- Added acks/reviews

 drivers/base/dma-mapping.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index efd71cf4fdea..ac224de462f6 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -273,6 +273,24 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 EXPORT_SYMBOL(dma_common_mmap);
 
 #ifdef CONFIG_MMU
+static struct vm_struct *__dma_common_pages_remap(struct page **pages,
+			size_t size, unsigned long vm_flags, pgprot_t prot,
+			const void *caller)
+{
+	struct vm_struct *area;
+
+	area = get_vm_area_caller(size, vm_flags, caller);
+	if (!area)
+		return NULL;
+
+	if (map_vm_area(area, prot, pages)) {
+		vunmap(area->addr);
+		return NULL;
+	}
+
+	return area;
+}
+
 /*
  * remaps an array of PAGE_SIZE pages into another vm_area
  * Cannot be used in non-sleeping contexts
@@ -283,17 +301,12 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 {
 	struct vm_struct *area;
 
-	area = get_vm_area_caller(size, vm_flags, caller);
+	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
 	if (!area)
 		return NULL;
 
 	area->pages = pages;
 
-	if (map_vm_area(area, prot, pages)) {
-		vunmap(area->addr);
-		return NULL;
-	}
-
 	return area->addr;
 }
 
@@ -308,7 +321,7 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 {
 	int i;
 	struct page **pages;
-	void *ptr;
+	struct vm_struct *area;
 	unsigned long pfn;
 
 	pages = kmalloc(sizeof(struct page *) << get_order(size), GFP_KERNEL);
@@ -318,11 +331,13 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 	for (i = 0, pfn = page_to_pfn(page); i < (size >> PAGE_SHIFT); i++)
 		pages[i] = pfn_to_page(pfn + i);
 
-	ptr = dma_common_pages_remap(pages, size, vm_flags, prot, caller);
+	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
 
 	kfree(pages);
 
-	return ptr;
+	if (!area)
+		return NULL;
+	return area->addr;
 }
 
 /*
