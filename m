From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 2 May 2014 21:58:41 +0530
Subject: [PATCH] dmaengine: qcom_bam_dma: Add descriptor flag APIs
In-Reply-To: <1397772242-4048-1-git-send-email-agross@codeaurora.org>
References: <1397772242-4048-1-git-send-email-agross@codeaurora.org>
Message-ID: <20140502162841.GZ32284@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 05:04:02PM -0500, Andy Gross wrote:
> This patch adds APIs that allow for BAM hardware flags to be set per
> descriptor.  Each one of the new flags informs the attached peripheral of a
> special behavior that is required.
> 
> The EOT flag requests that the peripheral assert an end of transaction interrupt
> when that descriptor is complete.  It also results in special signaling protocol
> that is used between the attached peripheral and the core using the DMA
> controller.
DMA_PREP_INTERRUPT ??

> 
> The NWD flag requests that the peripheral wait until the data has been fully
> processed before signaling an interrupt.
interrupt for transaction complete or DMA request?

-- 
~Vinod

> 
> The CMD flag informs the peripheral that the descriptor payload contains
> command descriptors and not data descriptors.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  drivers/dma/qcom_bam_dma.c       |   48 ++++++++++++++++++++++++++++++++++++--
>  include/linux/dma/qcom_bam_dma.h |   23 ++++++++++++++++++
>  2 files changed, 69 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/dma/qcom_bam_dma.h
> 
> diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom_bam_dma.c
> index 02f7fef..f6c8ef1 100644
> --- a/drivers/dma/qcom_bam_dma.c
> +++ b/drivers/dma/qcom_bam_dma.c
> @@ -61,12 +61,18 @@ struct bam_desc_hw {
>  #define DESC_FLAG_INT BIT(15)
>  #define DESC_FLAG_EOT BIT(14)
>  #define DESC_FLAG_EOB BIT(13)
> +#define DESC_FLAG_NWD BIT(12)
> +#define DESC_FLAG_CMD BIT(11)
>  
>  struct bam_async_desc {
>  	struct virt_dma_desc vd;
>  
>  	u32 num_desc;
>  	u32 xfer_len;
> +
> +	/* transaction flags, EOT|EOB|NWD|CMD */
> +	u16 flags;
> +
>  	struct bam_desc_hw *curr_desc;
>  
>  	enum dma_transfer_direction dir;
> @@ -800,6 +806,34 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>  	bchan->reconfigure = 0;
>  }
>  
> +void qcom_bam_set_desc_eot(struct dma_async_tx_descriptor *txd)
> +{
> +	struct bam_async_desc *async_desc = container_of(txd,
> +			struct bam_async_desc, vd.tx);
> +
> +	async_desc->flags |= DESC_FLAG_EOT;
> +}
> +EXPORT_SYMBOL(qcom_bam_set_desc_eot);
> +
> +void qcom_bam_set_desc_cmd(struct dma_async_tx_descriptor *txd)
> +{
> +	struct bam_async_desc *async_desc = container_of(txd,
> +			struct bam_async_desc, vd.tx);
> +
> +	async_desc->flags |= DESC_FLAG_CMD;
> +}
> +EXPORT_SYMBOL(qcom_bam_set_desc_cmd);
> +
> +void qcom_bam_set_desc_nwd(struct dma_async_tx_descriptor *txd)
> +{
> +	struct bam_async_desc *async_desc = container_of(txd,
> +			struct bam_async_desc, vd.tx);
> +
> +	async_desc->flags |= DESC_FLAG_NWD;
> +}
> +EXPORT_SYMBOL(qcom_bam_set_desc_nwd);
> +
> +
>  /**
>   * bam_start_dma - start next transaction
>   * @bchan - bam dma channel
> @@ -812,6 +846,7 @@ static void bam_start_dma(struct bam_chan *bchan)
>  	struct bam_desc_hw *desc;
>  	struct bam_desc_hw *fifo = PTR_ALIGN(bchan->fifo_virt,
>  					sizeof(struct bam_desc_hw));
> +	int i;
>  
>  	lockdep_assert_held(&bchan->vc.lock);
>  
> @@ -838,8 +873,17 @@ static void bam_start_dma(struct bam_chan *bchan)
>  	else
>  		async_desc->xfer_len = async_desc->num_desc;
>  
> -	/* set INT on last descriptor */
> -	desc[async_desc->xfer_len - 1].flags |= DESC_FLAG_INT;
> +	/* set command descriptor flag, if applicable */
> +	if (async_desc->flags & DESC_FLAG_CMD)
> +		for (i = 0; i < async_desc->xfer_len; i++)
> +			desc[i].flags |= DESC_FLAG_CMD;
> +
> +	/* set EOT or INT based on flag settings and if final transaction */
> +	if (async_desc->flags & DESC_FLAG_EOT &&
> +		async_desc->num_desc == async_desc->xfer_len)
> +		desc[async_desc->xfer_len - 1].flags |= DESC_FLAG_EOT;
> +	else
> +		desc[async_desc->xfer_len - 1].flags |= DESC_FLAG_INT;
>  
>  	if (bchan->tail + async_desc->xfer_len > MAX_DESCRIPTORS) {
>  		u32 partial = MAX_DESCRIPTORS - bchan->tail;
> diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
> new file mode 100644
> index 0000000..65a371eb
> --- /dev/null
> +++ b/include/linux/dma/qcom_bam_dma.h
> @@ -0,0 +1,23 @@
> +#ifndef _QCOM_BAM_DMA_H_
> +#define _QCOM_BAM_DMA_H_
> +/*
> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/dmaengine.h>
> +
> +void qcom_bam_set_desc_cmd(struct dma_async_tx_descriptor *);
> +void qcom_bam_set_desc_eot(struct dma_async_tx_descriptor *);
> +void qcom_bam_set_desc_nwd(struct dma_async_tx_descriptor *);
> +
> +#endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
