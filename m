From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 5 Apr 2016 14:53:27 -0700
Subject: [PATCH v3 2/2] dmaengine: vdma: Fix race condition in Non-SG mode
In-Reply-To: <1458897399-3939-1-git-send-email-appanad@xilinx.com>
References: <1458897399-3939-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160405215326.GB11586@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2016 at 02:46:39PM +0530, Kedareswara rao Appana wrote:
> When VDMA is configured in  Non-sg mode
> Users can queue descriptors greater than h/w configured frames.
> 
> Current driver allows the user to queue descriptors upto h/w configured.
> Which is wrong for non-sg mode configuration.

I see to have standalone patch 2, where is 1st patch?

There seems to be an issue with other 6 patch series with threading broken
and few patches showing up standalone and not part of series

Can you resend the whole thing please..

> 
> This patch fixes this issue.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v3:
> ---> New patch.
> 
>  drivers/dma/xilinx/xilinx_vdma.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
> index abe915c..b873d98 100644
> --- a/drivers/dma/xilinx/xilinx_vdma.c
> +++ b/drivers/dma/xilinx/xilinx_vdma.c
> @@ -209,6 +209,7 @@ struct xilinx_vdma_tx_descriptor {
>   * @flush_on_fsync: Flush on Frame sync
>   * @desc_pendingcount: Descriptor pending count
>   * @ext_addr: Indicates 64 bit addressing is supported by dma channel
> + * @desc_submitcount: Descriptor h/w submitted count
>   */
>  struct xilinx_vdma_chan {
>  	struct xilinx_vdma_device *xdev;
> @@ -233,6 +234,7 @@ struct xilinx_vdma_chan {
>  	bool flush_on_fsync;
>  	u32 desc_pendingcount;
>  	bool ext_addr;
> +	u32 desc_submitcount;
>  };
>  
>  /**
> @@ -716,9 +718,10 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
>  		struct xilinx_vdma_tx_segment *segment, *last = NULL;
>  		int i = 0;
>  
> -		list_for_each_entry(desc, &chan->pending_list, node) {
> -			segment = list_first_entry(&desc->segments,
> -					   struct xilinx_vdma_tx_segment, node);
> +		if (chan->desc_submitcount < chan->num_frms)
> +			i = chan->desc_submitcount;
> +
> +		list_for_each_entry(segment, &desc->segments, node) {
>  			if (chan->ext_addr)
>  				vdma_desc_write_64(chan,
>  					XILINX_VDMA_REG_START_ADDRESS_64(i++),
> @@ -742,8 +745,17 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
>  		vdma_desc_write(chan, XILINX_VDMA_REG_VSIZE, last->hw.vsize);
>  	}
>  
> -	list_splice_tail_init(&chan->pending_list, &chan->active_list);
> -	chan->desc_pendingcount = 0;
> +	if (!chan->has_sg) {
> +		list_del(&desc->node);
> +		list_add_tail(&desc->node, &chan->active_list);
> +		chan->desc_submitcount++;
> +		chan->desc_pendingcount--;
> +		if (chan->desc_submitcount == chan->num_frms)
> +			chan->desc_submitcount = 0;
> +	} else {
> +		list_splice_tail_init(&chan->pending_list, &chan->active_list);
> +		chan->desc_pendingcount = 0;
> +	}
>  }
>  
>  /**
> @@ -927,7 +939,8 @@ append:
>  	list_add_tail(&desc->node, &chan->pending_list);
>  	chan->desc_pendingcount++;
>  
> -	if (unlikely(chan->desc_pendingcount > chan->num_frms)) {
> +	if (chan->has_sg &&
> +	    unlikely(chan->desc_pendingcount > chan->num_frms)) {
>  		dev_dbg(chan->dev, "desc pendingcount is too high\n");
>  		chan->desc_pendingcount = chan->num_frms;
>  	}
> -- 
> 2.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod
