From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 11 Mar 2016 12:12:27 +0530
Subject: [PATCH 2/5] dmaengine: sun6i: Fix impossible settings of burst
 and bus width
In-Reply-To: <caa86759ff67df73c10fc3738eac5de58d582cc1.1457606136.git.moinejf@free.fr>
References: <cover.1457606136.git.moinejf@free.fr>
 <caa86759ff67df73c10fc3738eac5de58d582cc1.1457606136.git.moinejf@free.fr>
Message-ID: <20160311064227.GR11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 10:27:37AM +0100, Jean-Francois Moine wrote:
> In the commit 1f9cd915b64bb95f "dmaengine: sun6i: Fix memcpy operation",
> the signed values returned by convert_burst() and convert_buswidth()
> were stored in an unsigned value.
> Then, these values were considered as errors when non null.
> As a result, setting burst or buswidth to values different from 1 was
> making the DMA transfers to be rejected.

A value of 0 for burst does not make sense. Frr buswidth this in undefined.
So what are we gaining from 0 value and how is it fixing something which is
passed as wrong argument?


> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/dma/sun6i-dma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 2ec320d..3579ee7 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -281,25 +281,25 @@ static inline int sun6i_dma_cfg_lli(struct sun6i_dma_lli *lli,
>  				    dma_addr_t dst, u32 len,
>  				    struct dma_slave_config *config)
>  {
> -	u8 src_width, dst_width, src_burst, dst_burst;
> +	s8 src_width, dst_width, src_burst, dst_burst;
>  
>  	if (!config)
>  		return -EINVAL;
>  
>  	src_burst = convert_burst(config->src_maxburst);
> -	if (src_burst)
> +	if (src_burst < 0)
>  		return src_burst;
>  
>  	dst_burst = convert_burst(config->dst_maxburst);
> -	if (dst_burst)
> +	if (dst_burst < 0)
>  		return dst_burst;
>  
>  	src_width = convert_buswidth(config->src_addr_width);
> -	if (src_width)
> +	if (src_width < 0)
>  		return src_width;
>  
>  	dst_width = convert_buswidth(config->dst_addr_width);
> -	if (dst_width)
> +	if (dst_width < 0)
>  		return dst_width;
>  
>  	lli->cfg = DMA_CHAN_CFG_SRC_BURST(src_burst) |
> -- 
> 2.7.2
> 

-- 
~Vinod
