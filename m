From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Dec 2014 11:24 +0100
Subject: [PATCH] ARM: DMA: Fix kzalloc flags in __iommu_alloc_buffer()
In-Reply-To: <1418027967-12923-1-git-send-email-acourbot@nvidia.com>
References: <1418027967-12923-1-git-send-email-acourbot@nvidia.com>
Message-ID: <10532762.PXKTQM8KjH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 December 2014 17:39:27 Alexandre Courbot wrote:
> There doesn't seem to be any valid reason to allocate the pages array
> with the same flags as the buffer itself. Doing so can eventually lead
> to the following safeguard in mm/slab.c to be hit:
> 
> BUG_ON(flags & GFP_SLAB_BUG_MASK);
> 
> This happens when buffers are allocated with __GFP_DMA32 or
> __GFP_HIGHMEM.
> 
> Fix this by allocating the pages array with GFP_KERNEL to follow what is
> done elsewhere in this file. Using GFP_KERNEL in __iommu_alloc_buffer()
> is safe because atomic allocations are handled by __iommu_alloc_atomic().
> 

I think you need to carry over the GFP_ATOMIC flag if that is set by the
caller, but not the GFP_HIGHMEM or GFP_DMA32. Not sure if it's better
to mask out flags from the caller mask, or to start with GFP_KERNEL
and adding in extra bits.

	Arnd
