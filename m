From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 02 Dec 2014 15:47:41 +0200
Subject: [PATCH 0/4] Generic IOMMU page table framework
In-Reply-To: <20141201120534.GC18466@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
 <6034238.mfQ54vFFKj@avalon> <20141201120534.GC18466@arm.com>
Message-ID: <1669896.md3tuDH5WL@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Monday 01 December 2014 12:05:34 Will Deacon wrote:
> On Sun, Nov 30, 2014 at 10:03:08PM +0000, Laurent Pinchart wrote:
> > On Thursday 27 November 2014 11:51:14 Will Deacon wrote:
> > > Hi all,
> > > 
> > > This series introduces a generic IOMMU page table allocation framework,
> > > implements support for ARM long-descriptors and then ports the arm-smmu
> > > driver over to the new code.
> > > 
> > > There are a few reasons for doing this:
> > >   - Page table code is hard, and I don't enjoy shopping
> > >
> > >   - A number of IOMMUs actually use the same table format, but currently
> > >     duplicate the code
> > >
> > >   - It provides a CPU (and architecture) independent allocator, which
> > >     may be useful for some systems where the CPU is using a different
> > >     table format for its own mappings
> > >
> > > As illustrated in the final patch, an IOMMU driver interacts with the
> > > allocator by passing in a configuration structure describing the
> > > input and output address ranges, the supported pages sizes and a set of
> > > ops for performing various TLB invalidation and PTE flushing routines.
> > > 
> > > The LPAE code implements support for 4k/2M/1G, 16k/32M and 64k/512M
> > > mappings, but I decided not to implement the contiguous bit in the
> > > interest of trying to keep the code semi-readable. This could always be
> > > added later, if needed.
> > 
> > Do you have any idea how much the contiguous bit can improve performances
> > in real use cases ?
> 
> It depends on the TLB, really. Given that the contiguous sized map directly
> onto block sizes using different granules, I didn't see that the complexity
> was worth it.
> 
> For example:
> 
>    4k granule : 16 contiguous entries => {64k, 32M, 16G}
>   16k granule : 128 contiguous lvl3 entries => 2M
>                 32 contiguous lvl2 entries => 1G
>   64k granule : 32 contiguous entries => {2M, 16G}
> 
> If we use block mappings, then we get:
> 
>    4k granule : 2M @ lvl2, 1G @ lvl1
>   16k granule : 32M @ lvl2
>   64k granule : 512M @ lvl2
> 
> so really, we only miss the ability to create 16G mappings.

In the general case maybe, but as far as I know my IOMMU only supports 4kB 
granule. Without support for the contiguous bit I loose the ability to create 
64kB mappings, which I believe (but haven't test yet) will have a noticeable 
impact.

> I doubt that hardware even implements that size in the TLB (the contiguous
> bit is only a hint).
>
> On top of that, the contiguous bit leads to additional expense on unmap,
> since you have extra TLB invalidation splitting the thing into non-
> contiguous pages before you can do anything.

That will only be required when doing partial unmaps, which shouldn't be that 
frequent. When unmapping a 64kB block there's no need to split the mapping 
beforehand.

-- 
Regards,

Laurent Pinchart
