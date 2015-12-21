From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 21 Dec 2015 03:12:10 +0200
Subject: [PATCH] ARM: dma-mapping: Just allocate one chunk at a time
In-Reply-To: <CAAFQd5A1jDaqNaOqUqPOYFW+6aA5fAZwUxJB6LWQ44R0b9ZuQg@mail.gmail.com>
References: <1450384253-1067-1-git-send-email-dianders@chromium.org>
 <CAD=FV=XP9zx2XEmo7vS0MdsROJ0JoRYFidnRaBLxR43GXnuqag@mail.gmail.com>
 <CAAFQd5A1jDaqNaOqUqPOYFW+6aA5fAZwUxJB6LWQ44R0b9ZuQg@mail.gmail.com>
Message-ID: <4776364.A962n6yIkp@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Friday 18 December 2015 15:05:45 Tomasz Figa wrote:
> On Fri, Dec 18, 2015 at 7:31 AM, Doug Anderson wrote:
> > On Thu, Dec 17, 2015 at 12:30 PM, Douglas Anderson wrote:
> >> The __iommu_alloc_buffer() is expected to be called to allocate pretty
> >> sizeable buffers.  Upon simple tests of video I saw it trying to
> >> allocate 4,194,304 bytes.  The function tries to be efficient about this
> >> by starting out allocating large chunks and then moving to smaller and
> >> smaller chunk sizes until it succeeds.
> >> 
> >> The current function is very, very slow.
> >> 
> >> One problem is the way it keeps trying and trying to allocate big
> >> chunks.  Imagine a very fragmented memory that has 4M free but no
> >> contiguous pages at all.  Further imagine allocating 4M (1024 pages).
> >> We'll do the following memory allocations:
> >> 
> >> - For page 1:
> >>   - Try to allocate order 10 (no retry)
> >>   - Try to allocate order 9 (no retry)
> >>   - ...
> >>   - Try to allocate order 0 (with retry, but not needed)
> >> 
> >> - For page 2:
> >>   - Try to allocate order 9 (no retry)
> >>   - Try to allocate order 8 (no retry)
> >>   - ...
> >>   - Try to allocate order 0 (with retry, but not needed)
> >> 
> >> - ...
> >> - ...
> >> 
> >> Total number of calls to alloc() calls for this case is:
> >>   sum(int(math.log(i, 2)) + 1 for i in range(1, 1025))
> >>   => 9228
> >> 
> >> The above is obviously worse case, but given how slow alloc can be we
> >> really want to try to avoid even somewhat bad cases.  I timed the old
> >> code with a device under memory pressure and it wasn't hard to see it
> >> take more than 24 seconds to allocate 4 megs of memory (!!).
> >> 
> >> A second problem (and maybe even more important) is that allocating big
> >> chunks when we don't need them is just not a good idea anyway.  The
> >> first thing we do with these big chunks is break them into smaller
> >> chunks!  If we allocate small chunks:
> >> - The memory manager doesn't need to work so hard to give us big chunks.
> >> - We can save the big chunks for those that really need them and this
> >> 
> >>   code can make great use of all the small chunks sitting around.
> >> 
> >> Let's simplify by just allocating one page at a time.  We may make more
> >> total allocate calls but it works way better.  In real world tests that
> >> used to sometimes see a 24 second allocation call I can now see at most
> >> 250 ms.
> > 
> > Off-list I talked to Dmitry about this a little bit and he pointed out
> > that contiguous chunks actually give a benefit to the IOMMU.  I don't
> > think the benefit outweighs the cost in this case, but I'm happy to
> > hear what others have to say.
> 
> Yeah, I'd like to see some discussion about the effect of allocating
> bigger chunks on IOMMU performance. Dmitry (on CC), could you
> elaborate a bit on what Doug mentioned?
> 
> As for my own understanding, some IOMMUs can map memory using big
> pages, which should improve TLB efficiency and so look-up speed.
> However AFAICT current implementation of allocating function doesn't
> allocate the chunks properly, because there is no guarantee that
> particular chunks are aligned on big page boundary. For example, it
> might happen that we allocate first chunk of order 0, then second
> chunk of order 4 (64KiB - typical big page), then we won't be able to
> map the second chunk using a big page, because the IOVA at that point
> will not be aligned properly.

That might be true of the current implementations, but there's nothing that 
would stop an IOMMU driver to map the start of the buffer at an IOVA address 
aligned to 64kB minus 4kB in the example you mentioned. This would move to a 
trade-off between allocation complexity and runtime performances.

> Is there any other case when bigger physically contiguous chunks can
> help the IOMMU?

-- 
Regards,

Laurent Pinchart
