From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 27 Mar 2012 11:59:34 +0200
Subject: [GIT PULL] DMA-mapping framework updates for 3.4
In-Reply-To: <CA+55aFy9oxMrfm-+deMqV=XnFOa98aKXqW+8PR-P-zOARtC2BQ@mail.gmail.com>
References: <1332228283-29077-1-git-send-email-m.szyprowski@samsung.com>
 <CA+55aFy9oxMrfm-+deMqV=XnFOa98aKXqW+8PR-P-zOARtC2BQ@mail.gmail.com>
Message-ID: <007101cd0c00$4ff08af0$efd1a0d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Friday, March 23, 2012 10:36 PM Linus Torvalds wrote:

> On Tue, Mar 20, 2012 at 12:24 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > ?git://git.infradead.org/users/kmpark/linux-samsung dma-mapping-next
> >
> > Those patches introduce a new alloc method (with support for memory
> > attributes) in dma_map_ops structure, which will later replace
> > dma_alloc_coherent and dma_alloc_writecombine functions.
> 
> So I'm quite unhappy with these patches.
> 
> Here's just the few problems I saw from some *very* quick look-through
> of the git tree:
> 
>  - I'm not seeing ack's from the architecture maintainers for the
> patches that change some architecture.

Ok, I've asked personally each respective maintainer for an ack or 
comments. Before I've sent my pull request there were only a few comments
on the mailing lists, but this topic have been discussed at ELC-E in Prague
and Linaro Memory-management summit in Budapest (May 2011).
 
>  - Even more importantly, what I really want is acks and comments from
> the people who are expected to *use* this.

The plan is to use it as a base for further cleanup in the dma-mapping 
implementations, especially on ARM architecture. The changes are designed
in such a way to keep compatibility with the existing users of the API. 
ARM will be the first architecture which will use the new attributes. 
The main clients for this new API will be mainly multimedia drivers (v4l2,
drm) and dma_buf buffer sharing. The advantage of this approach is the 
fact that the same drivers can be used on other architectures without any
changes in the dma calls. The attributes which are not supported by the
architecture will be simply ignored.

>  - it looks like patches break compilation half-way through the
> series. Just one example I noticed: the "x86 adaptation" patch changes
> the functions in lib/swiotlb.c, but afaik ia64 *also* uses those. So
> now ia64 is broken until a couple of patches later. I suspect there
> are other examples like that.

Ok, I missed this and I will fix this issue asap.

>  - the sign-off chains are odd. What happened there? Several patches
> are signed off by Kyungmin Park, but he doesn't seem to be "in the
> chain" at all. Whazzup? (*)

That was caused by our internal flow of the patches, but I see that it 
made only a lot of confusion. I got my own git repository at 
git.linaro.org and I will resolve these sign-off issues correctly there.

>  - Finally, how/why are "dma attributes" different from the per-device
> dma limits ("device_dma_parameters")

Device dma parameters are global for all dma mapping operations for the 
specified device, while dma attributes can be set for each allocation or
mapping call. Dma attributes are mainly used to provide some hints to the
dma mapping core, which might improve speed/performance/throughput for
some particular sw&hw architectures. Unsupported attributes are ignored,
so the in the worst case a driver gets coherent mapping.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
