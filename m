From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:36 +0100
Subject: [PATCH v5 21/22] xen/swiotlb: Pass addresses rather than frame
 numbers to xen_arch_need_swiotlb
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-22-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With 64KB page granularity support, the frame number will be different.

It will be easier to modify the behavior in a single place rather than
in each caller.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86 at kernel.org

    Changes in v5:
        - Patch was previously sent separately
        - Fix compilation on x86 (spurious ; at the end of the
        declaration)
        - Add Stefano's reviewed-by
---
 arch/arm/include/asm/xen/page.h | 4 ++--
 arch/arm/xen/mm.c               | 7 +++++--
 arch/x86/include/asm/xen/page.h | 4 ++--
 drivers/xen/swiotlb-xen.c       | 4 ++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index e3d94cf..415dbc6 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -115,8 +115,8 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 #define xen_unmap(cookie) iounmap((cookie))
 
 bool xen_arch_need_swiotlb(struct device *dev,
-			   unsigned long pfn,
-			   unsigned long bfn);
+			   phys_addr_t phys,
+			   dma_addr_t dev_addr);
 unsigned long xen_get_swiotlb_free_pages(unsigned int order);
 
 #endif /* _ASM_ARM_XEN_PAGE_H */
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 6dd911d..7b517e91 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -138,9 +138,12 @@ void __xen_dma_sync_single_for_device(struct device *hwdev,
 }
 
 bool xen_arch_need_swiotlb(struct device *dev,
-			   unsigned long pfn,
-			   unsigned long bfn)
+			   phys_addr_t phys,
+			   dma_addr_t dev_addr)
 {
+	unsigned long pfn = PFN_DOWN(phys);
+	unsigned long bfn = PFN_DOWN(dev_addr);
+
 	return (!hypercall_cflush && (pfn != bfn) && !is_device_dma_coherent(dev));
 }
 
diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
index fe58e3a..f5fb840 100644
--- a/arch/x86/include/asm/xen/page.h
+++ b/arch/x86/include/asm/xen/page.h
@@ -298,8 +298,8 @@ void make_lowmem_page_readwrite(void *vaddr);
 #define xen_unmap(cookie) iounmap((cookie))
 
 static inline bool xen_arch_need_swiotlb(struct device *dev,
-					 unsigned long pfn,
-					 unsigned long bfn)
+					 phys_addr_t phys,
+					 dma_addr_t dev_addr)
 {
 	return false;
 }
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 79bc493..0a5a0e9 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -392,7 +392,7 @@ dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 */
 	if (dma_capable(dev, dev_addr, size) &&
 	    !range_straddles_page_boundary(phys, size) &&
-		!xen_arch_need_swiotlb(dev, PFN_DOWN(phys), PFN_DOWN(dev_addr)) &&
+		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
 		!swiotlb_force) {
 		/* we are not interested in the dma_addr returned by
 		 * xen_dma_map_page, only in the potential cache flushes executed
@@ -551,7 +551,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 		dma_addr_t dev_addr = xen_phys_to_bus(paddr);
 
 		if (swiotlb_force ||
-		    xen_arch_need_swiotlb(hwdev, PFN_DOWN(paddr), PFN_DOWN(dev_addr)) ||
+		    xen_arch_need_swiotlb(hwdev, paddr, dev_addr) ||
 		    !dma_capable(hwdev, dev_addr, sg->length) ||
 		    range_straddles_page_boundary(paddr, sg->length)) {
 			phys_addr_t map = swiotlb_tbl_map_single(hwdev,
-- 
2.1.4
