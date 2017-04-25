From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Apr 2017 19:22:23 +0100
Subject: [PATCH] arm64: Do not leave an invalid area->pages pointer in
 dma_common_contiguous_remap()
Message-ID: <1493144543-2497-1-git-send-email-catalin.marinas@arm.com>
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
Cc: Laura Abbott <labbott@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

This is for correctness since once the arm64's mmap and get_sgtable ops
are fixed for DMA_ATTR_FORCE_CONTIGUOUS, we would no longer see the
issue. Anyway, it's better to get this fixed in case others trip over a
similar issue. I added a "Fixes" tag for completeness but I'm not sure
it's worth back-porting.

 drivers/base/dma-mapping.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index efd71cf4fdea..ab7071041141 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -277,8 +277,8 @@ EXPORT_SYMBOL(dma_common_mmap);
  * remaps an array of PAGE_SIZE pages into another vm_area
  * Cannot be used in non-sleeping contexts
  */
-void *dma_common_pages_remap(struct page **pages, size_t size,
-			unsigned long vm_flags, pgprot_t prot,
+static struct vm_struct *__dma_common_pages_remap(struct page **pages,
+			size_t size, unsigned long vm_flags, pgprot_t prot,
 			const void *caller)
 {
 	struct vm_struct *area;
@@ -287,13 +287,26 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 	if (!area)
 		return NULL;
 
-	area->pages = pages;
-
 	if (map_vm_area(area, prot, pages)) {
 		vunmap(area->addr);
 		return NULL;
 	}
 
+	return area;
+}
+
+void *dma_common_pages_remap(struct page **pages, size_t size,
+			unsigned long vm_flags, pgprot_t prot,
+			const void *caller)
+{
+	struct vm_struct *area;
+
+	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
+	if (!area)
+		return NULL;
+
+	area->pages = pages;
+
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
