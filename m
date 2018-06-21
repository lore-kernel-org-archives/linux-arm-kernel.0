From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Thu, 21 Jun 2018 13:16:14 +0000
Subject: [PATCH v2 1/5] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cyclic mode align split descriptors
In-Reply-To: <20180621115822.20058-1-andrea.merello@gmail.com>
References: <20180621115822.20058-1-andrea.merello@gmail.com>
Message-ID: <DM6PR02MB4361C0F0D4002B73B24D2F98C7760@DM6PR02MB4361.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: dmaengine-owner at vger.kernel.org [mailto:dmaengine-
> owner at vger.kernel.org] On Behalf Of Andrea Merello
> Sent: Thursday, June 21, 2018 5:28 PM
> To: vkoul at kernel.org; dan.j.williams at intel.com; Michal Simek
> <michals@xilinx.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; dmaengine at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> Andrea Merello <andrea.merello@gmail.com>
> Subject: [PATCH v2 1/5] dmaengine: xilinx_dma: in axidma slave_sg and
> dma_cyclic mode align split descriptors
> 
> Whenever a single or cyclic transaction is prepared, the driver
> could eventually split it over several SG descriptors in order
> to deal with the HW maximum transfer length.
> 
> This could end up in DMA operations starting from a misaligned
> address. This seems fatal for the HW if DRE is not enabled.
> 
> This patch eventually adjusts the transfer size in order to make sure
> all operations start from an aligned address.
> 
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
> Changes in v2:
> 	- don't introduce copy_mask field, rather rely on already-esistent
> 	  copy_align field. Suggested by Radhey Shyam Pandey
> 	- reword title
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 27b523530c4a..22d7a6b85e65 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1789,10 +1789,15 @@ static struct dma_async_tx_descriptor
> *xilinx_dma_prep_slave_sg(
> 
>  			/*
>  			 * Calculate the maximum number of bytes to transfer,
> -			 * making sure it is less than the hw limit
> +			 * making sure it is less than the hw limit and that
> +			 * the next chunck start address is aligned
/s/chunck/chunk . Same for later occurrence.
>  			 */
> -			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
> -				     XILINX_DMA_MAX_TRANS_LEN);
> +			copy = sg_dma_len(sg) - sg_used;
> +			if (copy > XILINX_DMA_MAX_TRANS_LEN &&
> +			    chan->xdev->common.copy_align)
> +				copy =
> rounddown(XILINX_DMA_MAX_TRANS_LEN,
> +					 (1 << chan->xdev-
> >common.copy_align));
> +
If DRE is not enabled (copy_align=0) we are copying entire sg_dma_len 
which is not correct i.e more than XILINX_DMA_MAX_TRANS_LEN.

>  			hw = &segment->hw;
> 
>  			/* Fill in the descriptor */
> @@ -1894,10 +1899,15 @@ static struct dma_async_tx_descriptor
> *xilinx_dma_prep_dma_cyclic(
> 
>  			/*
>  			 * Calculate the maximum number of bytes to transfer,
> -			 * making sure it is less than the hw limit
> +			 * making sure it is less than the hw limit and that
> +			 * the next chunck start address is aligned
>  			 */
> -			copy = min_t(size_t, period_len - sg_used,
> -				     XILINX_DMA_MAX_TRANS_LEN);
> +			copy = period_len - sg_used;
> +			if (copy > XILINX_DMA_MAX_TRANS_LEN &&
> +			    chan->xdev->common.copy_align)
> +				copy =
> rounddown(XILINX_DMA_MAX_TRANS_LEN,
> +					 (1 << chan->xdev-
> >common.copy_align));
> +
>  			hw = &segment->hw;
>  			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
>  					  period_len * i);
> --
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
