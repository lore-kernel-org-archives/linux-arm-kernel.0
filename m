From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 14:19:28 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104281502.16296.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>
	<20110428122508.GC13402@8bytes.org>
	<20110428124242.GJ17290@n2100.arm.linux.org.uk>
	<201104281502.16296.arnd@arndb.de>
Message-ID: <20110428131928.GL17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 03:02:16PM +0200, Arnd Bergmann wrote:
> I think the misunderstanding is that you are saying we need the flag
> in dma_map_ops because you prefer to keep the cache management outside
> of the individual dma_map_ops implementations.
> 
> What I guess J?rg is thinking of is to have the generic IOMMU version
> of dma_map_ops call into the architecture specific code to manage the
> caches on architectures that need it. That implementation would of
> course not require the flag in dma_map_ops because the architecture
> specific callback would use other ways (hardcoded for an architecture,
> or looking at the individual device) to determine if this is ever needed.
> 
> That is also what I had in mind earlier, but you argued against it
> on the base that putting the logic into the common code would lead
> to a higher risk of people accidentally breaking it when they only
> care about coherent architectures.

You still need this same cache handling code even when you don't have
an iommu.  I don't see the point in having a dma_ops level of indirection
followed by a separate iommu_ops level of indirection - it seems to me to
be a waste of code and CPU time, and I don't see why its even necessary
when there's a much simpler way to deal with it (as I illustrated).
