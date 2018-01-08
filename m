From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Jan 2018 16:08:45 +0530
Subject: [PATCH v2 1/4] dmaengine: xilinx_dma: populate dma caps properly
In-Reply-To: <1514961731-1916-2-git-send-email-appanad@xilinx.com>
References: <1514961731-1916-1-git-send-email-appanad@xilinx.com>
 <1514961731-1916-2-git-send-email-appanad@xilinx.com>
Message-ID: <20180108103845.GE18649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 03, 2018 at 12:12:08PM +0530, Kedareswara rao Appana wrote:
> When client driver uses dma_get_slave_caps() api,
> it checks for certain fields of dma_device struct
> currently driver is not settings the directions and addr_widths
> fields resulting dma_get_slave_caps() returning failure.
> 
> This patch fixes this issue by populating proper values
> to the struct dma_device directions and addr_widths fields.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v2:
> --> Improved commit message title and description 
> as suggested by Vinod.
> 
>  drivers/dma/xilinx/xilinx_dma.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 88d317d..21ac954 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -2398,6 +2398,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  		chan->direction = DMA_MEM_TO_DEV;
>  		chan->id = chan_id;
>  		chan->tdest = chan_id;
> +		xdev->common.directions = BIT(DMA_MEM_TO_DEV);
>  
>  		chan->ctrl_offset = XILINX_DMA_MM2S_CTRL_OFFSET;
>  		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
> @@ -2415,6 +2416,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  		chan->direction = DMA_DEV_TO_MEM;
>  		chan->id = chan_id;
>  		chan->tdest = chan_id - xdev->nr_channels;
> +		xdev->common.directions |= BIT(DMA_DEV_TO_MEM);
>  
>  		chan->ctrl_offset = XILINX_DMA_S2MM_CTRL_OFFSET;
>  		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
> @@ -2629,6 +2631,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  		dma_cap_set(DMA_PRIVATE, xdev->common.cap_mask);
>  	}
>  
> +	xdev->common.dst_addr_widths = BIT(addr_width / 8);
> +	xdev->common.src_addr_widths = BIT(addr_width / 8);

Do you not support trf of 1byte, 2 bytes, or 4 bytes wide transfers? What is
value of addr_width here typically? Usually controllers can support
different widths and this is a surprise that you support only one value

-- 
~Vinod
