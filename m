From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2011 14:00:13 +0200
Subject: [PATCH 2/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <003001cc0017$c7fb3a40$57f1aec0$%szyprowski@samsung.com>
References: <1303118804-5575-1-git-send-email-m.szyprowski@samsung.com>
	<201104201807.27314.arnd@arndb.de>
	<003001cc0017$c7fb3a40$57f1aec0$%szyprowski@samsung.com>
Message-ID: <201104211400.13289.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2011, Marek Szyprowski wrote:
> On Wednesday, April 20, 2011 6:07 PM Arnd Bergmann wrote:
> > On Wednesday 20 April 2011, Marek Szyprowski wrote:
> > > The only question is how a device can allocate a buffer that will be most
> > > convenient for IOMMU mapping (i.e. will require least entries to map)?
> > >
> > > IOMMU can create a contiguous mapping for ANY set of pages, but it performs
> > > much better if the pages are grouped into 64KiB or 1MiB areas.
> > >
> > > Can device allocate a buffer without mapping it into kernel space?
> > 
> > Not today as far as I know. You can register coherent memory per device
> > using dma_declare_coherent_memory(), which will be used to back
> > dma_alloc_coherent(), but I believe it is always mapped right now.
> 
> This is not exactly what I meant.
> 
> As we have IOMMU, the device driver can access any system memory. However
> the performance will be better if the buffer is composed of larger contiguous
> parts (like 64KiB or 1MiB). I would like to avoid putting logic that manages
> buffer allocation into the device drivers. It would be best if such buffers
> could be allocated by a single call to dma-mapping API.
> 
> Right now there is dma_alloc_coherent() function, which is used by the
> drivers to allocate a contiguous block of memory and map it to DMA addresses.
> With IOMMU implementation it is quite easy to provide a replacement for it
> that will allocate some set of pages and map into device virtual address
> space as a contiguous buffer. 
>
> This will have the advantage that the same multimedia device driver
> will work on both systems - Samsung S5PC110 (without IOMMU) and Exynos4
> (with IOMMU).

Right.
 
> However dma_alloc_coherent() besides allocating memory also implies some
> particular type of memory mapping for it. IMHO it might be a good idea to
> separate these 2 things (allocation and mapping) somewhere in the future.
> 
> On systems with IOMMU the dma_map_sg() can be also used to create a mapping
> in device virtual address space, but the driver will still need to allocate
> the memory by itself.

Note that dma_map_sg() is the "streaming mapping", which provides a cacheable
buffer all the time, while dma_alloc_coherent() and is the "coherent mapping".

There is also dma_alloc_noncoherent(), which you can use to allocate a buffer
for the streaming mapping. This is currently not implemented on ARM, but if
I understand you correctly, adding this would do what you want.

> > Ok, I see. Having one device per channel as you suggested could probably
> > work around this, and it's at least consistent with how you'd represent
> > IOMMUs in the device tree. It is not ideal because it makes the video
> > driver more complex when it now has to deal with multiple struct device
> > that it binds to, but I can't think of any nicer way either.
> 
> Well, this will definitely complicate the codec driver. I wonder if allowing
> the driver to kmalloc(sizeof(struct device))) and copy the relevant data
> from the 'proper' struct device will be better idea. It is still hack but 
> definitely less intrusive for the driver.

No, I think that would be much worse, it definitely destroys all kinds of
assumptions that the core code makes about devices. However, I don't think
it's much of a problem to just create two child devices and use them
from the main driver, you don't really need to create a device_driver
to bind to each of them.

	Arnd
