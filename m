From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Jan 2012 11:25:01 +0100
Subject: [PATCH 3/3] i.MX SDMA: Fix burstsize settings
In-Reply-To: <1327082304-11398-4-git-send-email-philippe.retornaz@epfl.ch>
References: <1327082304-11398-1-git-send-email-philippe.retornaz@epfl.ch>
 <1327082304-11398-2-git-send-email-philippe.retornaz@epfl.ch>
 <1327082304-11398-3-git-send-email-philippe.retornaz@epfl.ch>
 <1327082304-11398-4-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20120123102501.GN5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 06:58:24PM +0100, Philippe R?tornaz wrote:
> Commit 6584cb88 fixed the mxcmmc driver but forgot to fix the
> SDMA driver to handle the correct burtsize.
> This make the SD card access works again with DMA on i.MX31 boards.
> 
> Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Please resend this patch With Cc: Vinod Koul <vinod.koul@intel.com> as
a single patch, not part of a series.

Sascha

> ---
>  drivers/dma/imx-sdma.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index f993955..c193dac 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1095,11 +1095,13 @@ static int sdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>  	case DMA_SLAVE_CONFIG:
>  		if (dmaengine_cfg->direction == DMA_FROM_DEVICE) {
>  			sdmac->per_address = dmaengine_cfg->src_addr;
> -			sdmac->watermark_level = dmaengine_cfg->src_maxburst;
> +			sdmac->watermark_level = dmaengine_cfg->src_maxburst *
> +						dmaengine_cfg->src_addr_width;
>  			sdmac->word_size = dmaengine_cfg->src_addr_width;
>  		} else {
>  			sdmac->per_address = dmaengine_cfg->dst_addr;
> -			sdmac->watermark_level = dmaengine_cfg->dst_maxburst;
> +			sdmac->watermark_level = dmaengine_cfg->dst_maxburst *
> +						dmaengine_cfg->dst_addr_width;
>  			sdmac->word_size = dmaengine_cfg->dst_addr_width;
>  		}
>  		return sdma_config_channel(sdmac);
> -- 
> 1.6.3.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
