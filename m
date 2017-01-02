From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 2 Jan 2017 11:46:30 +0000
Subject: [PATCH v2 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <a269409d-103e-1650-5df6-cc8743ed62cf@synopsys.com>
References: <1482483135-14767-1-git-send-email-appanad@xilinx.com>
 <1482483135-14767-3-git-send-email-appanad@xilinx.com>
 <a269409d-103e-1650-5df6-cc8743ed62cf@synopsys.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A65FFE9@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jose Miguel Abreu,
	
	Thanks for the review....
Sorry for the delay in the reply please see comments inline...

> >  	if (chan->has_sg) {
> >  		dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
> >  				tail_segment->phys);
> > +		list_splice_tail_init(&chan->pending_list, &chan->active_list);
> > +		chan->desc_pendingcount = 0;
> >  	} else {
> >  		struct xilinx_vdma_tx_segment *segment, *last = NULL;
> > -		int i = 0;
> > +		int i = 0, j = 0;
> >
> >  		if (chan->desc_submitcount < chan->num_frms)
> >  			i = chan->desc_submitcount;
> >
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
> > +
> > +				last = segment;
> > +			}
> > +			list_del(&desc->node);
> > +			list_add_tail(&desc->node, &chan->active_list);
> > +			j++;
> > +			if (list_empty(&chan->pending_list) ||
> > +			    (i == chan->num_frms))
> > +				break;
> > +			desc = list_first_entry(&chan->pending_list,
> > +						struct
> xilinx_dma_tx_descriptor,
> > +						node);
> >  		}
> >
> >  		if (!last)
> > @@ -1081,20 +1094,14 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_dma_chan *chan)
> >  		vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
> >  				last->hw.stride);
> >  		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last-
> >hw.vsize);
> 
> What if we reach here and j < num_frms? It can happen because if
> the pending list is empty the loop breaks. Then VDMA will start
> with framebuffers having address 0x0. You should only program
> vsize when j > num_frms or when we have already previously set
> the framebuffers (i.e. when submitcount has already been
> incremented num_frms at least once).

In case of j < num_frms VDMA won't start the frame buffer having address 0
As we are programming the VDMA buffer address based on the desc_submitcount value only i.e. i.

Code snippet in the driver doing this:
                         list_for_each_entry(segment, &desc->segments, node) {
                                if (chan->ext_addr)
                                        vdma_desc_write_64(chan,
                                          XILINX_VDMA_REG_START_ADDRESS_64(i++),
                                          segment->hw.buf_addr,
                                          segment->hw.buf_addr_msb);
                                else
                                        vdma_desc_write(chan,
                                            XILINX_VDMA_REG_START_ADDRESS(i++),
                                            segment->hw.buf_addr);

                                last = segment;
                        } 

Initially desc_submitcount will be zero.
Let's assume h/w is configured for 10 frames and user submitted only 5 frames.
And triggered the VDMA h/w using issue_pending in this case desc_submitcount will be 5.
desc_submitcount will become zero again only when
User submits more frames than h/w capable or user submit frames up to h/w capable.

If my understanding is wrong could you please elaborate the race condition that you are talking above?
	
Regards,
Kedar.

> 
> Best regards,
> Jose Miguel Abreu
> 
