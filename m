From: Jose.Abreu@synopsys.com (Jose Abreu)
Date: Thu, 15 Dec 2016 16:10:20 +0000
Subject: [PATCH 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <1481814682-31780-3-git-send-email-appanad@xilinx.com>
References: <1481814682-31780-1-git-send-email-appanad@xilinx.com>
 <1481814682-31780-3-git-send-email-appanad@xilinx.com>
Message-ID: <9d92984b-e04a-cd29-e933-d8ea4d610c94@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedar,


On 15-12-2016 15:11, Kedareswara rao Appana wrote:
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
>  drivers/dma/xilinx/xilinx_dma.c | 43 +++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 736c2a3..4f3fa94 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1087,23 +1087,33 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
>  				tail_segment->phys);
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

Hmm, is it possible to submit more than one segment? If so, then
i and j will get out of sync.

> +			}
> +			list_del(&desc->node);
> +			list_add_tail(&desc->node, &chan->active_list);
> +			j++;

But if i is non zero and pending_list has more than num_frms then
i will not wrap-around as it should and will write to invalid
framebuffer location, right?

> +			if (list_empty(&chan->pending_list))
> +				break;
> +			desc = list_first_entry(&chan->pending_list,
> +						struct xilinx_dma_tx_descriptor,
> +						node);
>  		}
>  
>  		if (!last)
> @@ -1114,14 +1124,13 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
>  		vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
>  				last->hw.stride);
>  		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);

Maybe a check that all framebuffers contain valid addresses
should be done before programming vsize so that VDMA does not try
to write to invalid addresses.

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

"desc_submitcount >= chan->num_frms would be safer here.

>  	} else {

Best regards,
Jose Miguel Abreu
