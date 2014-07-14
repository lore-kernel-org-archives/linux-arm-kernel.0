From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 14 Jul 2014 22:06:16 +0530
Subject: [PATCH] dmaengine: qcom_bam_dma: Add descriptor flags
In-Reply-To: <1401482990-26486-1-git-send-email-agross@codeaurora.org>
References: <1401482990-26486-1-git-send-email-agross@codeaurora.org>
Message-ID: <20140714163616.GA4387@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 03:49:50PM -0500, Andy Gross wrote:
> This patch adds support for end of transaction (EOT) and notify when done (NWD)
> hardware descriptor flags.
> 
> The EOT flag requests that the peripheral assert an end of transaction interrupt
> when that descriptor is complete.  It also results in special signaling protocol
> that is used between the attached peripheral and the core using the DMA
> controller.  Clients will specify DMA_PREP_INTERRUPT to enable this flag.
> 
> The NWD flag requests that the peripheral wait until the data has been fully
> processed by the peripheral before moving on to the next descriptor.  Clients
> will specify DMA_PREP_FENCE to enable this flag.

I am going to apply this, but pls send a follow up patch to add comments on the
flags and their behaviour. I think it is required!

> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  drivers/dma/qcom_bam_dma.c |   20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom_bam_dma.c
> index e01c2d106..4635224 100644
> --- a/drivers/dma/qcom_bam_dma.c
> +++ b/drivers/dma/qcom_bam_dma.c
> @@ -61,12 +61,17 @@ struct bam_desc_hw {
>  #define DESC_FLAG_INT BIT(15)
>  #define DESC_FLAG_EOT BIT(14)
>  #define DESC_FLAG_EOB BIT(13)
> +#define DESC_FLAG_NWD BIT(12)
explaining behvaiour will help..

-- 
~Vinod

>  
>  struct bam_async_desc {
>  	struct virt_dma_desc vd;
>  
>  	u32 num_desc;
>  	u32 xfer_len;
> +
> +	/* transaction flags, EOT|EOB|NWD */
> +	u16 flags;
> +
>  	struct bam_desc_hw *curr_desc;
>  
>  	enum dma_transfer_direction dir;
> @@ -490,6 +495,14 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  	if (!async_desc)
>  		goto err_out;
>  
> +	if (flags & DMA_PREP_FENCE)
> +		async_desc->flags |= DESC_FLAG_NWD;
> +
> +	if (flags & DMA_PREP_INTERRUPT)
> +		async_desc->flags |= DESC_FLAG_EOT;
> +	else
> +		async_desc->flags |= DESC_FLAG_INT;
> +
>  	async_desc->num_desc = num_alloc;
>  	async_desc->curr_desc = async_desc->desc;
>  	async_desc->dir = direction;
> @@ -795,8 +808,11 @@ static void bam_start_dma(struct bam_chan *bchan)
>  	else
>  		async_desc->xfer_len = async_desc->num_desc;
>  
> -	/* set INT on last descriptor */
> -	desc[async_desc->xfer_len - 1].flags |= DESC_FLAG_INT;
> +	/* set any special flags on the last descriptor */
> +	if (async_desc->num_desc == async_desc->xfer_len)
> +		desc[async_desc->xfer_len - 1].flags = async_desc->flags;
> +	else
> +		desc[async_desc->xfer_len - 1].flags |= DESC_FLAG_INT;
>  
>  	if (bchan->tail + async_desc->xfer_len > MAX_DESCRIPTORS) {
>  		u32 partial = MAX_DESCRIPTORS - bchan->tail;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
