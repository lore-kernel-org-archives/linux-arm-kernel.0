From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 16 Dec 2016 17:35:57 +0200
Subject: [PATCH 1/3] dmaengine: xilinx_dma: Check for channel idle state
 before submitting dma descriptor
In-Reply-To: <1481814682-31780-2-git-send-email-appanad@xilinx.com>
References: <1481814682-31780-1-git-send-email-appanad@xilinx.com>
 <1481814682-31780-2-git-send-email-appanad@xilinx.com>
Message-ID: <5248247.n0rV8xBPrZ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedareswara,

Thank you for the patch.

On Thursday 15 Dec 2016 20:41:20 Kedareswara rao Appana wrote:
> Add channel idle state to ensure that dma descriptor is not
> submitted when VDMA engine is in progress.
>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c index 8288fe4..736c2a3 100644
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
> @@ -966,6 +968,7 @@ static void xilinx_dma_halt(struct xilinx_dma_chan
> *chan) chan, dma_ctrl_read(chan, XILINX_DMA_REG_DMASR));
>  		chan->err = true;
>  	}
> +	chan->idle = true;
>  }
> 
>  /**
> @@ -1007,6 +1010,9 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_dma_chan *chan)
> 	if (chan->err)
>  		return;
> 
> +	if (!chan->idle)
> +		return;

Don't you need to perform the same check for the DMA and CDMA channels ? If 
so, shouldn't this be moved to common code ?

There's another problem (not strictly introduced by this patch) I wanted to 
mention. The append_desc_queue() function, called from your tx_submit handler, 
appends descriptors to the pending_list. The DMA engine API states that a 
transfer submitted by tx_submit will not be executed until .issue_pending() is 
called. However, if a transfer is in progress at tx_submit time, I believe 
that the IRQ handler, at transfer completion, will start the next transfer 
from the pending_list even if .issue_pending() hasn't been called for it.

>  	if (list_empty(&chan->pending_list))
>  		return;

Now that you catch busy channels with a software flag, do you still need the 
xilinx_dma_is_running() and xilinx_dma_is_idle() checks ? Three different 
checks for the same or very similar conditions are confusing, if you really 
need them you should document clearly how they differ.

> @@ -1110,6 +1116,7 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_dma_chan *chan) vdma_desc_write(chan, XILINX_DMA_REG_VSIZE,
> last->hw.vsize);
>  	}
> 
> +	chan->idle = false;

(and this too)

>  	if (!chan->has_sg) {
>  		list_del(&desc->node);
>  		list_add_tail(&desc->node, &chan->active_list);
> @@ -1447,6 +1454,7 @@ static irqreturn_t xilinx_dma_irq_handler(int irq,
> void *data) if (status & XILINX_DMA_DMASR_FRM_CNT_IRQ) {
>  		spin_lock(&chan->lock);
>  		xilinx_dma_complete_descriptor(chan);
> +		chan->idle = true;
>  		chan->start_transfer(chan);
>  		spin_unlock(&chan->lock);
>  	}
> @@ -2327,6 +2335,7 @@ static int xilinx_dma_chan_probe(struct
> xilinx_dma_device *xdev, chan->has_sg = xdev->has_sg;
>  	chan->desc_pendingcount = 0x0;
>  	chan->ext_addr = xdev->ext_addr;
> +	chan->idle = true;
> 
>  	spin_lock_init(&chan->lock);
>  	INIT_LIST_HEAD(&chan->pending_list);

-- 
Regards,

Laurent Pinchart
