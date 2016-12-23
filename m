From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 23 Dec 2016 08:49:07 +0000
Subject: [PATCH 1/3] dmaengine: xilinx_dma: Check for channel idle state
 before submitting dma descriptor
In-Reply-To: <2156938.MvgiZll4tB@avalon>
References: <1481814682-31780-1-git-send-email-appanad@xilinx.com>
 <5248247.n0rV8xBPrZ@avalon>
 <C246CAC1457055469EF09E3A7AC4E11A4A65D58E@XAP-PVEXMBX01.xlnx.xilinx.com>
 <2156938.MvgiZll4tB@avalon>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A65F569@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent Pinchart,

	Sorry for the delay in the reply.
	Thanks for the review...
> 
> Hi Kedar,
> 
> On Monday 19 Dec 2016 15:39:43 Appana Durga Kedareswara Rao wrote:
> > Hi Laurent Pinchart,
> >
> > 	Thanks for the review...
> >
> > > > +	if (!chan->idle)
> > > > +		return;
> > >
> > > Don't you need to perform the same check for the DMA and CDMA channels
> ?
> > > If so, shouldn't this be moved to common code ?
> >
> > Will fix it in v2...
> >
> > > There's another problem (not strictly introduced by this patch) I
> > > wanted to mention. The append_desc_queue() function, called from
> > > your tx_submit handler, appends descriptors to the pending_list. The
> > > DMA engine API states that a transfer submitted by tx_submit will
> > > not be executed until
> > > .issue_pending() is called. However, if a transfer is in progress at
> > > tx_submit time, I believe that the IRQ handler, at transfer
> > > completion, will start the next transfer from the pending_list even
> > > if
> > > .issue_pending() hasn't been called for it.
> > >
> > > >  	if (list_empty(&chan->pending_list))
> > > >  		return;
> >
> > If user submits more than h/w limit then that case only driver will
> > process The descriptors from the pending_list for other cases the
> > pending_list will be Empty so driver just returns from there.
> 
> I understand that, but that's not the problem. Your .tx_submit() handler calls
> append_desc_queue() which adds the tx descriptor to the pending_list. If a
> transfer is in progress at that time, I believe the transfer completion IRQ handler
> will take the next descriptor from the pending_list and process it, even though
> issue_pending() hasn't been called for it.
> 

Thanks for the explanation...
Agree will keep this my to-do list...

Regards,
Kedar.
