From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 19 Dec 2016 15:41:25 +0000
Subject: [PATCH 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <30884836.ckISXSrEvA@avalon>
References: <1481814682-31780-1-git-send-email-appanad@xilinx.com>
 <1481814682-31780-3-git-send-email-appanad@xilinx.com>
 <30884836.ckISXSrEvA@avalon>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A65D5AC@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent Pinchart,

	Thanks for the review...

> > +		int i = 0, j = 0;
> >
> >  		if (chan->desc_submitcount < chan->num_frms)
> >  			i = chan->desc_submitcount;
> 
> I don't get this. i seems to index into a segment start address array, but gets
> initialized with a variable documented as "Descriptor h/w submitted count". I'm
> not familiar with the hardware, but it makes no sense to me.

Here i is the h/w buffer address. 
For ex: If the h/w is configured for 3 frame buffers and user submits 4 desc's
Then we need to submit only 3 frame buffers to the h/w and the next desc will be submitted
After there is a room for buffers I mean when the free buffer is available.

> 
> > -		list_for_each_entry(segment, &desc->segments, node) {
> > -			if (chan->ext_addr)
> > -				vdma_desc_write_64(chan,
> > -
> 	XILINX_VDMA_REG_START_ADDRESS_64(i++),
> > -					segment->hw.buf_addr,
> > -					segment->hw.buf_addr_msb);
> > -			else
> > -				vdma_desc_write(chan,
> > -
> 	XILINX_VDMA_REG_START_ADDRESS(i++),
> > -					segment->hw.buf_addr);
> > -
> > -			last = segment;
> 
> Isn't it an issue to write the descriptors only after calling
> xilinx_dma_start() ?

Until writing to the VSIZE h/w won't get started...

> 
> > +		for (j = 0; j < chan->num_frms; ) {
> > +			list_for_each_entry(segment, &desc->segments, node)
> {
> > +				if (chan->ext_addr)
> > +					vdma_desc_write_64(chan,
> > +
> XILINX_VDMA_REG_START_ADDRESS_64(i++),
> > +					  segment->hw.buf_addr,
> > +					  segment->hw.buf_addr_msb);
> > +				else
> > +					vdma_desc_write(chan,
> > +
> XILINX_VDMA_REG_START_ADDRESS(i++),
> > +					    segment->hw.buf_addr);
> 
> I assume the size of the start address array to be limited by the hardware, but I
> don't see how this code prevents from overflowing this.
> 
> The whole function is very difficult to understand, it probably requires a rewrite.

Will fix it in v2...

> 
> > +				last = segment;
> > +			}
> > +			list_del(&desc->node);
> > +			list_add_tail(&desc->node, &chan->active_list);
> > +			j++;
> > +			if (list_empty(&chan->pending_list))
> > +				break;
> > +			desc = list_first_entry(&chan->pending_list,
> > +						struct
> xilinx_dma_tx_descriptor,
> > +						node);
> >  		}
> >  	if (!chan->has_sg) {
> > -		list_del(&desc->node);
> > -		list_add_tail(&desc->node, &chan->active_list);
> > -		chan->desc_submitcount++;
> > -		chan->desc_pendingcount--;
> >  		if (chan->desc_submitcount == chan->num_frms)
> >  			chan->desc_submitcount = 0;
> >  	} else {
> 
> While at it, can you merge this into the previous if (chan->has_sg) { ... } else { ... }
> ? Having them separate is confusing.

Ok sure will fix in v2...

Regards,
Kedar.

> 
> 
> --
> Regards,
> 
> Laurent Pinchart
