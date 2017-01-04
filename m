From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 4 Jan 2017 11:29:46 +0200
Subject: [PATCH v2] drm: tilcdc: simplify the recovery from sync lost
 error on rev1
In-Reply-To: <1482158834-29477-1-git-send-email-bgolaszewski@baylibre.com>
References: <1482158834-29477-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <8282435c-7ee4-61bd-8399-4c58a9fc5279@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/16 16:47, Bartosz Golaszewski wrote:
> Revision 2 of LCDC suffers from an issue where a SYNC_LOST error
> caused by limited memory bandwidth may leave the picture shifted a
> couple pixels to the right.
> 
> This issue has not been observed on revision 1, while the recovery
> mechanism introduces a different issue, where the END_OF_FRAME
> interrupt doesn't fire while drm is waiting for vblanks.
> 
> On rev1: recover from sync lost errors by simply clearing the
> RASTER_ENABLE bit in the RASTER_CTRL register and re-enabling it
> again as is suggested by the datasheet.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>


After testing I'll send this as fixes pull req for tilcdc 4.10.

Reviewed-by: Jyri Sarha <jsarha@ti.com>

> ---
> v1 -> v2:
> - add a check to see if the RASTER_ENABLE bit is set before clearing it
> 
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> index 9942b05..2004107 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -856,7 +856,7 @@ irqreturn_t tilcdc_crtc_irq(struct drm_crtc *crtc)
>  	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
>  	struct drm_device *dev = crtc->dev;
>  	struct tilcdc_drm_private *priv = dev->dev_private;
> -	uint32_t stat;
> +	uint32_t stat, reg;
>  
>  	stat = tilcdc_read_irqstatus(dev);
>  	tilcdc_clear_irqstatus(dev, stat);
> @@ -921,17 +921,26 @@ irqreturn_t tilcdc_crtc_irq(struct drm_crtc *crtc)
>  		dev_err_ratelimited(dev->dev, "%s(0x%08x): Sync lost",
>  				    __func__, stat);
>  		tilcdc_crtc->frame_intact = false;
> -		if (tilcdc_crtc->sync_lost_count++ >
> -		    SYNC_LOST_COUNT_LIMIT) {
> -			dev_err(dev->dev, "%s(0x%08x): Sync lost flood detected, recovering", __func__, stat);
> -			queue_work(system_wq, &tilcdc_crtc->recover_work);
> -			if (priv->rev == 1)
> +		if (priv->rev == 1) {
> +			reg = tilcdc_read(dev, LCDC_RASTER_CTRL_REG);
> +			if (reg & LCDC_RASTER_ENABLE) {
>  				tilcdc_clear(dev, LCDC_RASTER_CTRL_REG,
> -					     LCDC_V1_SYNC_LOST_INT_ENA);
> -			else
> +					     LCDC_RASTER_ENABLE);
> +				tilcdc_set(dev, LCDC_RASTER_CTRL_REG,
> +					   LCDC_RASTER_ENABLE);
> +			}
> +		} else {
> +			if (tilcdc_crtc->sync_lost_count++ >
> +			    SYNC_LOST_COUNT_LIMIT) {
> +				dev_err(dev->dev,
> +					"%s(0x%08x): Sync lost flood detected, recovering",
> +					__func__, stat);
> +				queue_work(system_wq,
> +					   &tilcdc_crtc->recover_work);
>  				tilcdc_write(dev, LCDC_INT_ENABLE_CLR_REG,
>  					     LCDC_SYNC_LOST);
> -			tilcdc_crtc->sync_lost_count = 0;
> +				tilcdc_crtc->sync_lost_count = 0;
> +			}
>  		}
>  	}
>  
> 
