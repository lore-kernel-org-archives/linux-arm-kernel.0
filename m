From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 18 Mar 2016 12:43:24 +0000
Subject: [PATCH 3/7] dmaengine: xilinx_vdma: Add Support for Xilinx AXI
 Direct Memory Access Engine
In-Reply-To: <3499146.PQW2st7Yr0@avalon>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
 <1458062592-27981-4-git-send-email-appanad@xilinx.com>
 <3499146.PQW2st7Yr0@avalon>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A56E3B4@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent Pinchart,

	Thanks for reviewing the patch.

> -----Original Message-----
> From: Laurent Pinchart [mailto:laurent.pinchart at ideasonboard.com]
> Sent: Thursday, March 17, 2016 1:35 PM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; vinod.koul at intel.com; Michal Simek; Soren
> Brinkmann; Appana Durga Kedareswara Rao; moritz.fischer at ettus.com;
> luis at debethencourt.com; Anirudha Sarangi; dmaengine at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 3/7] dmaengine: xilinx_vdma: Add Support for Xilinx AXI
> Direct Memory Access Engine
> 
> Hello,
> 
> Thank you for the patch.
> 
> On Tuesday 15 March 2016 22:53:08 Kedareswara rao Appana wrote:
> > This patch adds support for the AXI Direct Memory Access (AXI DMA)
> > core, which is a soft Xilinx IP core that provides high- bandwidth
> > direct memory access between memory and AXI4-Stream type target
> > peripherals.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_vdma.c | 385
> > +++++++++++++++++++++++++++++++-----
> >  1 file changed, 341 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_vdma.c
> > b/drivers/dma/xilinx/xilinx_vdma.c index f682bef..87525a9 100644
> > --- a/drivers/dma/xilinx/xilinx_vdma.c
> > +++ b/drivers/dma/xilinx/xilinx_vdma.c
> > @@ -16,6 +16,12 @@
> >   * video device (S2MM). Initialization, status, interrupt and management
> >   * registers are accessed through an AXI4-Lite slave interface.
> >   *
> > + *  The AXI DMA, is a soft IP, which provides high-bandwidth Direct
> > + Memory
> > + *  Access between memory and AXI4-Stream-type target peripherals. It
> > + can
> > be
> > + *  configured to have one channel or two channels and if configured
> > + as two
> > + *  channels, one is to transmit data from memory to a device and
> > + another
> > is
> > + *  to receive from a device.
> 
> Let's try to be both descriptive and consistent.
> 
> "The AXI Direct Memory Access (AXI DMA) core is a soft Xilinx IP core the
> provides high-bandwidth one dimensional direct memory access between
> memory and AXI4-Stream target peripherals. It supports one receive and one
> transmit channel, both of them optional at synthesis time."


Ok Will fix it in v2.

> 
> > + *
> >   * This program is free software: you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License as published by
> >   * the Free Software Foundation, either version 2 of the License, or
> > @@ -140,6 +146,20 @@
> >  #define XILINX_VDMA_LOOP_COUNT		1000000
> >
> >  #define AXIVDMA_SUPPORT		BIT(0)
> > +#define AXIDMA_SUPPORT		BIT(1)
> > +
> > +/* AXI DMA Specific Registers/Offsets */
> > +#define XILINX_DMA_REG_SRCDSTADDR	0x18
> > +#define XILINX_DMA_REG_DSTADDR		0x20
> > +#define XILINX_DMA_REG_BTT		0x28
> > +
> > +#define XILINX_DMA_MAX_TRANS_LEN	GENMASK(22, 0)
> > +#define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
> > +#define XILINX_DMA_CR_COALESCE_SHIFT	16
> > +#define XILINX_DMA_BD_SOP		BIT(27)
> > +#define XILINX_DMA_BD_EOP		BIT(26)
> > +#define XILINX_DMA_COALESCE_MAX		255
> > +#define XILINX_DMA_NUM_APP_WORDS	5
> >
> >  /**
> >   * struct xilinx_vdma_desc_hw - Hardware Descriptor @@ -147,19
> > +167,23 @@
> >   * @pad1: Reserved @0x04
> >   * @buf_addr: Buffer address @0x08
> >   * @pad2: Reserved @0x0C
> > - * @vsize: Vertical Size @0x10
> > + * @dstaddr_vsize: Vertical Size @0x10
> >   * @hsize: Horizontal Size @0x14
> > - * @stride: Number of bytes between the first
> > + * @control_stride: Number of bytes between the first
> >   *	    pixels of each horizontal line @0x18
> > + * @status: Status field @0x1C
> > + * @app: APP Fields @0x20 - 0x30
> 
> As the descriptors are not identical for the DMA and VDMA cores, please define
> two structures instead of abusing this one.

Ok will fix in v2.

> 
> >   */
> >  struct xilinx_vdma_desc_hw {
> >  	u32 next_desc;
> >  	u32 pad1;
> >  	u32 buf_addr;
> >  	u32 pad2;
> > -	u32 vsize;
> > +	u32 dstaddr_vsize;
> >  	u32 hsize;
> > -	u32 stride;
> > +	u32 control_stride;
> > +	u32 status;
> > +	u32 app[XILINX_DMA_NUM_APP_WORDS];
> >  } __aligned(64);
> >
> >  /**
> > @@ -209,6 +233,9 @@ struct xilinx_vdma_tx_descriptor {
> >   * @config: Device configuration info
> >   * @flush_on_fsync: Flush on Frame sync
> >   * @desc_pendingcount: Descriptor pending count
> > + * @residue: Residue for AXI DMA
> > + * @seg_v: Statically allocated segments base
> > + * @start_transfer: Differentiate b/w DMA IP's transfer
> 
> Please clearly document which fields are common and which fields are specific
> to one DMA engine type.

Ok Sure will fix in v2.

> 
> >   */
> >  struct xilinx_vdma_chan {
> >  	struct xilinx_vdma_device *xdev;
> > @@ -232,6 +259,9 @@ struct xilinx_vdma_chan {
> >  	struct xilinx_vdma_config config;
> >  	bool flush_on_fsync;
> >  	u32 desc_pendingcount;
> > +	u32 residue;
> > +	struct xilinx_vdma_tx_segment *seg_v;
> > +	void   (*start_transfer)(struct xilinx_vdma_chan *chan);
> 
> One space after void is enough.

OK will fix in v2.

> 
> >  };
> >
> >  /**
> > @@ -436,6 +466,7 @@ static void xilinx_vdma_free_chan_resources(struct
> > dma_chan *dchan) dev_dbg(chan->dev, "Free all channel resources.\n");
> >
> >  	xilinx_vdma_free_descriptors(chan);
> > +	xilinx_vdma_free_tx_segment(chan, chan->seg_v);
> >  	dma_pool_destroy(chan->desc_pool);
> >  	chan->desc_pool = NULL;
> >  }
> > @@ -515,7 +546,12 @@ static int
> > xilinx_vdma_alloc_chan_resources(struct
> > dma_chan *dchan) return -ENOMEM;
> >  	}
> >
> > +	chan->seg_v = xilinx_vdma_alloc_tx_segment(chan);
> 
> This is a bit scary. You allocate a segment here and free it in
> xilinx_vdma_free_chan_resources, but seg_v is reassigned in
> xilinx_dma_start_transfer(). A comment explaining how seg_v is used and why
> this is safe would be nice.

OK will add comments in the v2.

> 
> >  	dma_cookie_init(dchan);
> > +
> > +	/* Enable interrupts */
> > +	vdma_ctrl_set(chan, XILINX_VDMA_REG_DMACR,
> > +		      XILINX_VDMA_DMAXR_ALL_IRQ_MASK);
> 
> Why is this needed here ?

We are enable interrupts in the reset.
For VDMA Case if we reset one channel it will reset that particular channel only.
But in AXI DMA case if we reset one channel it will reset the other channel as well.
So one option is enable interrupts for the channels at the end of the probe.
Or enable interrupts during channel resource allocation. 

I did the changes in this patch for the 2nd option.


> 
> >  	return 0;
> >  }
> >
> > @@ -531,7 +567,37 @@ static enum dma_status
> > xilinx_vdma_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
> >  					struct dma_tx_state *txstate)
> >  {
> > -	return dma_cookie_status(dchan, cookie, txstate);
> > +	struct xilinx_vdma_chan *chan = to_xilinx_chan(dchan);
> > +	struct xilinx_vdma_tx_descriptor *desc;
> > +	struct xilinx_vdma_tx_segment *segment;
> > +	struct xilinx_vdma_desc_hw *hw;
> > +	enum dma_status ret;
> > +	unsigned long flags;
> > +	u32 residue = 0;
> > +
> > +	ret = dma_cookie_status(dchan, cookie, txstate);
> > +	if (ret == DMA_COMPLETE || !txstate)
> > +		return ret;
> > +
> > +	if (chan->xdev->quirks & AXIDMA_SUPPORT) {
> > +		desc = list_last_entry(&chan->active_list,
> > +				       struct xilinx_vdma_tx_descriptor, node);
> 
> Doesn't this need to be protected against race conditions ?

Yes will fix in v2.

> 
> > +
> > +		spin_lock_irqsave(&chan->lock, flags);
> > +		if (chan->has_sg) {
> > +			list_for_each_entry(segment, &desc->segments, node)
> {
> > +				hw = &segment->hw;
> > +				residue += (hw->control_stride - hw->status) &
> > +					   XILINX_DMA_MAX_TRANS_LEN;
> > +			}
> > +		}
> > +		spin_unlock_irqrestore(&chan->lock, flags);
> > +
> > +		chan->residue = residue;
> > +		dma_set_residue(txstate, chan->residue);
> > +	}
> 
> Is this really specific to the DMA engine type, or is it applicable to the VDMA and
> CDMA engines as well ?

Residue support is specific to AXI DMA IP only.
CDMA and VDMA IP's won't support residue.

> 
> > +	return ret;
> >  }
> >
> >  /**
> > @@ -713,8 +779,9 @@ static void xilinx_vdma_start_transfer(struct
> > xilinx_vdma_chan *chan) /* HW expects these parameters to be same for
> > one transaction */ vdma_desc_write(chan, XILINX_VDMA_REG_HSIZE,
> > last->hw.hsize);
> >  		vdma_desc_write(chan, XILINX_VDMA_REG_FRMDLY_STRIDE,
> > -				last->hw.stride);
> > -		vdma_desc_write(chan, XILINX_VDMA_REG_VSIZE, last-
> >hw.vsize);
> > +				last->hw.control_stride);
> > +		vdma_desc_write(chan, XILINX_VDMA_REG_VSIZE,
> > +				last->hw.dstaddr_vsize);
> >  	}
> >
> >  	list_splice_tail_init(&chan->pending_list, &chan->active_list); @@
> > -736,6 +803,105 @@ static void xilinx_vdma_issue_pending(struct
> > dma_chan
> > *dchan) }
> >
> >  /**
> > + * xilinx_dma_start_transfer - Starts DMA transfer
> > + * @chan: Driver specific channel struct pointer  */ static void
> > +xilinx_dma_start_transfer(struct xilinx_vdma_chan *chan) {
> > +	struct xilinx_vdma_tx_descriptor *head_desc, *tail_desc;
> > +	struct xilinx_vdma_tx_segment *tail_segment, *old_head, *new_head;
> > +	u32 reg;
> > +
> > +	/* This function was invoked with lock held */
> 
> If you want this to be mentioned in a comment please add it to the comment
> block before the function. I'd write it as "This function must be called with the
> channel lock held.".

Sure will fix in v2.

> 
> > +	if (chan->err)
> > +		return;
> > +
> > +	if (list_empty(&chan->pending_list))
> > +		return;
> > +
> > +	head_desc = list_first_entry(&chan->pending_list,
> > +				     struct xilinx_vdma_tx_descriptor, node);
> > +	tail_desc = list_last_entry(&chan->pending_list,
> > +				    struct xilinx_vdma_tx_descriptor, node);
> > +	tail_segment = list_last_entry(&tail_desc->segments,
> > +				       struct xilinx_vdma_tx_segment, node);
> > +
> > +	old_head = list_first_entry(&head_desc->segments,
> > +				struct xilinx_vdma_tx_segment, node);
> > +	new_head = chan->seg_v;
> > +	/* Copy Buffer Descriptor fields. */
> > +	new_head->hw = old_head->hw;
> > +
> > +	/* Swap and save new reserve */
> > +	list_replace_init(&old_head->node, &new_head->node);
> > +	chan->seg_v = old_head;
> > +
> > +	tail_segment->hw.next_desc = chan->seg_v->phys;
> > +	head_desc->async_tx.phys = new_head->phys;
> > +
> > +	/* If it is SG mode and hardware is busy, cannot submit */
> > +	if (chan->has_sg && xilinx_vdma_is_running(chan) &&
> > +	    !xilinx_vdma_is_idle(chan)) {
> > +		dev_dbg(chan->dev, "DMA controller still busy\n");
> > +		return;
> 
> Shouldn't this be checked before modifying the descriptors above ?

Ok will fix in v2.

> 
> > +	}
> > +
> > +	reg = vdma_ctrl_read(chan, XILINX_VDMA_REG_DMACR);
> > +
> > +	if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
> > +		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
> > +		reg |= chan->desc_pendingcount <<
> > +				  XILINX_DMA_CR_COALESCE_SHIFT;
> > +		vdma_ctrl_write(chan, XILINX_VDMA_REG_DMACR, reg);
> > +	}
> > +
> > +	if (chan->has_sg)
> > +		vdma_ctrl_write(chan, XILINX_VDMA_REG_CURDESC,
> > +				head_desc->async_tx.phys);
> > +
> > +	xilinx_vdma_start(chan);
> > +
> > +	if (chan->err)
> > +		return;
> > +
> > +	/* Start the transfer */
> > +	if (chan->has_sg) {
> > +		vdma_ctrl_write(chan, XILINX_VDMA_REG_TAILDESC,
> > +			       tail_segment->phys);
> > +	} else {
> > +		struct xilinx_vdma_tx_segment *segment;
> > +		struct xilinx_vdma_desc_hw *hw;
> > +
> > +		segment = list_first_entry(&head_desc->segments,
> > +					   struct xilinx_vdma_tx_segment,
> node);
> > +		hw = &segment->hw;
> > +
> > +		vdma_ctrl_write(chan, XILINX_DMA_REG_SRCDSTADDR, hw-
> >buf_addr);
> > +
> > +		/* Start the transfer */
> > +		vdma_ctrl_write(chan, XILINX_DMA_REG_BTT,
> > +			       hw->control_stride &
> XILINX_DMA_MAX_TRANS_LEN);
> > +	}
> > +
> > +	list_splice_tail_init(&chan->pending_list, &chan->active_list);
> > +	chan->desc_pendingcount = 0;
> > +}
> > +
> > +/**
> > + * xilinx_dma_issue_pending - Issue pending transactions
> > + * @dchan: DMA channel
> > + */
> > +static void xilinx_dma_issue_pending(struct dma_chan *dchan) {
> > +	struct xilinx_vdma_chan *chan = to_xilinx_chan(dchan);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&chan->lock, flags);
> > +	xilinx_dma_start_transfer(chan);
> 
> If you write it as chan->start_transfer(chan) you won't have to duplicate the
> issue_pending function.

Sure will fix in v2.

> 
> > +	spin_unlock_irqrestore(&chan->lock, flags); }
> > +
> > +/**
> >   * xilinx_vdma_complete_descriptor - Mark the active descriptor as
> > complete
> > * @chan : xilinx DMA channel
> >   *
> > @@ -841,15 +1007,12 @@ static irqreturn_t xilinx_vdma_irq_handler(int
> > irq, void *data) vdma_ctrl_write(chan, XILINX_VDMA_REG_DMASR,
> >  				errors &
> XILINX_VDMA_DMASR_ERR_RECOVER_MASK);
> >
> > -		if (!chan->flush_on_fsync ||
> > -		    (errors & ~XILINX_VDMA_DMASR_ERR_RECOVER_MASK)) {
> > -			dev_err(chan->dev,
> > -				"Channel %p has errors %x, cdr %x tdr %x\n",
> > -				chan, errors,
> > -				vdma_ctrl_read(chan,
> XILINX_VDMA_REG_CURDESC),
> > -				vdma_ctrl_read(chan,
> XILINX_VDMA_REG_TAILDESC));
> > -			chan->err = true;
> > -		}
> > +		dev_err(chan->dev,
> > +			"Channel %p has errors %x, cdr %x tdr %x\n",
> > +			chan, errors,
> > +			vdma_ctrl_read(chan, XILINX_VDMA_REG_CURDESC),
> > +			vdma_ctrl_read(chan, XILINX_VDMA_REG_TAILDESC));
> > +		chan->err = true;
> 
> You're removing the ability to recover when C_FLUSH_ON_FSYNC is set. Why is
> that ?

In any case (I mean if c_flush_on_sync is not being set that case)
 If we dump the register info it will be useful for the
Users to analyze the errors. That's why removed those checks.

> 
> >  	}
> >
> >  	if (status & XILINX_VDMA_DMASR_DLY_CNT_IRQ) { @@ -863,7 +1026,7
> @@
> > static irqreturn_t xilinx_vdma_irq_handler(int irq, void *data) if
> > (status & XILINX_VDMA_DMASR_FRM_CNT_IRQ) {
> >  		spin_lock(&chan->lock);
> >  		xilinx_vdma_complete_descriptor(chan);
> > -		xilinx_vdma_start_transfer(chan);
> > +		chan->start_transfer(chan);
> >  		spin_unlock(&chan->lock);
> >  	}
> >
> > @@ -903,7 +1066,8 @@ append:
> >  	list_add_tail(&desc->node, &chan->pending_list);
> >  	chan->desc_pendingcount++;
> >
> > -	if (unlikely(chan->desc_pendingcount > chan->num_frms)) {
> > +	if ((unlikely(chan->desc_pendingcount > chan->num_frms)) &&
> 
> Parenthesis around unlikely are not needed.

Ok will fix.

> 
> > +		(chan->xdev->quirks & AXIVDMA_SUPPORT)) {
> >  		dev_dbg(chan->dev, "desc pendingcount is too high\n");
> >  		chan->desc_pendingcount = chan->num_frms;
> >  	}
> > @@ -989,11 +1153,11 @@ xilinx_vdma_dma_prep_interleaved(struct
> > dma_chan *dchan,
> >
> >  	/* Fill in the hardware descriptor */
> >  	hw = &segment->hw;
> > -	hw->vsize = xt->numf;
> > +	hw->dstaddr_vsize = xt->numf;
> >  	hw->hsize = xt->sgl[0].size;
> > -	hw->stride = (xt->sgl[0].icg + xt->sgl[0].size) <<
> > +	hw->control_stride = (xt->sgl[0].icg + xt->sgl[0].size) <<
> >  			XILINX_VDMA_FRMDLY_STRIDE_STRIDE_SHIFT;
> > -	hw->stride |= chan->config.frm_dly <<
> > +	hw->control_stride |= chan->config.frm_dly <<
> >  			XILINX_VDMA_FRMDLY_STRIDE_FRMDLY_SHIFT;
> >
> >  	if (xt->dir != DMA_MEM_TO_DEV)
> > @@ -1019,6 +1183,108 @@ error:
> >  }
> >
> >  /**
> > + * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE
> > transaction + * @dchan: DMA channel
> > + * @sgl: scatterlist to transfer to/from
> > + * @sg_len: number of entries in @scatterlist
> > + * @direction: DMA direction
> > + * @flags: transfer ack flags
> > + * @context: APP words of the descriptor
> > + *
> > + * Return: Async transaction descriptor on success and NULL on
> > +failure  */ static struct dma_async_tx_descriptor
> > +*xilinx_dma_prep_slave_sg(
> > +	struct dma_chan *dchan, struct scatterlist *sgl, unsigned int sg_len,
> > +	enum dma_transfer_direction direction, unsigned long flags,
> > +	void *context)
> > +{
> > +	struct xilinx_vdma_chan *chan = to_xilinx_chan(dchan);
> > +	struct xilinx_vdma_tx_descriptor *desc;
> > +	struct xilinx_vdma_tx_segment *segment = NULL, *prev = NULL;
> > +	u32 *app_w = (u32 *)context;
> > +	struct scatterlist *sg;
> > +	size_t copy, sg_used;
> 
> Please don't declare multiple unrelated variables on a single line.


Ok will fix.

> 
> > +	int i;
> 
> i will never be negative, you can make it an unsigned int.

Ok will fix in v2.

> 
> > +
> > +	if (!is_slave_direction(direction))
> > +		return NULL;
> > +
> > +	/* Allocate a transaction descriptor. */
> > +	desc = xilinx_vdma_alloc_tx_descriptor(chan);
> > +	if (!desc)
> > +		return NULL;
> > +
> > +	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> > +	desc->async_tx.tx_submit = xilinx_vdma_tx_submit;
> > +
> > +	/* Build transactions using information in the scatter gather list */
> > +	for_each_sg(sgl, sg, sg_len, i) {
> > +		sg_used = 0;
> > +
> > +		/* Loop until the entire scatterlist entry is used */
> > +		while (sg_used < sg_dma_len(sg)) {
> > +			struct xilinx_vdma_desc_hw *hw;
> > +
> > +			/* Get a free segment */
> > +			segment = xilinx_vdma_alloc_tx_segment(chan);
> > +			if (!segment)
> > +				goto error;
> > +
> > +			/*
> > +			 * Calculate the maximum number of bytes to transfer,
> > +			 * making sure it is less than the hw limit
> > +			 */
> > +			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
> > +				     XILINX_DMA_MAX_TRANS_LEN);
> > +			hw = &segment->hw;
> > +
> > +			/* Fill in the descriptor */
> > +			hw->buf_addr = sg_dma_address(sg) + sg_used;
> > +
> > +			hw->control_stride = copy;
> > +
> > +			if (chan->direction == DMA_MEM_TO_DEV) {
> > +				if (app_w)
> > +					memcpy(hw->app, app_w, sizeof(u32)
> *
> > +					       XILINX_DMA_NUM_APP_WORDS);
> > +			}
> > +
> > +			if (prev)
> > +				prev->hw.next_desc = segment->phys;
> > +
> > +			prev = segment;
> > +			sg_used += copy;
> > +
> > +			/*
> > +			 * Insert the segment into the descriptor segments
> > +			 * list.
> > +			 */
> > +			list_add_tail(&segment->node, &desc->segments);
> > +		}
> > +	}
> > +
> > +	segment = list_first_entry(&desc->segments,
> > +				   struct xilinx_vdma_tx_segment, node);
> > +	desc->async_tx.phys = segment->phys;
> > +	prev->hw.next_desc = segment->phys;
> > +
> > +	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
> > +	if (chan->direction == DMA_MEM_TO_DEV) {
> > +		segment->hw.control_stride |= XILINX_DMA_BD_SOP;
> > +		segment = list_last_entry(&desc->segments,
> > +					  struct xilinx_vdma_tx_segment,
> > +					  node);
> > +		segment->hw.control_stride |= XILINX_DMA_BD_EOP;
> > +	}
> > +
> > +	return &desc->async_tx;
> > +
> > +error:
> > +	xilinx_vdma_free_tx_descriptor(chan, desc);
> > +	return NULL;
> > +}
> > +
> > +/**
> >   * xilinx_vdma_terminate_all - Halt the channel and free descriptors
> >   * @chan: Driver specific VDMA Channel pointer
> >   */
> > @@ -1179,27 +1445,36 @@ static int xilinx_vdma_chan_probe(struct
> > xilinx_vdma_device *xdev, chan->id = 0;
> >
> >  		chan->ctrl_offset = XILINX_VDMA_MM2S_CTRL_OFFSET;
> > -		chan->desc_offset = XILINX_VDMA_MM2S_DESC_OFFSET;
> > +		if (xdev->quirks & AXIVDMA_SUPPORT) {
> > +			chan->desc_offset =
> XILINX_VDMA_MM2S_DESC_OFFSET;
> >
> > -		if (xdev->flush_on_fsync == XILINX_VDMA_FLUSH_BOTH ||
> > -		    xdev->flush_on_fsync == XILINX_VDMA_FLUSH_MM2S)
> > -			chan->flush_on_fsync = true;
> > +			if (xdev->flush_on_fsync ==
> XILINX_VDMA_FLUSH_BOTH ||
> > +			    xdev->flush_on_fsync ==
> XILINX_VDMA_FLUSH_MM2S)
> > +				chan->flush_on_fsync = true;
> > +		}
> >  	} else if (of_device_is_compatible(node,
> >  					    "xlnx,axi-vdma-s2mm-channel")) {
> >  		chan->direction = DMA_DEV_TO_MEM;
> >  		chan->id = 1;
> >
> >  		chan->ctrl_offset = XILINX_VDMA_S2MM_CTRL_OFFSET;
> > -		chan->desc_offset = XILINX_VDMA_S2MM_DESC_OFFSET;
> > +		if (xdev->quirks & AXIVDMA_SUPPORT) {
> > +			chan->desc_offset =
> XILINX_VDMA_S2MM_DESC_OFFSET;
> >
> > -		if (xdev->flush_on_fsync == XILINX_VDMA_FLUSH_BOTH ||
> > -		    xdev->flush_on_fsync == XILINX_VDMA_FLUSH_S2MM)
> > -			chan->flush_on_fsync = true;
> > +			if (xdev->flush_on_fsync ==
> XILINX_VDMA_FLUSH_BOTH ||
> > +			    xdev->flush_on_fsync ==
> XILINX_VDMA_FLUSH_S2MM)
> > +				chan->flush_on_fsync = true;
> > +		}
> >  	} else {
> >  		dev_err(xdev->dev, "Invalid channel compatible node\n");
> >  		return -EINVAL;
> >  	}
> >
> > +	if (xdev->quirks & AXIVDMA_SUPPORT)
> > +		chan->start_transfer = xilinx_vdma_start_transfer;
> > +	else
> > +		chan->start_transfer = xilinx_dma_start_transfer;
> > +
> >  	/* Request the interrupt */
> >  	chan->irq = irq_of_parse_and_map(node, 0);
> >  	err = request_irq(chan->irq, xilinx_vdma_irq_handler, IRQF_SHARED,
> > @@ -1255,8 +1530,13 @@ static const struct xdma_platform_data
> xvdma_def = {
> >  	.quirks = AXIVDMA_SUPPORT,
> >  };
> >
> > +static const struct xdma_platform_data xdma_def = {
> > +	.quirks = AXIDMA_SUPPORT,
> > +};
> > +
> >  static const struct of_device_id xilinx_vdma_of_ids[] = {
> >  	{ .compatible = "xlnx,axi-vdma-1.00.a", .data = &xvdma_def},
> > +	{ .compatible = "xlnx,axi-dma-1.00.a", .data = &xdma_def},
> 
> Please keep the entries alphabetically sorted.

Ok Sure will fix in v2.

> 
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, xilinx_vdma_of_ids); @@ -1300,16 +1580,22
> @@
> > static int xilinx_vdma_probe(struct platform_device
> > *pdev) /* Retrieve the DMA engine properties from the device tree */
> >  	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
> >
> > -	err = of_property_read_u32(node, "xlnx,num-fstores", &num_frames);
> > -	if (err < 0) {
> > -		dev_err(xdev->dev, "missing xlnx,num-fstores property\n");
> > -		return err;
> > -	}
> > +	if ((xdev->quirks & AXIVDMA_SUPPORT)) {
> 
> Extra parenthesis. Furthermore, as every DMA IP implements one and only one
> type, please replace the _SUPPORT bitmask macros with an enum and test for
> equality.

Ok Sure will fix in v2.

> 
> >
> > -	err = of_property_read_u32(node, "xlnx,flush-fsync",
> > -					&xdev->flush_on_fsync);
> > -	if (err < 0)
> > -		dev_warn(xdev->dev, "missing xlnx,flush-fsync property\n");
> > +		err = of_property_read_u32(node, "xlnx,num-fstores",
> > +					   &num_frames);
> > +		if (err < 0) {
> > +			dev_err(xdev->dev,
> > +				"missing xlnx,num-fstores property\n");
> > +			return err;
> > +		}
> > +
> > +		err = of_property_read_u32(node, "xlnx,flush-fsync",
> > +						&xdev->flush_on_fsync);
> 
> Too many spaces, please align &xdev under node.

Ok Sure will fix in v2.

> 
> > +		if (err < 0)
> > +			dev_warn(xdev->dev,
> > +				 "missing xlnx,flush-fsync property\n");
> > +	}
> >
> >  	/* Initialize the DMA engine */
> >  	xdev->common.dev = &pdev->dev;
> > @@ -1322,11 +1608,20 @@ static int xilinx_vdma_probe(struct
> > platform_device
> > *pdev) xilinx_vdma_alloc_chan_resources;
> >  	xdev->common.device_free_chan_resources =
> >  				xilinx_vdma_free_chan_resources;
> > -	xdev->common.device_prep_interleaved_dma =
> > -				xilinx_vdma_dma_prep_interleaved;
> >  	xdev->common.device_terminate_all = xilinx_vdma_terminate_all;
> >  	xdev->common.device_tx_status = xilinx_vdma_tx_status;
> > -	xdev->common.device_issue_pending = xilinx_vdma_issue_pending;
> > +	if (xdev->quirks & AXIVDMA_SUPPORT) {
> > +		xdev->common.device_issue_pending =
> xilinx_vdma_issue_pending;
> > +		xdev->common.device_prep_interleaved_dma =
> > +				xilinx_vdma_dma_prep_interleaved;
> 
> Shouldn't the VDMA also set directions and residue granularity ? Please add that
> as an additional patch before this one.

VDMA won't support residue granularity.
Directions it requires will add one more patch before this one.

> 
> > +	} else {
> > +		xdev->common.device_prep_slave_sg =
> xilinx_dma_prep_slave_sg;
> > +		xdev->common.device_issue_pending =
> xilinx_dma_issue_pending;
> 
> I would use the same initialization order in both branches of the if, it will make
> the code easier to read.

Ok will fix in v2.

> 
> > +		xdev->common.directions = BIT(DMA_DEV_TO_MEM) |
> > +					  BIT(DMA_MEM_TO_DEV);
> 
> Shouldn't that depend on which channels have been synthesized (and thus
> declared in DT) ? The code to set the directions field can probably be made for
> all three DMA engine types.

Ok will fix in v2.

Regards,
Kedar.

> 
> > +		xdev->common.residue_granularity =
> > +
> DMA_RESIDUE_GRANULARITY_SEGMENT;
> > +	}
> >
> >  	platform_set_drvdata(pdev, xdev);
> >
> > @@ -1337,9 +1632,11 @@ static int xilinx_vdma_probe(struct
> > platform_device
> > *pdev) goto error;
> >  	}
> >
> > -	for (i = 0; i < XILINX_VDMA_MAX_CHANS_PER_DEVICE; i++)
> > -		if (xdev->chan[i])
> > -			xdev->chan[i]->num_frms = num_frames;
> > +	if (xdev->quirks & AXIVDMA_SUPPORT) {
> > +		for (i = 0; i < XILINX_VDMA_MAX_CHANS_PER_DEVICE; i++)
> > +			if (xdev->chan[i])
> > +				xdev->chan[i]->num_frms = num_frames;
> > +	}
> >
> >  	/* Register the DMA engine with the core */
> >  	dma_async_device_register(&xdev->common);
> 
> --
> Regards,
> 
> Laurent Pinchart
> :
