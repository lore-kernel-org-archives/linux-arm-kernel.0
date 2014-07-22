From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 22 Jul 2014 14:46:55 +0900
Subject: [PATCH RESEND] drm/ttm: expose CPU address of DMA-allocated pages
In-Reply-To: <CAPM=9txDw7fJpeFB72OdSgAVuaZbpfivV-9imT9V1MBYDvBv-A@mail.gmail.com>
References: <1405390206-5081-1-git-send-email-acourbot@nvidia.com>
 <CAAVeFuJFCQdRuuJ=WQAL65MMoWzPj03evGiXmfQh=2K7+i5Gdg@mail.gmail.com>
 <CAPM=9txDw7fJpeFB72OdSgAVuaZbpfivV-9imT9V1MBYDvBv-A@mail.gmail.com>
Message-ID: <CAAVeFuLfREn00Qw51Q9=0ncqO-WAR87Sf=0VWOPETrk9T5sG2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 2:07 PM, Dave Airlie <airlied@gmail.com> wrote:
> On 22 July 2014 14:21, Alexandre Courbot <gnurou@gmail.com> wrote:
>> DRM maintainers, could I have a comment about this patch? A bunch of
>> Nouveau changes depend on it.
>
> I'm not sure we really have anyone who is in a great position to comment,
>
> my major issue would be its allocate a large chunk of RAM that might
> not be needed
> in all cases, and if we could avoid that when we don't need it, then
> it would be good.

Strictly speaking memory allocated using dma_alloc_coherent() should
only be accessed by the CPU through the returned mapping, so having
this extra information is probably as legitimate as the current
dma_address array.

Now I agree that this results in more memory being used, which is
especially sad since this information is already known in the dma_page
internal structure. Maybe we could expose the whole dma_pages instead
of just the dma address? That way both addresses would be accessible
for the same memory cost (we will need an array to store the adresses
to the dma_pages).

>
> Or maybe we could join some allocations together, but with the Linux
> mm subsystem,
> who knows maybe separate small allocs have a better hope of success.
>
> Dave.
