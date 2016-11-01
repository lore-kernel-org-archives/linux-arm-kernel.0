From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Nov 2016 09:31:40 +0000
Subject: [PATCH] staging: vc04_services: setup DMA and coherent mask
In-Reply-To: <1477943593.30971.3.camel@crowfest.net>
References: <20161028171159.23973-1-mzoran@crowfest.net>
 <87twbsqsb4.fsf@eliezer.anholt.net>
 <1477939258.30971.1.camel@crowfest.net>
 <1477943593.30971.3.camel@crowfest.net>
Message-ID: <20161101093140.GN1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 12:53:13PM -0700, Michael Zoran wrote:
> On Mon, 2016-10-31 at 11:40 -0700, Michael Zoran wrote:
> > The comment is easy to change.
> > 
> > I don't have the log available ATM, but if I remember the DMA API's
> > bugcheck the first time that are used.??
> > 
> > I think this was a policy decision or something because the
> > information
> > should be available in the dma-ranges.
> > 
> > If it's important, I can setup a test again without the change and e-
> > mail the logs.
> > 
> > If you look at the DWC2 driver you will see that it also sets this
> > mask.
> 
> OK, I'm begging to understand this.  It appears the architecture
> specific paths are very different.
> 
> In arm the mask and coherent is set to DMA_BIT_MASK(32) in mm/dma-
> mapping.c the first time the dma APIs are used.

I'm not sure where you get that from, this is absolutely not the case.

>  On arm64, it appears
> this variable is uninitialized and will contain random crude.
> 
> Like I said, I don't know if this is a policy decision or if it just
> slipped through the cracks.
> 
> arch/arm/mm/dma-mapping.c(Note the call to get_coherent_dma_mask(dev))
> 
> static u64 get_coherent_dma_mask(struct device *dev)
> {
> 	u64 mask = (u64)DMA_BIT_MASK(32);
> 
> 	if (dev) {
> 		mask = dev->coherent_dma_mask;
> 
> 		/*
> 		?* Sanity check the DMA mask - it must be non-zero, and
> 		?* must be able to be satisfied by a DMA allocation.
> 		?*/
> 		if (mask == 0) {
> 			dev_warn(dev, "coherent DMA mask is unset\n");
> 			return 0;

If the mask is unset (iow, zero) this function returns zero.  There
is no "the first time" here anywhere - dev->coherent_dma_mask remains
at zero and doesn't change as a result of calling this path.

> 		}
> 
> 		if (!__dma_supported(dev, mask, true))
> 			return 0;
> 	}
> 
> 	return mask;
> }
> 
> static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t
> *handle,
> 			?gfp_t gfp, pgprot_t prot, bool is_coherent,
> 			?unsigned long attrs, const void *caller)
> {
> 	u64 mask = get_coherent_dma_mask(dev);
> 	struct page *page = NULL;
> 	void *addr;
> 	bool allowblock, cma;
> 	struct arm_dma_buffer *buf;
> 	struct arm_dma_alloc_args args = {
> 		.dev = dev,
> 		.size = PAGE_ALIGN(size),
> 		.gfp = gfp,
> 		.prot = prot,
> 		.caller = caller,
> 		.want_vaddr = ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) ==
> 0),
> 		.coherent_flag = is_coherent ? COHERENT : NORMAL,
> 	};

which then causes:

        if (!mask)
                return NULL;

this function to return NULL, hence failing the request.  Rightfully
so, because we don't know what an acceptable allocation for the device
would be, as the device is effectively saying "I support 0 bits of DMA
address."

Now, firstly, the driver is required to call one of:

	dma_set_mask_and_coherent()
	dma_set_coherent_mask()

if it is to use coherent DMA - see Documentation/DMA-API-HOWTO.txt.
However, the bus code should already have setup a default mask in both
dev->dma_mask and the coherent DMA mask if DMA is possible, which
normally will be the 32-bit mask.

As explained in the document, if the device and driver supports 64-bit
addressing, and wants to make use of it, it must successfully negotiate
with the kernel before using it, which includes making calls to change
the DMA masks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
