From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 5 Feb 2015 14:08:32 +0100
Subject: [PATCH] drm: atmel-hlcdc: Atomic mode-setting conversion
In-Reply-To: <1423081251-11062-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1423081251-11062-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150205130832.GU14009@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 09:20:51PM +0100, Boris Brezillon wrote:
> Convert the HLCDC driver to atomic mode-setting.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Just a quick comment: dpms isn't yet converted over, and from experience
with tegra/msm that probably will yield some surprises. Since only with
dpms will it be obvious how strict the added requirements from the atomic
helpers are ;-)
-Daniel

> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 142 ++----
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     |   4 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |   5 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c  |   4 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h  |   3 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c |   3 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c  | 556 +++++++++++++----------
>  7 files changed, 383 insertions(+), 334 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 0409b90..a69c966 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -114,25 +114,17 @@ static void atmel_hlcdc_crtc_dpms(struct drm_crtc *c, int mode)
>  	crtc->dpms = mode;
>  }
>  
> -static int atmel_hlcdc_crtc_mode_set(struct drm_crtc *c,
> -				     struct drm_display_mode *mode,
> -				     struct drm_display_mode *adj,
> -				     int x, int y,
> -				     struct drm_framebuffer *old_fb)
> +static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  {
>  	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
>  	struct regmap *regmap = crtc->dc->hlcdc->regmap;
> -	struct drm_plane *plane = c->primary;
> -	struct drm_framebuffer *fb;
> +	struct drm_display_mode *adj = &c->state->adjusted_mode;
>  	unsigned long mode_rate;
>  	struct videomode vm;
>  	unsigned long prate;
>  	unsigned int cfg;
>  	int div;
>  
> -	if (atmel_hlcdc_dc_mode_valid(crtc->dc, adj) != MODE_OK)
> -		return -EINVAL;
> -
>  	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
>  	vm.vback_porch = adj->crtc_vtotal - adj->crtc_vsync_end;
>  	vm.vsync_len = adj->crtc_vsync_end - adj->crtc_vsync_start;
> @@ -156,7 +148,7 @@ static int atmel_hlcdc_crtc_mode_set(struct drm_crtc *c,
>  	cfg = ATMEL_HLCDC_CLKPOL;
>  
>  	prate = clk_get_rate(crtc->dc->hlcdc->sys_clk);
> -	mode_rate = mode->crtc_clock * 1000;
> +	mode_rate = adj->crtc_clock * 1000;
>  	if ((prate / 2) < mode_rate) {
>  		prate *= 2;
>  		cfg |= ATMEL_HLCDC_CLKSEL;
> @@ -174,10 +166,10 @@ static int atmel_hlcdc_crtc_mode_set(struct drm_crtc *c,
>  
>  	cfg = 0;
>  
> -	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> +	if (adj->flags & DRM_MODE_FLAG_NVSYNC)
>  		cfg |= ATMEL_HLCDC_VSPOL;
>  
> -	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> +	if (adj->flags & DRM_MODE_FLAG_NHSYNC)
>  		cfg |= ATMEL_HLCDC_HSPOL;
>  
>  	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(5),
> @@ -187,34 +179,6 @@ static int atmel_hlcdc_crtc_mode_set(struct drm_crtc *c,
>  			   ATMEL_HLCDC_VSPSU | ATMEL_HLCDC_VSPHO |
>  			   ATMEL_HLCDC_GUARDTIME_MASK,
>  			   cfg);
> -
> -	fb = plane->fb;
> -	plane->fb = old_fb;
> -
> -	return atmel_hlcdc_plane_update_with_mode(plane, c, fb, 0, 0,
> -						  adj->hdisplay, adj->vdisplay,
> -						  x << 16, y << 16,
> -						  adj->hdisplay << 16,
> -						  adj->vdisplay << 16,
> -						  adj);
> -}
> -
> -int atmel_hlcdc_crtc_mode_set_base(struct drm_crtc *c, int x, int y,
> -				   struct drm_framebuffer *old_fb)
> -{
> -	struct drm_plane *plane = c->primary;
> -	struct drm_framebuffer *fb = plane->fb;
> -	struct drm_display_mode *mode = &c->hwmode;
> -
> -	plane->fb = old_fb;
> -
> -	return plane->funcs->update_plane(plane, c, fb,
> -					  0, 0,
> -					  mode->hdisplay,
> -					  mode->vdisplay,
> -					  x << 16, y << 16,
> -					  mode->hdisplay << 16,
> -					  mode->vdisplay << 16);
>  }
>  
>  static void atmel_hlcdc_crtc_prepare(struct drm_crtc *crtc)
> @@ -250,14 +214,48 @@ static void atmel_hlcdc_crtc_disable(struct drm_crtc *crtc)
>  	}
>  }
>  
> +static int atmel_hlcdc_crtc_atomic_check(struct drm_crtc *c,
> +					 struct drm_crtc_state *s)
> +{
> +	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
> +
> +	if (atmel_hlcdc_dc_mode_valid(crtc->dc, &s->adjusted_mode) != MODE_OK)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void atmel_hlcdc_crtc_atomic_begin(struct drm_crtc *c)
> +{
> +	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
> +
> +	if (c->state->event) {
> +		c->state->event->pipe = drm_crtc_index(c);
> +
> +		WARN_ON(drm_crtc_vblank_get(c) != 0);
> +
> +		crtc->event = c->state->event;
> +		c->state->event = NULL;
> +	}
> +}
> +
> +static void atmel_hlcdc_crtc_atomic_flush(struct drm_crtc *crtc)
> +{
> +	/* TODO: write common plane control register if available */
> +}
> +
>  static const struct drm_crtc_helper_funcs lcdc_crtc_helper_funcs = {
>  	.mode_fixup = atmel_hlcdc_crtc_mode_fixup,
>  	.dpms = atmel_hlcdc_crtc_dpms,
> -	.mode_set = atmel_hlcdc_crtc_mode_set,
> -	.mode_set_base = atmel_hlcdc_crtc_mode_set_base,
> +	.mode_set = drm_helper_crtc_mode_set,
> +	.mode_set_nofb = atmel_hlcdc_crtc_mode_set_nofb,
> +	.mode_set_base = drm_helper_crtc_mode_set_base,
>  	.prepare = atmel_hlcdc_crtc_prepare,
>  	.commit = atmel_hlcdc_crtc_commit,
>  	.disable = atmel_hlcdc_crtc_disable,
> +	.atomic_check = atmel_hlcdc_crtc_atomic_check,
> +	.atomic_begin = atmel_hlcdc_crtc_atomic_begin,
> +	.atomic_flush = atmel_hlcdc_crtc_atomic_flush,
>  };
>  
>  static void atmel_hlcdc_crtc_destroy(struct drm_crtc *c)
> @@ -306,61 +304,13 @@ void atmel_hlcdc_crtc_irq(struct drm_crtc *c)
>  	atmel_hlcdc_crtc_finish_page_flip(drm_crtc_to_atmel_hlcdc_crtc(c));
>  }
>  
> -static int atmel_hlcdc_crtc_page_flip(struct drm_crtc *c,
> -				      struct drm_framebuffer *fb,
> -				      struct drm_pending_vblank_event *event,
> -				      uint32_t page_flip_flags)
> -{
> -	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
> -	struct atmel_hlcdc_plane_update_req req;
> -	struct drm_plane *plane = c->primary;
> -	struct drm_device *dev = c->dev;
> -	unsigned long flags;
> -	int ret = 0;
> -
> -	spin_lock_irqsave(&dev->event_lock, flags);
> -	if (crtc->event)
> -		ret = -EBUSY;
> -	spin_unlock_irqrestore(&dev->event_lock, flags);
> -
> -	if (ret)
> -		return ret;
> -
> -	memset(&req, 0, sizeof(req));
> -	req.crtc_x = 0;
> -	req.crtc_y = 0;
> -	req.crtc_h = c->mode.crtc_vdisplay;
> -	req.crtc_w = c->mode.crtc_hdisplay;
> -	req.src_x = c->x << 16;
> -	req.src_y = c->y << 16;
> -	req.src_w = req.crtc_w << 16;
> -	req.src_h = req.crtc_h << 16;
> -	req.fb = fb;
> -
> -	ret = atmel_hlcdc_plane_prepare_update_req(plane, &req, &c->hwmode);
> -	if (ret)
> -		return ret;
> -
> -	if (event) {
> -		drm_vblank_get(c->dev, crtc->id);
> -		spin_lock_irqsave(&dev->event_lock, flags);
> -		crtc->event = event;
> -		spin_unlock_irqrestore(&dev->event_lock, flags);
> -	}
> -
> -	ret = atmel_hlcdc_plane_apply_update_req(plane, &req);
> -	if (ret)
> -		crtc->event = NULL;
> -	else
> -		plane->fb = fb;
> -
> -	return ret;
> -}
> -
>  static const struct drm_crtc_funcs atmel_hlcdc_crtc_funcs = {
> -	.page_flip = atmel_hlcdc_crtc_page_flip,
> -	.set_config = drm_crtc_helper_set_config,
> +	.page_flip = drm_atomic_helper_page_flip,
> +	.set_config = drm_atomic_helper_set_config,
>  	.destroy = atmel_hlcdc_crtc_destroy,
> +	.reset = drm_atomic_helper_crtc_reset,
> +	.atomic_duplicate_state =  drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
>  };
>  
>  int atmel_hlcdc_crtc_create(struct drm_device *dev)
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 7320a6c..47fd147 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -222,6 +222,8 @@ static void atmel_hlcdc_fb_output_poll_changed(struct drm_device *dev)
>  static const struct drm_mode_config_funcs mode_config_funcs = {
>  	.fb_create = atmel_hlcdc_fb_create,
>  	.output_poll_changed = atmel_hlcdc_fb_output_poll_changed,
> +	.atomic_check = drm_atomic_helper_check,
> +	.atomic_commit = drm_atomic_helper_commit,
>  };
>  
>  static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
> @@ -319,6 +321,8 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>  		goto err_periph_clk_disable;
>  	}
>  
> +	drm_mode_config_reset(dev);
> +
>  	ret = drm_vblank_init(dev, 1);
>  	if (ret < 0) {
>  		dev_err(dev->dev, "failed to initialize vblank\n");
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index 7bc96af..c18da22 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -26,11 +26,14 @@
>  #include <linux/irqdomain.h>
>  #include <linux/pwm.h>
>  
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_panel.h>
> +#include <drm/drm_plane_helper.h>
>  #include <drm/drmP.h>
>  
>  #include "atmel_hlcdc_layer.h"
> @@ -69,7 +72,6 @@ struct atmel_hlcdc_dc_desc {
>   */
>  struct atmel_hlcdc_plane_properties {
>  	struct drm_property *alpha;
> -	struct drm_property *rotation;
>  };
>  
>  /**
> @@ -84,7 +86,6 @@ struct atmel_hlcdc_plane {
>  	struct drm_plane base;
>  	struct atmel_hlcdc_layer layer;
>  	struct atmel_hlcdc_plane_properties *properties;
> -	unsigned int rotation;
>  };
>  
>  static inline struct atmel_hlcdc_plane *
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
> index 063d2a7..d1dca39 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
> @@ -298,7 +298,7 @@ void atmel_hlcdc_layer_irq(struct atmel_hlcdc_layer *layer)
>  	spin_unlock_irqrestore(&layer->lock, flags);
>  }
>  
> -int atmel_hlcdc_layer_disable(struct atmel_hlcdc_layer *layer)
> +void atmel_hlcdc_layer_disable(struct atmel_hlcdc_layer *layer)
>  {
>  	struct atmel_hlcdc_layer_dma_channel *dma = &layer->dma;
>  	struct atmel_hlcdc_layer_update *upd = &layer->update;
> @@ -340,8 +340,6 @@ int atmel_hlcdc_layer_disable(struct atmel_hlcdc_layer *layer)
>  	dma->status = ATMEL_HLCDC_LAYER_DISABLED;
>  
>  	spin_unlock_irqrestore(&layer->lock, flags);
> -
> -	return 0;
>  }
>  
>  int atmel_hlcdc_layer_update_start(struct atmel_hlcdc_layer *layer)
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
> index 27e56c0..9beabc9 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
> @@ -120,6 +120,7 @@
>  #define ATMEL_HLCDC_LAYER_DISCEN		BIT(11)
>  #define ATMEL_HLCDC_LAYER_GA_SHIFT		16
>  #define ATMEL_HLCDC_LAYER_GA_MASK		GENMASK(23, ATMEL_HLCDC_LAYER_GA_SHIFT)
> +#define ATMEL_HLCDC_LAYER_GA(x)			((x) << ATMEL_HLCDC_LAYER_GA_SHIFT)
>  
>  #define ATMEL_HLCDC_LAYER_CSC_CFG(p, o)		ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.csc + o)
>  
> @@ -376,7 +377,7 @@ int atmel_hlcdc_layer_init(struct drm_device *dev,
>  void atmel_hlcdc_layer_cleanup(struct drm_device *dev,
>  			       struct atmel_hlcdc_layer *layer);
>  
> -int atmel_hlcdc_layer_disable(struct atmel_hlcdc_layer *layer);
> +void atmel_hlcdc_layer_disable(struct atmel_hlcdc_layer *layer);
>  
>  int atmel_hlcdc_layer_update_start(struct atmel_hlcdc_layer *layer);
>  
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> index b049f22..1e814c7 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> @@ -234,6 +234,9 @@ static const struct drm_connector_funcs atmel_hlcdc_panel_connector_funcs = {
>  	.detect = atmel_hlcdc_panel_connector_detect,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = atmel_hlcdc_panel_connector_destroy,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
>  static int atmel_hlcdc_create_panel_output(struct drm_device *dev,
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index c5892dc..4aa473c 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -19,6 +19,52 @@
>  
>  #include "atmel_hlcdc_dc.h"
>  
> +/**
> + * Atmel HLCDC Plane state structure.
> + *
> + * @base: DRM plane state
> + * @crtc_x: x position of the plane relative to the CRTC
> + * @crtc_y: y position of the plane relative to the CRTC
> + * @crtc_w: visible width of the plane
> + * @crtc_h: visible height of the plane
> + * @src_x: x buffer position
> + * @src_y: y buffer position
> + * @src_w: buffer width
> + * @src_h: buffer height
> + * @alpha: alpha blending of the plane
> + * @bpp: bytes per pixel deduced from pixel_format
> + * @offsets: offsets to apply to the GEM buffers
> + * @xstride: value to add to the pixel pointer between each line
> + * @pstride: value to add to the pixel pointer between each pixel
> + * @nplanes: number of planes (deduced from pixel_format)
> + */
> +struct atmel_hlcdc_plane_state {
> +	struct drm_plane_state base;
> +	int crtc_x;
> +	int crtc_y;
> +	unsigned int crtc_w;
> +	unsigned int crtc_h;
> +	uint32_t src_x;
> +	uint32_t src_y;
> +	uint32_t src_w;
> +	uint32_t src_h;
> +
> +	u8 alpha;
> +
> +	/* These fields are private and should not be touched */
> +	int bpp[ATMEL_HLCDC_MAX_PLANES];
> +	unsigned int offsets[ATMEL_HLCDC_MAX_PLANES];
> +	int xstride[ATMEL_HLCDC_MAX_PLANES];
> +	int pstride[ATMEL_HLCDC_MAX_PLANES];
> +	int nplanes;
> +};
> +
> +static inline struct atmel_hlcdc_plane_state *
> +drm_plane_state_to_atmel_hlcdc_plane_state(struct drm_plane_state *s)
> +{
> +	return container_of(s, struct atmel_hlcdc_plane_state, base);
> +}
> +
>  #define SUBPIXEL_MASK			0xffff
>  
>  static uint32_t rgb_formats[] = {
> @@ -128,7 +174,7 @@ static int atmel_hlcdc_format_to_plane_mode(u32 format, u32 *mode)
>  	return 0;
>  }
>  
> -static bool atmel_hlcdc_format_embedds_alpha(u32 format)
> +static bool atmel_hlcdc_format_embeds_alpha(u32 format)
>  {
>  	int i;
>  
> @@ -204,7 +250,7 @@ static u32 heo_upscaling_ycoef[] = {
>  
>  static void
>  atmel_hlcdc_plane_update_pos_and_size(struct atmel_hlcdc_plane *plane,
> -				struct atmel_hlcdc_plane_update_req *req)
> +				      struct atmel_hlcdc_plane_state *state)
>  {
>  	const struct atmel_hlcdc_layer_cfg_layout *layout =
>  						&plane->layer.desc->layout;
> @@ -213,69 +259,69 @@ atmel_hlcdc_plane_update_pos_and_size(struct atmel_hlcdc_plane *plane,
>  		atmel_hlcdc_layer_update_cfg(&plane->layer,
>  					     layout->size,
>  					     0xffffffff,
> -					     (req->crtc_w - 1) |
> -					     ((req->crtc_h - 1) << 16));
> +					     (state->crtc_w - 1) |
> +					     ((state->crtc_h - 1) << 16));
>  
>  	if (layout->memsize)
>  		atmel_hlcdc_layer_update_cfg(&plane->layer,
>  					     layout->memsize,
>  					     0xffffffff,
> -					     (req->src_w - 1) |
> -					     ((req->src_h - 1) << 16));
> +					     (state->src_w - 1) |
> +					     ((state->src_h - 1) << 16));
>  
>  	if (layout->pos)
>  		atmel_hlcdc_layer_update_cfg(&plane->layer,
>  					     layout->pos,
>  					     0xffffffff,
> -					     req->crtc_x |
> -					     (req->crtc_y  << 16));
> +					     state->crtc_x |
> +					     (state->crtc_y  << 16));
>  
>  	/* TODO: rework the rescaling part */
> -	if (req->crtc_w != req->src_w || req->crtc_h != req->src_h) {
> +	if (state->crtc_w != state->src_w || state->crtc_h != state->src_h) {
>  		u32 factor_reg = 0;
>  
> -		if (req->crtc_w != req->src_w) {
> +		if (state->crtc_w != state->src_w) {
>  			int i;
>  			u32 factor;
>  			u32 *coeff_tab = heo_upscaling_xcoef;
>  			u32 max_memsize;
>  
> -			if (req->crtc_w < req->src_w)
> +			if (state->crtc_w < state->src_w)
>  				coeff_tab = heo_downscaling_xcoef;
>  			for (i = 0; i < ARRAY_SIZE(heo_upscaling_xcoef); i++)
>  				atmel_hlcdc_layer_update_cfg(&plane->layer,
>  							     17 + i,
>  							     0xffffffff,
>  							     coeff_tab[i]);
> -			factor = ((8 * 256 * req->src_w) - (256 * 4)) /
> -				 req->crtc_w;
> +			factor = ((8 * 256 * state->src_w) - (256 * 4)) /
> +				 state->crtc_w;
>  			factor++;
> -			max_memsize = ((factor * req->crtc_w) + (256 * 4)) /
> +			max_memsize = ((factor * state->crtc_w) + (256 * 4)) /
>  				      2048;
> -			if (max_memsize > req->src_w)
> +			if (max_memsize > state->src_w)
>  				factor--;
>  			factor_reg |= factor | 0x80000000;
>  		}
>  
> -		if (req->crtc_h != req->src_h) {
> +		if (state->crtc_h != state->src_h) {
>  			int i;
>  			u32 factor;
>  			u32 *coeff_tab = heo_upscaling_ycoef;
>  			u32 max_memsize;
>  
> -			if (req->crtc_w < req->src_w)
> +			if (state->crtc_w < state->src_w)
>  				coeff_tab = heo_downscaling_ycoef;
>  			for (i = 0; i < ARRAY_SIZE(heo_upscaling_ycoef); i++)
>  				atmel_hlcdc_layer_update_cfg(&plane->layer,
>  							     33 + i,
>  							     0xffffffff,
>  							     coeff_tab[i]);
> -			factor = ((8 * 256 * req->src_w) - (256 * 4)) /
> -				 req->crtc_w;
> +			factor = ((8 * 256 * state->src_w) - (256 * 4)) /
> +				 state->crtc_w;
>  			factor++;
> -			max_memsize = ((factor * req->crtc_w) + (256 * 4)) /
> +			max_memsize = ((factor * state->crtc_w) + (256 * 4)) /
>  				      2048;
> -			if (max_memsize > req->src_w)
> +			if (max_memsize > state->src_w)
>  				factor--;
>  			factor_reg |= (factor << 16) | 0x80000000;
>  		}
> @@ -287,7 +333,7 @@ atmel_hlcdc_plane_update_pos_and_size(struct atmel_hlcdc_plane *plane,
>  
>  static void
>  atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
> -				struct atmel_hlcdc_plane_update_req *req)
> +					struct atmel_hlcdc_plane_state *state)
>  {
>  	const struct atmel_hlcdc_layer_cfg_layout *layout =
>  						&plane->layer.desc->layout;
> @@ -297,10 +343,11 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
>  		cfg |= ATMEL_HLCDC_LAYER_OVR | ATMEL_HLCDC_LAYER_ITER2BL |
>  		       ATMEL_HLCDC_LAYER_ITER;
>  
> -		if (atmel_hlcdc_format_embedds_alpha(req->fb->pixel_format))
> +		if (atmel_hlcdc_format_embeds_alpha(state->base.fb->pixel_format))
>  			cfg |= ATMEL_HLCDC_LAYER_LAEN;
>  		else
> -			cfg |= ATMEL_HLCDC_LAYER_GAEN;
> +			cfg |= ATMEL_HLCDC_LAYER_GAEN |
> +			       ATMEL_HLCDC_LAYER_GA(state->alpha);
>  	}
>  
>  	atmel_hlcdc_layer_update_cfg(&plane->layer,
> @@ -312,24 +359,26 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
>  				     ATMEL_HLCDC_LAYER_ITER2BL |
>  				     ATMEL_HLCDC_LAYER_ITER |
>  				     ATMEL_HLCDC_LAYER_GAEN |
> +				     ATMEL_HLCDC_LAYER_GA_MASK |
>  				     ATMEL_HLCDC_LAYER_LAEN |
>  				     ATMEL_HLCDC_LAYER_OVR |
>  				     ATMEL_HLCDC_LAYER_DMA, cfg);
>  }
>  
>  static void atmel_hlcdc_plane_update_format(struct atmel_hlcdc_plane *plane,
> -				struct atmel_hlcdc_plane_update_req *req)
> +					struct atmel_hlcdc_plane_state *state)
>  {
>  	u32 cfg;
>  	int ret;
>  
> -	ret = atmel_hlcdc_format_to_plane_mode(req->fb->pixel_format, &cfg);
> +	ret = atmel_hlcdc_format_to_plane_mode(state->base.fb->pixel_format,
> +					       &cfg);
>  	if (ret)
>  		return;
>  
> -	if ((req->fb->pixel_format == DRM_FORMAT_YUV422 ||
> -	     req->fb->pixel_format == DRM_FORMAT_NV61) &&
> -	    (plane->rotation & (BIT(DRM_ROTATE_90) | BIT(DRM_ROTATE_270))))
> +	if ((state->base.fb->pixel_format == DRM_FORMAT_YUV422 ||
> +	     state->base.fb->pixel_format == DRM_FORMAT_NV61) &&
> +	    (state->base.rotation & (BIT(DRM_ROTATE_90) | BIT(DRM_ROTATE_270))))
>  		cfg |= ATMEL_HLCDC_YUV422ROT;
>  
>  	atmel_hlcdc_layer_update_cfg(&plane->layer,
> @@ -341,7 +390,7 @@ static void atmel_hlcdc_plane_update_format(struct atmel_hlcdc_plane *plane,
>  	 * Rotation optimization is not working on RGB888 (rotation is still
>  	 * working but without any optimization).
>  	 */
> -	if (req->fb->pixel_format == DRM_FORMAT_RGB888)
> +	if (state->base.fb->pixel_format == DRM_FORMAT_RGB888)
>  		cfg = ATMEL_HLCDC_LAYER_DMA_ROTDIS;
>  	else
>  		cfg = 0;
> @@ -352,73 +401,44 @@ static void atmel_hlcdc_plane_update_format(struct atmel_hlcdc_plane *plane,
>  }
>  
>  static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
> -				struct atmel_hlcdc_plane_update_req *req)
> +					struct atmel_hlcdc_plane_state *state)
>  {
>  	struct atmel_hlcdc_layer *layer = &plane->layer;
>  	const struct atmel_hlcdc_layer_cfg_layout *layout =
>  							&layer->desc->layout;
>  	int i;
>  
> -	atmel_hlcdc_layer_update_set_fb(&plane->layer, req->fb, req->offsets);
> +	atmel_hlcdc_layer_update_set_fb(&plane->layer, state->base.fb,
> +					state->offsets);
>  
> -	for (i = 0; i < req->nplanes; i++) {
> +	for (i = 0; i < state->nplanes; i++) {
>  		if (layout->xstride[i]) {
>  			atmel_hlcdc_layer_update_cfg(&plane->layer,
>  						layout->xstride[i],
>  						0xffffffff,
> -						req->xstride[i]);
> +						state->xstride[i]);
>  		}
>  
>  		if (layout->pstride[i]) {
>  			atmel_hlcdc_layer_update_cfg(&plane->layer,
>  						layout->pstride[i],
>  						0xffffffff,
> -						req->pstride[i]);
> +						state->pstride[i]);
>  		}
>  	}
>  }
>  
> -static int atmel_hlcdc_plane_check_update_req(struct drm_plane *p,
> -				struct atmel_hlcdc_plane_update_req *req,
> -				const struct drm_display_mode *mode)
> +static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
> +					  struct drm_plane_state *s)
>  {
>  	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> +	struct atmel_hlcdc_plane_state *state =
> +				drm_plane_state_to_atmel_hlcdc_plane_state(s);
>  	const struct atmel_hlcdc_layer_cfg_layout *layout =
>  						&plane->layer.desc->layout;
> -
> -	if (!layout->size &&
> -	    (mode->hdisplay != req->crtc_w ||
> -	     mode->vdisplay != req->crtc_h))
> -		return -EINVAL;
> -
> -	if (plane->layer.desc->max_height &&
> -	    req->crtc_h > plane->layer.desc->max_height)
> -		return -EINVAL;
> -
> -	if (plane->layer.desc->max_width &&
> -	    req->crtc_w > plane->layer.desc->max_width)
> -		return -EINVAL;
> -
> -	if ((req->crtc_h != req->src_h || req->crtc_w != req->src_w) &&
> -	    (!layout->memsize ||
> -	     atmel_hlcdc_format_embedds_alpha(req->fb->pixel_format)))
> -		return -EINVAL;
> -
> -	if (req->crtc_x < 0 || req->crtc_y < 0)
> -		return -EINVAL;
> -
> -	if (req->crtc_w + req->crtc_x > mode->hdisplay ||
> -	    req->crtc_h + req->crtc_y > mode->vdisplay)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -int atmel_hlcdc_plane_prepare_update_req(struct drm_plane *p,
> -				struct atmel_hlcdc_plane_update_req *req,
> -				const struct drm_display_mode *mode)
> -{
> -	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> +	struct drm_framebuffer *fb = state->base.fb;
> +	const struct drm_display_mode *mode;
> +	struct drm_crtc_state *crtc_state;
>  	unsigned int patched_crtc_w;
>  	unsigned int patched_crtc_h;
>  	unsigned int patched_src_w;
> @@ -430,196 +450,202 @@ int atmel_hlcdc_plane_prepare_update_req(struct drm_plane *p,
>  	int vsub = 1;
>  	int i;
>  
> -	if ((req->src_x | req->src_y | req->src_w | req->src_h) &
> +	if (!state->base.crtc || !fb)
> +		return 0;
> +
> +	crtc_state = s->state->crtc_states[drm_crtc_index(s->crtc)];
> +	mode = &crtc_state->adjusted_mode;
> +
> +	state->src_x = s->src_x;
> +	state->src_y = s->src_y;
> +	state->src_h = s->src_h;
> +	state->src_w = s->src_w;
> +	state->crtc_x = s->crtc_x;
> +	state->crtc_y = s->crtc_y;
> +	state->crtc_h = s->crtc_h;
> +	state->crtc_w = s->crtc_w;
> +	if ((state->src_x | state->src_y | state->src_w | state->src_h) &
>  	    SUBPIXEL_MASK)
>  		return -EINVAL;
>  
> -	req->src_x >>= 16;
> -	req->src_y >>= 16;
> -	req->src_w >>= 16;
> -	req->src_h >>= 16;
> +	state->src_x >>= 16;
> +	state->src_y >>= 16;
> +	state->src_w >>= 16;
> +	state->src_h >>= 16;
>  
> -	req->nplanes = drm_format_num_planes(req->fb->pixel_format);
> -	if (req->nplanes > ATMEL_HLCDC_MAX_PLANES)
> +	state->nplanes = drm_format_num_planes(fb->pixel_format);
> +	if (state->nplanes > ATMEL_HLCDC_MAX_PLANES)
>  		return -EINVAL;
>  
>  	/*
>  	 * Swap width and size in case of 90 or 270 degrees rotation
>  	 */
> -	if (plane->rotation & (BIT(DRM_ROTATE_90) | BIT(DRM_ROTATE_270))) {
> -		tmp = req->crtc_w;
> -		req->crtc_w = req->crtc_h;
> -		req->crtc_h = tmp;
> -		tmp = req->src_w;
> -		req->src_w = req->src_h;
> -		req->src_h = tmp;
> +	if (state->base.rotation & (BIT(DRM_ROTATE_90) | BIT(DRM_ROTATE_270))) {
> +		tmp = state->crtc_w;
> +		state->crtc_w = state->crtc_h;
> +		state->crtc_h = tmp;
> +		tmp = state->src_w;
> +		state->src_w = state->src_h;
> +		state->src_h = tmp;
>  	}
>  
> -	if (req->crtc_x + req->crtc_w > mode->hdisplay)
> -		patched_crtc_w = mode->hdisplay - req->crtc_x;
> +	if (state->crtc_x + state->crtc_w > mode->hdisplay)
> +		patched_crtc_w = mode->hdisplay - state->crtc_x;
>  	else
> -		patched_crtc_w = req->crtc_w;
> +		patched_crtc_w = state->crtc_w;
>  
> -	if (req->crtc_x < 0) {
> -		patched_crtc_w += req->crtc_x;
> -		x_offset = -req->crtc_x;
> -		req->crtc_x = 0;
> +	if (state->crtc_x < 0) {
> +		patched_crtc_w += state->crtc_x;
> +		x_offset = -state->crtc_x;
> +		state->crtc_x = 0;
>  	}
>  
> -	if (req->crtc_y + req->crtc_h > mode->vdisplay)
> -		patched_crtc_h = mode->vdisplay - req->crtc_y;
> +	if (state->crtc_y + state->crtc_h > mode->vdisplay)
> +		patched_crtc_h = mode->vdisplay - state->crtc_y;
>  	else
> -		patched_crtc_h = req->crtc_h;
> +		patched_crtc_h = state->crtc_h;
>  
> -	if (req->crtc_y < 0) {
> -		patched_crtc_h += req->crtc_y;
> -		y_offset = -req->crtc_y;
> -		req->crtc_y = 0;
> +	if (state->crtc_y < 0) {
> +		patched_crtc_h += state->crtc_y;
> +		y_offset = -state->crtc_y;
> +		state->crtc_y = 0;
>  	}
>  
> -	patched_src_w = DIV_ROUND_CLOSEST(patched_crtc_w * req->src_w,
> -					  req->crtc_w);
> -	patched_src_h = DIV_ROUND_CLOSEST(patched_crtc_h * req->src_h,
> -					  req->crtc_h);
> +	patched_src_w = DIV_ROUND_CLOSEST(patched_crtc_w * state->src_w,
> +					  state->crtc_w);
> +	patched_src_h = DIV_ROUND_CLOSEST(patched_crtc_h * state->src_h,
> +					  state->crtc_h);
>  
> -	hsub = drm_format_horz_chroma_subsampling(req->fb->pixel_format);
> -	vsub = drm_format_vert_chroma_subsampling(req->fb->pixel_format);
> +	hsub = drm_format_horz_chroma_subsampling(fb->pixel_format);
> +	vsub = drm_format_vert_chroma_subsampling(fb->pixel_format);
>  
> -	for (i = 0; i < req->nplanes; i++) {
> +	for (i = 0; i < state->nplanes; i++) {
>  		unsigned int offset = 0;
>  		int xdiv = i ? hsub : 1;
>  		int ydiv = i ? vsub : 1;
>  
> -		req->bpp[i] = drm_format_plane_cpp(req->fb->pixel_format, i);
> -		if (!req->bpp[i])
> +		state->bpp[i] = drm_format_plane_cpp(fb->pixel_format, i);
> +		if (!state->bpp[i])
>  			return -EINVAL;
>  
> -		switch (plane->rotation & 0xf) {
> +		switch (state->base.rotation & 0xf) {
>  		case BIT(DRM_ROTATE_90):
> -			offset = ((y_offset + req->src_y + patched_src_w - 1) /
> -				  ydiv) * req->fb->pitches[i];
> -			offset += ((x_offset + req->src_x) / xdiv) *
> -				  req->bpp[i];
> -			req->xstride[i] = ((patched_src_w - 1) / ydiv) *
> -					  req->fb->pitches[i];
> -			req->pstride[i] = -req->fb->pitches[i] - req->bpp[i];
> +			offset = ((y_offset + state->src_y + patched_src_w - 1) /
> +				  ydiv) * fb->pitches[i];
> +			offset += ((x_offset + state->src_x) / xdiv) *
> +				  state->bpp[i];
> +			state->xstride[i] = ((patched_src_w - 1) / ydiv) *
> +					  fb->pitches[i];
> +			state->pstride[i] = -fb->pitches[i] - state->bpp[i];
>  			break;
>  		case BIT(DRM_ROTATE_180):
> -			offset = ((y_offset + req->src_y + patched_src_h - 1) /
> -				  ydiv) * req->fb->pitches[i];
> -			offset += ((x_offset + req->src_x + patched_src_w - 1) /
> -				   xdiv) * req->bpp[i];
> -			req->xstride[i] = ((((patched_src_w - 1) / xdiv) - 1) *
> -					   req->bpp[i]) - req->fb->pitches[i];
> -			req->pstride[i] = -2 * req->bpp[i];
> +			offset = ((y_offset + state->src_y + patched_src_h - 1) /
> +				  ydiv) * fb->pitches[i];
> +			offset += ((x_offset + state->src_x + patched_src_w - 1) /
> +				   xdiv) * state->bpp[i];
> +			state->xstride[i] = ((((patched_src_w - 1) / xdiv) - 1) *
> +					   state->bpp[i]) - fb->pitches[i];
> +			state->pstride[i] = -2 * state->bpp[i];
>  			break;
>  		case BIT(DRM_ROTATE_270):
> -			offset = ((y_offset + req->src_y) / ydiv) *
> -				 req->fb->pitches[i];
> -			offset += ((x_offset + req->src_x + patched_src_h - 1) /
> -				   xdiv) * req->bpp[i];
> -			req->xstride[i] = -(((patched_src_w - 1) / ydiv) *
> -					    req->fb->pitches[i]) -
> -					  (2 * req->bpp[i]);
> -			req->pstride[i] = req->fb->pitches[i] - req->bpp[i];
> +			offset = ((y_offset + state->src_y) / ydiv) *
> +				 fb->pitches[i];
> +			offset += ((x_offset + state->src_x + patched_src_h - 1) /
> +				   xdiv) * state->bpp[i];
> +			state->xstride[i] = -(((patched_src_w - 1) / ydiv) *
> +					    fb->pitches[i]) -
> +					  (2 * state->bpp[i]);
> +			state->pstride[i] = fb->pitches[i] - state->bpp[i];
>  			break;
>  		case BIT(DRM_ROTATE_0):
>  		default:
> -			offset = ((y_offset + req->src_y) / ydiv) *
> -				 req->fb->pitches[i];
> -			offset += ((x_offset + req->src_x) / xdiv) *
> -				  req->bpp[i];
> -			req->xstride[i] = req->fb->pitches[i] -
> +			offset = ((y_offset + state->src_y) / ydiv) *
> +				 fb->pitches[i];
> +			offset += ((x_offset + state->src_x) / xdiv) *
> +				  state->bpp[i];
> +			state->xstride[i] = fb->pitches[i] -
>  					  ((patched_src_w / xdiv) *
> -					   req->bpp[i]);
> -			req->pstride[i] = 0;
> +					   state->bpp[i]);
> +			state->pstride[i] = 0;
>  			break;
>  		}
>  
> -		req->offsets[i] = offset + req->fb->offsets[i];
> +		state->offsets[i] = offset + fb->offsets[i];
>  	}
>  
> -	req->src_w = patched_src_w;
> -	req->src_h = patched_src_h;
> -	req->crtc_w = patched_crtc_w;
> -	req->crtc_h = patched_crtc_h;
> +	state->src_w = patched_src_w;
> +	state->src_h = patched_src_h;
> +	state->crtc_w = patched_crtc_w;
> +	state->crtc_h = patched_crtc_h;
>  
> -	return atmel_hlcdc_plane_check_update_req(p, req, mode);
> -}
> +	if (!layout->size &&
> +	    (mode->hdisplay != state->crtc_w ||
> +	     mode->vdisplay != state->crtc_h))
> +		return -EINVAL;
>  
> -int atmel_hlcdc_plane_apply_update_req(struct drm_plane *p,
> -				struct atmel_hlcdc_plane_update_req *req)
> -{
> -	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> -	int ret;
> +	if (plane->layer.desc->max_height &&
> +	    state->crtc_h > plane->layer.desc->max_height)
> +		return -EINVAL;
>  
> -	ret = atmel_hlcdc_layer_update_start(&plane->layer);
> -	if (ret)
> -		return ret;
> +	if (plane->layer.desc->max_width &&
> +	    state->crtc_w > plane->layer.desc->max_width)
> +		return -EINVAL;
>  
> -	atmel_hlcdc_plane_update_pos_and_size(plane, req);
> -	atmel_hlcdc_plane_update_general_settings(plane, req);
> -	atmel_hlcdc_plane_update_format(plane, req);
> -	atmel_hlcdc_plane_update_buffers(plane, req);
> +	if ((state->crtc_h != state->src_h || state->crtc_w != state->src_w) &&
> +	    (!layout->memsize ||
> +	     atmel_hlcdc_format_embeds_alpha(state->base.fb->pixel_format)))
> +		return -EINVAL;
>  
> -	atmel_hlcdc_layer_update_commit(&plane->layer);
> +	if (state->crtc_x < 0 || state->crtc_y < 0)
> +		return -EINVAL;
> +
> +	if (state->crtc_w + state->crtc_x > mode->hdisplay ||
> +	    state->crtc_h + state->crtc_y > mode->vdisplay)
> +		return -EINVAL;
>  
>  	return 0;
>  }
>  
> -int atmel_hlcdc_plane_update_with_mode(struct drm_plane *p,
> -				       struct drm_crtc *crtc,
> -				       struct drm_framebuffer *fb,
> -				       int crtc_x, int crtc_y,
> -				       unsigned int crtc_w,
> -				       unsigned int crtc_h,
> -				       uint32_t src_x, uint32_t src_y,
> -				       uint32_t src_w, uint32_t src_h,
> -				       const struct drm_display_mode *mode)
> +static int atmel_hlcdc_plane_prepare_fb(struct drm_plane *p,
> +					struct drm_framebuffer *fb)
>  {
>  	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> -	struct atmel_hlcdc_plane_update_req req;
> -	int ret = 0;
> -
> -	memset(&req, 0, sizeof(req));
> -	req.crtc_x = crtc_x;
> -	req.crtc_y = crtc_y;
> -	req.crtc_w = crtc_w;
> -	req.crtc_h = crtc_h;
> -	req.src_x = src_x;
> -	req.src_y = src_y;
> -	req.src_w = src_w;
> -	req.src_h = src_h;
> -	req.fb = fb;
> -
> -	ret = atmel_hlcdc_plane_prepare_update_req(&plane->base, &req, mode);
> -	if (ret)
> -		return ret;
>  
> -	if (!req.crtc_h || !req.crtc_w)
> -		return atmel_hlcdc_layer_disable(&plane->layer);
> +	return atmel_hlcdc_layer_update_start(&plane->layer);
> +}
> +
> +static void atmel_hlcdc_plane_cleanup_fb(struct drm_plane *p,
> +					 struct drm_framebuffer *fb)
> +{
> +	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
>  
> -	return atmel_hlcdc_plane_apply_update_req(&plane->base, &req);
> +	atmel_hlcdc_layer_update_rollback(&plane->layer);
>  }
>  
> -static int atmel_hlcdc_plane_update(struct drm_plane *p,
> -				    struct drm_crtc *crtc,
> -				    struct drm_framebuffer *fb,
> -				    int crtc_x, int crtc_y,
> -				    unsigned int crtc_w, unsigned int crtc_h,
> -				    uint32_t src_x, uint32_t src_y,
> -				    uint32_t src_w, uint32_t src_h)
> +static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
> +					    struct drm_plane_state *old_s)
>  {
> -	return atmel_hlcdc_plane_update_with_mode(p, crtc, fb, crtc_x, crtc_y,
> -						  crtc_w, crtc_h, src_x, src_y,
> -						  src_w, src_h, &crtc->hwmode);
> +	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> +	struct atmel_hlcdc_plane_state *state =
> +			drm_plane_state_to_atmel_hlcdc_plane_state(p->state);
> +
> +	if (!p->state->crtc || !p->state->fb)
> +		return;
> +
> +	atmel_hlcdc_plane_update_pos_and_size(plane, state);
> +	atmel_hlcdc_plane_update_general_settings(plane, state);
> +	atmel_hlcdc_plane_update_format(plane, state);
> +	atmel_hlcdc_plane_update_buffers(plane, state);
> +
> +	atmel_hlcdc_layer_update_commit(&plane->layer);
>  }
>  
> -static int atmel_hlcdc_plane_disable(struct drm_plane *p)
> +static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
> +					     struct drm_plane_state *old_state)
>  {
>  	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
>  
> -	return atmel_hlcdc_layer_disable(&plane->layer);
> +	atmel_hlcdc_layer_disable(&plane->layer);
>  }
>  
>  static void atmel_hlcdc_plane_destroy(struct drm_plane *p)
> @@ -635,38 +661,36 @@ static void atmel_hlcdc_plane_destroy(struct drm_plane *p)
>  	devm_kfree(p->dev->dev, plane);
>  }
>  
> -static int atmel_hlcdc_plane_set_alpha(struct atmel_hlcdc_plane *plane,
> -				       u8 alpha)
> +static int atmel_hlcdc_plane_atomic_set_property(struct drm_plane *p,
> +						 struct drm_plane_state *s,
> +						 struct drm_property *property,
> +						 uint64_t val)
>  {
> -	atmel_hlcdc_layer_update_start(&plane->layer);
> -	atmel_hlcdc_layer_update_cfg(&plane->layer,
> -				     plane->layer.desc->layout.general_config,
> -				     ATMEL_HLCDC_LAYER_GA_MASK,
> -				     alpha << ATMEL_HLCDC_LAYER_GA_SHIFT);
> -	atmel_hlcdc_layer_update_commit(&plane->layer);
> -
> -	return 0;
> -}
> +	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> +	struct atmel_hlcdc_plane_properties *props = plane->properties;
> +	struct atmel_hlcdc_plane_state *state =
> +			drm_plane_state_to_atmel_hlcdc_plane_state(s);
>  
> -static int atmel_hlcdc_plane_set_rotation(struct atmel_hlcdc_plane *plane,
> -					  unsigned int rotation)
> -{
> -	plane->rotation = rotation;
> +	if (property == props->alpha)
> +		state->alpha = val;
> +	else
> +		return -EINVAL;
>  
>  	return 0;
>  }
>  
> -static int atmel_hlcdc_plane_set_property(struct drm_plane *p,
> -					  struct drm_property *property,
> -					  uint64_t value)
> +static int atmel_hlcdc_plane_atomic_get_property(struct drm_plane *p,
> +					const struct drm_plane_state *s,
> +					struct drm_property *property,
> +					uint64_t *val)
>  {
>  	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
>  	struct atmel_hlcdc_plane_properties *props = plane->properties;
> +	const struct atmel_hlcdc_plane_state *state =
> +		container_of(s, const struct atmel_hlcdc_plane_state, base);
>  
>  	if (property == props->alpha)
> -		atmel_hlcdc_plane_set_alpha(plane, value);
> -	else if (property == props->rotation)
> -		atmel_hlcdc_plane_set_rotation(plane, value);
> +		*val = state->alpha;
>  	else
>  		return -EINVAL;
>  
> @@ -694,8 +718,8 @@ static void atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane,
>  
>  	if (desc->layout.xstride && desc->layout.pstride)
>  		drm_object_attach_property(&plane->base.base,
> -					   props->rotation,
> -					   BIT(DRM_ROTATE_0));
> +				plane->base.dev->mode_config.rotation_property,
> +				BIT(DRM_ROTATE_0));
>  
>  	if (desc->layout.csc) {
>  		/*
> @@ -717,11 +741,75 @@ static void atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane,
>  	}
>  }
>  
> +static struct drm_plane_helper_funcs atmel_hlcdc_layer_plane_helper_funcs = {
> +	.prepare_fb = atmel_hlcdc_plane_prepare_fb,
> +	.cleanup_fb = atmel_hlcdc_plane_cleanup_fb,
> +	.atomic_check = atmel_hlcdc_plane_atomic_check,
> +	.atomic_update = atmel_hlcdc_plane_atomic_update,
> +	.atomic_disable = atmel_hlcdc_plane_atomic_disable,
> +};
> +
> +static void atmel_hlcdc_plane_reset(struct drm_plane *p)
> +{
> +	struct atmel_hlcdc_plane_state *state;
> +
> +	if (p->state) {
> +		state = drm_plane_state_to_atmel_hlcdc_plane_state(p->state);
> +
> +		if (state->base.fb)
> +			drm_framebuffer_unreference(state->base.fb);
> +
> +		kfree(state);
> +		p->state = NULL;
> +	}
> +
> +	state = kzalloc(sizeof(*state), GFP_KERNEL);
> +	if (state) {
> +		state->alpha = 255;
> +		p->state = &state->base;
> +		p->state->plane = p;
> +	}
> +}
> +
> +static struct drm_plane_state *
> +atmel_hlcdc_plane_atomic_duplicate_state(struct drm_plane *p)
> +{
> +	struct atmel_hlcdc_plane_state *state =
> +			drm_plane_state_to_atmel_hlcdc_plane_state(p->state);
> +	struct atmel_hlcdc_plane_state *copy;
> +
> +	copy = kmemdup(state, sizeof(*state), GFP_KERNEL);
> +	if (!copy)
> +		return NULL;
> +
> +	if (copy->base.fb)
> +		drm_framebuffer_reference(copy->base.fb);
> +
> +	return &copy->base;
> +}
> +
> +static void atmel_hlcdc_plane_atomic_destroy_state(struct drm_plane *plane,
> +						   struct drm_plane_state *s)
> +{
> +	struct atmel_hlcdc_plane_state *state =
> +			drm_plane_state_to_atmel_hlcdc_plane_state(s);
> +
> +	if (s->fb)
> +		drm_framebuffer_unreference(s->fb);
> +
> +	kfree(state);
> +}
> +
>  static struct drm_plane_funcs layer_plane_funcs = {
> -	.update_plane = atmel_hlcdc_plane_update,
> -	.disable_plane = atmel_hlcdc_plane_disable,
> -	.set_property = atmel_hlcdc_plane_set_property,
> +	.update_plane = drm_atomic_helper_update_plane,
> +	.disable_plane = drm_atomic_helper_disable_plane,
> +	.set_property = drm_atomic_helper_plane_set_property,
>  	.destroy = atmel_hlcdc_plane_destroy,
> +	.reset = atmel_hlcdc_plane_reset,
> +	.atomic_duplicate_state = atmel_hlcdc_plane_atomic_duplicate_state,
> +	.atomic_destroy_state = atmel_hlcdc_plane_atomic_destroy_state,
> +	.atomic_set_property = atmel_hlcdc_plane_atomic_set_property,
> +	.atomic_get_property = atmel_hlcdc_plane_atomic_get_property,
>  };
>  
>  static struct atmel_hlcdc_plane *
> @@ -755,6 +843,9 @@ atmel_hlcdc_plane_create(struct drm_device *dev,
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> +	drm_plane_helper_add(&plane->base,
> +			     &atmel_hlcdc_layer_plane_helper_funcs);
> +
>  	/* Set default property values*/
>  	atmel_hlcdc_plane_init_properties(plane, desc, props);
>  
> @@ -774,12 +865,13 @@ atmel_hlcdc_plane_create_properties(struct drm_device *dev)
>  	if (!props->alpha)
>  		return ERR_PTR(-ENOMEM);
>  
> -	props->rotation = drm_mode_create_rotation_property(dev,
> -						BIT(DRM_ROTATE_0) |
> -						BIT(DRM_ROTATE_90) |
> -						BIT(DRM_ROTATE_180) |
> -						BIT(DRM_ROTATE_270));
> -	if (!props->rotation)
> +	dev->mode_config.rotation_property =
> +			drm_mode_create_rotation_property(dev,
> +							  BIT(DRM_ROTATE_0) |
> +							  BIT(DRM_ROTATE_90) |
> +							  BIT(DRM_ROTATE_180) |
> +							  BIT(DRM_ROTATE_270));
> +	if (!dev->mode_config.rotation_property)
>  		return ERR_PTR(-ENOMEM);
>  
>  	return props;
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
