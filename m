From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 19 Dec 2016 15:40:02 +0000
Subject: [PATCH 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <689b1077-6ee3-60d0-1fdf-0a125003a479@synopsys.com>
References: <1481814682-31780-1-git-send-email-appanad@xilinx.com>
 <1481814682-31780-3-git-send-email-appanad@xilinx.com>
 <9d92984b-e04a-cd29-e933-d8ea4d610c94@synopsys.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A65C9D3@XAP-PVEXMBX01.xlnx.xilinx.com>
 <689b1077-6ee3-60d0-1fdf-0a125003a479@synopsys.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A65D59D@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jose Miguel Abreu,

	Thanks for the review... 

> >
> >>> -			last = segment;
> >>> +		for (j = 0; j < chan->num_frms; ) {
> >>> +			list_for_each_entry(segment, &desc->segments, node)
> >> {
> >>> +				if (chan->ext_addr)
> >>> +					vdma_desc_write_64(chan,
> >>> +
> >> XILINX_VDMA_REG_START_ADDRESS_64(i++),
> >>> +					  segment->hw.buf_addr,
> >>> +					  segment->hw.buf_addr_msb);
> >>> +				else
> >>> +					vdma_desc_write(chan,
> >>> +
> >> XILINX_VDMA_REG_START_ADDRESS(i++),
> >>> +					    segment->hw.buf_addr);
> >>> +
> >>> +				last = segment;
> >> Hmm, is it possible to submit more than one segment? If so, then i
> >> and j will get out of sync.
> > If h/w is configured for more than 1 frame buffer and user submits
> > more than one frame buffer We can submit more than one frame/ segment to
> hw right??
> 
> I'm not sure. When I used VDMA driver I always submitted only one segment and
> multiple descriptors. But the problem is, for example:
> 
> If you have:
> descriptor1 (2 segments)
> descriptor2 (2 segments)
> 
> And you have 3 frame buffers in the HW.
> 
> Then:
> 1st frame buffer will have: descriptor1 -> segment1 2nd frame buffer will have:
> descriptor1 -> segment2 3rd frame buffer will have: descriptor2 -> segment1
> but, 4th frame buffer will have: descriptor2 -> segment2 <---- INVALID because
> there is only 3 frame buffers
> 
> So, maybe a check inside the loop "list_for_each_entry(segment, &desc-
> >segments, node)" could be a nice to have.

With the current driver flow user can submit only 1 segment per descriptor
That's why didn't checked the list_for_each_entry for each descriptors...
Hope it clarifies your query...

> 
> >
> >>> +			}
> >>> +			list_del(&desc->node);
> >>> +			list_add_tail(&desc->node, &chan->active_list);
> >>> +			j++;
> >> But if i is non zero and pending_list has more than num_frms then i
> >> will not wrap-around as it should and will write to invalid framebuffer
> location, right?
> > Yep will fix in v2...
> >
> > 	If (if (list_empty(&chan->pending_list)) || (i == chan->num_frms)
> > 		break;
> >
> > Above condition is sufficient right???
> 
> Looks ok.

Thanks...

> >>> @@ -1114,14 +1124,13 @@ static void
> >>> xilinx_vdma_start_transfer(struct
> >> xilinx_dma_chan *chan)
> >>>  		vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
> >>>  				last->hw.stride);
> >>>  		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last-
> hw.vsize);
> >> Maybe a check that all framebuffers contain valid addresses should be
> >> done before programming vsize so that VDMA does not try to write to
> >> invalid addresses.
> > Do we really need to check for valid address???
> > I didn't get you what to do you mean by invalid address could you please
> explain???
> > In the driver we are reading form the pending_list which will be
> > updated by pep_interleaved_dma Call so we are under assumption that user
> sends the proper address right???
> 
> What I mean by valid address is to check that i variable has already been
> incremented by num_frms at least once since a VDMA reset. This way you know
> that you have programmed all the addresses of the frame buffers with an
> address and they are non-zero.

Ok Sure will fix in v2...

Regards,
Kedar.

> 
> Best regards,
> Jose Miguel Abreu
> 
