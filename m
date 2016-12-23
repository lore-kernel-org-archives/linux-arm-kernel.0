From: Jose.Abreu@synopsys.com (Jose Abreu)
Date: Fri, 23 Dec 2016 15:36:45 +0000
Subject: [PATCH v2 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <1482483135-14767-3-git-send-email-appanad@xilinx.com>
References: <1482483135-14767-1-git-send-email-appanad@xilinx.com>
 <1482483135-14767-3-git-send-email-appanad@xilinx.com>
Message-ID: <a269409d-103e-1650-5df6-cc8743ed62cf@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedar,


On 23-12-2016 08:52, Kedareswara rao Appana wrote:
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
> Changes for v2:
> ---> Fixed race conditions in the driver as suggested by Jose Abreu
> ---> Fixed unnecessray if else checks in the vdma_start_transfer
>      as suggested by Laurent Pinchart.
>
>  drivers/dma/xilinx/xilinx_dma.c | 54 +++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index be7eb41..cf9edd8 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1052,25 +1052,38 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
>  	if (chan->has_sg) {
>  		dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
>  				tail_segment->phys);
> +		list_splice_tail_init(&chan->pending_list, &chan->active_list);
> +		chan->desc_pendingcount = 0;
>  	} else {
>  		struct xilinx_vdma_tx_segment *segment, *last = NULL;
> -		int i = 0;
> +		int i = 0, j = 0;
>  
>  		if (chan->desc_submitcount < chan->num_frms)
>  			i = chan->desc_submitcount;
>  
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
> +		for (j = 0; j < chan->num_frms; ) {
> +			list_for_each_entry(segment, &desc->segments, node) {
> +				if (chan->ext_addr)
> +					vdma_desc_write_64(chan,
> +					  XILINX_VDMA_REG_START_ADDRESS_64(i++),
> +					  segment->hw.buf_addr,
> +					  segment->hw.buf_addr_msb);
> +				else
> +					vdma_desc_write(chan,
> +					    XILINX_VDMA_REG_START_ADDRESS(i++),
> +					    segment->hw.buf_addr);
> +
> +				last = segment;
> +			}
> +			list_del(&desc->node);
> +			list_add_tail(&desc->node, &chan->active_list);
> +			j++;
> +			if (list_empty(&chan->pending_list) ||
> +			    (i == chan->num_frms))
> +				break;
> +			desc = list_first_entry(&chan->pending_list,
> +						struct xilinx_dma_tx_descriptor,
> +						node);
>  		}
>  
>  		if (!last)
> @@ -1081,20 +1094,14 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
>  		vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
>  				last->hw.stride);
>  		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);

What if we reach here and j < num_frms? It can happen because if
the pending list is empty the loop breaks. Then VDMA will start
with framebuffers having address 0x0. You should only program
vsize when j > num_frms or when we have already previously set
the framebuffers (i.e. when submitcount has already been
incremented num_frms at least once).

Best regards,
Jose Miguel Abreu

> -	}
>  
> -	chan->idle = false;
> -	if (!chan->has_sg) {
> -		list_del(&desc->node);
> -		list_add_tail(&desc->node, &chan->active_list);
> -		chan->desc_submitcount++;
> -		chan->desc_pendingcount--;
> +		chan->desc_submitcount += j;
> +		chan->desc_pendingcount -= j;
>  		if (chan->desc_submitcount == chan->num_frms)
>  			chan->desc_submitcount = 0;
> -	} else {
> -		list_splice_tail_init(&chan->pending_list, &chan->active_list);
> -		chan->desc_pendingcount = 0;
>  	}
> +
> +	chan->idle = false;
>  }
>  
>  /**
> @@ -1342,6 +1349,7 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
>  
>  	chan->err = false;
>  	chan->idle = true;
> +	chan->desc_submitcount = 0;
>  
>  	return err;
>  }
