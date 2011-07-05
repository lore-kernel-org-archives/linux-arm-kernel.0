From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Jul 2011 14:27:44 +0200
Subject: [PATCH 6/8] drivers: add Contiguous Memory Allocator
In-Reply-To: <20110705113345.GA8286@n2100.arm.linux.org.uk>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<1309851710-3828-7-git-send-email-m.szyprowski@samsung.com>
	<20110705113345.GA8286@n2100.arm.linux.org.uk>
Message-ID: <201107051427.44899.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Russell King - ARM Linux wrote:
> On Tue, Jul 05, 2011 at 09:41:48AM +0200, Marek Szyprowski wrote:
> > The Contiguous Memory Allocator is a set of helper functions for DMA
> > mapping framework that improves allocations of contiguous memory chunks.
> > 
> > CMA grabs memory on system boot, marks it with CMA_MIGRATE_TYPE and
> > gives back to the system. Kernel is allowed to allocate movable pages
> > within CMA's managed memory so that it can be used for example for page
> > cache when DMA mapping do not use it. On dma_alloc_from_contiguous()
> > request such pages are migrated out of CMA area to free required
> > contiguous block and fulfill the request. This allows to allocate large
> > contiguous chunks of memory at any time assuming that there is enough
> > free memory available in the system.
> > 
> > This code is heavily based on earlier works by Michal Nazarewicz.
> 
> And how are you addressing the technical concerns about aliasing of
> cache attributes which I keep bringing up with this and you keep
> ignoring and telling me that I'm standing in your way.

This is of course an important issue, and it's the one item listed as
TODO in the introductory mail that sent.

It's also a preexisting problem as far as I can tell, and it needs
to be solved in __dma_alloc for both cases, dma_alloc_from_contiguous
and __alloc_system_pages as introduced in patch 7.

We've discussed this back and forth, and it always comes down to
one of two ugly solutions:

1. Put all of the MIGRATE_CMA and pages into highmem and change
__alloc_system_pages so it also allocates only from highmem pages.
The consequences of this are that we always need to build kernels
with highmem enabled and that we have less lowmem on systems that
are already small, both of which can be fairly expensive unless
you have lots of highmem already.

2. Add logic to unmap pages from the linear mapping, which is
very expensive because it forces the use of small pages in the
linear mapping (or in parts of it), and possibly means walking
all page tables to remove the PTEs on alloc and put them back
in on free.

I believe that Chunsang Jeong from Linaro is planning to
implement both variants and post them for review, so we can
decide which one to merge, or even to merge both and make
it a configuration option. See also
https://blueprints.launchpad.net/linaro-mm-sig/+spec/engr-mm-dma-mapping-2011.07

I don't think we need to make merging the CMA patches depending on
the other patches, it's clear that both need to be solved, and
they are independent enough.

	Arnd
