From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 16 Oct 2014 19:20:33 +0300
Subject: [PATCH v2 40/53] dmaengine: xilinx: Split device_control
In-Reply-To: <1413454672-27400-41-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
 <1413454672-27400-41-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <16437910.e1eS0oSP8W@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch.

On Thursday 16 October 2014 12:17:39 Maxime Ripard wrote:
> Split the device_control callback of the Xilinx VDMA driver to make use of
> the newly introduced callbacks, that will eventually be used to retrieve
> slave capabilities.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/dma/xilinx/xilinx_vdma.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_vdma.c
> b/drivers/dma/xilinx/xilinx_vdma.c index 42a13e8d4607..35024e7b9f9f 100644
> --- a/drivers/dma/xilinx/xilinx_vdma.c
> +++ b/drivers/dma/xilinx/xilinx_vdma.c
> @@ -996,8 +996,10 @@ error:
>   * xilinx_vdma_terminate_all - Halt the channel and free descriptors
>   * @chan: Driver specific VDMA Channel pointer
>   */
> -static void xilinx_vdma_terminate_all(struct xilinx_vdma_chan *chan)
> +static int xilinx_vdma_terminate_all(struct dma_chan *dchan)

I'm pretty sure you now miss a return statement at the end of the function. 
With that fixed,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  {
> +	struct xilinx_vdma_chan *chan = to_xilinx_chan(dchan);
> +
>  	/* Halt the DMA engine */
>  	xilinx_vdma_halt(chan);
> 
> @@ -1070,27 +1072,6 @@ int xilinx_vdma_channel_set_config(struct dma_chan
> *dchan, }
>  EXPORT_SYMBOL(xilinx_vdma_channel_set_config);
> 
> -/**
> - * xilinx_vdma_device_control - Configure DMA channel of the device
> - * @dchan: DMA Channel pointer
> - * @cmd: DMA control command
> - * @arg: Channel configuration
> - *
> - * Return: '0' on success and failure value on error
> - */
> -static int xilinx_vdma_device_control(struct dma_chan *dchan,
> -				      enum dma_ctrl_cmd cmd, unsigned long arg)
> -{
> -	struct xilinx_vdma_chan *chan = to_xilinx_chan(dchan);
> -
> -	if (cmd != DMA_TERMINATE_ALL)
> -		return -ENXIO;
> -
> -	xilinx_vdma_terminate_all(chan);
> -
> -	return 0;
> -}
> -
>  /*
> ---------------------------------------------------------------------------
> -- * Probe and remove
>   */
> @@ -1295,7 +1276,7 @@ static int xilinx_vdma_probe(struct platform_device
> *pdev) xilinx_vdma_free_chan_resources;
>  	xdev->common.device_prep_interleaved_dma =
>  				xilinx_vdma_dma_prep_interleaved;
> -	xdev->common.device_control = xilinx_vdma_device_control;
> +	xdev->common.device_terminate_all = xilinx_vdma_terminate_all;
>  	xdev->common.device_tx_status = xilinx_vdma_tx_status;
>  	xdev->common.device_issue_pending = xilinx_vdma_issue_pending;

-- 
Regards,

Laurent Pinchart
