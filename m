From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 24 Apr 2013 14:35:32 -0700
Subject: RFC: Unified DMA allocation algorithms
Message-ID: <51785024.40305@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've been looking at a better way to do custom dma allocation algorithms 
in a similar style to Ion heaps. Most drivers/clients have come up with 
a series of semi-standard ways to get memory (CMA, memblock_reserve, 
discontiguous pages etc.) . As these allocation schemes get more and 
more complex, there needs to be a since place where all clients (Ion 
based driver vs. DRM driver vs. ???)  can independently take advantage 
of any optimizations and call a single API for the backing allocations.

The dma_map_ops take care of almost everything needed for abstraction
but the question is where should new allocation algorithms be located?
Most of the work has been added to either arm/mm/dma-mapping.c or
dma-contiguous.c . My current thought:

1) split out the dma_map_ops currently in dma-mapping.c into separate 
files (dma-mapping-common.c, dma-mapping-iommu.c)
2) Extend dma-contiguous.c to support memblock_reserve memory
3) Place additional algorithms in either arch/arm/mm or 
drivers/base/dma-alloc/ as appropriate to the code. This is the part 
where I'm most unsure about the direction.

I don't have anything written yet but I plan to draft some patches 
assuming the proposed approach sounds reasonable and no one else has 
started on something similar already.

Thoughts? Opinions?

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
