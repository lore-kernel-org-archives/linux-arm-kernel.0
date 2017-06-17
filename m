From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 17 Jun 2017 19:07:16 +0530
Subject: [PATCH] dmaengine: qcom-bam: Process multiple pending descriptors
In-Reply-To: <004fa3c7-afb9-f56c-8a57-abc0117638eb@codeaurora.org>
References: <1496838547-15092-1-git-send-email-sricharan@codeaurora.org>
 <20170615041011.GN13020@localhost>
 <004fa3c7-afb9-f56c-8a57-abc0117638eb@codeaurora.org>
Message-ID: <20170617133716.GG19154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 08:19:48PM +0530, Sricharan R wrote:

> > I am not sure why suppressing callback helps? I think you should still
> > continue filling up FIFO but also ensure interrupt so that callback can be
> > invoked, user thread maybe waiting on that
> > 
> > FWIW waiting for interrupt and submitting is extremely inefficient and
> > shouldn't be done, so that part of this is good.
> > 
> 
>  Thanks for the review.
>  
>  So one part is, adding desc to the FIFO till its full, so the BAM dmaengine is
>  busy  when there are pending descriptors without waiting for interrupt.
> 
>  Another part is, currently, the driver signals the completion of the each
>  descriptor with a interrupt, even though the client has not requested
>  a DMA_PREP_INTERRUPT/registered a callback. Instead if the client has
>  not requested for a interrupt for the completion of a descriptor, then
>  generate a interrupt only for descriptor for which it was requested and
>  also complete all the previous descriptors in that interrupt (means call
>  all callbacks). So we still call all callbacks but at the end of a
>  group of descriptors.

okay that sounds sane, but somehow I was getting the impression that we
might be suppressing, so you might want to update comments

> >>  	async_desc->num_desc = num_alloc;
> >>  	async_desc->curr_desc = async_desc->desc;
> >> @@ -680,13 +684,18 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
> >>  static int bam_dma_terminate_all(struct dma_chan *chan)
> >>  {
> >>  	struct bam_chan *bchan = to_bam_chan(chan);
> >> +	struct bam_async_desc *async_desc;
> >>  	unsigned long flag;
> >>  	LIST_HEAD(head);
> >>  
> >>  	/* remove all transactions, including active transaction */
> >>  	spin_lock_irqsave(&bchan->vc.lock, flag);
> >>  	if (bchan->curr_txd) {
> >> -		list_add(&bchan->curr_txd->vd.node, &bchan->vc.desc_issued);
> >> +		list_for_each_entry(async_desc, &bchan->desc_list, desc_node) {
> >> +			bchan->curr_txd = async_desc;
> >> +			list_add(&bchan->curr_txd->vd.node,
> >> +				 &bchan->vc.desc_issued);
> > 
> > that is wrong, terminated should not add to issued list
> 
>  hmm, since it was already done like that, i added the same for list of descriptors now.

Sounds like you should fix existing behaviour too :)

-- 
~Vinod
