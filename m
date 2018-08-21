From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 21 Aug 2018 07:31:11 +0000
Subject: [PATCH 1/3] dmaengine: xilinx_dma: Refactor axidma channel
 allocation
In-Reply-To: <1532688639-32230-2-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-2-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <DM5PR02MB21872434D0054888E8CA1EC5DC310@DM5PR02MB2187.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	Thanks for the patch... 
> 
> In axidma alloc_chan_resources merge BD and cyclic BD allocation.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-for-series: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

Regards,
Kedar.

> ---
>  drivers/dma/xilinx/xilinx_dma.c |   36 ++++++++++++++++++------------------
>  1 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c index c124423..06d1632 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -887,6 +887,24 @@ static int xilinx_dma_alloc_chan_resources(struct
> dma_chan *dchan)
>  				chan->id);
>  			return -ENOMEM;
>  		}
> +		/*
> +		 * For cyclic DMA mode we need to program the tail
> Descriptor
> +		 * register with a value which is not a part of the BD chain
> +		 * so allocating a desc segment during channel allocation for
> +		 * programming tail descriptor.
> +		 */
> +		chan->cyclic_seg_v = dma_zalloc_coherent(chan->dev,
> +					sizeof(*chan->cyclic_seg_v),
> +					&chan->cyclic_seg_p, GFP_KERNEL);
> +		if (!chan->cyclic_seg_v) {
> +			dev_err(chan->dev,
> +				"unable to allocate desc segment for cyclic
> DMA\n");
> +			dma_free_coherent(chan->dev, sizeof(*chan->seg_v)
> *
> +				XILINX_DMA_NUM_DESCS, chan->seg_v,
> +				chan->seg_p);
> +			return -ENOMEM;
> +		}
> +		chan->cyclic_seg_v->phys = chan->cyclic_seg_p;
> 
>  		for (i = 0; i < XILINX_DMA_NUM_DESCS; i++) {
>  			chan->seg_v[i].hw.next_desc =
> @@ -922,24 +940,6 @@ static int xilinx_dma_alloc_chan_resources(struct
> dma_chan *dchan)
>  		return -ENOMEM;
>  	}
> 
> -	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> -		/*
> -		 * For cyclic DMA mode we need to program the tail
> Descriptor
> -		 * register with a value which is not a part of the BD chain
> -		 * so allocating a desc segment during channel allocation for
> -		 * programming tail descriptor.
> -		 */
> -		chan->cyclic_seg_v = dma_zalloc_coherent(chan->dev,
> -					sizeof(*chan->cyclic_seg_v),
> -					&chan->cyclic_seg_p, GFP_KERNEL);
> -		if (!chan->cyclic_seg_v) {
> -			dev_err(chan->dev,
> -				"unable to allocate desc segment for cyclic
> DMA\n");
> -			return -ENOMEM;
> -		}
> -		chan->cyclic_seg_v->phys = chan->cyclic_seg_p;
> -	}
> -
>  	dma_cookie_init(dchan);
> 
>  	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> --
> 1.7.1
