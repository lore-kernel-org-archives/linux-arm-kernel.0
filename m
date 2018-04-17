From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Tue, 17 Apr 2018 12:28:52 +0000
Subject: [RFC 4/6] dmaengine: xilinx_dma: Freeup active list based on
 descriptor completion bit
In-Reply-To: <20180411091102.GZ6014@localhost>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-5-git-send-email-radheys@xilinx.com>
 <20180411091102.GZ6014@localhost>
Message-ID: <BN6PR02MB3282D60BCF6A4B40BCC7A5B8C7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  Vinod,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Wednesday, April 11, 2018 2:41 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams at intel.com; michal.simek at xilinx.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; Radhey Shyam Pandey
> <radheys@xilinx.com>; lars at metafoo.de; dmaengine at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [RFC 4/6] dmaengine: xilinx_dma: Freeup active list based on
> descriptor completion bit
> 
> On Mon, Apr 02, 2018 at 04:09:04PM +0530, Radhey Shyam Pandey wrote:
> > AXIDMA IP sets completion bit to 1 when the transfer is completed. Read
> > this bit to move descriptor from active list to the done list. This feature
> > is needed when interrupt delay timeout and IRQThreshold is enabled i.e
> > Dly_IrqEn is triggered w/o completing Interrupt Threshold.
> >
> > Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c |   18 ++++++++++++++----
> >  1 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c
> > index 36e1ab9..518465e 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -103,6 +103,7 @@
> >  #define XILINX_DMA_PARK_PTR_RD_REF_SHIFT	0
> >  #define XILINX_DMA_PARK_PTR_RD_REF_MASK		GENMASK(4,
> 0)
> >  #define XILINX_DMA_REG_VDMA_VERSION		0x002c
> > +#define XILINX_DMA_COMP_MASK			BIT(31)
> >
> >  /* Register Direct Mode Registers */
> >  #define XILINX_DMA_REG_VSIZE			0x0000
> > @@ -1387,16 +1388,25 @@ static void xilinx_dma_issue_pending(struct
> dma_chan *dchan)
> >  static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
> >  {
> >  	struct xilinx_dma_tx_descriptor *desc, *next;
> > +	struct xilinx_axidma_tx_segment *seg;
> >
> >  	/* This function was invoked with lock held */
> >  	if (list_empty(&chan->active_list))
> >  		return;
> >
> >  	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
> > -		list_del(&desc->node);
> > -		if (!desc->cyclic)
> > -			dma_cookie_complete(&desc->async_tx);
> > -		list_add_tail(&desc->node, &chan->done_list);
> > +
> > +		seg = list_last_entry(&desc->segments,
> > +				      struct xilinx_axidma_tx_segment, node);
> > +		if ((seg->hw.status & XILINX_DMA_COMP_MASK) ||
> > +			(!chan->xdev->has_axieth_connected)) {
> 
> why the second case ? That is not expalined in log?
In the current implementation, delay timeout is enabled only for
has_axieth_connected usecase. For ethernet, we need real-time processing
while still having benefit of interrupt coalescing. Example: In RX interrupt
coalescing is set to 0x3.  Without delay timeout, DMA engine will wait for
all frames and then issue completion interrupt. In ethernet usecase, this
can introduce huge latencies. Delay timeout interrupt will trigger if delay
time period has expired and we can notify dma client with received frames.

The second case is added to keep the previous implementation as is.(i.e when
Delay timeout interrupt is not enabled - move all active desc to done list). 
Sure I will add a description for it in the commit log.

> 
> > +			list_del(&desc->node);
> > +			if (!desc->cyclic)
> > +				dma_cookie_complete(&desc->async_tx);
> > +			list_add_tail(&desc->node, &chan->done_list);
> > +		} else {
> > +			break;
> > +		}
> >  	}
> >  }
> >
> > --
> > 1.7.1
> >
> 
> --
> ~Vinod
