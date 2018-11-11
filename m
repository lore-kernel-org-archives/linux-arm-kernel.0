From: vkoul@kernel.org (Vinod Koul)
Date: Sun, 11 Nov 2018 15:59:47 +0530
Subject: [PATCH v2 2/4] dmaengine: xilinx_dma: Refactor axidma channel
 validation
In-Reply-To: <1538241480-13844-3-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1538241480-13844-3-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <20181111102947.GG12092@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-09-18, 11:17, Radhey Shyam Pandey wrote:
> In axidma start_transfer, prefer checking channel states before
> other params i.e pending_list. No functional change.

There needs to be proper reason rather than a preference, can you
explain why

> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes for v2:
> Modified the commit message to mark it as non-functional change.
> ---
>  drivers/dma/xilinx/xilinx_dma.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 06d1632..a37871e 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1271,10 +1271,10 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>  	if (chan->err)
>  		return;
>  
> -	if (list_empty(&chan->pending_list))
> +	if (!chan->idle)
>  		return;
>  
> -	if (!chan->idle)
> +	if (list_empty(&chan->pending_list))
>  		return;
>  
>  	head_desc = list_first_entry(&chan->pending_list,
> -- 
> 1.7.1

-- 
~Vinod
