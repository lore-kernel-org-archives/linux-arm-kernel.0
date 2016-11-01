From: jsarha@ti.com (Jyri Sarha)
Date: Tue, 1 Nov 2016 16:25:03 +0200
Subject: [PATCH v5 2/2] drm: tilcdc: clear the sync lost bit in crtc isr
In-Reply-To: <1477923567-1610-3-git-send-email-bgolaszewski@baylibre.com>
References: <1477923567-1610-1-git-send-email-bgolaszewski@baylibre.com>
 <1477923567-1610-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <f26ad056-8cf7-41b8-c80b-1c564ebe51a3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/16 16:19, Bartosz Golaszewski wrote:
> The frame synchronization error happens when the DMA engine attempts
> to read what it believes to be the first word of the video buffer but
> it cannot be recognized as such or when the LCDC is starved of data
> due to insufficient bandwidth of the system interconnect.
> 
> On some SoCs (notably: da850) the memory settings do not meet the
> LCDC throughput requirements even after increasing the memory
> controller command re-ordering and the LDCD master peripheral
> priority, sometimes causing the sync lost error (typically when
> changing the resolution).
> 
> When the sync lost error occurs, simply reset the input FIFO in the
> DMA controller unless a sync lost flood is detected in which case
> disable the interrupt.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 50 ++++++++++++++++++++++++++----------
>  drivers/gpu/drm/tilcdc/tilcdc_regs.h |  1 +
>  2 files changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> index 937697d..c4c6323 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -163,7 +163,7 @@ static void tilcdc_crtc_enable_irqs(struct drm_device *dev)
>  
>  	if (priv->rev == 1) {
>  		tilcdc_set(dev, LCDC_RASTER_CTRL_REG,
> -			LCDC_V1_UNDERFLOW_INT_ENA);
> +			LCDC_V1_UNDERFLOW_INT_ENA | LCDC_V1_SYNC_LOST_ENA);
>  		tilcdc_set(dev, LCDC_DMA_CTRL_REG,
>  			LCDC_V1_END_OF_FRAME_INT_ENA);
>  	} else {
> @@ -181,7 +181,9 @@ static void tilcdc_crtc_disable_irqs(struct drm_device *dev)
>  	/* disable irqs that we might have enabled: */
>  	if (priv->rev == 1) {
>  		tilcdc_clear(dev, LCDC_RASTER_CTRL_REG,
> -			LCDC_V1_UNDERFLOW_INT_ENA | LCDC_V1_PL_INT_ENA);
> +			     LCDC_V1_UNDERFLOW_INT_ENA |
> +			     LCDC_V1_PL_INT_ENA |
> +			     LCDC_V1_SYNC_LOST_ENA);
>  		tilcdc_clear(dev, LCDC_DMA_CTRL_REG,
>  			LCDC_V1_END_OF_FRAME_INT_ENA);
>  	} else {
> @@ -885,24 +887,44 @@ irqreturn_t tilcdc_crtc_irq(struct drm_crtc *crtc)
>  			wake_up(&tilcdc_crtc->frame_done_wq);
>  		}
>  
> -		if (stat & LCDC_SYNC_LOST) {
> -			dev_err_ratelimited(dev->dev, "%s(0x%08x): Sync lost",
> -					    __func__, stat);
> -			tilcdc_crtc->frame_intact = false;
> -			if (tilcdc_crtc->sync_lost_count++ >
> -			    SYNC_LOST_COUNT_LIMIT) {
> -				dev_err(dev->dev, "%s(0x%08x): Sync lost flood detected, disabling the interrupt", __func__, stat);
> -				tilcdc_write(dev, LCDC_INT_ENABLE_CLR_REG,
> -					     LCDC_SYNC_LOST);
> -			}
> -		}
> -
>  		/* Indicate to LCDC that the interrupt service routine has
>  		 * completed, see 13.3.6.1.6 in AM335x TRM.
>  		 */
>  		tilcdc_write(dev, LCDC_END_OF_INT_IND_REG, 0);

Oh, I think this should the last thing done in the irq routine, thought
I do not really know what it does :).

>  	}
>  
> +	if (stat & LCDC_SYNC_LOST) {
> +		dev_err_ratelimited(dev->dev, "%s(0x%08x): Sync lost",
> +				    __func__, stat);
> +
> +		tilcdc_crtc->frame_intact = false;
> +		if (tilcdc_crtc->sync_lost_count++ > SYNC_LOST_COUNT_LIMIT) {
> +			dev_err(dev->dev,
> +				"%s(0x%08x): Sync lost flood detected, disabling the interrupt",
> +				__func__, stat);
> +			if (priv->rev == 2)
> +				tilcdc_write(dev, LCDC_INT_ENABLE_CLR_REG,
> +					     LCDC_SYNC_LOST);
> +			else if (priv->rev == 1)
> +				tilcdc_clear(dev, LCDC_RASTER_CTRL_REG,
> +					     LCDC_V1_SYNC_LOST_ENA);
> +		}
> +
> +		if (priv->rev == 2) {
> +			/*
> +			 * Indicate to LCDC that the interrupt service routine
> +			 * has completed, see 13.3.6.1.6 in AM335x TRM.
> +			 */
> +			tilcdc_write(dev, LCDC_END_OF_INT_IND_REG, 0);
> +		} else if (priv->rev == 1) {
> +			/* Reset the input FIFO in the DMA controller. */
> +			tilcdc_clear(dev,
> +				     LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
> +			tilcdc_set(dev,
> +				   LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
> +		}
> +	}
> +
>  	return IRQ_HANDLED;
>  }
>  
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> index f57c0d6..beb8c21 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> @@ -61,6 +61,7 @@
>  #define LCDC_V2_UNDERFLOW_INT_ENA                BIT(5)
>  #define LCDC_V1_PL_INT_ENA                       BIT(4)
>  #define LCDC_V2_PL_INT_ENA                       BIT(6)
> +#define LCDC_V1_SYNC_LOST_ENA                    BIT(5)
>  #define LCDC_MONOCHROME_MODE                     BIT(1)
>  #define LCDC_RASTER_ENABLE                       BIT(0)
>  #define LCDC_TFT_ALT_ENABLE                      BIT(23)
> 
