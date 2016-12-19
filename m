From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 19 Dec 2016 15:39:43 +0000
Subject: [PATCH 1/3] dmaengine: xilinx_dma: Check for channel idle state
 before submitting dma descriptor
In-Reply-To: <5248247.n0rV8xBPrZ@avalon>
References: <1481814682-31780-1-git-send-email-appanad@xilinx.com>
 <1481814682-31780-2-git-send-email-appanad@xilinx.com>
 <5248247.n0rV8xBPrZ@avalon>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A65D58E@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent Pinchart,

	Thanks for the review...

> >
> > +	if (!chan->idle)
> > +		return;
> 
> Don't you need to perform the same check for the DMA and CDMA channels ? If
> so, shouldn't this be moved to common code ?

Will fix it in v2...

> 
> There's another problem (not strictly introduced by this patch) I wanted to
> mention. The append_desc_queue() function, called from your tx_submit
> handler, appends descriptors to the pending_list. The DMA engine API states
> that a transfer submitted by tx_submit will not be executed until .issue_pending()
> is called. However, if a transfer is in progress at tx_submit time, I believe that
> the IRQ handler, at transfer completion, will start the next transfer from the
> pending_list even if .issue_pending() hasn't been called for it.
> 
> >  	if (list_empty(&chan->pending_list))
> >  		return;


If user submits more than h/w limit then that case only driver will process
The descriptors from the pending_list for other cases the pending_list will be 
Empty so driver just returns from there.

> 
> Now that you catch busy channels with a software flag, do you still need the
> xilinx_dma_is_running() and xilinx_dma_is_idle() checks ? Three different checks
> for the same or very similar conditions are confusing, if you really need them
> you should document clearly how they differ.

Will remove the xilinx_dma_is_running and xilinx_dmais_idle() checks and will use
Chan->idle check across all the IP's. Will fix it v2...

> 
> > @@ -1110,6 +1116,7 @@ static void xilinx_vdma_start_transfer(struct
> > xilinx_dma_chan *chan) vdma_desc_write(chan, XILINX_DMA_REG_VSIZE,
> > last->hw.vsize);
> >  	}
> >
> > +	chan->idle = false;
> 
> (and this too)

Will fix in v2...

Regards,
Kedar.
