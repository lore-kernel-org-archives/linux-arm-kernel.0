From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 12:57:58 +0200
Subject: [Linaro-mm-sig] [RFC 2/3] ARM: dma-mapping: Pass DMA attrs as
 IOMMU prot
In-Reply-To: <20130620.133407.798194318297047071.hdoyu@nvidia.com>
References: <CAMcxFTS0dUUEfGj-=-cb_rdfy+qWvtsaoR6Tv+-x05XX0mZmmw@mail.gmail.com>
 <201306201213.13644.arnd@arndb.de>
 <20130620.133407.798194318297047071.hdoyu@nvidia.com>
Message-ID: <201306201257.58419.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Hiroshi Doyu wrote:
> Arnd Bergmann <arnd@arndb.de> wrote @ Thu, 20 Jun 2013 12:13:13 +0200:
> 
> > On Thursday 20 June 2013, Hiroshi Doyu wrote:
> > > > If devices allocate via dma-mapping API, physical mem allocation, iova
> > > > allocation and iommu mapping happens internally.
> > > > Devices may allocate physical memory using any allocator (say ION
> > > > including carveout area), use "iommu mapping" API which will do iova
> > > > allocation and iommu mapping. The prot flags could be useful in this
> > > > case as well - not sure whether we would need dma-attrs here.
> > > 
> > > I haven't followed ION recently, but can't ION backed by DMA mapping
> > > API instead of using IOMMU API directly?
> > 
> > For a GPU with an IOMMU, you typically want per-process IOMMU contexts,
> > which are only available when using the IOMMU API directly, as the
> > dma-mapping abstraction uses only one context for kernel space.
> 
> Yes, we had some experiment for switching IOMMU context with DMA
> mapping API. We needed to add some new DMA mapping API, and didn't
> look so nice at that time. What do you think to introduce multiple
> context or switching context in dma-mapping abstruction?

My feeling is that drivers with the need for multiple contexts
are better off using the iommu API, since that is what it was
made for. The dma-mapping abstraction really tries to hide the
bus address assignment, while users with multiple contexts typically
also want to control the bus addresses.

	Arnd
