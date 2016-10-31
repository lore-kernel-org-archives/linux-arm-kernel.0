From: jsarha@ti.com (Jyri Sarha)
Date: Mon, 31 Oct 2016 18:05:16 +0200
Subject: [PATCH v5 1/2] drm: tilcdc: implement palette loading for rev1
In-Reply-To: <1477923567-1610-2-git-send-email-bgolaszewski@baylibre.com>
References: <1477923567-1610-1-git-send-email-bgolaszewski@baylibre.com>
 <1477923567-1610-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <3fc032e5-cc23-ae7b-9f59-9c71c0a909b8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/16 16:19, Bartosz Golaszewski wrote:
> Revision 1 of the IP doesn't work if we don't load the palette (even
> if it's not used, which is the case for the RGB565 format).
> 
> Add a function called from tilcdc_crtc_enable() which performs all
> required actions if we're dealing with a rev1 chip.
> 

There is only one thing I do not like about this patch. The palette
loading is done so late that the frame buffer address are already placed
into DMA base and ceiling registers, and we need to read them from the
registers and restore them back after the palette loading.

Could you try if the palette loading function works without trouble when
called from tilcdc_pm_resume() before drm_atomic_helper_resume() call?
If it does it would be cleaner in the sense that you could get rid off
the old dma address restore code. You could reinit the completion always
there right before the palette loading.

If you can not get the above suggestion to work, then I can take this
patch.

BR,
Jyri

ps. There is one nit pick comment bellow.

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 88 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> index db2f538..937697d 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -21,11 +21,15 @@
>  #include <drm/drm_flip_work.h>
>  #include <drm/drm_plane_helper.h>
>  #include <linux/workqueue.h>
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
>  
>  #include "tilcdc_drv.h"
>  #include "tilcdc_regs.h"
>  
> -#define TILCDC_VBLANK_SAFETY_THRESHOLD_US 1000
> +#define TILCDC_VBLANK_SAFETY_THRESHOLD_US	1000
> +#define TILCDC_REV1_PALETTE_SIZE		32
> +#define TILCDC_REV1_PALETTE_FIRST_ENTRY		0x4000
>  
>  struct tilcdc_crtc {
>  	struct drm_crtc base;
> @@ -53,6 +57,10 @@ struct tilcdc_crtc {
>  
>  	int sync_lost_count;
>  	bool frame_intact;
> +
> +	dma_addr_t palette_dma_handle;
> +	void *palette_base;
> +	struct completion palette_loaded;
>  };
>  #define to_tilcdc_crtc(x) container_of(x, struct tilcdc_crtc, base)
>  
> @@ -98,6 +106,55 @@ static void set_scanout(struct drm_crtc *crtc, struct drm_framebuffer *fb)
>  	tilcdc_crtc->curr_fb = fb;
>  }
>  
> +/*
> + * The driver currently only supports the RGB565 format for revision 1. For
> + * 16 bits-per-pixel the palette block is bypassed, but the first 32 bytes of
> + * the framebuffer are still considered palette. The first 16-bit entry must
> + * be 0x4000 while all other entries must be zeroed.
> + */
> +static void tilcdc_crtc_load_palette(struct drm_crtc *crtc)
> +{
> +	u32 dma_fb_base, dma_fb_ceiling, raster_ctl;
> +	struct tilcdc_crtc *tilcdc_crtc;
> +	struct drm_device *dev;
> +	u16 *first_entry;
> +
> +	dev = crtc->dev;
> +	tilcdc_crtc = to_tilcdc_crtc(crtc);
> +	first_entry = tilcdc_crtc->palette_base;
> +
> +	*first_entry = TILCDC_REV1_PALETTE_FIRST_ENTRY;
> +
> +	dma_fb_base = tilcdc_read(dev, LCDC_DMA_FB_BASE_ADDR_0_REG);
> +	dma_fb_ceiling = tilcdc_read(dev, LCDC_DMA_FB_CEILING_ADDR_0_REG);
> +	raster_ctl = tilcdc_read(dev, LCDC_RASTER_CTRL_REG);
> +
> +	/* Tell the LCDC where the palette is located. */
> +	tilcdc_write(dev, LCDC_DMA_FB_BASE_ADDR_0_REG,
> +		     tilcdc_crtc->palette_dma_handle);
> +	tilcdc_write(dev, LCDC_DMA_FB_CEILING_ADDR_0_REG,
> +		     (u32)tilcdc_crtc->palette_dma_handle

Just a nit pick, but I would put the plus sign to the end of the line
above instead of the beginning of the line bellow. However,
check_patch.pl does not complain about this so I guess I can accept it too.

> +				+ TILCDC_REV1_PALETTE_SIZE - 1);
> +
> +	/* Load it. */
> +	tilcdc_clear(dev, LCDC_RASTER_CTRL_REG,
> +		     LCDC_PALETTE_LOAD_MODE(DATA_ONLY));
> +	tilcdc_set(dev, LCDC_RASTER_CTRL_REG,
> +		   LCDC_PALETTE_LOAD_MODE(PALETTE_ONLY));
> +
> +	/* Enable the LCDC and wait for palette to be loaded. */
> +	tilcdc_set(dev, LCDC_RASTER_CTRL_REG, LCDC_V1_PL_INT_ENA);
> +	tilcdc_set(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
> +
> +	wait_for_completion(&tilcdc_crtc->palette_loaded);
> +
> +	/* Restore the registers. */
> +	tilcdc_clear(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
> +	tilcdc_write(dev, LCDC_DMA_FB_BASE_ADDR_0_REG, dma_fb_base);
> +	tilcdc_write(dev, LCDC_DMA_FB_CEILING_ADDR_0_REG, dma_fb_ceiling);
> +	tilcdc_write(dev, LCDC_RASTER_CTRL_REG, raster_ctl);
> +}
> +
>  static void tilcdc_crtc_enable_irqs(struct drm_device *dev)
>  {
>  	struct tilcdc_drm_private *priv = dev->dev_private;
> @@ -152,6 +209,7 @@ static void tilcdc_crtc_enable(struct drm_crtc *crtc)
>  {
>  	struct drm_device *dev = crtc->dev;
>  	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> +	struct tilcdc_drm_private *priv = dev->dev_private;
>  
>  	WARN_ON(!drm_modeset_is_locked(&crtc->mutex));
>  
> @@ -162,6 +220,9 @@ static void tilcdc_crtc_enable(struct drm_crtc *crtc)
>  
>  	reset(crtc);
>  
> +	if (priv->rev == 1 && !completion_done(&tilcdc_crtc->palette_loaded))
> +		tilcdc_crtc_load_palette(crtc);
> +
>  	tilcdc_crtc_enable_irqs(dev);
>  
>  	tilcdc_clear(dev, LCDC_DMA_CTRL_REG, LCDC_DUAL_FRAME_BUFFER_ENABLE);
> @@ -200,6 +261,13 @@ void tilcdc_crtc_disable(struct drm_crtc *crtc)
>  				__func__);
>  	}
>  
> +	/*
> +	 * LCDC will not retain the palette when reset. Make sure it gets
> +	 * reloaded on tilcdc_crtc_enable().
> +	 */
> +	if (priv->rev == 1)
> +		reinit_completion(&tilcdc_crtc->palette_loaded);
> +
>  	drm_crtc_vblank_off(crtc);
>  
>  	tilcdc_crtc_disable_irqs(dev);
> @@ -802,6 +870,14 @@ irqreturn_t tilcdc_crtc_irq(struct drm_crtc *crtc)
>  		dev_err_ratelimited(dev->dev, "%s(0x%08x): FIFO underfow",
>  				    __func__, stat);
>  
> +	if (priv->rev == 1) {
> +		if (stat & LCDC_PL_LOAD_DONE) {
> +			complete(&tilcdc_crtc->palette_loaded);
> +			tilcdc_clear(dev,
> +				     LCDC_RASTER_CTRL_REG, LCDC_V1_PL_INT_ENA);
> +		}
> +	}
> +
>  	/* For revision 2 only */
>  	if (priv->rev == 2) {
>  		if (stat & LCDC_FRAME_DONE) {
> @@ -843,6 +919,16 @@ struct drm_crtc *tilcdc_crtc_create(struct drm_device *dev)
>  		return NULL;
>  	}
>  
> +	if (priv->rev == 1) {
> +		init_completion(&tilcdc_crtc->palette_loaded);
> +		tilcdc_crtc->palette_base = dmam_alloc_coherent(dev->dev,
> +					TILCDC_REV1_PALETTE_SIZE,
> +					&tilcdc_crtc->palette_dma_handle,
> +					GFP_KERNEL | __GFP_ZERO);
> +		if (!tilcdc_crtc->palette_base)
> +			return ERR_PTR(-ENOMEM);
> +	}
> +
>  	crtc = &tilcdc_crtc->base;
>  
>  	ret = tilcdc_plane_init(dev, &tilcdc_crtc->primary);
> 
