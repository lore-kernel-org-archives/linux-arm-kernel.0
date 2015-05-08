From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 May 2015 12:10:48 +0100
Subject: dma_alloc_coherent versus streaming DMA, neither works
 satisfactory
In-Reply-To: <554C4FCE.6070802@topic.nl>
References: <5538DD02.6050401@topic.nl> <3382997.5hgfVKmNXP@wuerfel>
 <5540D356.50708@topic.nl> <9622793.RaVBbeJMCx@wuerfel>
 <554B49F0.1090100@topic.nl>
 <CAD8Lp45w6_ck13sG3PQ549AxsgTi96XQAkUEd9DQqt-i=ZXxUQ@mail.gmail.com>
 <554B6917.40705@topic.nl> <554B71F6.5000106@topic.nl>
 <20150507143010.GC2067@n2100.arm.linux.org.uk>
 <554C4FCE.6070802@topic.nl>
Message-ID: <20150508111048.GE2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 07:55:26AM +0200, Mike Looijmans wrote:
> On 07-05-15 16:30, Russell King - ARM Linux wrote:
> >On Thu, May 07, 2015 at 04:08:54PM +0200, Mike Looijmans wrote:
> >>I read the rest of the thread, apparently it was never integrated.
> >>
> >>The patch for "non-consistent" is a BUG FIX, not some feature request or so.
> >>I was already wondering why my driver had to kalloc pages to get proper
> >>caching on it.
> >
> >I disagree.
> >
> >> From https://www.kernel.org/doc/Documentation/DMA-attributes.txt:
> >>"""
> >>DMA_ATTR_NON_CONSISTENT ... lets the platform to choose to return either
> >>consistent or non-consistent memory as it sees fit.  By using this API,
> >>you are guaranteeing to the platform that you have all the correct and
> >>necessary sync points for this memory in the driver.
> >>"""
> >
> >DMA attributes are something that came in _after_ the DMA API had been
> >around for many years.  It's a "new feature" that was added to an
> >existing subsystem, and because there have been no need for it to be
> >implemented on ARM, the new feature was never implemented.
> >
> >More than that, the vast majority of ARM hardware can't provide this
> >kind of memory, and there are _no_ kernel APIs to ensure that if
> 
> By "non-coherent" memory I thought it meant the same kind of memory that
> kalloc would return. But from your answer it seems I am mistaken and this is
> something different?

Well, I do find the language used rather loose.  The term "coherent" is
well understood, but when the documentation mixes it with "consistent"
it becomes less clear whether the two terms mean the same thing or
something different.

First, let's clear up the API.  There are two parts of the DMA API, the
streaming API and the coherent API.

The streaming API is made up from:

- dma_map_single()
- dma_map_page()
- dma_map_sg()
- dma_sync_single_*()
- dma_sync_sg_*()
- dma_unmap_single() 
- dma_unmap_page()
- dma_unmap_sg()

The coherent API is made up from:

- dma_alloc_coherent() (or a derived function of this.)
- dma_zalloc_coherent()
- dma_free_coherent()
- dma_pool_create()
- dma_pool_alloc()
- dma_pool_free()
- dma_pool_destroy()

Using the streaming API functions with memory returned from the coherent
API is invalid, and in older ARM implementations will cause a WARN_ON()
or BUG_ON() to trigger (due to the need for coherent memory to be
remapped.)

>From the description of DMA_ATTR_NON_CONSISTENT talks about returning
memory.  None of the streaming API interfaces returns memory, only the
coherent API does.  So, DMA_ATTR_NON_CONSISTENT is something you'd pass
into dma_alloc_coherent().

Great, so you get your coherent-but-non-consistent memory (what's that?)
but the documentation says that you guarantee to the platform that you
have the necessary sync points in the driver for this.  What sync points
are those?  Is it talking about memory barriers, or is it talking about
some other cache flushing that the DMA API doesn't describe?

If it's talking about the driver needing to have memory barriers to
ensure proper ordering of accesses to the returned memory, that's
something modern ARMs always need irrespective of anything, so in that
sense, we always return non-consistent memory everywhere.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
