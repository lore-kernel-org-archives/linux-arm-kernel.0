From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Mon, 23 Jan 2017 08:26:09 +0100
Subject: [PATCH v6 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <1484372155-19423-3-git-send-email-appanad@xilinx.com>
References: <1484372155-19423-1-git-send-email-appanad@xilinx.com>
 <1484372155-19423-3-git-send-email-appanad@xilinx.com>
Message-ID: <296cffff-3847-4217-bd94-ac72fe044f73@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 14-01-17 06:35, Kedareswara rao Appana wrote:
> When VDMA is configured for more than one frame in the h/w.
> For example h/w is configured for n number of frames, user
> Submits n number of frames and triggered the DMA using issue_pending API.
>
> In the current driver flow we are submitting one frame at a time,
> But we should submit all the n number of frames at one time
> As the h/w is configured for n number of frames.

The hardware can always handle a single frame submission, by using the "park" 
bit. This would make a good "cyclic" implementation too (using vdma as 
framebuffer).

It could also handle all cases for "k" frames where n%k==0 (n is a multiple of 
k) by simply replicating the frame pointers.

>
> This patch fixes this issue.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Jose Abreu <joabreu@synopsys.com>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v6:
> ---> Added Rob Acked-by
> ---> Updated commit message as suggested by Vinod.
> Changes for v5:
> ---> Updated xlnx,fstore-config property to xlnx,fstore-enable
>      and updated description as suggested by Rob.
> Changes for v4:
> ---> Add Check for framestore configuration on Transmit case as well
>      as suggested by Jose Abreu.
> ---> Modified the dev_dbg checks to dev_warn checks as suggested
>      by Jose Abreu.
> Changes for v3:
> ---> Added Checks for frame store configuration. If frame store
>      Configuration is not present at the h/w level and user
>      Submits less frames added debug prints in the driver as relevant.
> Changes for v2:
> ---> Fixed race conditions in the driver as suggested by Jose Abreu
> ---> Fixed unnecessray if else checks in the vdma_start_transfer
>      as suggested by Laurent Pinchart.
>
>  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |  2 +
>  drivers/dma/xilinx/xilinx_dma.c                    | 78 +++++++++++++++-------
>  2 files changed, 57 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> index a2b8bfa..e951c09 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> @@ -66,6 +66,8 @@ Optional child node properties:
>  Optional child node properties for VDMA:
>  - xlnx,genlock-mode: Tells Genlock synchronization is
>  	enabled/disabled in hardware.
> +- xlnx,fstore-enable: boolean; if defined, it indicates that controller
> +	supports frame store configuration.
>  Optional child node properties for AXI DMA:
>  -dma-channels: Number of dma channels in child node.
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 5eeea57..edb5b71 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -322,6 +322,7 @@ struct xilinx_dma_tx_descriptor {
>   * @genlock: Support genlock mode
>   * @err: Channel has errors
>   * @idle: Check for channel idle
> + * @has_fstoreen: Check for frame store configuration
>   * @tasklet: Cleanup work after irq
>   * @config: Device configuration info
>   * @flush_on_fsync: Flush on Frame sync
> @@ -353,6 +354,7 @@ struct xilinx_dma_chan {
>  	bool genlock;
>  	bool err;
>  	bool idle;
> +	bool has_fstoreen;
>  	struct tasklet_struct tasklet;
>  	struct xilinx_vdma_config config;
>  	bool flush_on_fsync;
> @@ -990,6 +992,27 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
>  	if (list_empty(&chan->pending_list))
>  		return;
>
> +	/*
> +	 * Note: When VDMA is built with default h/w configuration
> +	 * User should submit frames upto H/W configured.
> +	 * If users submits less than h/w configured
> +	 * VDMA engine tries to write to a invalid location
> +	 * Results undefined behaviour/memory corruption.
> +	 *
> +	 * If user would like to submit frames less than h/w capable
> +	 * On S2MM side please enable debug info 13 at the h/w level
> +	 * On MM2S side please enable debug info 6 at the h/w level
> +	 * It will allows the frame buffers numbers to be modified at runtime.
> +	 */
> +	if (!chan->has_fstoreen &&
> +	     chan->desc_pendingcount < chan->num_frms) {
> +		dev_warn(chan->dev, "Frame Store Configuration is not enabled at the\n");
> +		dev_warn(chan->dev, "H/w level enable Debug info 13 or 6 at the h/w level\n");
> +		dev_warn(chan->dev, "OR Submit the frames upto h/w Capable\n\r");
> +
> +		return;
> +	}
> +
>  	desc = list_first_entry(&chan->pending_list,
>  				struct xilinx_dma_tx_descriptor, node);
>  	tail_desc = list_last_entry(&chan->pending_list,
> @@ -1052,25 +1075,38 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
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
> @@ -1081,20 +1117,14 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
>  		vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
>  				last->hw.stride);
>  		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);
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
> @@ -1342,6 +1372,7 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
>
>  	chan->err = false;
>  	chan->idle = true;
> +	chan->desc_submitcount = 0;
>
>  	return err;
>  }
> @@ -2320,6 +2351,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  	has_dre = of_property_read_bool(node, "xlnx,include-dre");
>
>  	chan->genlock = of_property_read_bool(node, "xlnx,genlock-mode");
> +	chan->has_fstoreen = of_property_read_bool(node, "xlnx,fstore-enable");
>
>  	err = of_property_read_u32(node, "xlnx,datawidth", &value);
>  	if (err) {
>



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
