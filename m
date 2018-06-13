From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 Jun 2018 11:54:44 +0200
Subject: [PATCH v3 5/6] dmaengine: imx-sdma: remove the maximum limation
 for bd numbers
In-Reply-To: <1528729173-28684-6-git-send-email-yibin.gong@nxp.com>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
 <1528729173-28684-6-git-send-email-yibin.gong@nxp.com>
Message-ID: <20180613095444.uek6uzczdhx3rh56@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


In the subject: s/limation/limitation/

Sascha

On Mon, Jun 11, 2018 at 10:59:32PM +0800, Robin Gong wrote:
> No this limitation now after virtual dma used since bd is allocated
> dynamically instead of static.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index f150b38..0b0588d2 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -292,7 +292,6 @@ struct sdma_context_data {
>  	u32  scratch7;
>  } __attribute__ ((packed));
>  
> -#define NUM_BD (int)(PAGE_SIZE / sizeof(struct sdma_buffer_descriptor))
>  
>  struct sdma_engine;
>  
> @@ -1296,13 +1295,6 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
>  	if (ret)
>  		goto err_bd_out;
>  
> -	if (sg_len > NUM_BD) {
> -		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
> -				channel, sg_len, NUM_BD);
> -		ret = -EINVAL;
> -		goto err_bd_out;
> -	}
> -
>  	desc->chn_count = 0;
>  	for_each_sg(sgl, sg, sg_len, i) {
>  		struct sdma_buffer_descriptor *bd = &desc->bd[i];
> @@ -1412,12 +1404,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
>  	if (ret)
>  		goto err_bd_out;
>  
> -	if (num_periods > NUM_BD) {
> -		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
> -				channel, num_periods, NUM_BD);
> -		goto err_bd_out;
> -	}
> -
>  	if (period_len > 0xffff) {
>  		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
>  				channel, period_len, 0xffff);
> -- 
> 2.7.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
