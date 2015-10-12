From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 12 Oct 2015 19:53:36 +0530
Subject: [PATCH v2] dmaengine: xgene-dma: Disable memcpy operation due to
 performance drop
In-Reply-To: <CAFd313w3010=LN7rfrxwohM=h-9xWzK6UNtcWxn+eXtx-pNv4Q@mail.gmail.com>
References: <1444295217-3099-1-git-send-email-rsahu@apm.com>
 <20151009161208.GJ3609@vkoul-mobl.iind.intel.com>
 <CAFd313w3010=LN7rfrxwohM=h-9xWzK6UNtcWxn+eXtx-pNv4Q@mail.gmail.com>
Message-ID: <20151012142336.GA27370@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 10:08:32PM +0530, Rameshwar Sahu wrote:
> Hi Vinod,
> 
> On Fri, Oct 9, 2015 at 9:42 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Thu, Oct 08, 2015 at 02:36:57PM +0530, Rameshwar Prasad Sahu wrote:
> >> The DMA engine supports memory copy, RAID5 XOR, RAID6 PQ, and other
> >> computations. But the bandwidth of the entire DMA engine is shared
> >> among all channels. This patch re-configures operations availability
> >> such that one can achieve maximum performance for XOR and PQ
> >> computation by removing the memory offload operations.
> >>
> >> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> >> ---
> >>  drivers/dma/xgene-dma.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
> >> index 8d57b1b..cd38022 100644
> >> --- a/drivers/dma/xgene-dma.c
> >> +++ b/drivers/dma/xgene-dma.c
> >> @@ -1707,7 +1707,6 @@ static void xgene_dma_set_caps(struct xgene_dma_chan *chan,
> >>       dma_cap_zero(dma_dev->cap_mask);
> >>
> >>       /* Set DMA device capability */
> >> -     dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> >>       dma_cap_set(DMA_SG, dma_dev->cap_mask);
> >
> > This will not work. Still clients can invoke memcpy operation. You need to
> > remove the callback
> 
> Got it, instead of removing the callback registration can we keep it
> inside the condition like..
> 
> if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask))
>             dma_dev->device_prep_dma_memcpy = xgene_dma_prep_memcpy;

But the code is dead and will not be tested and hence not maintained. I do
not see a reason to keep dead code in kernel

-- 
~Vinod
