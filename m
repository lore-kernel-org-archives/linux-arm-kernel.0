From: vkoul@kernel.org (Vinod)
Date: Fri, 29 Jun 2018 13:07:07 +0530
Subject: [PATCH v3 4/5] dmaengine: xilinx_dma: autodetect whether the HW
 supports scatter-gather
In-Reply-To: <20180625092724.22164-4-andrea.merello@gmail.com>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
 <20180625092724.22164-4-andrea.merello@gmail.com>
Message-ID: <20180629073707.GZ22377@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-06-18, 11:27, Andrea Merello wrote:
> The AXIDMA and CDMA HW can be either direct-access or scatter-gather
> version. These are SW incompatible.
> 
> The driver can handle both version: a DT property was used to
                                ^^^^
versions

> tell the driver whether to assume the HW is is scatter-gather mode.
                                           ^^^^^
is in?

> 
> This patch makes the driver to autodetect this information. The DT
> property is not required anymore.
> 
> No changes for VDMA.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes in v2:
> 	- autodetect only in !VDMA case
> Changes in v3:
> 	- cc DT maintainers/ML
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 7f0ab904b749..43fcc71ff287 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -86,6 +86,7 @@
>  #define XILINX_DMA_DMASR_DMA_DEC_ERR		BIT(6)
>  #define XILINX_DMA_DMASR_DMA_SLAVE_ERR		BIT(5)
>  #define XILINX_DMA_DMASR_DMA_INT_ERR		BIT(4)
> +#define XILINX_DMA_DMASR_SG_MASK		BIT(3)
>  #define XILINX_DMA_DMASR_IDLE			BIT(1)
>  #define XILINX_DMA_DMASR_HALTED		BIT(0)
>  #define XILINX_DMA_DMASR_DELAY_MASK		GENMASK(31, 24)
> @@ -406,7 +407,6 @@ struct xilinx_dma_config {
>   * @dev: Device Structure
>   * @common: DMA device structure
>   * @chan: Driver specific DMA channel
> - * @has_sg: Specifies whether Scatter-Gather is present or not
>   * @mcdma: Specifies whether Multi-Channel is present or not
>   * @flush_on_fsync: Flush on frame sync
>   * @ext_addr: Indicates 64 bit addressing is supported by dma device
> @@ -426,7 +426,6 @@ struct xilinx_dma_device {
>  	struct device *dev;
>  	struct dma_device common;
>  	struct xilinx_dma_chan *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
> -	bool has_sg;
>  	bool mcdma;
>  	u32 flush_on_fsync;
>  	bool ext_addr;
> @@ -2393,7 +2392,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  
>  	chan->dev = xdev->dev;
>  	chan->xdev = xdev;
> -	chan->has_sg = xdev->has_sg;
>  	chan->desc_pendingcount = 0x0;
>  	chan->ext_addr = xdev->ext_addr;
>  	/* This variable ensures that descriptors are not
> @@ -2486,6 +2484,15 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  		chan->stop_transfer = xilinx_dma_stop_transfer;
>  	}
>  
> +	/* check if SG is enabled (only for AXIDMA and CDMA) */
> +	if (xdev->dma_config->dmatype != XDMA_TYPE_VDMA) {
> +		if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
> +		    XILINX_DMA_DMASR_SG_MASK)

why not read this for VDMA too, will it return false?

> +			chan->has_sg = true;
> +		dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
> +			chan->has_sg ? "enabled" : "disabled");

this debug print can be removed

-- 
~Vinod
