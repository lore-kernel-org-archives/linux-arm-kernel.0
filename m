From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 21 Apr 2015 12:11:01 +0100
Subject: [Xen-devel] [PATCH] xen: Add __GFP_DMA flag when xen_swiotlb_init
 gets free pages.
In-Reply-To: <alpine.DEB.2.02.1504211115300.3112@kaball.uk.xensource.com>
References: <1429526904-27176-1-git-send-email-cbz@baozis.org>
 <5534DABB.5060305@citrix.com> <20150420110729.GA27707@cbz-thinkpad>
 <5534EAE3.8060403@citrix.com>
 <alpine.DEB.2.02.1504201828380.30125@kaball.uk.xensource.com>
 <1429603030.6174.21.camel@citrix.com>
 <alpine.DEB.2.02.1504211115300.3112@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1504211203520.3112@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Apr 2015, Stefano Stabellini wrote:
> On Tue, 21 Apr 2015, Ian Campbell wrote:
> > On Mon, 2015-04-20 at 18:54 +0100, Stefano Stabellini wrote:
> > > This should definitely be done only on ARM and ARM64, as on x86 PVH
> > > assumes the presence of an IOMMU. We need an ifdef.
> > > 
> > > Also we need to figure out a way to try without GFP_DMA in case no ram
> > > under 4g is available at all, as some arm64 platforms don't have any. Of
> > > course in those cases we don't need to worry about devices and their dma
> > > masks.  Maybe we could use memblock for that?
> > 
> > It's pretty ugly, but I've not got any better ideas.
> > 
> > It would perhaps be less ugly as a an arch-specific
> > get_me_a_swiotlb_region type function, with the bare __get_free_pages as
> > the generic fallback.
> 
> We could do that, but even open code like this isn't too bad: it might
> be ugly but at least is very obvious.

Chen,
could you please try the patch below in your repro scenario?
I have only build tested it.

---

xen: Add __GFP_DMA flag when xen_swiotlb_init gets free pages on ARM

From: Chen Baozi <baozich@gmail.com>

Make sure that xen_swiotlb_init allocates buffers that are DMA capable
when at least one memblock is available below 4G. Otherwise we assume
that all devices on the SoC can cope with >4G addresses.

No functional changes on x86.

Signed-off-by: Chen Baozi <baozich@gmail.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 2f7e6ff..0b579b2 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -110,5 +110,6 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 bool xen_arch_need_swiotlb(struct device *dev,
 			   unsigned long pfn,
 			   unsigned long mfn);
+unsigned long xen_get_swiotlb_free_pages(unsigned int order);
 
 #endif /* _ASM_ARM_XEN_PAGE_H */
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 793551d..4983250 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -4,6 +4,7 @@
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/export.h>
+#include <linux/memblock.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -21,6 +22,20 @@
 #include <asm/xen/hypercall.h>
 #include <asm/xen/interface.h>
 
+unsigned long xen_get_swiotlb_free_pages(unsigned int order)
+{
+	struct memblock_region *reg;
+	gfp_t flags = __GFP_NOWARN;
+
+	for_each_memblock(memory, reg) {
+		if (reg->base < (phys_addr_t)0xffffffff) {
+			flags |= __GFP_DMA;
+			break;
+		}
+	}
+	return __get_free_pages(flags, order);
+}
+
 enum dma_cache_op {
        DMA_UNMAP,
        DMA_MAP,
diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
index 358dcd3..c44a5d5 100644
--- a/arch/x86/include/asm/xen/page.h
+++ b/arch/x86/include/asm/xen/page.h
@@ -269,4 +269,9 @@ static inline bool xen_arch_need_swiotlb(struct device *dev,
 	return false;
 }
 
+static inline unsigned long xen_get_swiotlb_free_pages(unsigned int order)
+{
+	return __get_free_pages(__GFP_NOWARN, order);
+}
+
 #endif /* _ASM_X86_XEN_PAGE_H */
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 810ad41..4c54932 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -235,7 +235,7 @@ retry:
 #define SLABS_PER_PAGE (1 << (PAGE_SHIFT - IO_TLB_SHIFT))
 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
 		while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
-			xen_io_tlb_start = (void *)__get_free_pages(__GFP_NOWARN, order);
+			xen_io_tlb_start = (void *)xen_get_swiotlb_free_pages(order);
 			if (xen_io_tlb_start)
 				break;
 			order--;
