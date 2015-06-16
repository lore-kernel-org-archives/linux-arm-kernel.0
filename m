From: torfl6749@gmail.com (Torsten Fleischer)
Date: Tue, 16 Jun 2015 18:11:56 +0200
Subject: [PATCH linux-next 1/1] dmaengine: at_hdmac: fix residue
 computation
In-Reply-To: <381ecf2427a6aae4b7109d930121df9f36aef81e.1434380729.git.cyrille.pitchen@atmel.com>
References: <cover.1434380729.git.cyrille.pitchen@atmel.com>
 <381ecf2427a6aae4b7109d930121df9f36aef81e.1434380729.git.cyrille.pitchen@atmel.com>
Message-ID: <2899583.NPB62C1E0l@linux-1fbo.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 June 2015 at 17:17:51 Cyrille Pitchen wrote:
> As claimed by the programmer datasheet and confirmed by the IP designer,
> the Block Transfer Size (BTSIZE) bitfield of the Channel x Control A
> Register (CTRLAx) always refers to a number of Source Width (SRC_WIDTH)
> transfers.
> 
> Both the SRC_WIDTH and BTSIZE bitfields can be extacted from the CTRLAx
> register to compute the DMA residue. So the 'tx_width' field is useless
> and can be removed from the struct at_desc.
> 
> Before this patch, atc_prep_slave_sg() was not consistent: BTSIZE was
> correctly initialized according to the SRC_WIDTH but 'tx_width' was always
> set to reg_width, which was incorrect for MEM_TO_DEV transfers. It led to
> bad DMA residue when 'tx_width' != SRC_WIDTH.
> 
> Also the 'tx_width' field was mostly set only in the first and last
> descriptors. Depending on the kind of DMA transfer, this field remained
> uninitialized for intermediate descriptors. The accurate DMA residue was
> computed only when the currently processed descriptor was the first or the
> last of the chain. This algorithm was a little bit odd. An accurate DMA
> residue can always be computed using the SRC_WIDTH and BTSIZE bitfields
> in the CTRLAx register.

Please see my comment below.

> 
> Finally, the test to check whether the currently processed descriptor is
> the last of the chain was wrong: for cyclic transfer, last_desc->lli.dscr
> is NOT equal to zero, since set_desc_eol() is never called, but logically
> equal to first_desc->txd.phys. This bug has a side effect on the
> drivers/tty/serial/atmel_serial.c driver, which uses cyclic DMA transfer
> to receive data. Since the DMA residue was wrong each time the DMA
> transfer reaches the second (and last) period of the transfer, no more
> data were received by the USART driver till the cyclic DMA transfer loops
> back to the first period.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  drivers/dma/at_hdmac.c      | 47
> ++++++++++++++++----------------------------- drivers/dma/at_hdmac_regs.h |
>  3 +--
>  2 files changed, 18 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 59892126..51e870a 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -285,12 +285,19 @@ static struct at_desc *atc_get_desc_by_cookie(struct
> at_dma_chan *atchan, *
>   * @current_len: the number of bytes left before reading CTRLA
>   * @ctrla: the value of CTRLA
> - * @desc: the descriptor containing the transfer width
>   */
> -static inline int atc_calc_bytes_left(int current_len, u32 ctrla,
> -					struct at_desc *desc)
> +static inline int atc_calc_bytes_left(int current_len, u32 ctrla)
>  {
> -	return current_len - ((ctrla & ATC_BTSIZE_MAX) << desc->tx_width);
> +	u32 btsize = (ctrla & ATC_BTSIZE_MAX);
> +	u32 src_width = ATC_REG_TO_SRC_WIDTH(ctrla);
> +
> +	/*
> +	 * According to the datasheet, when reading the Control A Register
> +	 * (ctrla), the Buffer Transfer Size (btsize) bitfield refers to the
> +	 * number of transfers completed on the Source Interface.
> +	 * So btsize is always a number of source width transfers.
> +	 */
> +	return current_len - (btsize << src_width);
>  }
> 
>  /**
> @@ -299,14 +306,13 @@ static inline int atc_calc_bytes_left(int current_len,
> u32 ctrla, *
>   * @current_len: the number of bytes left before reading CTRLA
>   * @atchan: the channel to read CTRLA for
> - * @desc: the descriptor containing the transfer width
>   */
>  static inline int atc_calc_bytes_left_from_reg(int current_len,
> -			struct at_dma_chan *atchan, struct at_desc *desc)
> +					       struct at_dma_chan *atchan)
>  {
>  	u32 ctrla = channel_readl(atchan, CTRLA);
> 
> -	return atc_calc_bytes_left(current_len, ctrla, desc);
> +	return atc_calc_bytes_left(current_len, ctrla);
>  }
> 
>  /**
> @@ -354,7 +360,7 @@ static int atc_get_bytes_left(struct dma_chan *chan,
> dma_cookie_t cookie)
> 
>  		/* for the first descriptor we can be more accurate */
>  		if (desc_first->lli.dscr == dscr)
> -			return atc_calc_bytes_left(ret, ctrla, desc_first);
> +			return atc_calc_bytes_left(ret, ctrla);
> 
>  		ret -= desc_first->len;
>  		list_for_each_entry(desc, &desc_first->tx_list, desc_node) {
> @@ -365,16 +371,13 @@ static int atc_get_bytes_left(struct dma_chan *chan,
> dma_cookie_t cookie) }
> 
>  		/*
> -		 * For the last descriptor in the chain we can calculate
> +		 * For the current descriptor in the chain we can calculate
>  		 * the remaining bytes using the channel's register.
> -		 * Note that the transfer width of the first and last
> -		 * descriptor may differ.
>  		 */
> -		if (!desc->lli.dscr)
> -			ret = atc_calc_bytes_left_from_reg(ret, atchan, desc);
> +		ret = atc_calc_bytes_left_from_reg(ret, atchan);

I see two issues here.

First this always returns the number if remaining bytes of the current child 
transfer and not of the entire hardware linked list transfer.

Finally, for the calculation of the remaining bytes of a hardware linked list 
the value of DSCR is used to get the current child transfer.
But regarding to a running DMA transfer, reading DSCR and CTRLA is not atomic. 
If you read CTRLA after DSCR then the value may not refer to the child 
transfer as read from DSCR, but to a subsequent one.
Its only safe for the first transfer where CTRLA is read before DSCR and for 
the last transfer where CTRLA is read after DSCR.

>  	} else {
>  		/* single transfer */
> -		ret = atc_calc_bytes_left_from_reg(ret, atchan, desc_first);
> +		ret = atc_calc_bytes_left_from_reg(ret, atchan);
>  	}
> 
>  	return ret;
> @@ -726,7 +729,6 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
> 
>  	desc->txd.cookie = -EBUSY;
>  	desc->total_len = desc->len = len;
> -	desc->tx_width = dwidth;
> 
>  	/* set end-of-link to the last link descriptor of list*/
>  	set_desc_eol(desc);
> @@ -804,10 +806,6 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t
> dest, dma_addr_t src, first->txd.cookie = -EBUSY;
>  	first->total_len = len;
> 
> -	/* set transfer width for the calculation of the residue */
> -	first->tx_width = src_width;
> -	prev->tx_width = src_width;
> -
>  	/* set end-of-link to the last link descriptor of list*/
>  	set_desc_eol(desc);
> 
> @@ -956,10 +954,6 @@ atc_prep_slave_sg(struct dma_chan *chan, struct
> scatterlist *sgl, first->txd.cookie = -EBUSY;
>  	first->total_len = total_len;
> 
> -	/* set transfer width for the calculation of the residue */
> -	first->tx_width = reg_width;
> -	prev->tx_width = reg_width;
> -
>  	/* first link descriptor of list is responsible of flags */
>  	first->txd.flags = flags; /* client is in control of this ack */
> 
> @@ -1077,12 +1071,6 @@ atc_prep_dma_sg(struct dma_chan *chan,
>  		desc->txd.cookie = 0;
>  		desc->len = len;
> 
> -		/*
> -		 * Although we only need the transfer width for the first and
> -		 * the last descriptor, its easier to set it to all descriptors.
> -		 */
> -		desc->tx_width = src_width;
> -
>  		atc_desc_chain(&first, &prev, desc);
> 
>  		/* update the lengths and addresses for the next loop cycle */
> @@ -1256,7 +1244,6 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t
> buf_addr, size_t buf_len, /* First descriptor of the chain embedds
> additional information */ first->txd.cookie = -EBUSY;
>  	first->total_len = buf_len;
> -	first->tx_width = reg_width;
> 
>  	return &first->txd;
> 
> diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
> index bc8d5eb..7f5a082 100644
> --- a/drivers/dma/at_hdmac_regs.h
> +++ b/drivers/dma/at_hdmac_regs.h
> @@ -112,6 +112,7 @@
>  #define		ATC_SRC_WIDTH_BYTE	(0x0 << 24)
>  #define		ATC_SRC_WIDTH_HALFWORD	(0x1 << 24)
>  #define		ATC_SRC_WIDTH_WORD	(0x2 << 24)
> +#define		ATC_REG_TO_SRC_WIDTH(r)	(((r) >> 24) & 0x3)
>  #define	ATC_DST_WIDTH_MASK	(0x3 << 28)	/* Destination Single 
Transfer Size
> */ #define		ATC_DST_WIDTH(x)	((x) << 28)
>  #define		ATC_DST_WIDTH_BYTE	(0x0 << 28)
> @@ -182,7 +183,6 @@ struct at_lli {
>   * @txd: support for the async_tx api
>   * @desc_node: node on the channed descriptors list
>   * @len: descriptor byte count
> - * @tx_width: transfer width
>   * @total_len: total transaction byte count
>   */
>  struct at_desc {
> @@ -194,7 +194,6 @@ struct at_desc {
>  	struct dma_async_tx_descriptor	txd;
>  	struct list_head		desc_node;
>  	size_t				len;
> -	u32				tx_width;
>  	size_t				total_len;
> 
>  	/* Interleaved data */

Regards,

Torsten
