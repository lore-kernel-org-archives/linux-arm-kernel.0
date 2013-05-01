From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 May 2013 16:24:21 +0100
Subject: RFC: Unified DMA allocation algorithms
In-Reply-To: <51785024.40305@codeaurora.org>
References: <51785024.40305@codeaurora.org>
Message-ID: <20130501152421.GB24055@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 10:35:32PM +0100, Laura Abbott wrote:
> Hi all,

Hi Laura,

> I've been looking at a better way to do custom dma allocation algorithms 
> in a similar style to Ion heaps. Most drivers/clients have come up with 
> a series of semi-standard ways to get memory (CMA, memblock_reserve, 
> discontiguous pages etc.) . As these allocation schemes get more and 
> more complex, there needs to be a since place where all clients (Ion 
> based driver vs. DRM driver vs. ???)  can independently take advantage 
> of any optimizations and call a single API for the backing allocations.

Makes sense.

> The dma_map_ops take care of almost everything needed for abstraction
> but the question is where should new allocation algorithms be located?
> Most of the work has been added to either arm/mm/dma-mapping.c or
> dma-contiguous.c . My current thought:
> 
> 1) split out the dma_map_ops currently in dma-mapping.c into separate 
> files (dma-mapping-common.c, dma-mapping-iommu.c)
> 2) Extend dma-contiguous.c to support memblock_reserve memory
> 3) Place additional algorithms in either arch/arm/mm or 
> drivers/base/dma-alloc/ as appropriate to the code. This is the part 
> where I'm most unsure about the direction.
> 
> I don't have anything written yet but I plan to draft some patches 
> assuming the proposed approach sounds reasonable and no one else has 
> started on something similar already.
> 
> Thoughts? Opinions?

The only thing I'd add (which unfortunately doesn't help to answer your
questions!) is that it would be good to see the various allocation
strategies parameterised by IOMMU constraints. For example:

	- Input address sizes / windows
	- Mapping granules (i.e. not just PAGE_SIZE)
	- Streaming hints for physically contiguous allocation

dma-mapping does some of this, but it's still not ideal or generalised (for
example, it allocates a bitmap for the entire virtual space for each
domain). I'd welcome any generalisation in this area.

Will
