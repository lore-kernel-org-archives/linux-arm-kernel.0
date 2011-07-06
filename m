From: cl@linux.com (Christoph Lameter)
Date: Wed, 6 Jul 2011 11:05:00 -0500 (CDT)
Subject: [PATCH 6/8] drivers: add Contiguous Memory Allocator
In-Reply-To: <20110706154857.GG8286@n2100.arm.linux.org.uk>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<201107061609.29996.arnd@arndb.de>
	<20110706142345.GC8286@n2100.arm.linux.org.uk>
	<201107061651.49824.arnd@arndb.de>
	<20110706154857.GG8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1107061100290.17624@router.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Russell King - ARM Linux wrote:

> > > they typically don't fall into the highmem zone.  As the dmabounce
> > > code allocates from the DMA coherent allocator to provide it with
> > > guaranteed DMA-able memory, that would be rather inconvenient.
> >
> > True. The dmabounce code would consequently have to allocate
> > the memory through an internal function that avoids the
> > contiguous allocation area and goes straight to ZONE_DMA memory
> > as it does today.
>
> CMA's whole purpose for existing is to provide _dma-able_ contiguous
> memory for things like cameras and such like found on crippled non-
> scatter-gather hardware.  If that memory is not DMA-able what's the
> point?

ZONE_DMA is a zone for memory of legacy (crippled) devices that cannot DMA
into all of memory (and so is ZONE_DMA32). Memory from ZONE_NORMAL can be
used for DMA as well and a fully capable device would be expected to
handle any memory in the system for DMA transfers.

"guaranteed" dmaable memory? DMA abilities are device specific. Well maybe
you can call ZONE_DMA memory to be guaranteed if you guarantee that any
device must at mininum be able to perform DMA into ZONE_DMA memory. But
there may not be much of that memory around so you would want to limit
the use of that scarce resource.
