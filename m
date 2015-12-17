From: dianders@chromium.org (Doug Anderson)
Date: Thu, 17 Dec 2015 14:31:40 -0800
Subject: [PATCH] ARM: dma-mapping: Just allocate one chunk at a time
In-Reply-To: <1450384253-1067-1-git-send-email-dianders@chromium.org>
References: <1450384253-1067-1-git-send-email-dianders@chromium.org>
Message-ID: <CAD=FV=XP9zx2XEmo7vS0MdsROJ0JoRYFidnRaBLxR43GXnuqag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 17, 2015 at 12:30 PM, Douglas Anderson
<dianders@chromium.org> wrote:
> The __iommu_alloc_buffer() is expected to be called to allocate pretty
> sizeable buffers.  Upon simple tests of video I saw it trying to
> allocate 4,194,304 bytes.  The function tries to be efficient about this
> by starting out allocating large chunks and then moving to smaller and
> smaller chunk sizes until it succeeds.
>
> The current function is very, very slow.
>
> One problem is the way it keeps trying and trying to allocate big
> chunks.  Imagine a very fragmented memory that has 4M free but no
> contiguous pages at all.  Further imagine allocating 4M (1024 pages).
> We'll do the following memory allocations:
> - For page 1:
>   - Try to allocate order 10 (no retry)
>   - Try to allocate order 9 (no retry)
>   - ...
>   - Try to allocate order 0 (with retry, but not needed)
> - For page 2:
>   - Try to allocate order 9 (no retry)
>   - Try to allocate order 8 (no retry)
>   - ...
>   - Try to allocate order 0 (with retry, but not needed)
> - ...
> - ...
>
> Total number of calls to alloc() calls for this case is:
>   sum(int(math.log(i, 2)) + 1 for i in range(1, 1025))
>   => 9228
>
> The above is obviously worse case, but given how slow alloc can be we
> really want to try to avoid even somewhat bad cases.  I timed the old
> code with a device under memory pressure and it wasn't hard to see it
> take more than 24 seconds to allocate 4 megs of memory (!!).
>
> A second problem (and maybe even more important) is that allocating big
> chunks when we don't need them is just not a good idea anyway.  The
> first thing we do with these big chunks is break them into smaller
> chunks!  If we allocate small chunks:
> - The memory manager doesn't need to work so hard to give us big chunks.
> - We can save the big chunks for those that really need them and this
>   code can make great use of all the small chunks sitting around.
>
> Let's simplify by just allocating one page at a time.  We may make more
> total allocate calls but it works way better.  In real world tests that
> used to sometimes see a 24 second allocation call I can now see at most
> 250 ms.

Off-list I talked to Dmitry about this a little bit and he pointed out
that contiguous chunks actually give a benefit to the IOMMU.  I don't
think the benefit outweighs the cost in this case, but I'm happy to
hear what others have to say.  I did some quick printouts and it turns
out that even when requesting page at a time the memory manager
(unsurprisingly) can in many cases still give us pages that are
contiguous.

Also I'm happy to post up
<https://chromium-review.googlesource.com/#/c/319210/> which sorts the
array and could possibly give us larger chunks of contiguous memory.


-Doug
