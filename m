From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 20 Apr 2015 18:54:22 +0100
Subject: [Xen-devel] [PATCH] xen: Add __GFP_DMA flag when xen_swiotlb_init
 gets free pages.
In-Reply-To: <5534EAE3.8060403@citrix.com>
References: <1429526904-27176-1-git-send-email-cbz@baozis.org>
 <5534DABB.5060305@citrix.com> <20150420110729.GA27707@cbz-thinkpad>
 <5534EAE3.8060403@citrix.com>
Message-ID: <alpine.DEB.2.02.1504201828380.30125@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Apr 2015, David Vrabel wrote:
> On 20/04/15 12:07, Chen Baozi wrote:
> > On Mon, Apr 20, 2015 at 11:53:47AM +0100, David Vrabel wrote:
> >> On 20/04/15 11:48, Chen Baozi wrote:
> >>> Make sure that xen_swiotlb_init allocates buffers that is DMA capable.
> >>>
> >>> Signed-off-by: Chen Baozi <baozich@gmail.com>
> >>> ---
> >>>  drivers/xen/swiotlb-xen.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> >>> index 810ad41..7345afd 100644
> >>> --- a/drivers/xen/swiotlb-xen.c
> >>> +++ b/drivers/xen/swiotlb-xen.c
> >>> @@ -235,7 +235,8 @@ retry:
> >>>  #define SLABS_PER_PAGE (1 << (PAGE_SHIFT - IO_TLB_SHIFT))
> >>>  #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
> >>>  		while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
> >>> -			xen_io_tlb_start = (void *)__get_free_pages(__GFP_NOWARN, order);
> >>> +			xen_io_tlb_start = (void *)__get_free_pages(
> >>> +						__GFP_NOWARN|__GFP_DMA, order);
> >>
> >> I think this breaks x86 where __GFP_DMA means below 16 MB.  Perhaps you
> >> mean __GFP_DMA32?
> > 
> > __GFP_DMA32 doesn't help on arm64...
> > 
> > I guess there might be conflicts about the meaning of __GFP_DMA between x86 and
> > arm?
> 
> Yes.

This should definitely be done only on ARM and ARM64, as on x86 PVH
assumes the presence of an IOMMU. We need an ifdef.

Also we need to figure out a way to try without GFP_DMA in case no ram
under 4g is available at all, as some arm64 platforms don't have any. Of
course in those cases we don't need to worry about devices and their dma
masks.  Maybe we could use memblock for that? Something like:

    struct memblock_region *reg;
    gfp_t flags = __GFP_NOWARN;

#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
	for_each_memblock(memory, reg) {
		unsigned long start = memblock_region_memory_base_pfn(reg);

        if (start < 4G) {
            flags |= __GFP_DMA;
            break;
        }
    }
#endif

    [...]

    xen_io_tlb_start = (void *)__get_free_pages(flags, order);
    




> This is also conceptually wrong since it doesn't matter where the pages
> are in PFN space,  but where they are in bus address (MFN) space (which
> is what the subsequent hypercall is required to sort out).

Actually on ARM dom0 is mapped 1:1, so it is the same thing.
