From: vkoul@kernel.org (Vinod)
Date: Fri, 29 Jun 2018 12:55:52 +0530
Subject: [PATCH v3 1/5] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cylic mode align split descriptors
In-Reply-To: <20180625092724.22164-1-andrea.merello@gmail.com>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
Message-ID: <20180629072552.GY22377@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-06-18, 11:27, Andrea Merello wrote:
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
> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes in v2:
>         - don't introduce copy_mask field, rather rely on already-esistent
>           copy_align field. Suggested by Radhey Shyam Pandey
>         - reword title
> Changes in v3:
> 	- fix bug introduced in v2: wrong copy size when DRE is enabled
> 	  use implementation suggested by Radhey Shyam Pandey
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 27b523530c4a..113d9bf1b6a1 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1793,6 +1793,16 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
>  			 */
>  			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
>  				     XILINX_DMA_MAX_TRANS_LEN);
> +
> +			if ((copy + sg_used < sg_dma_len(sg)) &&
> +			    chan->xdev->common.copy_align) {
> +				/*
> +				 * If this is not the last descriptor, make sure
> +				 * the next one will be properly aligned
> +				 */
> +				copy = rounddown(copy,
> +					(1 << chan->xdev->common.copy_align));
> +			}
>  			hw = &segment->hw;
>  
>  			/* Fill in the descriptor */
> @@ -1898,6 +1908,16 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
>  			 */
>  			copy = min_t(size_t, period_len - sg_used,
>  				     XILINX_DMA_MAX_TRANS_LEN);
> +
> +			if ((copy + sg_used < period_len) &&
> +			    chan->xdev->common.copy_align) {
> +				/*
> +				 * If this is not the last descriptor, make sure
> +				 * the next one will be properly aligned
> +				 */
> +				copy = rounddown(copy,
> +					(1 << chan->xdev->common.copy_align));
> +			}

same code pasted twice, can we have a routine for this... perhaps more
code can be made common too

-- 
~Vinod
