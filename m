From: mzoran@crowfest.net (Michael Zoran)
Date: Mon, 31 Oct 2016 12:53:13 -0700
Subject: [PATCH] staging: vc04_services: setup DMA and coherent mask
In-Reply-To: <1477939258.30971.1.camel@crowfest.net>
References: <20161028171159.23973-1-mzoran@crowfest.net>
 <87twbsqsb4.fsf@eliezer.anholt.net> <1477939258.30971.1.camel@crowfest.net>
Message-ID: <1477943593.30971.3.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-10-31 at 11:40 -0700, Michael Zoran wrote:
> On Mon, 2016-10-31 at 11:36 -0700, Eric Anholt wrote:
> > Michael Zoran <mzoran@crowfest.net> writes:
> > 
> > > Setting the DMA mask is optional on 32 bit but
> > > is mandatory on 64 bit.??Set the DMA mask and coherent
> > > to force all DMA to be in the 32 bit address space.
> > > 
> > > This is considered a "good practice" and most drivers
> > > already do this.
> > > 
> > > Signed-off-by: Michael Zoran <mzoran@crowfest.net>
> > > ---
> > > ?.../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c |
> > > 10 ++++++++++
> > > ?1 file changed, 10 insertions(+)
> > > 
> > > diff --git
> > > a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_ar
> > > m.
> > > c
> > > b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_ar
> > > m.
> > > c
> > > index a5afcc5..6fa2b5a 100644
> > > ---
> > > a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_ar
> > > m.
> > > c
> > > +++
> > > b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_ar
> > > m.
> > > c
> > > @@ -97,6 +97,16 @@ int vchiq_platform_init(struct platform_device
> > > *pdev, VCHIQ_STATE_T *state)
> > > ?	int slot_mem_size, frag_mem_size;
> > > ?	int err, irq, i;
> > > ?
> > > +	/*
> > > +	?* Setting the DMA mask is necessary in the 64 bit
> > > environment.
> > > +	?* It isn't necessary in a 32 bit environment but is
> > > considered
> > > +	?* a good practice.
> > > +	?*/
> > > +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > 
> > I think a better comment here would be simply:
> > 
> > /* VCHI messages between the CPU and firmware use 32-bit bus
> > addresses. */
> > 
> > explaining why the value is chosen (once you know that the 32 bit
> > restriction exists, reporting it is obviously needed).??I'm
> > curious,
> > though: what failed when you didn't set it?
> > 
> 
> The comment is easy to change.
> 
> I don't have the log available ATM, but if I remember the DMA API's
> bugcheck the first time that are used.??
> 
> I think this was a policy decision or something because the
> information
> should be available in the dma-ranges.
> 
> If it's important, I can setup a test again without the change and e-
> mail the logs.
> 
> If you look at the DWC2 driver you will see that it also sets this
> mask.

OK, I'm begging to understand this.  It appears the architecture
specific paths are very different.

In arm the mask and coherent is set to DMA_BIT_MASK(32) in mm/dma-
mapping.c the first time the dma APIs are used.  On arm64, it appears
this variable is uninitialized and will contain random crude.

Like I said, I don't know if this is a policy decision or if it just
slipped through the cracks.

arch/arm/mm/dma-mapping.c(Note the call to get_coherent_dma_mask(dev))

static u64 get_coherent_dma_mask(struct device *dev)
{
	u64 mask = (u64)DMA_BIT_MASK(32);

	if (dev) {
		mask = dev->coherent_dma_mask;

		/*
		?* Sanity check the DMA mask - it must be non-zero, and
		?* must be able to be satisfied by a DMA allocation.
		?*/
		if (mask == 0) {
			dev_warn(dev, "coherent DMA mask is unset\n");
			return 0;
		}

		if (!__dma_supported(dev, mask, true))
			return 0;
	}

	return mask;
}

static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t
*handle,
			?gfp_t gfp, pgprot_t prot, bool is_coherent,
			?unsigned long attrs, const void *caller)
{
	u64 mask = get_coherent_dma_mask(dev);
	struct page *page = NULL;
	void *addr;
	bool allowblock, cma;
	struct arm_dma_buffer *buf;
	struct arm_dma_alloc_args args = {
		.dev = dev,
		.size = PAGE_ALIGN(size),
		.gfp = gfp,
		.prot = prot,
		.caller = caller,
		.want_vaddr = ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) ==
0),
		.coherent_flag = is_coherent ? COHERENT : NORMAL,
	};

arch/arm64/include/asm/dma-mapping.h

/* do not use this function in a driver */
static inline bool is_device_dma_coherent(struct device *dev)
{
	if (!dev)
		return false;
	return dev->archdata.dma_coherent;
}

arch/arm64/mm/dma-mapping.c(Note no call to get_coherent_dma_mask)

static void *__dma_alloc(struct device *dev, size_t size,
			?dma_addr_t *dma_handle, gfp_t flags,
			?unsigned long attrs)
{
	struct page *page;
	void *ptr, *coherent_ptr;
	bool coherent = is_device_dma_coherent(dev);
	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, false);

	size = PAGE_ALIGN(size);

	if (!coherent && !gfpflags_allow_blocking(flags)) {
		struct page *page = NULL;
		void *addr = __alloc_from_pool(size, &page, flags);

		if (addr)
			*dma_handle = phys_to_dma(dev,
page_to_phys(page));

		return addr;
	}

	ptr = __dma_alloc_coherent(dev, size, dma_handle, flags,
attrs);
