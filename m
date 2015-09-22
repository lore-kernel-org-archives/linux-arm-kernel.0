From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 22 Sep 2015 12:17:27 +0100
Subject: Question about the sparse memory section size
In-Reply-To: <56010DDD.3080803@hisilicon.com>
References: <56010DDD.3080803@hisilicon.com>
Message-ID: <20150922111723.GI6281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 04:14:21PM +0800, chenfeng wrote:
> Hi all,
> The sparse memory section size, SECTION_SIZE_BITS, currently is 1GB
> for arm64 by default. However, it might generate wasted memmap memory
> space for those memory sections less than 1GB. e.g.
> 
> for 512MB memory section, still 14MB(sizeof(struct page) *
> PAGES_PER_SECTION) memmap needs to be reserved. The wasted memmap
> space could be eliminated by changing memory section size from 1GB to
> 512M, but still some questions to be answered,
> 
> 1) why arm64 uses 1GB as default setting?
> 2) any risk to change section size from 1GB to 512MB? like, any
> impact to performance since memory section number is increased.

For arm64 we have SPARSEMEM_VMEMMAP enabled by default, which enables
much of the wasted memmap backing memory to be reclaimed.

Take a look at arch/arm64/mm/init.c:free_unused_memmap().

This should reduce the amount of actual memory wasted on unused parts
of memmap.  The virtual space stays wasted as you describe, but that's
plentiful on 64-bit arches.

You could try sticking some printks in there is you want to see how much
of the memmap the code successfully frees.

Cheers
---Dave
