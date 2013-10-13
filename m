From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 13 Oct 2013 21:48:01 +0530
Subject: [PATCH 1/1] dma: imx-sdma: setup dma mask
In-Reply-To: <1380623464-24652-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1380623464-24652-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380623464-24652-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20131013161801.GP2954@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 12:31:04PM +0200, Philippe R?tornaz wrote:
> The dma mask is not configured in the current code.
> This was triggered by soc-dmaengine-pcm which allocate the dma
> buffers with the imx-sdma as device.
> This commit fix audio on imx31.
> 
> Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
This needs to go thru Russell's tree, that has the below API

Acked-by Vinod Koul <vinod.koul@intel.com>

~Vinod

> ---
>  drivers/dma/imx-sdma.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index fc43603..c1fd504 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1432,6 +1432,10 @@ static int __init sdma_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;
> +
>  	sdma = kzalloc(sizeof(*sdma), GFP_KERNEL);
>  	if (!sdma)
>  		return -ENOMEM;
> -- 
> 1.7.9.5
> 

-- 
