From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 21 Apr 2015 08:57:10 +0100
Subject: [Xen-devel] [PATCH] xen: Add __GFP_DMA flag when
 xen_swiotlb_init gets free pages.
In-Reply-To: <alpine.DEB.2.02.1504201828380.30125@kaball.uk.xensource.com>
References: <1429526904-27176-1-git-send-email-cbz@baozis.org>
 <5534DABB.5060305@citrix.com> <20150420110729.GA27707@cbz-thinkpad>
 <5534EAE3.8060403@citrix.com>
 <alpine.DEB.2.02.1504201828380.30125@kaball.uk.xensource.com>
Message-ID: <1429603030.6174.21.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-04-20 at 18:54 +0100, Stefano Stabellini wrote:
> This should definitely be done only on ARM and ARM64, as on x86 PVH
> assumes the presence of an IOMMU. We need an ifdef.
> 
> Also we need to figure out a way to try without GFP_DMA in case no ram
> under 4g is available at all, as some arm64 platforms don't have any. Of
> course in those cases we don't need to worry about devices and their dma
> masks.  Maybe we could use memblock for that?

It's pretty ugly, but I've not got any better ideas.

It would perhaps be less ugly as a an arch-specific
get_me_a_swiotlb_region type function, with the bare __get_free_pages as
the generic fallback.

>  Something like:
> 
>     struct memblock_region *reg;
>     gfp_t flags = __GFP_NOWARN;
> 
> #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> 	for_each_memblock(memory, reg) {
> 		unsigned long start = memblock_region_memory_base_pfn(reg);
> 
>         if (start < 4G) {
>             flags |= __GFP_DMA;
>             break;
>         }
>     }
> #endif
> 
>     [...]
> 
>     xen_io_tlb_start = (void *)__get_free_pages(flags, order);
>     
> 
> 
> 
> 
> > This is also conceptually wrong since it doesn't matter where the pages
> > are in PFN space,  but where they are in bus address (MFN) space (which
> > is what the subsequent hypercall is required to sort out).
> 
> Actually on ARM dom0 is mapped 1:1, so it is the same thing.

On a system with a fully functional SMMU dom0 may not be 1:1 mapped, but
I think that dom0 can still treat that as 1:1 mapped for these purposes,
since the SMMU will provide that illusion.

Dumb question, and this might affect PVH too, if you have an IOMMU and a
device with a limited DMA range, I suppose you need to provide DMA
addresses in the <4G for the input to the IOMMU (i.e. PFN) and not the
output (i.e. MFN) space (since the device only sees PFNs).

So even for x86 PVH isn't something required here to ensure that the
swiotlb has suitable pages under 4GB in PFN space too?

(On ARM PFN==IPA and MFN==PA)

Second dumb question, on x86 PVH or ARM with an SMMU, would we even hit
the Xen swiotlb code, or would we want to arrange to go via the native
swiotlb paths? I initially thought the latter, but does e.g. grant
mappings still need some special handling?

Ian.
