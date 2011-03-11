From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Mar 2011 16:15:01 +0100
Subject: [PATCH 3/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <000101cbdffb$e1844b00$a48ce100$%szyprowski@samsung.com>
References: <1299229274-9753-4-git-send-email-m.szyprowski@samsung.com>
	<201103111507.59825.arnd@arndb.de>
	<000101cbdffb$e1844b00$a48ce100$%szyprowski@samsung.com>
Message-ID: <201103111615.01829.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011, Marek Szyprowski wrote:
> On Friday, March 11, 2011 3:08 PM Arnd Bergmann wrote:
> 
> > On Friday 11 March 2011, Marek Szyprowski wrote:
> > > > The iommu API is not really meant to be KVM specific, it's just that the
> > > > in-tree users are basically limited to KVM at the moment. Another user that
> > > > is coming up soon is the vmio device driver that can be used to transparently
> > > > pass devices to user space. The idea behind the IOMMU API is that you can
> > > > map arbitrary bus addresses to physical memory addresses, but it does not
> > > > deal with allocating the bus addresses or providing buffer management such
> > > > as cache flushes.
> > >
> > > Yea, I've noticed this and this basically what we expect from iommu driver.
> > > However the iommu.h API requires a separate call to map each single memory page.
> > > This is quite ineffective approach and imho the API need to be extended to allow
> > > mapping of the arbitrary set of pages.
> > 
> > We can always discuss extensions to the existing infrastructure, adding
> > an interface for mapping an array of page pointers in the iommu API
> > sounds like a good idea.
> 
> We will investigate this API further. From the first sight it looks it won't take
> much work to port/rewrite our driver to fit into iommu.h API.

Ok, sounds good.

> > I also think that we should not really have separate iommu and dma-mapping
> > interfaces, but rather have a portable way to define an iommu so that it
> > can be used through the dma-mapping interfaces. I'm not asking you to
> > do that as a prerequisite to merging your driver, but it may be good to
> > keep in mind that the current situation is still lacking and that any
> > suggestion for improving this as part of your work to support the
> > samsung IOMMU is welcome.
> 
> Well creating a portable iommu framework and merging it with dma-mapping interface
> looks like a much harder (and time consuming) task. There is definitely a need for
> it. I hope that it can be developed incrementally starting from the current iommu.h
> and dma-mapping.h interfaces.

Yes, that is the idea. Maybe we should add it to the list things that the
Linaro kernel working group can target for the November release?

> Please note that there might be some subtle differences
> in the hardware that such framework must be aware. The first obvious one is the
> hardware design. Some platform has central iommu unit, other (like Samsung Exynos4)
> has a separate iommu unit per each device driver (this is still a simplification,
> because a video codec device has 2 memory interfaces and 2 iommu units). Currently
> I probably have not enough knowledge to predict the other possible issues that need
> to be taken into account in the portable and generic iommu/dma-mapping frame-work.

The dma-mapping API can deal well with one IOMMU per device, but would
need some tricks to work with one device that has two separate IOMMUs.

I'm not very familar with the iommu API, but in the common KVM scenario,
you need one IOMMU per device, so it should handle that just fine as well.

> > Note that the ARM implementation of the dma-mapping.h interface currently
> > does not support IOMMUs, but that could be changed by wrapping it
> > using the include/asm-generic/dma-mapping-common.h infrastructure.
> 
> ARM dma-mapping framework also requires some additional research for better DMA
> support (there are still issues with multiple mappings to be resolved).

You mean mapping the same memory into multiple devices, or a different problem?

	Arnd
