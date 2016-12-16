From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 16 Dec 2016 17:54:56 +0200
Subject: [PATCH 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <1481814682-31780-3-git-send-email-appanad@xilinx.com>
References: <1481814682-31780-1-git-send-email-appanad@xilinx.com>
 <1481814682-31780-3-git-send-email-appanad@xilinx.com>
Message-ID: <30884836.ckISXSrEvA@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedareswara,

Thank you for the patch.

On Thursday 15 Dec 2016 20:41:21 Kedareswara rao Appana wrote:
> When VDMA is configured for more than one frame in the h/w
> for example h/w is configured for n number of frames and user
> Submits n number of frames and triggered the DMA using issue_pending API.
> In the current driver flow we are submitting one frame at a time
> but we should submit all the n number of frames at one time as the h/w
> Is configured for n number of frames.
> 
> This patch fixes this issue.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 43 ++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c index 736c2a3..4f3fa94 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1087,23 +1087,33 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_dma_chan *chan)
> 		tail_segment->phys);
>  	} else {
>  		struct xilinx_vdma_tx_segment *segment, *last = NULL;
> -		int i = 0;
> +		int i = 0, j = 0;
> 
>  		if (chan->desc_submitcount < chan->num_frms)
>  			i = chan->desc_submitcount;

I don't get this. i seems to index into a segment start address array, but 
gets initialized with a variable documented as "Descriptor h/w submitted 
count". I'm not familiar with the hardware, but it makes no sense to me.

> -		list_for_each_entry(segment, &desc->segments, node) {
> -			if (chan->ext_addr)
> -				vdma_desc_write_64(chan,
> -					XILINX_VDMA_REG_START_ADDRESS_64(i++),
> -					segment->hw.buf_addr,
> -					segment->hw.buf_addr_msb);
> -			else
> -				vdma_desc_write(chan,
> -					XILINX_VDMA_REG_START_ADDRESS(i++),
> -					segment->hw.buf_addr);
> -
> -			last = segment;

Isn't it an issue to write the descriptors only after calling 
xilinx_dma_start() ?

> +		for (j = 0; j < chan->num_frms; ) {
> +			list_for_each_entry(segment, &desc->segments, node) {
> +				if (chan->ext_addr)
> +					vdma_desc_write_64(chan,
> +					  
XILINX_VDMA_REG_START_ADDRESS_64(i++),
> +					  segment->hw.buf_addr,
> +					  segment->hw.buf_addr_msb);
> +				else
> +					vdma_desc_write(chan,
> +					    
XILINX_VDMA_REG_START_ADDRESS(i++),
> +					    segment->hw.buf_addr);

I assume the size of the start address array to be limited by the hardware, 
but I don't see how this code prevents from overflowing this.

The whole function is very difficult to understand, it probably requires a 
rewrite.

> +				last = segment;
> +			}
> +			list_del(&desc->node);
> +			list_add_tail(&desc->node, &chan->active_list);
> +			j++;
> +			if (list_empty(&chan->pending_list))
> +				break;
> +			desc = list_first_entry(&chan->pending_list,
> +						struct 
xilinx_dma_tx_descriptor,
> +						node);
>  		}
> 
>  		if (!last)
> @@ -1114,14 +1124,13 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_dma_chan *chan) vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
>  				last->hw.stride);
>  		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);
> +
> +		chan->desc_submitcount += j;
> +		chan->desc_pendingcount -= j;
>  	}
> 
>  	chan->idle = false;
>  	if (!chan->has_sg) {
> -		list_del(&desc->node);
> -		list_add_tail(&desc->node, &chan->active_list);
> -		chan->desc_submitcount++;
> -		chan->desc_pendingcount--;
>  		if (chan->desc_submitcount == chan->num_frms)
>  			chan->desc_submitcount = 0;
>  	} else {

While at it, can you merge this into the previous if (chan->has_sg) { ... } 
else { ... } ? Having them separate is confusing.


-- 
Regards,

Laurent Pinchart
