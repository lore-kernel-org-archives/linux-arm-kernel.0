From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 26 Apr 2016 09:15:54 +0530
Subject: [PATCH v5 2/3] dmaengine: sun6i: Set default maxburst size and
 bus width
In-Reply-To: <b862c3ac7d268e08c3052e245df4c3024f12d7f5.1461307982.git.moinejf@free.fr>
References: <cover.1461307982.git.moinejf@free.fr>
 <b862c3ac7d268e08c3052e245df4c3024f12d7f5.1461307982.git.moinejf@free.fr>
Message-ID: <20160426034554.GF2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 08:48:40AM +0200, Jean-Francois Moine wrote:
> Some DMA clients, as audio, don't set the maxburst size and bus width
> on the memory side when starting DMA transfers.
> This patch prevents such transfers to be aborted by providing system
> default values to the lacking ones.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/dma/sun6i-dma.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index b08245e..821fc4f 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -470,10 +470,25 @@ static int set_config(struct sun6i_dma_dev *sdev,
>  {
>  	s8 src_width, dst_width, src_burst, dst_burst;
>  
> -	src_burst = convert_burst(sconfig->src_maxburst);
> -	src_width = convert_buswidth(sconfig->src_addr_width);
> -	dst_burst = convert_burst(sconfig->dst_maxburst);
> -	dst_width = convert_buswidth(sconfig->dst_addr_width);
> +	if (direction == DMA_MEM_TO_DEV) {
> +		src_burst = convert_burst(sconfig->src_maxburst ?
> +					sconfig->src_maxburst : 8);
> +		src_width = convert_buswidth(sconfig->src_addr_width !=
> +						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
> +				sconfig->src_addr_width :
> +				DMA_SLAVE_BUSWIDTH_4_BYTES);
> +		dst_burst = convert_burst(sconfig->dst_maxburst);
> +		dst_width = convert_buswidth(sconfig->dst_addr_width);
> +	} else {	/* DMA_DEV_TO_MEM */

Else can be any other direction, I would prefer we check that. Also swicth
would be better

> +		src_burst = convert_burst(sconfig->src_maxburst);
> +		src_width = convert_buswidth(sconfig->src_addr_width);
> +		dst_burst = convert_burst(sconfig->dst_maxburst ?
> +					sconfig->dst_maxburst : 8);
> +		dst_width = convert_buswidth(sconfig->dst_addr_width !=
> +						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
> +				sconfig->dst_addr_width :
> +				DMA_SLAVE_BUSWIDTH_4_BYTES);
> +	}
>  
>  	if (src_burst < 0)
>  		return src_burst;

-- 
~Vinod
