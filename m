From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 15 Dec 2016 19:09:39 +0000
Subject: [PATCH 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <9d92984b-e04a-cd29-e933-d8ea4d610c94@synopsys.com>
References: <1481814682-31780-1-git-send-email-appanad@xilinx.com>
 <1481814682-31780-3-git-send-email-appanad@xilinx.com>
 <9d92984b-e04a-cd29-e933-d8ea4d610c94@synopsys.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A65C9D3@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jose Miguel Abreu,

	Thanks for the review....

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
> 
> Hmm, is it possible to submit more than one segment? If so, then i and j will get
> out of sync.

If h/w is configured for more than 1 frame buffer and user submits more than one frame buffer
We can submit more than one frame/ segment to hw right??

> 
> > +			}
> > +			list_del(&desc->node);
> > +			list_add_tail(&desc->node, &chan->active_list);
> > +			j++;
> 
> But if i is non zero and pending_list has more than num_frms then i will not
> wrap-around as it should and will write to invalid framebuffer location, right?

Yep will fix in v2...
		
	If (if (list_empty(&chan->pending_list)) || (i == chan->num_frms)
		break;

Above condition is sufficient right???

> 
> > +			if (list_empty(&chan->pending_list))
> > +				break;
> > +			desc = list_first_entry(&chan->pending_list,
> > +						struct
> xilinx_dma_tx_descriptor,
> > +						node);
> >  		}
> >
> >  		if (!last)
> > @@ -1114,14 +1124,13 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_dma_chan *chan)
> >  		vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
> >  				last->hw.stride);
> >  		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last-
> >hw.vsize);
> 
> Maybe a check that all framebuffers contain valid addresses should be done
> before programming vsize so that VDMA does not try to write to invalid
> addresses.

Do we really need to check for valid address??? 
I didn't get you what to do you mean by invalid address could you please explain???
In the driver we are reading form the pending_list which will be updated by pep_interleaved_dma 
Call so we are under assumption that user sends the proper address right???

> 
> > +
> > +		chan->desc_submitcount += j;
> > +		chan->desc_pendingcount -= j;
> >  	}
> >
> >  	chan->idle = false;
> >  	if (!chan->has_sg) {
> > -		list_del(&desc->node);
> > -		list_add_tail(&desc->node, &chan->active_list);
> > -		chan->desc_submitcount++;
> > -		chan->desc_pendingcount--;
> >  		if (chan->desc_submitcount == chan->num_frms)
> >  			chan->desc_submitcount = 0;
> 
> "desc_submitcount >= chan->num_frms would be safer here.

Sure will fix in v2...

Regards,
Kedar.

> 
> >  	} else {
> 
> Best regards,
> Jose Miguel Abreu
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in the body
> of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
