From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 30 Oct 2015 10:02:47 +0200
Subject: [PATCH 1/3] dmaengine: ti-dma-crossbar: dra7: Use bitops instead
 of idr
In-Reply-To: <1446107331-30041-2-git-send-email-peter.ujfalusi@ti.com>
References: <1446107331-30041-1-git-send-email-peter.ujfalusi@ti.com>
 <1446107331-30041-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <56332427.6000805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the record...

On 10/29/2015 10:28 AM, Peter Ujfalusi wrote:
> The use of idr was nice, but it was a bit heavy and we did not need the
> features it provides. Using simple bitmap to track allocated DMA channels
> is adequate here and it will be easier to add support for reserving
> channels later on.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> -	map->xbar_out = idr_alloc(&xbar->map_idr, NULL, 0, xbar->dma_requests,
> -				  GFP_KERNEL);
> +	mutex_lock(&xbar->mutex);
> +	map->xbar_out = find_next_zero_bit(xbar->dma_inuse, xbar->dma_requests,
> +					   0);

find_first_zero_bit() ;)

> +	mutex_unlock(&xbar->mutex);
> +	if (map->xbar_out) {

Well, this is obviously wrong... Should have been:
	if (map->xbar_out == xbar->dma_requests) {


> +		dev_err(&pdev->dev, "Run out of free DMA requests\n");
> +		kfree(map);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	set_bit(map->xbar_out, xbar->dma_inuse);
> +

-- 
P?ter
