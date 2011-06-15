From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 15 Jun 2011 10:02:48 +0200
Subject: [PATCH 08/10] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <201106141549.29315.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106101821.50437.arnd@arndb.de>
	<006a01cc29a9$1394c330$3abe4990$%szyprowski@samsung.com>
	<201106141549.29315.arnd@arndb.de>
Message-ID: <000601cc2b32$9e2a4030$da7ec090$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, June 14, 2011 3:49 PM Arnd Bergmann wrote:

> On Monday 13 June 2011, Marek Szyprowski wrote:
> > cm_alloc/free are definitely not meant to be called from device drivers.
> > They should be only considered as a backend for dma-mapping.
> >
> > 'Raw' contiguous memory block doesn't really make sense for the device
> > drivers. What the drivers require is a contiguous memory block that is
> > somehow mapped into respective bus address space, so dma-mapping
> > framework is the right interface.
> >
> > alloc_pages(..., GFP_CMA) looks nice but in fact it is really impractical.
> > The driver will need to map such buffer to dma context anyway, so imho
> > dma_alloc_attributed() will give the drivers much more flexibility. In
> > terms of dma-mapping the context argument isn't anything odd.
> 
> Ok.
> 
> > If possible I would like to make cma something similar to
> > declare_dma_coherent()&friends, so the board/platform/bus startup code
> > will just call declare_dma_contiguous() to enable support for cma for
> > particular devices.
> 
> Sounds good, I like that.
 
Thanks. I thought a bit more on this and decided that I want to make this
declare_dma_contiguous() optional for the drivers. It should be used only
for some sophisticated cases like for example our video codec with two
memory interfaces for 2 separate banks. By default the dma-mapping will
use system-wide cma pool.

(snipped)

> > > * It requires you to pass the exact location of the area. I can see why
> > >   you want that on certain machines that require DMA areas to be spread
> > >   across multiple memory buses, but IMHO it's not appropriate for a
> > >   generic API.
> >
> > IMHO we can also use some NULL context to indicate some global, system
> > wide CMA area and again -> in terms of dma-mapping api having a context
> > isn't anything uncommon.
> 
> Please explain the exact requirements that lead you to defining multiple
> contexts. My feeling is that in most cases we don't need them and can
> simply live with a single area. Depending on how obscure the cases are
> where we do need something beyond that, we can then come up with
> special-case solutions for them.

Like it was already stated we need such feature for our multimedia codec
to allocate buffers from different memory banks. I really don't see any
problems with the possibility to have additional cma areas for special
purposes.

> > > * It requires you to hardcode the size in a machine specific source
> file.
> > >   This probably seems to be a natural thing to do when you have worked
> a
> > >   lot on the ARM architecture, but it's really not. We really want to
> > >   get rid of board files and replace them with generic probing based on
> > >   the device tree, and the size of the area is more policy than a
> property
> > >   of the hardware that can be accurately described in the device tree
> or
> > >   a board file.
> >
> > The problem is the fact that right now, we still have board files and we
> > have to live with them for a while (with all advantages and
> disadvantages).
> > I hope that you won't require me to rewrite the whole support for all ARM
> > platforms to get rid of board files to get CMA merged ;)
> 
> Of course not. But we need to know what we want a platform with device
> tree support to look like when it's using CMA, so we don't make it
> harder to change the platforms over than it already is.
> 
> > I see no problem defining CMA areas in device tree, as this is something
> > really specific to particular board configuration.
> 
> The problem with defining CMA areas in the device tree is that it's not
> a property of the hardware, but really policy. The device tree file
> should not contain anything related to a specific operating system
> because you might want to boot something on the board that doesn't
> know about CMA, and even when you only care about using Linux, the
> implementation might change to the point where hardcoded CMA areas
> no longer make sense.

I really doubt that the device tree will carry only system-independent
information. Anyway, the preferred or required memory areas/banks for
buffer allocation is something that is a property of the hardware not
the OS policy.

> IMHO we should first aim for a solution that works almost everywhere
> without the kernel knowing what board it's running on, and then we
> can add quirks for devices that have special requirements. I think
> the situation is similar to the vmalloc virtual address space, which
> normally has a hardcoded size that works almost everywhere, but there
> are certain drivers etc that require much more, or there are situations
> where you want to make it smaller in order to avoid highmem.

I'm trying to create something that will fulfill the requirements of my
hardware, that's why I cannot focus on a generic case only.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
