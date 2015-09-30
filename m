From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:37 +0100
Subject: [PATCH v5 22/22] xen/swiotlb: Add support for 64KB page granularity
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-23-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Swiotlb is used on ARM64 to support DMA on platform where devices are
not protected by an SMMU. Furthermore it's only enabled for DOM0.

While Xen is always using 4KB page granularity in the stage-2 page table,
Linux ARM64 may either use 4KB or 64KB. This means that a Linux page
can be spanned accross multiple Xen page.

The Swiotlb code has to validate that the buffer used for DMA is
physically contiguous in the memory. As a Linux page can't be shared
between local memory and foreign page by design (the balloon code always
removing entirely a Linux page), the changes in the code are very
minimal because we only need to check the first Xen PFN.

Note that it may be possible to optimize the function
check_page_physically_contiguous to avoid looping over every Xen PFN
for local memory. Although I will let this optimization for a follow-up.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>

    Changes in v5:
        - Patch was previously sent separately
        - Add Stefano's reviewed-by
---
 arch/arm/include/asm/xen/page-coherent.h | 26 +++++++++++++--------
 arch/arm/xen/mm.c                        | 38 ++++++++++++++++++++++---------
 drivers/xen/swiotlb-xen.c                | 39 ++++++++++++++++----------------
 3 files changed, 63 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
index efd5624..0375c8c 100644
--- a/arch/arm/include/asm/xen/page-coherent.h
+++ b/arch/arm/include/asm/xen/page-coherent.h
@@ -35,11 +35,15 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
 	     enum dma_data_direction dir, struct dma_attrs *attrs)
 {
-	bool local = PFN_DOWN(dev_addr) == page_to_pfn(page);
-	/* Dom0 is mapped 1:1, so if pfn == mfn the page is local otherwise
-	 * is a foreign page grant-mapped in dom0. If the page is local we
-	 * can safely call the native dma_ops function, otherwise we call
-	 * the xen specific function. */
+	bool local = XEN_PFN_DOWN(dev_addr) == page_to_xen_pfn(page);
+	/*
+	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
+	 * multiple Xen page, it's not possible to have a mix of local and
+	 * foreign Xen page. So if the first xen_pfn == mfn the page is local
+	 * otherwise it's a foreign page grant-mapped in dom0. If the page is
+	 * local we can safely call the native dma_ops function, otherwise we
+	 * call the xen specific function.
+	 */
 	if (local)
 		__generic_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
 	else
@@ -51,10 +55,14 @@ static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		struct dma_attrs *attrs)
 {
 	unsigned long pfn = PFN_DOWN(handle);
-	/* Dom0 is mapped 1:1, so calling pfn_valid on a foreign mfn will
-	 * always return false. If the page is local we can safely call the
-	 * native dma_ops function, otherwise we call the xen specific
-	 * function. */
+	/*
+	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
+	 * multiple Xen page, it's not possible to have a mix of local and
+	 * foreign Xen page. Dom0 is mapped 1:1, so calling pfn_valid on a
+	 * foreign mfn will always return false. If the page is local we can
+	 * safely call the native dma_ops function, otherwise we call the xen
+	 * specific function.
+	 */
 	if (pfn_valid(pfn)) {
 		if (__generic_dma_ops(hwdev)->unmap_page)
 			__generic_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 7b517e91..7c34f71 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -48,22 +48,22 @@ static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
 	size_t size, enum dma_data_direction dir, enum dma_cache_op op)
 {
 	struct gnttab_cache_flush cflush;
-	unsigned long pfn;
+	unsigned long xen_pfn;
 	size_t left = size;
 
-	pfn = (handle >> PAGE_SHIFT) + offset / PAGE_SIZE;
-	offset %= PAGE_SIZE;
+	xen_pfn = (handle >> XEN_PAGE_SHIFT) + offset / XEN_PAGE_SIZE;
+	offset %= XEN_PAGE_SIZE;
 
 	do {
 		size_t len = left;
 	
 		/* buffers in highmem or foreign pages cannot cross page
 		 * boundaries */
-		if (len + offset > PAGE_SIZE)
-			len = PAGE_SIZE - offset;
+		if (len + offset > XEN_PAGE_SIZE)
+			len = XEN_PAGE_SIZE - offset;
 
 		cflush.op = 0;
-		cflush.a.dev_bus_addr = pfn << PAGE_SHIFT;
+		cflush.a.dev_bus_addr = xen_pfn << XEN_PAGE_SHIFT;
 		cflush.offset = offset;
 		cflush.length = len;
 
@@ -79,7 +79,7 @@ static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
 			HYPERVISOR_grant_table_op(GNTTABOP_cache_flush, &cflush, 1);
 
 		offset = 0;
-		pfn++;
+		xen_pfn++;
 		left -= len;
 	} while (left);
 }
@@ -141,10 +141,26 @@ bool xen_arch_need_swiotlb(struct device *dev,
 			   phys_addr_t phys,
 			   dma_addr_t dev_addr)
 {
-	unsigned long pfn = PFN_DOWN(phys);
-	unsigned long bfn = PFN_DOWN(dev_addr);
-
-	return (!hypercall_cflush && (pfn != bfn) && !is_device_dma_coherent(dev));
+	unsigned int xen_pfn = XEN_PFN_DOWN(phys);
+	unsigned int bfn = XEN_PFN_DOWN(dev_addr);
+
+	/*
+	 * The swiotlb buffer should be used if
+	 *	- Xen doesn't have the cache flush hypercall
+	 *	- The Linux page refers to foreign memory
+	 *	- The device doesn't support coherent DMA request
+	 *
+	 * The Linux page may be spanned acrros multiple Xen page, although
+	 * it's not possible to have a mix of local and foreign Xen page.
+	 * Furthermore, range_straddles_page_boundary is already checking
+	 * if buffer is physically contiguous in the host RAM.
+	 *
+	 * Therefore we only need to check the first Xen page to know if we
+	 * require a bounce buffer because the device doesn't support coherent
+	 * memory and we are not able to flush the cache.
+	 */
+	return (!hypercall_cflush && (xen_pfn != bfn) &&
+		!is_device_dma_coherent(dev));
 }
 
 int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 0a5a0e9..7399782 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -76,27 +76,27 @@ static unsigned long xen_io_tlb_nslabs;
 static u64 start_dma_addr;
 
 /*
- * Both of these functions should avoid PFN_PHYS because phys_addr_t
+ * Both of these functions should avoid XEN_PFN_PHYS because phys_addr_t
  * can be 32bit when dma_addr_t is 64bit leading to a loss in
  * information if the shift is done before casting to 64bit.
  */
 static inline dma_addr_t xen_phys_to_bus(phys_addr_t paddr)
 {
-	unsigned long bfn = pfn_to_bfn(PFN_DOWN(paddr));
-	dma_addr_t dma = (dma_addr_t)bfn << PAGE_SHIFT;
+	unsigned long bfn = pfn_to_bfn(XEN_PFN_DOWN(paddr));
+	dma_addr_t dma = (dma_addr_t)bfn << XEN_PAGE_SHIFT;
 
-	dma |= paddr & ~PAGE_MASK;
+	dma |= paddr & ~XEN_PAGE_MASK;
 
 	return dma;
 }
 
 static inline phys_addr_t xen_bus_to_phys(dma_addr_t baddr)
 {
-	unsigned long pfn = bfn_to_pfn(PFN_DOWN(baddr));
-	dma_addr_t dma = (dma_addr_t)pfn << PAGE_SHIFT;
+	unsigned long xen_pfn = bfn_to_pfn(XEN_PFN_DOWN(baddr));
+	dma_addr_t dma = (dma_addr_t)xen_pfn << XEN_PAGE_SHIFT;
 	phys_addr_t paddr = dma;
 
-	paddr |= baddr & ~PAGE_MASK;
+	paddr |= baddr & ~XEN_PAGE_MASK;
 
 	return paddr;
 }
@@ -106,7 +106,7 @@ static inline dma_addr_t xen_virt_to_bus(void *address)
 	return xen_phys_to_bus(virt_to_phys(address));
 }
 
-static int check_pages_physically_contiguous(unsigned long pfn,
+static int check_pages_physically_contiguous(unsigned long xen_pfn,
 					     unsigned int offset,
 					     size_t length)
 {
@@ -114,11 +114,11 @@ static int check_pages_physically_contiguous(unsigned long pfn,
 	int i;
 	int nr_pages;
 
-	next_bfn = pfn_to_bfn(pfn);
-	nr_pages = (offset + length + PAGE_SIZE-1) >> PAGE_SHIFT;
+	next_bfn = pfn_to_bfn(xen_pfn);
+	nr_pages = (offset + length + XEN_PAGE_SIZE-1) >> XEN_PAGE_SHIFT;
 
 	for (i = 1; i < nr_pages; i++) {
-		if (pfn_to_bfn(++pfn) != ++next_bfn)
+		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
 			return 0;
 	}
 	return 1;
@@ -126,28 +126,27 @@ static int check_pages_physically_contiguous(unsigned long pfn,
 
 static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 {
-	unsigned long pfn = PFN_DOWN(p);
-	unsigned int offset = p & ~PAGE_MASK;
+	unsigned long xen_pfn = XEN_PFN_DOWN(p);
+	unsigned int offset = p & ~XEN_PAGE_MASK;
 
-	if (offset + size <= PAGE_SIZE)
+	if (offset + size <= XEN_PAGE_SIZE)
 		return 0;
-	if (check_pages_physically_contiguous(pfn, offset, size))
+	if (check_pages_physically_contiguous(xen_pfn, offset, size))
 		return 0;
 	return 1;
 }
 
 static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
 {
-	unsigned long bfn = PFN_DOWN(dma_addr);
-	unsigned long pfn = bfn_to_local_pfn(bfn);
-	phys_addr_t paddr;
+	unsigned long bfn = XEN_PFN_DOWN(dma_addr);
+	unsigned long xen_pfn = bfn_to_local_pfn(bfn);
+	phys_addr_t paddr = XEN_PFN_PHYS(xen_pfn);
 
 	/* If the address is outside our domain, it CAN
 	 * have the same virtual address as another address
 	 * in our domain. Therefore _only_ check address within our domain.
 	 */
-	if (pfn_valid(pfn)) {
-		paddr = PFN_PHYS(pfn);
+	if (pfn_valid(PFN_DOWN(paddr))) {
 		return paddr >= virt_to_phys(xen_io_tlb_start) &&
 		       paddr < virt_to_phys(xen_io_tlb_end);
 	}
-- 
2.1.4
