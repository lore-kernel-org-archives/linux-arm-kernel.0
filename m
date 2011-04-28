From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2011 15:02:16 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110428124242.GJ17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<20110428122508.GC13402@8bytes.org>
	<20110428124242.GJ17290@n2100.arm.linux.org.uk>
Message-ID: <201104281502.16296.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2011, Russell King - ARM Linux wrote:
> > 
> > Do we need flags for that? A flag is necessary if the cache-management
> > differs between IOMMU implementations on the same platform. If
> > cache-management is only specific to the platform (or architecture) then
> > it does make more sense to just call the function without flag checking
> > and every platform with coherent DMA just implements these as static
> > inline noops.
> 
> Sigh.  You're not seeing the point.
> 
> There is no point doing the cache management if we're using something
> like dmabounce or swiotlb, as we'll be using memcpy() at some point with
> the buffer.  Moreover, dmabounce or swiotlb may have to do its own cache
> management after that memcpy() to ensure that the page cache requirements
> are met.

I think the misunderstanding is that you are saying we need the flag
in dma_map_ops because you prefer to keep the cache management outside
of the individual dma_map_ops implementations.

What I guess J?rg is thinking of is to have the generic IOMMU version
of dma_map_ops call into the architecture specific code to manage the
caches on architectures that need it. That implementation would of
course not require the flag in dma_map_ops because the architecture
specific callback would use other ways (hardcoded for an architecture,
or looking at the individual device) to determine if this is ever needed.

That is also what I had in mind earlier, but you argued against it
on the base that putting the logic into the common code would lead
to a higher risk of people accidentally breaking it when they only
care about coherent architectures.

	Arnd
