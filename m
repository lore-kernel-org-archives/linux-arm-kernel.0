From: vkoul@kernel.org (Vinod)
Date: Tue, 10 Jul 2018 21:01:04 +0530
Subject: [PATCH v1 2/4] dmaengine: imx-sdma: add check_bd_buswidth() to
 kill the dulicated code
In-Reply-To: <1531239793-11781-3-git-send-email-yibin.gong@nxp.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-3-git-send-email-yibin.gong@nxp.com>
Message-ID: <20180710153104.GF3219@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-07-18, 00:23, Robin Gong wrote:
> Add check_bd_buswidth() to minimize the code size.

this looks mostly fine and I think this should be first patch..

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 64 +++++++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 27ccabf..ed2267d 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1326,6 +1326,33 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
>  	return NULL;
>  }
>  
> +static int check_bd_buswidth(struct sdma_buffer_descriptor *bd,
> +			     struct sdma_channel *sdmac, int count,
> +			     dma_addr_t dma_dst, dma_addr_t dma_src)
> +{
> +	int ret = 0;
> +
> +	switch (sdmac->word_size) {
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		bd->mode.command = 0;
> +		if ((count | dma_dst | dma_src) & 3)
> +			ret = -EINVAL;
> +		break;

empty line after each break please

> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +		bd->mode.command = 2;
> +		if ((count | dma_dst | dma_src) & 1)
> +			ret = -EINVAL;
> +		break;
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +		 bd->mode.command = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
-- 
~Vinod
