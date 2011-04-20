From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Apr 2011 18:07:27 +0200
Subject: [PATCH 2/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <007301cbff6a$f17a4710$d46ed530$%szyprowski@samsung.com>
References: <1303118804-5575-1-git-send-email-m.szyprowski@samsung.com>
	<201104191629.49676.arnd@arndb.de>
	<007301cbff6a$f17a4710$d46ed530$%szyprowski@samsung.com>
Message-ID: <201104201807.27314.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 April 2011, Marek Szyprowski wrote:
> On Tuesday, April 19, 2011 4:30 PM Arnd Bergmann wrote:

> > Sounds good. I think we should put it into a new drivers/iommu, along
> > with your specific iommu implementation, and then we can convert the
> > existing ones over to use that.
> 
> I see, this sounds quite reasonable. I think I finally got how this should
> be implemented. 
> 
> The only question is how a device can allocate a buffer that will be most
> convenient for IOMMU mapping (i.e. will require least entries to map)?
> 
> IOMMU can create a contiguous mapping for ANY set of pages, but it performs
> much better if the pages are grouped into 64KiB or 1MiB areas.
> 
> Can device allocate a buffer without mapping it into kernel space?

Not today as far as I know. You can register coherent memory per device
using dma_declare_coherent_memory(), which will be used to back
dma_alloc_coherent(), but I believe it is always mapped right now.

This can of course be changed. 

> The problem that still left to be resolved is the fact the
> dma_coherent_alloc() should also be able to use IOMMU. This would however
> trigger the problem of double mappings with different cache attributes: 
> dma api might require to create coherent (==non-cached mappings), while 
> all low-memory is still mapped with (super)sections as cached, what is 
> against ARM CPU specification and might cause unpredicted behavior
> especially on CPUs that do speculative prefetch. Right now this problem
> has been ignored in dma-mappings implementation, but there have been some
> patches posted to resolve this by reserving some area exclusively for dma
> coherent mappings: 
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/100822/focus=100913
> 
> Right now I would like to postpone resolving this issue because the Samsung
> iommu task already became really big.

Agreed.

> > > Getting back to our video codec - it has 2 IOMMU controllers. The codec
> > > hardware is able to address only 256MiB of space. Do you have an idea how
> > > this can be handled with dma-mapping API? The only idea that comes to my
> > > mind is to provide a second, fake 'struct device' and use it for
> > allocations
> > > for the second IOMMU controller.
> > 
> > Good question.
> > 
> > How do you even decide which controller to use from the driver?
> > I would need to understand better what you are trying to do to
> > give a good recommendation.
> 
> Both controllers are used by the hardware depending on the buffer type.
> For example, buffers with chroma video data are accessed by first (called
> 'left') memory channel, the others (with luma video data) - by the second
> channel (called 'right'). Each memory channel is limited to 256MiB address
> space and best performance is achieved when buffers are allocated in 
> separate physical memory banks (the boards usually have 2 or more memory banks,
> memory is not interleaved).

Ok, I see. Having one device per channel as you suggested could probably
work around this, and it's at least consistent with how you'd represent
IOMMUs in the device tree. It is not ideal because it makes the video
driver more complex when it now has to deal with multiple struct device
that it binds to, but I can't think of any nicer way either.

	Arnd
