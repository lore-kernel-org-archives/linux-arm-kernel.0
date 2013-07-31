From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 31 Jul 2013 20:54:10 +0100
Subject: [PATCH v2 RFC 6/8] xen: make xen_create_contiguous_region return the
 dma address
In-Reply-To: <alpine.DEB.2.02.1307312048511.4893@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1307312048511.4893@kaball.uk.xensource.com>
Message-ID: <1375300452-12545-6-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify xen_create_contiguous_region to return the dma address of the
newly contiguous buffer.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: david.vrabel at citrix.com
---
 arch/x86/xen/mmu.c        |    4 +++-
 drivers/xen/swiotlb-xen.c |    6 +++---
 include/xen/xen-ops.h     |    3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index fdc3ba2..df9ab44 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -2329,7 +2329,8 @@ static int xen_exchange_memory(unsigned long extents_in, unsigned int order_in,
 }
 
 int xen_create_contiguous_region(unsigned long vstart, unsigned int order,
-				 unsigned int address_bits)
+				 unsigned int address_bits,
+				 dma_addr_t *dma_handle)
 {
 	unsigned long *in_frames = discontig_frames, out_frame;
 	unsigned long  flags;
@@ -2368,6 +2369,7 @@ int xen_create_contiguous_region(unsigned long vstart, unsigned int order,
 
 	spin_unlock_irqrestore(&xen_reservation_lock, flags);
 
+	*dma_handle = xen_virt_to_bus(vstart);
 	return success ? 0 : -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(xen_create_contiguous_region);
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index aadffcf..353f013 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -126,6 +126,7 @@ xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
 {
 	int i, rc;
 	int dma_bits;
+	dma_addr_t dma_handle;
 
 	dma_bits = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT) + PAGE_SHIFT;
 
@@ -137,7 +138,7 @@ xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
 			rc = xen_create_contiguous_region(
 				(unsigned long)buf + (i << IO_TLB_SHIFT),
 				get_order(slabs << IO_TLB_SHIFT),
-				dma_bits);
+				dma_bits, &dma_handle);
 		} while (rc && dma_bits++ < max_dma_bits);
 		if (rc)
 			return rc;
@@ -294,11 +295,10 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		*dma_handle = dev_addr;
 	else {
 		if (xen_create_contiguous_region(vstart, order,
-						 fls64(dma_mask)) != 0) {
+						 fls64(dma_mask), dma_handle) != 0) {
 			free_pages(vstart, order);
 			return NULL;
 		}
-		*dma_handle = virt_to_machine(ret).maddr;
 	}
 	memset(ret, 0, size);
 	return ret;
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index d6fe062..9ef704d 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -20,7 +20,8 @@ int xen_setup_shutdown_event(void);
 
 extern unsigned long *xen_contiguous_bitmap;
 int xen_create_contiguous_region(unsigned long vstart, unsigned int order,
-				unsigned int address_bits);
+				unsigned int address_bits,
+				dma_addr_t *dma_handle);
 
 void xen_destroy_contiguous_region(unsigned long vstart, unsigned int order);
 
-- 
1.7.2.5
