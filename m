From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 28 Apr 2011 07:31:06 +1000
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104212129.17013.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>
Message-ID: <1303939866.2513.180.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-04-21 at 21:29 +0200, Arnd Bergmann wrote:
> 
> 7. Extend the dma_map_ops to have a way for mapping a buffer
>    from dma_alloc_{non,}coherent into user space. We have not
>    discussed that yet, but after thinking this for some time, I
>    believe this would be the right approach to map buffers into
>    user space from code that doesn't care about the underlying
>    hardware.

Yes. There is a dma_mmap_coherent() call that's not part of the "Real"
API but is implemented by some archs and used by Alsa (I added support
for it on powerpc recently).

Maybe that should go into the dma ops.

The question remains, if we ever want to do more complex demand-paged
operations, should we also expose a lower level set of functions to get
struct page out of a dma_alloc_coherent() allocation and to get the
pgprot for the user dma mapping ?

> After all these are in place, building anything on top of
> dma_alloc_{non,}coherent should be much easier. The question
> of passing buffers between V4L and DRM is still completely
> unsolved as far as I can tell, but that discussion might become
> more focused if we can agree on the above points and assume
> that it will be done.

My gut feeling is that it should be done by having V4L use DRM buffers
in the first place...

> I expect that I will have to update the list above as people
> point out mistakes in my assumptions.

Cheers,
Ben.
