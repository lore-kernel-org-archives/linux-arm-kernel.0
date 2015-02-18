From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 18 Feb 2015 16:02:16 +0100
Subject: [PATCH 1/2] dma: at_hdmac: Fix calculation of the residual bytes
In-Reply-To: <1423387744-2410-2-git-send-email-torfl6749@gmail.com>
References: <1423387744-2410-1-git-send-email-torfl6749@gmail.com>
 <1423387744-2410-2-git-send-email-torfl6749@gmail.com>
Message-ID: <20150218150216.GE32600@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Torsten,

On Sun, Feb 08, 2015 at 10:29:03AM +0100, Torsten Fleischer wrote:
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

You're right about these points. Good job. I think it should be sent to
stable if it can be applied properly.

For multilines comments, please follow the coding rule 
/*
 * my
 * comments
 */

> Signed-off-by: Torsten Fleischer <torfl6749@gmail.com>

Another comments below. Otherwise

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
>  drivers/dma/at_hdmac.c      | 151 ++++++++++++++++++++++----------------------
>  drivers/dma/at_hdmac_regs.h |  11 ++--
>  2 files changed, 79 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index ca9dd26..0fb98a3 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -233,93 +233,92 @@ static void atc_dostart(struct at_dma_chan *atchan, struct at_desc *first)
>  }

[...]

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
> -	/*
> -	 * Initialize necessary values in the first time.
> -	 * remain_desc record remain desc length.
> -	 */
> -	if (atchan->remain_desc == 0)
> -		/* First descriptor embedds the transaction length */
> -		atchan->remain_desc = desc_first->len;
> +	/* If the cookie doesn't match to the currently running transfer then
> +	 * we can return the total length of the associated DMA transfer,
> +	 * because it is still queued. */
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
> -		}
> +	/* cookie matches to the currently running transfer */
> +	ret = desc_first->total_len;
> +
> +	if (desc_first->lli.dscr) {
> +		/* hardware linked list transfer */
> +
> +		/* Calculate the residue by removing the length of the child
> +		 * descriptors already transferred from the total length.
> +		 * To get the current child descriptor we can use the value of
> +		 * the channel's DSCR register and compare it against the value
> +		 * of the hardware linked list structure of each child
> +		 * descriptor. */
> +
> +		dscr = channel_readl(atchan, DSCR);
> +
> +		/* the first descriptor is currently in work */
> +		if (desc_first->lli.dscr == dscr)
> +			return ret;
>  

Why returning total_len in this case? I think you can return a more accurate
value as you do for the last descriptor.

> -		count = (desc_cur->lli.ctrla & ATC_BTSIZE_MAX)
> -			<< desc_first->tx_width;
> -		if (atchan->remain_desc < count) {
> -			ret = -EINVAL;
> -			goto out;
> +		list_for_each_entry(desc, &desc_first->tx_list, desc_node) {
> +			if (desc->lli.dscr == dscr)
> +				break;
> +
> +			ret -= desc->len;
>  		}
>  
> -		atchan->remain_desc -= count;
> -		ret = atchan->remain_desc;
> +		/* For the last descriptor in the chain we can calculate
> +		 * the remaining bytes using the channel's register. */
> +		if (!desc->lli.dscr) {
> +			ctrla = channel_readl(atchan, CTRLA);
> +			count = (desc->lli.ctrla & ATC_BTSIZE_MAX) -
> +				(ctrla & ATC_BTSIZE_MAX);
> +
> +			ret = count << ATC_REG_TO_SRC_WIDTH(ctrla);
> +		}
>  	} else {
> -		/*
> -		 * Get residual bytes when current
> -		 * descriptor transfer in progress.
> -		 */
> -		count = (channel_readl(atchan, CTRLA) & ATC_BTSIZE_MAX)
> -				<< (desc_first->tx_width);
> -		ret = atchan->remain_desc - count;
> +		/* single transfer */
> +		ctrla = channel_readl(atchan, CTRLA);
> +		count = (ctrla & ATC_BTSIZE_MAX) << ATC_REG_TO_SRC_WIDTH(ctrla);
> +		ret -= count;
>  	}
> -	/*
> -	 * Check fifo empty.
> -	 */
> -	if (!(dma_readl(atdma, CHSR) & AT_DMA_EMPT(chan_id)))
> -		atc_issue_pending(chan);
>  
> -out:
>  	return ret;
>  }

[...]


Regards

Ludovic
