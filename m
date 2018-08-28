From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Tue, 28 Aug 2018 13:03:12 +0000
Subject: [PATCH 2/3] dmaengine: xilinx_dma: Refactor axidma channel
 validation
In-Reply-To: <20180821155024.GH2388@vkoul-mobl>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-3-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821155024.GH2388@vkoul-mobl>
Message-ID: <MWHPR0201MB36280726FBCF3A2BF07EB781C70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Vinod <vkoul@kernel.org>
> Sent: Tuesday, August 21, 2018 9:20 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams at intel.com; Michal Simek <michals@xilinx.com>; Appana
> Durga Kedareswara Rao <appanad@xilinx.com>; lars at metafoo.de;
> dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH 2/3] dmaengine: xilinx_dma: Refactor axidma channel
> validation
> 
> On 27-07-18, 16:20, Radhey Shyam Pandey wrote:
> > In axidma start_transfer, prefer checking channel states before other
> > params i.e pending_list.
> 
> and what that preference be?
There is no strict preference. I thought to group and first check channel
states(idle/error) and then look for pending list.

Thanks,
Radhey
> 
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c index 06d1632..a37871e 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -1271,10 +1271,10 @@ static void xilinx_dma_start_transfer(struct
> xilinx_dma_chan *chan)
> >  	if (chan->err)
> >  		return;
> >
> > -	if (list_empty(&chan->pending_list))
> > +	if (!chan->idle)
> >  		return;
> >
> > -	if (!chan->idle)
> > +	if (list_empty(&chan->pending_list))
> >  		return;
> >
> >  	head_desc = list_first_entry(&chan->pending_list,
> > --
> > 1.7.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe dmaengine"
> > in the body of a message to majordomo at vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> ~Vinod
