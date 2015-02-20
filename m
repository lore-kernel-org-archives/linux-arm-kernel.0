From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 20 Feb 2015 12:25:55 +0100
Subject: [PATCH v2 1/2] dma: at_hdmac: Fix calculation of the residual
 bytes
In-Reply-To: <1424365673-7675-2-git-send-email-torfl6749@gmail.com>
References: <1424365673-7675-1-git-send-email-torfl6749@gmail.com>
 <1424365673-7675-2-git-send-email-torfl6749@gmail.com>
Message-ID: <54E719C3.1000002@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/02/2015 18:07, Torsten Fleischer a ?crit :
> From: Torsten Fleischer <torfl6749@gmail.com>
> 
> This patch fixes the following issues regarding to the calculation of the
> residue:
> 
> 1. The residue is always calculated for the current transfer even if the
> cookie is associated to a pending transfer.
> 
> 2. For scatter/gather DMA the calculation of the residue for the current
> transfer doesn't include the bytes of the child descriptors that are already
> transferred.
> It only calculates the difference between the transfer's total length minus
> the number of bytes that are already transferred for the current child
> descriptor.
> For example: There is a scatter/gather DMA transfer with a total length of
> 1 MByte. Getting the residue several times while the transfer is running shows
> something like that:
> 
> 1: residue = 975584
> 2: residue = 1002766
> 3: residue = 992627
> 4: residue = 983767
> 5: residue = 985694
> 6: residue = 1008094
> 7: residue = 1009741
> 8: residue = 1011195
> 
> 3. The driver stores the residue but never resets it when starting a new
> transfer.
> For example: If there are two subsequent DMA transfers. The first one with
> a total length of 1 MByte and the second one with a total length of 1 kByte.
> Getting the residue for both transfers shows something like that:
> 
> transfer 1: residue = 975584
> transfer 2: residue = 1048380
> 
> Changes from V1:
>    * Fixed coding style of the multi-line comments.
>    * Improved accuracy of the residue calculation when the transfer for the
>      first descriptor is active.
> 
> Signed-off-by: Torsten Fleischer <torfl6749@gmail.com>

Torsten,

Thanks a lot for your work and sorry for the delay.
I just do an additional review after Ludovic's one. BTW, I think we can
add his from the v1 of the series:
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Anyway, I still have a few comments below...

> ---
>  drivers/dma/at_hdmac.c      | 155 +++++++++++++++++++++++---------------------
>  drivers/dma/at_hdmac_regs.h |  11 ++--
>  2 files changed, 87 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index ca9dd26..f46d86d 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -233,93 +233,104 @@ static void atc_dostart(struct at_dma_chan *atchan, struct at_desc *first)
>  }
>  
>  /*
> - * atc_get_current_descriptors -
> - * locate the descriptor which equal to physical address in DSCR
> - * @atchan: the channel we want to start
> - * @dscr_addr: physical descriptor address in DSCR
> + * atc_get_desc_by_cookie - get the descriptor of a cookie
> + * @atchan: the DMA channel
> + * @cookie: the cookie to get the descriptor for
>   */
> -static struct at_desc *atc_get_current_descriptors(struct at_dma_chan *atchan,
> -							u32 dscr_addr)
> +static struct at_desc *atc_get_desc_by_cookie(struct at_dma_chan *atchan,
> +						dma_cookie_t cookie)
>  {
> -	struct at_desc  *desc, *_desc, *child, *desc_cur = NULL;
> +	struct at_desc *desc, *_desc;
>  
> -	list_for_each_entry_safe(desc, _desc, &atchan->active_list, desc_node) {
> -		if (desc->lli.dscr == dscr_addr) {
> -			desc_cur = desc;
> -			break;
> -		}
> +	list_for_each_entry_safe(desc, _desc, &atchan->queue, desc_node) {
> +		if (desc->txd.cookie == cookie)
> +			return desc;
> +	}
>  
> -		list_for_each_entry(child, &desc->tx_list, desc_node) {
> -			if (child->lli.dscr == dscr_addr) {
> -				desc_cur = child;
> -				break;
> -			}
> -		}
> +	list_for_each_entry_safe(desc, _desc, &atchan->active_list, desc_node) {
> +		if (desc->txd.cookie == cookie)
> +			return desc;
>  	}
>  
> -	return desc_cur;
> +	return NULL;
>  }
>  
> -/*
> - * atc_get_bytes_left -
> - * Get the number of bytes residue in dma buffer,
> - * @chan: the channel we want to start
> +/**
> + * atc_get_bytes_left - get the number of bytes residue for a cookie
> + * @chan: DMA channel
> + * @cookie: transaction identifier to check status of
>   */
> -static int atc_get_bytes_left(struct dma_chan *chan)
> +static int atc_get_bytes_left(struct dma_chan *chan, dma_cookie_t cookie)
>  {
>  	struct at_dma_chan      *atchan = to_at_dma_chan(chan);
> -	struct at_dma           *atdma = to_at_dma(chan->device);
> -	int	chan_id = atchan->chan_common.chan_id;
>  	struct at_desc *desc_first = atc_first_active(atchan);
> -	struct at_desc *desc_cur;
> +	struct at_desc *desc;
>  	int ret = 0, count = 0;
> +	u32 ctrla, dscr;
>  
>  	/*
> -	 * Initialize necessary values in the first time.
> -	 * remain_desc record remain desc length.
> +	 * If the cookie doesn't match to the currently running transfer then
> +	 * we can return the total length of the associated DMA transfer,
> +	 * because it is still queued.
>  	 */
> -	if (atchan->remain_desc == 0)
> -		/* First descriptor embedds the transaction length */
> -		atchan->remain_desc = desc_first->len;
> +	desc = atc_get_desc_by_cookie(atchan, cookie);
> +	if (desc == NULL)
> +		return -EINVAL;
> +	else if (desc != desc_first)
> +		return desc->total_len;
>  
> -	/*
> -	 * This happens when current descriptor transfer complete.
> -	 * The residual buffer size should reduce current descriptor length.
> -	 */
> -	if (unlikely(test_bit(ATC_IS_BTC, &atchan->status))) {
> -		clear_bit(ATC_IS_BTC, &atchan->status);
> -		desc_cur = atc_get_current_descriptors(atchan,
> -						channel_readl(atchan, DSCR));
> -		if (!desc_cur) {
> -			ret = -EINVAL;
> -			goto out;
> +	/* cookie matches to the currently running transfer */
> +	ret = desc_first->total_len;
> +
> +	if (desc_first->lli.dscr) {
> +		/* hardware linked list transfer */
> +
> +		/*
> +		 * Calculate the residue by removing the length of the child
> +		 * descriptors already transferred from the total length.
> +		 * To get the current child descriptor we can use the value of
> +		 * the channel's DSCR register and compare it against the value
> +		 * of the hardware linked list structure of each child
> +		 * descriptor.
> +		 */
> +
> +		ctrla = channel_readl(atchan, CTRLA);
> +		rmb(); /* ensure CTRLA is read before DSCR */
> +		dscr = channel_readl(atchan, DSCR);
> +
> +		/* for the first descriptor we can be more accurate */
> +		if (desc_first->lli.dscr == dscr) {
> +			count = (ctrla & ATC_BTSIZE_MAX);
> +			ret -= count << ATC_REG_TO_SRC_WIDTH(ctrla);

I see a little issue here. How are you sure that we must use the *src*
width and not the *dst* width in this computation?

As the register width is different depending on the transfer direction,
I suspect the computation can be wrong in "slave_sg" case.
So, I would recommend to keep the "tx_width" property in the descriptor
and use it here.

Apart from that, it seems that this computation or variants of it are
done twice or maybe 3 times. So, do you think that we can extract a
function from this code?

> +			return ret;
>  		}
>  
> -		count = (desc_cur->lli.ctrla & ATC_BTSIZE_MAX)
> -			<< desc_first->tx_width;
> -		if (atchan->remain_desc < count) {
> -			ret = -EINVAL;
> -			goto out;
> +		ret -= desc_first->len;
> +		list_for_each_entry(desc, &desc_first->tx_list, desc_node) {
> +			if (desc->lli.dscr == dscr)
> +				break;
> +
> +			ret -= desc->len;
>  		}
>  
> -		atchan->remain_desc -= count;
> -		ret = atchan->remain_desc;
> -	} else {
>  		/*
> -		 * Get residual bytes when current
> -		 * descriptor transfer in progress.
> +		 * For the last descriptor in the chain we can calculate
> +		 * the remaining bytes using the channel's register.
>  		 */
> -		count = (channel_readl(atchan, CTRLA) & ATC_BTSIZE_MAX)
> -				<< (desc_first->tx_width);
> -		ret = atchan->remain_desc - count;
> +		if (!desc->lli.dscr) {
> +			ctrla = channel_readl(atchan, CTRLA);
> +			count = (desc->lli.ctrla & ATC_BTSIZE_MAX) -
> +				(ctrla & ATC_BTSIZE_MAX);
> +
> +			ret = count << ATC_REG_TO_SRC_WIDTH(ctrla);

Ditto.

> +		}
> +	} else {
> +		/* single transfer */
> +		ctrla = channel_readl(atchan, CTRLA);
> +		count = (ctrla & ATC_BTSIZE_MAX) << ATC_REG_TO_SRC_WIDTH(ctrla);

Ditto.

> +		ret -= count;
>  	}
> -	/*
> -	 * Check fifo empty.
> -	 */
> -	if (!(dma_readl(atdma, CHSR) & AT_DMA_EMPT(chan_id)))
> -		atc_issue_pending(chan);

Yes, I've never understood why it was needed.

>  
> -out:
>  	return ret;
>  }
>  
> @@ -534,8 +545,6 @@ static irqreturn_t at_dma_interrupt(int irq, void *dev_id)
>  					/* Give information to tasklet */
>  					set_bit(ATC_IS_ERROR, &atchan->status);
>  				}
> -				if (pending & AT_DMA_BTC(i))
> -					set_bit(ATC_IS_BTC, &atchan->status);
>  				tasklet_schedule(&atchan->tasklet);
>  				ret = IRQ_HANDLED;
>  			}
> @@ -648,14 +657,14 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  		desc->lli.ctrlb = ctrlb;
>  
>  		desc->txd.cookie = 0;
> +		desc->len = xfer_count << src_width;
>  
>  		atc_desc_chain(&first, &prev, desc);
>  	}
>  
>  	/* First descriptor of the chain embedds additional information */
>  	first->txd.cookie = -EBUSY;
> -	first->len = len;
> -	first->tx_width = src_width;

Let's keep tx_width.

> +	first->total_len = len;
>  
>  	/* set end-of-link to the last link descriptor of list*/
>  	set_desc_eol(desc);
> @@ -747,6 +756,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  					| ATC_SRC_WIDTH(mem_width)
>  					| len >> mem_width;
>  			desc->lli.ctrlb = ctrlb;
> +			desc->len = len;
>  
>  			atc_desc_chain(&first, &prev, desc);
>  			total_len += len;
> @@ -787,6 +797,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  					| ATC_DST_WIDTH(mem_width)
>  					| len >> reg_width;
>  			desc->lli.ctrlb = ctrlb;
> +			desc->len = len;
>  
>  			atc_desc_chain(&first, &prev, desc);
>  			total_len += len;
> @@ -801,8 +812,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  
>  	/* First descriptor of the chain embedds additional information */
>  	first->txd.cookie = -EBUSY;
> -	first->len = total_len;
> -	first->tx_width = reg_width;

Let's keep tx_width: this is where tx_width can be different depending
of the transfer direction.

> +	first->total_len = total_len;
>  
>  	/* first link descriptor of list is responsible of flags */
>  	first->txd.flags = flags; /* client is in control of this ack */
> @@ -867,6 +877,7 @@ atc_dma_cyclic_fill_desc(struct dma_chan *chan, struct at_desc *desc,
>  				| ATC_FC_MEM2PER
>  				| ATC_SIF(atchan->mem_if)
>  				| ATC_DIF(atchan->per_if);
> +		desc->len = period_len;
>  		break;
>  
>  	case DMA_DEV_TO_MEM:
> @@ -878,6 +889,7 @@ atc_dma_cyclic_fill_desc(struct dma_chan *chan, struct at_desc *desc,
>  				| ATC_FC_PER2MEM
>  				| ATC_SIF(atchan->per_if)
>  				| ATC_DIF(atchan->mem_if);
> +		desc->len = period_len;
>  		break;
>  
>  	default:
> @@ -959,8 +971,7 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
>  
>  	/* First descriptor of the chain embedds additional information */
>  	first->txd.cookie = -EBUSY;
> -	first->len = buf_len;
> -	first->tx_width = reg_width;

Here again, let's keep tx_width.

> +	first->total_len = buf_len;
>  
>  	return &first->txd;
>  
> @@ -1091,7 +1102,7 @@ atc_tx_status(struct dma_chan *chan,
>  	spin_lock_irqsave(&atchan->lock, flags);
>  
>  	/*  Get number of bytes left in the active transactions */
> -	bytes = atc_get_bytes_left(chan);
> +	bytes = atc_get_bytes_left(chan, cookie);
>  
>  	spin_unlock_irqrestore(&atchan->lock, flags);
>  
> @@ -1187,7 +1198,6 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
>  
>  	spin_lock_irqsave(&atchan->lock, flags);
>  	atchan->descs_allocated = i;
> -	atchan->remain_desc = 0;

Ok, this is not needed anymore: right.

>  	list_splice(&tmp_list, &atchan->free_list);
>  	dma_cookie_init(chan);
>  	spin_unlock_irqrestore(&atchan->lock, flags);
> @@ -1230,7 +1240,6 @@ static void atc_free_chan_resources(struct dma_chan *chan)
>  	list_splice_init(&atchan->free_list, &list);
>  	atchan->descs_allocated = 0;
>  	atchan->status = 0;
> -	atchan->remain_desc = 0;
>  
>  	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
>  }
> diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
> index 2787aba..f458642 100644
> --- a/drivers/dma/at_hdmac_regs.h
> +++ b/drivers/dma/at_hdmac_regs.h
> @@ -112,11 +112,13 @@
>  #define		ATC_SRC_WIDTH_BYTE	(0x0 << 24)
>  #define		ATC_SRC_WIDTH_HALFWORD	(0x1 << 24)
>  #define		ATC_SRC_WIDTH_WORD	(0x2 << 24)
> +#define		ATC_REG_TO_SRC_WIDTH(x)	(((x) >> 24) & 0x3)

Here...

>  #define	ATC_DST_WIDTH_MASK	(0x3 << 28)	/* Destination Single Transfer Size */
>  #define		ATC_DST_WIDTH(x)	((x) << 28)
>  #define		ATC_DST_WIDTH_BYTE	(0x0 << 28)
>  #define		ATC_DST_WIDTH_HALFWORD	(0x1 << 28)
>  #define		ATC_DST_WIDTH_WORD	(0x2 << 28)
> +#define		ATC_REG_TO_DST_WIDTH(x)	(((x) >> 28) & 0x3)

... and here, well, I'm not sure it can be statically called: so maybe
these macros are not needed.


>  #define	ATC_DONE		(0x1 << 31)	/* Tx Done (only written back in descriptor) */
>  
>  /* Bitfields in CTRLB */
> @@ -181,8 +183,8 @@ struct at_lli {
>   * @at_lli: hardware lli structure
>   * @txd: support for the async_tx api
>   * @desc_node: node on the channed descriptors list
> - * @len: total transaction bytecount

Yes for the re-purpose of this.

> - * @tx_width: transfer width

Nack for this, sorry.


> + * @len: descriptor byte count

Ok.

> + * @total_len: total transaction byte count

Ok: this is clearer.

>   */
>  struct at_desc {
>  	/* FIRST values the hardware uses */
> @@ -193,7 +195,7 @@ struct at_desc {
>  	struct dma_async_tx_descriptor	txd;
>  	struct list_head		desc_node;
>  	size_t				len;
> -	u32				tx_width;
> +	size_t				total_len;
>  };
>  
>  static inline struct at_desc *
> @@ -213,7 +215,6 @@ txd_to_at_desc(struct dma_async_tx_descriptor *txd)
>  enum atc_status {
>  	ATC_IS_ERROR = 0,
>  	ATC_IS_PAUSED = 1,
> -	ATC_IS_BTC = 2,

Yes, it's seems not needed anymore.

>  	ATC_IS_CYCLIC = 24,
>  };
>  
> @@ -231,7 +232,6 @@ enum atc_status {
>   * @save_cfg: configuration register that is saved on suspend/resume cycle
>   * @save_dscr: for cyclic operations, preserve next descriptor address in
>   *             the cyclic list on suspend/resume cycle
> - * @remain_desc: to save remain desc length
>   * @dma_sconfig: configuration for slave transfers, passed via DMA_SLAVE_CONFIG
>   * @lock: serializes enqueue/dequeue operations to descriptors lists
>   * @active_list: list of descriptors dmaengine is being running on
> @@ -250,7 +250,6 @@ struct at_dma_chan {
>  	struct tasklet_struct	tasklet;
>  	u32			save_cfg;
>  	u32			save_dscr;
> -	u32			remain_desc;
>  	struct dma_slave_config dma_sconfig;
>  
>  	spinlock_t		lock;
> 


-- 
Nicolas Ferre
