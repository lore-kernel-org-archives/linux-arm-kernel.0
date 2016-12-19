From: jsarha@ti.com (Jyri Sarha)
Date: Mon, 19 Dec 2016 15:09:12 +0200
Subject: [PATCH] drm: tilcdc: simplify the recovery from sync lost error
 on rev1
In-Reply-To: <1481641656-25227-1-git-send-email-bgolaszewski@baylibre.com>
References: <1481641656-25227-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <590211f1-8e31-cecc-8dd2-f7e2976b81d1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One comment bellow.

On 12/13/16 17:07, Bartosz Golaszewski wrote:
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
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> index 9942b05..70e57a7 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -921,17 +921,23 @@ irqreturn_t tilcdc_crtc_irq(struct drm_crtc *crtc)
>  		dev_err_ratelimited(dev->dev, "%s(0x%08x): Sync lost",
>  				    __func__, stat);
>  		tilcdc_crtc->frame_intact = false;
> -		if (tilcdc_crtc->sync_lost_count++ >
> -		    SYNC_LOST_COUNT_LIMIT) {
> -			dev_err(dev->dev, "%s(0x%08x): Sync lost flood detected, recovering", __func__, stat);
> -			queue_work(system_wq, &tilcdc_crtc->recover_work);
> -			if (priv->rev == 1)
> -				tilcdc_clear(dev, LCDC_RASTER_CTRL_REG,
> -					     LCDC_V1_SYNC_LOST_INT_ENA);
> -			else
> +		if (priv->rev == 1) {

I would add here:
+		if ((tilcdc_read(dev, LCDC_RASTER_CTRL_REG) &
+				LCDC_RASTER_ENABLE)) {

> +			tilcdc_clear(dev,
> +				     LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
> +			tilcdc_set(dev,
> +				   LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
+		}

Just in case the interrupt is for some reason handled right after the
crtc is disabled.

With this addition I could send a pull request for this fix still today,
if you agree with the change.

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
