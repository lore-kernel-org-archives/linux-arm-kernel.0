From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 23 Feb 2016 04:19:03 +0000
Subject: [PATCH v2 2/4] dmaengine: xilinx_vdma: Simplify spin lock handling
In-Reply-To: <20160223030937.GH17690@localhost>
References: <1456120477-32134-1-git-send-email-appanad@xilinx.com>
 <1456120477-32134-2-git-send-email-appanad@xilinx.com>
 <20160223030937.GH17690@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A561D18@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Tuesday, February 23, 2016 8:40 AM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; Michal Simek; Soren Brinkmann; Appana Durga
> Kedareswara Rao; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Anirudha
> Sarangi; dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v2 2/4] dmaengine: xilinx_vdma: Simplify spin lock handling
> 
> On Mon, Feb 22, 2016 at 11:24:35AM +0530, Kedareswara rao Appana wrote:
> > This patch simplifies the spin lock handling in the driver.
> 
> But sadly doesn't describe how?

Ok sure will improve commit message in the next version.

> 
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> > Changes for v2:
> > ---> splitted the changes into multiple patches.
> >
> >  drivers/dma/xilinx/xilinx_vdma.c | 27 ++++++++++-----------------
> >  1 file changed, 10 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_vdma.c
> > b/drivers/dma/xilinx/xilinx_vdma.c
> > index 06bffec..d646218 100644
> > --- a/drivers/dma/xilinx/xilinx_vdma.c
> > +++ b/drivers/dma/xilinx/xilinx_vdma.c
> > @@ -605,17 +605,14 @@ static void xilinx_vdma_start_transfer(struct
> > xilinx_vdma_chan *chan)  {
> >  	struct xilinx_vdma_config *config = &chan->config;
> >  	struct xilinx_vdma_tx_descriptor *desc, *tail_desc;
> > -	unsigned long flags;
> >  	u32 reg;
> >  	struct xilinx_vdma_tx_segment *tail_segment;
> >
> >  	if (chan->err)
> >  		return;
> >
> > -	spin_lock_irqsave(&chan->lock, flags);
> > -
> 
> It would help if you add a comment to this function taht we need to invoke this
> with lock held...

Ok sure will add comment..

> 
> >  	if (list_empty(&chan->pending_list))
> > -		goto out_unlock;
> > +		return;
> >
> >  	desc = list_first_entry(&chan->pending_list,
> >  				struct xilinx_vdma_tx_descriptor, node); @@ -
> 629,7 +626,7 @@
> > static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
> >  	if (chan->has_sg && xilinx_vdma_is_running(chan) &&
> >  	    !xilinx_vdma_is_idle(chan)) {
> >  		dev_dbg(chan->dev, "DMA controller still busy\n");
> > -		goto out_unlock;
> > +		return;
> >  	}
> >
> >  	/*
> > @@ -676,7 +673,7 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_vdma_chan *chan)
> >  	xilinx_vdma_start(chan);
> >
> >  	if (chan->err)
> > -		goto out_unlock;
> > +		return;
> >
> >  	/* Start the transfer */
> >  	if (chan->has_sg) {
> > @@ -696,7 +693,7 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_vdma_chan *chan)
> >  		}
> >
> >  		if (!last)
> > -			goto out_unlock;
> > +			return;
> >
> >  		/* HW expects these parameters to be same for one
> transaction */
> >  		vdma_desc_write(chan, XILINX_VDMA_REG_HSIZE, last-
> >hw.hsize); @@
> > -707,9 +704,6 @@ static void xilinx_vdma_start_transfer(struct
> > xilinx_vdma_chan *chan)
> >
> >  	list_splice_tail_init(&chan->pending_list, &chan->active_list);
> >  	chan->desc_pendingcount = 0;
> > -
> > -out_unlock:
> > -	spin_unlock_irqrestore(&chan->lock, flags);
> >  }
> >
> >  /**
> > @@ -719,8 +713,11 @@ out_unlock:
> >  static void xilinx_vdma_issue_pending(struct dma_chan *dchan)  {
> >  	struct xilinx_vdma_chan *chan = to_xilinx_chan(dchan);
> > +	unsigned long flags;
> >
> > +	spin_lock_irqsave(&chan->lock, flags);
> >  	xilinx_vdma_start_transfer(chan);
> > +	spin_unlock_irqrestore(&chan->lock, flags);
> >  }
> >
> >  /**
> > @@ -732,21 +729,15 @@ static void xilinx_vdma_issue_pending(struct
> > dma_chan *dchan)  static void xilinx_vdma_complete_descriptor(struct
> > xilinx_vdma_chan *chan)  {
> >  	struct xilinx_vdma_tx_descriptor *desc, *next;
> > -	unsigned long flags;
> > -
> > -	spin_lock_irqsave(&chan->lock, flags);
> 
> this one as well

Ok sure will add comment..

Regards,
Kedar.

> 
> >
> >  	if (list_empty(&chan->active_list))
> > -		goto out_unlock;
> > +		return;
> >
> >  	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
> >  		list_del(&desc->node);
> >  		dma_cookie_complete(&desc->async_tx);
> >  		list_add_tail(&desc->node, &chan->done_list);
> >  	}
> > -
> > -out_unlock:
> > -	spin_unlock_irqrestore(&chan->lock, flags);
> >  }
> >
> >  /**
> > @@ -857,8 +848,10 @@ static irqreturn_t xilinx_vdma_irq_handler(int irq,
> void *data)
> >  	}
> >
> >  	if (status & XILINX_VDMA_DMASR_FRM_CNT_IRQ) {
> > +		spin_lock(&chan->lock);
> >  		xilinx_vdma_complete_descriptor(chan);
> >  		xilinx_vdma_start_transfer(chan);
> > +		spin_unlock(&chan->lock);
> >  	}
> >
> >  	tasklet_schedule(&chan->tasklet);
> > --
> > 2.1.2
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe dmaengine"
> > in the body of a message to majordomo at vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> ~Vinod
