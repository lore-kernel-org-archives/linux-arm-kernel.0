From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Mar 2017 21:19:00 +0000
Subject: [Question] devm_kmalloc() for DMA ?
In-Reply-To: <456e0515-b9d7-e1b6-fc25-a2ec5244d9db@metafoo.de>
References: <CAK7LNARbD262isY7yOgQKAcbWQHV+3dsoRjtu6S+qUpPr98qSQ@mail.gmail.com>
 <b7dd01e6-ddcd-a34a-c26c-05ce6ae4015a@arm.com>
 <CAK7LNAQ3FbicgoV1Q70T2gZQS0j1Z8LffXquSM=v6DYcHP_m4Q@mail.gmail.com>
 <fd2097a1-c9b5-e6ab-f3b3-04b432bda0a3@metafoo.de>
 <20170308195901.GD21222@n2100.armlinux.org.uk>
 <456e0515-b9d7-e1b6-fc25-a2ec5244d9db@metafoo.de>
Message-ID: <20170308211900.GE21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 09:44:17PM +0100, Lars-Peter Clausen wrote:
> On 03/08/2017 08:59 PM, Russell King - ARM Linux wrote:
> > On Wed, Mar 08, 2017 at 08:48:31PM +0100, Lars-Peter Clausen wrote:
> >> When the DMA memory is mapped for reading from the device the associated
> >> cachelines are invalidated without writeback. There is no guarantee that
> >> the changes made to the devres_node have made it to main memory yet, or
> >> is there?
> > 
> > That is incorrect.
> > 
> > Overlapping cache lines are always written back on transitions from CPU
> > to device ownership of the buffer (eg, dma_map_*().)
> 
> On ARM. But my understanding is that this is not a universal requirement
> according to DMA-API.txt. It says that mappings must be cache line aligned
> and otherwise behavior is undefined.

There is no use of the term "undefined" in the document you refer to.

There is the recommendation that regions are cache line aligned, but
there is quite a bit of history in the kernel where DMA has been to
regions that are not cache line aligned, and where the DMA region
overlaps with data that has recent accesses made to it.

The situation is improving (in that DMA buffers are being allocated
separately, rather than being part of some other structure) but that
doesn't mean that it's safe to assume that overlapping cache lines can
be invalidated.

In any case, DMA with devm allocated buffers really is not a good idea.
The lifetime of devm allocated buffers is between their allocation and
the point that the driver is unbound (either via probe failure or
removal.)  If that turns out to be shorter than DMA, then you end up
scribbing over free'd memory.

Moreover, any memory that is dma_map'd must be dma_unmap'd before
being freed.

So, unless we're going to get devm_* stuff for DMA API and for ensuring
that DMA is disabled, I don't think using devm_k*alloc() with DMA is
really a good idea.

Take the fact that it returns memory that is not cache line aligned to
be a big clue that it shouldn't be used for this purpose.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
