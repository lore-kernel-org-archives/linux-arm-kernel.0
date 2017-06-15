From: sricharan@codeaurora.org (Sricharan R)
Date: Thu, 15 Jun 2017 20:19:48 +0530
Subject: [PATCH] dmaengine: qcom-bam: Process multiple pending descriptors
In-Reply-To: <20170615041011.GN13020@localhost>
References: <1496838547-15092-1-git-send-email-sricharan@codeaurora.org>
 <20170615041011.GN13020@localhost>
Message-ID: <004fa3c7-afb9-f56c-8a57-abc0117638eb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 6/15/2017 9:40 AM, Vinod Koul wrote:
> On Wed, Jun 07, 2017 at 05:59:07PM +0530, Sricharan R wrote:
>> The bam dmaengine has a circular FIFO to which we
>> add hw descriptors that describes the transaction.
>> The FIFO has space for about 4096 hw descriptors.
>>
>> Currently we add one descriptor and wait for it to
>> complete with interrupt and start processing the
>> next pending descriptor. In this way, FIFO is
>> underutilised and also adds additional interrupt
>> overhead for each of the descriptor. This results
>> in loss of throughput for clients that submits
>> multiple descriptors together, that can be processed
>> by bam and the client peripheral together.
>> So instead, when a client does an issue_pending,
>> we can keep pulling in descriptors from the pending
>> queue and add it to the FIFO, till either the FIFO
>> is full (or) client has requested for an interrupt
>> notification for that descriptor. After this,
>> receiving a completion interrupt implies that all
>> descriptors that were submitted have completed.
>> so notify completion for all the descriptors.
>>
>> CURRENT:
>>
>>             ------      -------   ---------------
>>             |DES 0|     |DESC 1|  |DESC 2 + INT |
>>             ------      -------   ---------------
>>                |           |            |
>>                |           |            |
>> INTERRUPT:   (INT)       (INT)	      (INT)
>> CALLBACK:     (CB)        (CB)         (CB)
>>
>> 		MTD_SPEEDTEST READ PAGE: 3560 KiB/s
>> 		MTD_SPEEDTEST WRITE PAGE: 2664 KiB/s
>> 		IOZONE READ: 2456 KB/s
>> 		IOZONE WRITE: 1230 KB/s
>>
>> 	bam dma interrupts (after tests): 96508
>>
>> CHANGE:
>>
>>         ------  -------    -------------
>>         |DES 0| |DESC 1   |DESC 2 + INT |
>>         ------  -------   --------------
>> 				|
>> 				|
>>           		      (INT)
>> 			      (CB for 0, 1, 2)
> 
> I am not sure why suppressing callback helps? I think you should still
> continue filling up FIFO but also ensure interrupt so that callback can be
> invoked, user thread maybe waiting on that
> 
> FWIW waiting for interrupt and submitting is extremely inefficient and
> shouldn't be done, so that part of this is good.
> 

 Thanks for the review.
 
 So one part is, adding desc to the FIFO till its full, so the BAM dmaengine is
 busy  when there are pending descriptors without waiting for interrupt.

 Another part is, currently, the driver signals the completion of the each
 descriptor with a interrupt, even though the client has not requested
 a DMA_PREP_INTERRUPT/registered a callback. Instead if the client has
 not requested for a interrupt for the completion of a descriptor, then
 generate a interrupt only for descriptor for which it was requested and
 also complete all the previous descriptors in that interrupt (means call
 all callbacks). So we still call all callbacks but at the end of a
 group of descriptors.

 This was reducing the total number of interrupts. Nand was one such client
 which was requiring callback only at the end of a group of submitted
 descriptors.

>>
>> 		MTD_SPEEDTEST READ PAGE: 3860 KiB/s
>> 		MTD_SPEEDTEST WRITE PAGE: 2837 KiB/s
>> 		IOZONE READ: 2677 KB/s
>> 		IOZONE WRITE: 1308 KB/s
>>
>> 	bam dma interrupts (after tests): 58806
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  drivers/dma/qcom/bam_dma.c | 180 +++++++++++++++++++++++++++++----------------
>>  1 file changed, 115 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index 03c4eb3..97892f7 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -46,6 +46,7 @@
>>  #include <linux/of_address.h>
>>  #include <linux/of_irq.h>
>>  #include <linux/of_dma.h>
>> +#include <linux/circ_buf.h>
>>  #include <linux/clk.h>
>>  #include <linux/dmaengine.h>
>>  #include <linux/pm_runtime.h>
>> @@ -76,7 +77,8 @@ struct bam_async_desc {
>>  	u16 flags;
>>  
>>  	struct bam_desc_hw *curr_desc;
>> -
>> +	/* list node for the desc in the bam_chan list of descriptors */
>> +	struct list_head desc_node;
>>  	enum dma_transfer_direction dir;
>>  	size_t length;
>>  	struct bam_desc_hw desc[0];
>> @@ -371,6 +373,8 @@ struct bam_chan {
>>  	unsigned int initialized;	/* is the channel hw initialized? */
>>  	unsigned int paused;		/* is the channel paused? */
>>  	unsigned int reconfigure;	/* new slave config? */
>> +	/* list of descriptors currently processed */
>> +	struct list_head desc_list;
>>  
>>  	struct list_head node;
>>  };
>> @@ -486,6 +490,8 @@ static void bam_chan_init_hw(struct bam_chan *bchan,
>>  
>>  	bchan->initialized = 1;
>>  
>> +	INIT_LIST_HEAD(&bchan->desc_list);
>> +
>>  	/* init FIFO pointers */
>>  	bchan->head = 0;
>>  	bchan->tail = 0;
>> @@ -631,8 +637,6 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>>  
>>  	if (flags & DMA_PREP_INTERRUPT)
>>  		async_desc->flags |= DESC_FLAG_EOT;
>> -	else
>> -		async_desc->flags |= DESC_FLAG_INT;
> 
> shouldn't we do DESC_FLAG_INT for DMA_PREP_INTERRUPT and not EOT which i
> suppose means end of transfers?

 EOT generates a interrupt as well. So, right now we do interrupt for EOT
 if DMA_PREP_INTERRUPT was set, otherwise do interrupt with DESC_FLAG_INT.

> 
>>  
>>  	async_desc->num_desc = num_alloc;
>>  	async_desc->curr_desc = async_desc->desc;
>> @@ -680,13 +684,18 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>>  static int bam_dma_terminate_all(struct dma_chan *chan)
>>  {
>>  	struct bam_chan *bchan = to_bam_chan(chan);
>> +	struct bam_async_desc *async_desc;
>>  	unsigned long flag;
>>  	LIST_HEAD(head);
>>  
>>  	/* remove all transactions, including active transaction */
>>  	spin_lock_irqsave(&bchan->vc.lock, flag);
>>  	if (bchan->curr_txd) {
>> -		list_add(&bchan->curr_txd->vd.node, &bchan->vc.desc_issued);
>> +		list_for_each_entry(async_desc, &bchan->desc_list, desc_node) {
>> +			bchan->curr_txd = async_desc;
>> +			list_add(&bchan->curr_txd->vd.node,
>> +				 &bchan->vc.desc_issued);
> 
> that is wrong, terminated should not add to issued list

 hmm, since it was already done like that, i added the same for list of descriptors now.

> 
>> +		}
>>  		bchan->curr_txd = NULL;
>>  	}
>>  
>> @@ -761,7 +770,7 @@ static u32 process_channel_irqs(struct bam_device *bdev)
>>  {
>>  	u32 i, srcs, pipe_stts;
>>  	unsigned long flags;
>> -	struct bam_async_desc *async_desc;
>> +	struct bam_async_desc *async_desc, *tmp;
>>  
>>  	srcs = readl_relaxed(bam_addr(bdev, 0, BAM_IRQ_SRCS_EE));
>>  
>> @@ -777,33 +786,39 @@ static u32 process_channel_irqs(struct bam_device *bdev)
>>  
>>  		/* clear pipe irq */
>>  		pipe_stts = readl_relaxed(bam_addr(bdev, i, BAM_P_IRQ_STTS));
>> -
> 
> noise

 ok, will remove.

> 
>>  		writel_relaxed(pipe_stts, bam_addr(bdev, i, BAM_P_IRQ_CLR));
>>  
>>  		spin_lock_irqsave(&bchan->vc.lock, flags);
>> -		async_desc = bchan->curr_txd;
>> -
>> -		if (async_desc) {
>> -			async_desc->num_desc -= async_desc->xfer_len;
>> -			async_desc->curr_desc += async_desc->xfer_len;
>> -			bchan->curr_txd = NULL;
>> -
>> -			/* manage FIFO */
>> -			bchan->head += async_desc->xfer_len;
>> -			bchan->head %= MAX_DESCRIPTORS;
>> -
>> -			/*
>> -			 * if complete, process cookie.  Otherwise
>> -			 * push back to front of desc_issued so that
>> -			 * it gets restarted by the tasklet
>> -			 */
>> -			if (!async_desc->num_desc)
>> -				vchan_cookie_complete(&async_desc->vd);
>> -			else
>> -				list_add(&async_desc->vd.node,
>> -					&bchan->vc.desc_issued);
>> +
>> +		list_for_each_entry_safe(async_desc, tmp,
>> +					 &bchan->desc_list, desc_node) {
>> +			bchan->curr_txd = async_desc;
>> +
>> +			if (async_desc) {
>> +				async_desc->num_desc -= async_desc->xfer_len;
>> +				async_desc->curr_desc += async_desc->xfer_len;
>> +
>> +				/* manage FIFO */
>> +				bchan->head += async_desc->xfer_len;
>> +				bchan->head %= MAX_DESCRIPTORS;
>> +
>> +				/*
>> +				 * if complete, process cookie.  Otherwise
> 								^^
> double spaces

 ok.

>> +				 * push back to front of desc_issued so that
>> +				 * it gets restarted by the tasklet
>> +				 */
> 
> can you explain this part, why would you move this up in latter case?

 This means that, we were not able to push all the sgs of that descriptor
 in to the FIFO, as it become full, so only some sgs was pushed. So
 add the descriptor back to the issued list to process the remaining sgs.

> 
>> +				if (!async_desc->num_desc) {
>> +					vchan_cookie_complete(&async_desc->vd);
>> +				} else {
>> +					list_add(&async_desc->vd.node,
>> +						 &bchan->vc.desc_issued);
>> +				}
>> +				list_del(&async_desc->desc_node);
>> +			}
>>  		}
>>  
>> +		bchan->curr_txd = NULL;
>> +
>>  		spin_unlock_irqrestore(&bchan->vc.lock, flags);
>>  	}
>>  
>> @@ -863,6 +878,7 @@ static enum dma_status bam_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>>  		struct dma_tx_state *txstate)
>>  {
>>  	struct bam_chan *bchan = to_bam_chan(chan);
>> +	struct bam_async_desc *async_desc;
>>  	struct virt_dma_desc *vd;
>>  	int ret;
>>  	size_t residue = 0;
>> @@ -877,12 +893,21 @@ static enum dma_status bam_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>>  		return bchan->paused ? DMA_PAUSED : ret;
>>  
>>  	spin_lock_irqsave(&bchan->vc.lock, flags);
>> +
>>  	vd = vchan_find_desc(&bchan->vc, cookie);
>> -	if (vd)
>> +	if (vd) {
>>  		residue = container_of(vd, struct bam_async_desc, vd)->length;
>> -	else if (bchan->curr_txd && bchan->curr_txd->vd.tx.cookie == cookie)
>> -		for (i = 0; i < bchan->curr_txd->num_desc; i++)
>> -			residue += bchan->curr_txd->curr_desc[i].size;
>> +	} else if (bchan->curr_txd) {
>> +		list_for_each_entry(async_desc, &bchan->desc_list, desc_node) {
>> +			bchan->curr_txd = async_desc;
>> +
>> +			if (bchan->curr_txd->vd.tx.cookie != cookie)
>> +				continue;
>> +
>> +			for (i = 0; i < bchan->curr_txd->num_desc; i++)
>> +				residue += bchan->curr_txd->curr_desc[i].size;
>> +		}
>> +	}
>>  
>>  	spin_unlock_irqrestore(&bchan->vc.lock, flags);
>>  
>> @@ -923,63 +948,88 @@ static void bam_start_dma(struct bam_chan *bchan)
>>  {
>>  	struct virt_dma_desc *vd = vchan_next_desc(&bchan->vc);
>>  	struct bam_device *bdev = bchan->bdev;
>> -	struct bam_async_desc *async_desc;
>> +	struct bam_async_desc *async_desc = NULL;
>>  	struct bam_desc_hw *desc;
>>  	struct bam_desc_hw *fifo = PTR_ALIGN(bchan->fifo_virt,
>>  					sizeof(struct bam_desc_hw));
>>  	int ret;
>> +	unsigned int avail;
>>  
>>  	lockdep_assert_held(&bchan->vc.lock);
>>  
>>  	if (!vd)
>>  		return;
>>  
>> -	list_del(&vd->node);
>> -
>> -	async_desc = container_of(vd, struct bam_async_desc, vd);
>> -	bchan->curr_txd = async_desc;
>> -
>>  	ret = pm_runtime_get_sync(bdev->dev);
>>  	if (ret < 0)
>>  		return;
>>  
>> -	/* on first use, initialize the channel hardware */
>> -	if (!bchan->initialized)
>> -		bam_chan_init_hw(bchan, async_desc->dir);
>> +	while (vd) {
>> +		list_del(&vd->node);
>>  
>> -	/* apply new slave config changes, if necessary */
>> -	if (bchan->reconfigure)
>> -		bam_apply_new_config(bchan, async_desc->dir);
>> +		async_desc = container_of(vd, struct bam_async_desc, vd);
>>  
>> -	desc = bchan->curr_txd->curr_desc;
>> +		/* on first use, initialize the channel hardware */
>> +		if (!bchan->initialized)
>> +			bam_chan_init_hw(bchan, async_desc->dir);
>>  
>> -	if (async_desc->num_desc > MAX_DESCRIPTORS)
>> -		async_desc->xfer_len = MAX_DESCRIPTORS;
>> -	else
>> -		async_desc->xfer_len = async_desc->num_desc;
>> +		/* apply new slave config changes, if necessary */
>> +		if (bchan->reconfigure)
>> +			bam_apply_new_config(bchan, async_desc->dir);
>>  
>> -	/* set any special flags on the last descriptor */
>> -	if (async_desc->num_desc == async_desc->xfer_len)
>> -		desc[async_desc->xfer_len - 1].flags =
>> -					cpu_to_le16(async_desc->flags);
>> -	else
>> -		desc[async_desc->xfer_len - 1].flags |=
>> +		bchan->curr_txd = async_desc;
>> +		desc = bchan->curr_txd->curr_desc;
>> +		avail = CIRC_SPACE(bchan->tail, bchan->head,
>> +				   MAX_DESCRIPTORS + 1);
>> +
>> +		if (async_desc->num_desc > avail)
>> +			async_desc->xfer_len = avail;
>> +		else
>> +			async_desc->xfer_len = async_desc->num_desc;
>> +
>> +		/* set any special flags on the last descriptor */
>> +		if (async_desc->num_desc == async_desc->xfer_len)
>> +			desc[async_desc->xfer_len - 1].flags |=
>> +						cpu_to_le16(async_desc->flags);
>> +
>> +		vd = vchan_next_desc(&bchan->vc);
>> +
>> +		/*
>> +		 * This will be the last descriptor in the chain if,
>> +		 *  - FIFO is FULL.
>> +		 *  - No more descriptors to add.
>> +		 *  - This descriptor has interrupt flags set,
>> +		 *    so that we will have to indicate finishing of
>> +		 *    that descriptor.
> 
> is this a HW limitation? Cant interrupt be generated while continuing the
> transfer of next one in FIFO?

 No HW limitation here. I was doing this, so that we can keep a list
 of descriptors in which the last descriptor requires interrupt and
 when interrupt is generated, all the descriptors in the list are
 completed. But this can be still be optimised, by not stopping at
 end of the flags, continue to add descs just till FIFO is full, so
 bam works while interrupts are handled by the cpu. Will try that.

Regards,
  Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
