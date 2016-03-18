From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 18 Mar 2016 18:25:04 +0900
Subject: [PATCH] ARM: DMA: Fix kzalloc flags in __dma_alloc
In-Reply-To: <20160318080552.GA28076@lnxrabinv.se.axis.com>
References: <1458267146-24451-1-git-send-email-acourbot@nvidia.com>
 <20160318080552.GA28076@lnxrabinv.se.axis.com>
Message-ID: <56EBC970.2030903@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2016 05:05 PM, Rabin Vincent wrote:
> On Fri, Mar 18, 2016 at 11:12:26AM +0900, Alexandre Courbot wrote:
>> Commit 19e6e5e5392b ("ARM: 8547/1: dma-mapping: store buffer
>> information") allocates a structure meant for internal buffer management
>> with the GFP flags of the buffer itself. This can trigger the following
>> safeguard in the slab/slub allocator:
>>
>> 	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
>> 		pr_emerg("gfp: %u\n", flags & GFP_SLAB_BUG_MASK);
>> 		BUG();
>> 	}
>>
>> Fix this by allocating the structure with GFP_KERNEL, as it is meant to
>> be used by the kernel and not for DMA.
>
> We can't use GFP_KERNEL here.  The caller may have passed in gfp flags
> which indicate that we can't sleep, and we need to respect that.  What we can
> do is mask out the region specifiers in the gfp flags that we pass to
> kzalloc().  This is what the other architectures do in their dma
> allocation functions:
>
> arch/mips/cavium-octeon/dma-octeon.c:   gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
> arch/mips/loongson64/common/dma-swiotlb.c:      gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
> arch/mips/mm/dma-default.c:     gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
> arch/mips/netlogic/common/nlm-dma.c:    gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
> arch/x86/kernel/pci-dma.c:      *gfp &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);

Makes sense. Too bad GFP_SLAB_BUG_MASK is private, otherwise we could 
have used it directly.

Your comment reminded me that I have applied the same "fix" to 
__iommu_alloc_buffer() last year:

	if (array_size <= PAGE_SIZE)
		pages = kzalloc(array_size, GFP_KERNEL);

... but that one is followed by this, which exists since 2012:

	else
		pages = vzalloc(array_size);

So I guess we are not too worried about sleeping in that particular 
function.

Anyway, I will fix as you suggested and resend.
