From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sat, 13 Aug 2011 09:39:55 -0500
Subject: [RFC] ARM: dma_map|unmap_sg plus iommu
In-Reply-To: <01e301cc5660$c93d51f0$5bb7f5d0$%szyprowski@samsung.com>
References: <CAB-zwWjb+2ExjNDB3OtHmRmgaHMnO-VgEe9VZk_wU=ryrq_AGw@mail.gmail.com>
	<000301cc4dc4$31b53630$951fa290$%szyprowski@samsung.com>
	<CAB-zwWhh=ZTvheTebKhz55rr1=WFD8R=+BWZ8mwYiO_25mjpYA@mail.gmail.com>
	<01e301cc5660$c93d51f0$5bb7f5d0$%szyprowski@samsung.com>
Message-ID: <CAB-zwWgN+OoGKxs=aCunCeu8yx+RDFOj2Nk6MM0a40v2+phTxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2011 at 1:51 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On Monday, August 08, 2011 5:05 PM Ramirez Luna, Omar wrote:
>
>> On Fri, Jul 29, 2011 at 2:50 AM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>> > dma_addr IS the virtual address in the device's io
>> > address space, so the dma_addr is a value that your device should put into
>> > it's own registers to start dma transfer to provided memory pages.
>>
>> I also wanted to keep the same part as the original arm_dma_map_sg:
>>
>> s->dma_address = __dma_map_page...
>>
>> Where the dma_address was the "clean" (from cache) physical address.
>
> Nope, DMA-mapping API defines dma_address as a value that should be written to
> device registers to start DMA transfer.

Yes, but in the standard context of DMA, the dma_address is the place
in memory where the transference is going to take place, e.g.: you
don't fill dma_address right now because dma_map_sg overrides with the
previous assignment (and I'm not saying that I'm using this value for
anything).

OTOH, on iommu context, this will be filled with the virtual address
that the device will be accessing for DMA, I'm OK with that, what I
was trying to say, is that you need the "clean" physical address after
mapping the page to the mmu even if the return value of __dma_map_page
is not going to be stored.

> Are all of these regions used by the same single device driver?

Yes they are part of the same firmware that controls the dsp.

> It looks
> that you might need to create separate struct device entries for each 'memory'
> region and attach them as the children to your main device structure. Each
> such child device can have different iommu/memory configuration and the main
> driver can easily gather them with device_find_child() function. We have such
> solution working very well for our video codec. Please refer to the following
> patches merged to v3.1-rc1:
>
> 1. MFC driver: af935746781088f28904601469671d244d2f653b -
> ? ? ? ?drivers/media/video/s5p-mfc/s5p_mfc.c, function s5p_mfc_probe()
>
> 2. platform device definitions: 0f75a96bc0c4611dea0c7207533f822315120054

I took a quick look, it seems like you only need 2 memory regions and
for that only define 2 devices, I'll consider it to see how it looks
for me defining a bunch of devices (5 or less) for these memory
sections.

Thanks,

Omar
