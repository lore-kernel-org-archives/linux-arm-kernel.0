From: Jose.Abreu@synopsys.com (Jose Abreu)
Date: Thu, 15 Dec 2016 15:45:49 +0000
Subject: [PATCH 1/3] dmaengine: xilinx_dma: Check for channel idle state
 before submitting dma descriptor
In-Reply-To: <1481814682-31780-2-git-send-email-appanad@xilinx.com>
References: <1481814682-31780-1-git-send-email-appanad@xilinx.com>
 <1481814682-31780-2-git-send-email-appanad@xilinx.com>
Message-ID: <5f667b4f-b1f3-df34-ec0d-b62061328642@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedar,


On 15-12-2016 15:11, Kedareswara rao Appana wrote:
> Add channel idle state to ensure that dma descriptor is not
> submitted when VDMA engine is in progress.
>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 8288fe4..736c2a3 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -321,6 +321,7 @@ struct xilinx_dma_tx_descriptor {
>   * @cyclic: Check for cyclic transfers.
>   * @genlock: Support genlock mode
>   * @err: Channel has errors
> + * @idle: Check for channel idle
>   * @tasklet: Cleanup work after irq
>   * @config: Device configuration info
>   * @flush_on_fsync: Flush on Frame sync
> @@ -351,6 +352,7 @@ struct xilinx_dma_chan {
>  	bool cyclic;
>  	bool genlock;
>  	bool err;
> +	bool idle;
>  	struct tasklet_struct tasklet;
>  	struct xilinx_vdma_config config;
>  	bool flush_on_fsync;
> @@ -966,6 +968,7 @@ static void xilinx_dma_halt(struct xilinx_dma_chan *chan)
>  			chan, dma_ctrl_read(chan, XILINX_DMA_REG_DMASR));
>  		chan->err = true;
>  	}
> +	chan->idle = true;
>  }
>  
>  /**
> @@ -1007,6 +1010,9 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
>  	if (chan->err)
>  		return;
>  
> +	if (!chan->idle)
> +		return;
> +
>  	if (list_empty(&chan->pending_list))
>  		return;
>  
> @@ -1110,6 +1116,7 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
>  		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);
>  	}
>  
> +	chan->idle = false;
>  	if (!chan->has_sg) {
>  		list_del(&desc->node);
>  		list_add_tail(&desc->node, &chan->active_list);
> @@ -1447,6 +1454,7 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
>  	if (status & XILINX_DMA_DMASR_FRM_CNT_IRQ) {
>  		spin_lock(&chan->lock);
>  		xilinx_dma_complete_descriptor(chan);
> +		chan->idle = true;
>  		chan->start_transfer(chan);
>  		spin_unlock(&chan->lock);
>  	}
> @@ -2327,6 +2335,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  	chan->has_sg = xdev->has_sg;
>  	chan->desc_pendingcount = 0x0;
>  	chan->ext_addr = xdev->ext_addr;
> +	chan->idle = true;
>  
>  	spin_lock_init(&chan->lock);
>  	INIT_LIST_HEAD(&chan->pending_list);

I think there is missing a set to true in idle when a channel
reset is performed.
Otherwise: Reviewed-by: Jose Abreu <joabreu@synopsys.com>

Best regards,
Jose Miguel Abreu
