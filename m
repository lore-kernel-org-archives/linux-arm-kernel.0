From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Thu, 15 Nov 2018 02:57:41 +0000
Subject: [PATCH v2 2/4] dmaengine: xilinx_dma: Refactor axidma channel
 validation
In-Reply-To: <20181111102947.GG12092@vkoul-mobl>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1538241480-13844-3-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20181111102947.GG12092@vkoul-mobl>
Message-ID: <MWHPR0201MB36283D3B93A3CB6E14165CE9C7DC0@MWHPR0201MB3628.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Sunday, November 11, 2018 2:30 AM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams at intel.com; Michal Simek <michals@xilinx.com>; Appana
> Durga Kedareswara Rao <appanad@xilinx.com>; dmaengine at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v2 2/4] dmaengine: xilinx_dma: Refactor axidma channel
> validation
> 
> On 29-09-18, 11:17, Radhey Shyam Pandey wrote:
> > In axidma start_transfer, prefer checking channel states before
> > other params i.e pending_list. No functional change.
> 
> There needs to be proper reason rather than a preference, can you
> explain why
Initially, I thought to group channel states check before checking
pending_list. It came up in doing diff with xilinx tree and mainline
tree. But agree it's not of significant importance and can be dropped.
> 
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > ---
> > Changes for v2:
> > Modified the commit message to mark it as non-functional change.
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> > index 06d1632..a37871e 100644
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
> 
> --
> ~Vinod
