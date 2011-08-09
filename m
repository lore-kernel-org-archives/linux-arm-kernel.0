From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 09 Aug 2011 08:51:37 +0200
Subject: [RFC] ARM: dma_map|unmap_sg plus iommu
In-Reply-To: <CAB-zwWhh=ZTvheTebKhz55rr1=WFD8R=+BWZ8mwYiO_25mjpYA@mail.gmail.com>
References: <CAB-zwWjb+2ExjNDB3OtHmRmgaHMnO-VgEe9VZk_wU=ryrq_AGw@mail.gmail.com>
	<000301cc4dc4$31b53630$951fa290$%szyprowski@samsung.com>
	<CAB-zwWhh=ZTvheTebKhz55rr1=WFD8R=+BWZ8mwYiO_25mjpYA@mail.gmail.com>
Message-ID: <01e301cc5660$c93d51f0$5bb7f5d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, August 08, 2011 5:05 PM Ramirez Luna, Omar wrote:

> On Fri, Jul 29, 2011 at 2:50 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >> 1. There is no way to keep track of what virtual address are being mapped
> >> in the scatterlist, which we need to propagate to the dsp, in order that it
> >> knows where does the buffers start and end on its virtual address space.
> >> I ended up adding an iov_address to scatterlist which if accepted should be
> >> toggled/affected by the selection of CONFIG_IOMMU_API.
> >
> > Sorry, but your patch is completely wrong. You should not add any additional
> > entries to scatterlist.
> 
> At the time it was the easiest way for me to keep track of both
> virtual and physical addresses, without doing a page_to_phys every
> time on unmap. I understand that it might fall out of the scope of the
> scatterlist struct.
> 
> > dma_addr IS the virtual address in the device's io
> > address space, so the dma_addr is a value that your device should put into
> > it's own registers to start dma transfer to provided memory pages.
> 
> I also wanted to keep the same part as the original arm_dma_map_sg:
> 
> s->dma_address = __dma_map_page...
> 
> Where the dma_address was the "clean" (from cache) physical address.

Nope, DMA-mapping API defines dma_address as a value that should be written to 
device registers to start DMA transfer. Physical address of the page should
never
be used by the driver directly.

> But if desired, I guess this value can be replaced for the iommu va.
> 
> >> 2. tidspbridge driver sometimes needs to map a physical address into a
> >> fixed virtual address (i.e. the start of a firmware section is expected to
> >> be at dsp va 0x20000000), there is no straight forward way to do this with
> >> the dma api given that it only expects to receive a cpu_addr, a sg or a
> >> page, by adding iov_address I could pass phys and iov addresses in a sg
> >> and overcome this limitation, but, these addresses belong to:
> >
> > We also encountered the problem of fixed firmware address. We addressed is
by
> > setting io address space start to this address and letting device driver to
> > rely on the fact that the first call to dma_alloc() will match this address.
> 
> Indeed, however in my case, I need sections at (I might have
> approximated the numbers to the real ones):
> 
> 0x11000000 for dsp shared memory
> 0x11800000 for peripherals
> 0x20000000 for dsp external code
> 0x21000000 for mapped buffers
> 
> The end of a section and start of the other usually have a gap, so the
> exact address needs to be specified by the firmware. So, this won't
> work with just letting the pool manager to provide the virtual
> address.

Are all of these regions used by the same single device driver? It looks
that you might need to create separate struct device entries for each 'memory'
region and attach them as the children to your main device structure. Each
such child device can have different iommu/memory configuration and the main
driver can easily gather them with device_find_child() function. We have such
solution working very well for our video codec. Please refer to the following
patches merged to v3.1-rc1:

1. MFC driver: af935746781088f28904601469671d244d2f653b - 
	drivers/media/video/s5p-mfc/s5p_mfc.c, function s5p_mfc_probe()

2. platform device definitions: 0f75a96bc0c4611dea0c7207533f822315120054 

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
