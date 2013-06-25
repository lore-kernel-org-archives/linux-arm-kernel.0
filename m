From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 25 Jun 2013 20:46:12 +0530
Subject: [RFC PATCH v2 01/12] dmaengine: PL08x: Refactor
 pl08x_getbytes_chan() to lower indentation
In-Reply-To: <1371933764-24875-2-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130625151612.GO23141@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:42:33PM +0200, Tomasz Figa wrote:
> Further patch will introduce support for PL080S, which requires some
> things to be done conditionally, thus increasing indentation level of
> some functions even more.
> 
> This patch reduces indentation level of pl08x_getbytes_chan() function
> by inverting several conditions and returning from function wherever
> possible.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/dma/amba-pl08x.c | 53 ++++++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index 06fe45c..6a12392 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -469,47 +469,52 @@ static inline u32 get_bytes_in_cctl(u32 cctl)
>  /* The channel should be paused when calling this */
>  static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
>  {
> +	struct pl08x_lli *llis_va;
>  	struct pl08x_phy_chan *ch;
> +	dma_addr_t llis_bus;
>  	struct pl08x_txd *txd;
> -	size_t bytes = 0;
> +	size_t bytes;
> +	int index;
> +	u32 clli;
>  
>  	ch = plchan->phychan;
>  	txd = plchan->at;
>  
> +	if (!ch || !txd)
> +		return 0;
shouldnt this be err return

> +
>  	/*
>  	 * Follow the LLIs to get the number of remaining
>  	 * bytes in the currently active transaction.
>  	 */
> -	if (ch && txd) {
> -		u32 clli = readl(ch->base + PL080_CH_LLI) & ~PL080_LLI_LM_AHB2;
> +	clli = readl(ch->base + PL080_CH_LLI) & ~PL080_LLI_LM_AHB2;
>  
> -		/* First get the remaining bytes in the active transfer */
> -		bytes = get_bytes_in_cctl(readl(ch->base + PL080_CH_CONTROL));
> +	/* First get the remaining bytes in the active transfer */
> +	bytes = get_bytes_in_cctl(readl(ch->base + PL080_CH_CONTROL));
>  
> -		if (clli) {
> -			struct pl08x_lli *llis_va = txd->llis_va;
> -			dma_addr_t llis_bus = txd->llis_bus;
> -			int index;
> +	if (!clli)
> +		return bytes;
>  
> -			BUG_ON(clli < llis_bus || clli >= llis_bus +
> +	llis_va = txd->llis_va;
> +	llis_bus = txd->llis_bus;
> +
> +	BUG_ON(clli < llis_bus || clli >= llis_bus +
>  				sizeof(struct pl08x_lli) * MAX_NUM_TSFR_LLIS);
IMO BUG_ON is too much for this. Perhaps returning error and logging error would
be okay

--
~Vinod
