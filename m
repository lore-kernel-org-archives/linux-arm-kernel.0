From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 28 Feb 2017 11:56:28 +0100
Subject: [PATCH] drm/atmel-hlcdc: Simplify the HLCDC layer logic
In-Reply-To: <1486405627-25714-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1486405627-25714-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <383d6cde-5090-7d8e-6254-fdd6228e57b5@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/02/2017 ? 19:27, Boris Brezillon a ?crit :
> An HLCDC layers in Atmel's nomenclature is either a DRM plane or a 'Post
> Processing Layer' which can be used to output the results of the HLCDC
> composition in a memory buffer.
> 
> atmel_hlcdc_layer.c was designed to be generic enough to be re-usable in
> both cases, but we're not exposing the post-processing layer yet, and
> even if we were, I'm not sure the code would provide the necessary tools
> to manipulate this kind of layer.
> 
> Moreover, the code in atmel_hlcdc_{plane,layer}.c was designed before the
> atomic modesetting API, and was trying solve the
> check-setting/commit-if-ok/rollback-otherwise problem, which is now
> entirely solved by the existing core infrastructure.
> 
> And finally, the code in atmel_hlcdc_layer.c in over-complicated compared
> to what we really need. This rework is a good excuse to simplify it. Note
> that this rework solves an existing resource leak (leading to a -EBUSY
> error) which I failed to clearly identify.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

I have little knowledge for a review, but here is my:

Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com>

on sama5d4 Xplained with PDA 7" screen and based on drm-misc.

> ---
> Hi Daniel,
> 
> You might not remember, but this is something you asked me to do a while
> ago, and it's finally there.
> This patch reworks the Atmel HLCDC plane logic to get rid of all the
> complexity in atmel_hlcdc_layer.c and this includes getting rid of
> drm_flip_work, which you were trying to kill IIRC.
> 
> Regards,
> 
> Boris
> ---
>  drivers/gpu/drm/atmel-hlcdc/Makefile            |   1 -
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c  |  32 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    |  81 +--
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |  62 +--
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c | 666 ------------------------
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h | 334 ++++--------
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 618 +++++++++++-----------
>  7 files changed, 522 insertions(+), 1272 deletions(-)
>  delete mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/Makefile b/drivers/gpu/drm/atmel-hlcdc/Makefile
> index 10ae426e60bd..bb5f8507a8ce 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/Makefile
> +++ b/drivers/gpu/drm/atmel-hlcdc/Makefile
> @@ -1,6 +1,5 @@
>  atmel-hlcdc-dc-y := atmel_hlcdc_crtc.o \
>  		atmel_hlcdc_dc.o \
> -		atmel_hlcdc_layer.o \
>  		atmel_hlcdc_output.o \
>  		atmel_hlcdc_plane.o
>  
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 9b17a66cf0e1..cdf8aa2b7a8d 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -445,8 +445,8 @@ static const struct drm_crtc_funcs atmel_hlcdc_crtc_funcs = {
>  
>  int atmel_hlcdc_crtc_create(struct drm_device *dev)
>  {
> +	struct drm_plane *primary = NULL, *cursor = NULL;
>  	struct atmel_hlcdc_dc *dc = dev->dev_private;
> -	struct atmel_hlcdc_planes *planes = dc->planes;
>  	struct atmel_hlcdc_crtc *crtc;
>  	int ret;
>  	int i;
> @@ -457,20 +457,32 @@ int atmel_hlcdc_crtc_create(struct drm_device *dev)
>  
>  	crtc->dc = dc;
>  
> -	ret = drm_crtc_init_with_planes(dev, &crtc->base,
> -				&planes->primary->base,
> -				planes->cursor ? &planes->cursor->base : NULL,
> -				&atmel_hlcdc_crtc_funcs, NULL);
> +	for (i = 0; i < ATMEL_HLCDC_MAX_LAYERS; i++) {
> +		switch (dc->layers[i].type) {
> +		case ATMEL_HLCDC_BASE_LAYER:
> +			primary = dc->layers[i].plane;
> +			break;
> +
> +		case ATMEL_HLCDC_CURSOR_LAYER:
> +			cursor = dc->layers[i].plane;
> +			break;
> +
> +		default:
> +			break;
> +		}
> +	}
> +
> +	ret = drm_crtc_init_with_planes(dev, &crtc->base, primary, cursor,
> +					&atmel_hlcdc_crtc_funcs, NULL);
>  	if (ret < 0)
>  		goto fail;
>  
>  	crtc->id = drm_crtc_index(&crtc->base);
>  
> -	if (planes->cursor)
> -		planes->cursor->base.possible_crtcs = 1 << crtc->id;
> -
> -	for (i = 0; i < planes->noverlays; i++)
> -		planes->overlays[i]->base.possible_crtcs = 1 << crtc->id;
> +	for (i = 0; i < ATMEL_HLCDC_MAX_LAYERS; i++) {
> +		if (dc->layers[i].type == ATMEL_HLCDC_OVERLAY_LAYER)
> +			dc->layers[i].plane->possible_crtcs = 1 << crtc->id;
> +	}
>  
>  	drm_crtc_helper_add(&crtc->base, &lcdc_crtc_helper_funcs);
>  	drm_crtc_vblank_reset(&crtc->base);
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 0bf32d6ac39b..5e7ba6de1777 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -36,7 +36,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9n12_layers[] = {
>  		.regs_offset = 0x40,
>  		.id = 0,
>  		.type = ATMEL_HLCDC_BASE_LAYER,
> -		.nconfigs = 5,
> +		.cfgs_offset = 0x2c,
>  		.layout = {
>  			.xstride = { 2 },
>  			.default_color = 3,
> @@ -65,7 +65,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9x5_layers[] = {
>  		.regs_offset = 0x40,
>  		.id = 0,
>  		.type = ATMEL_HLCDC_BASE_LAYER,
> -		.nconfigs = 5,
> +		.cfgs_offset = 0x2c,
>  		.layout = {
>  			.xstride = { 2 },
>  			.default_color = 3,
> @@ -80,7 +80,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9x5_layers[] = {
>  		.regs_offset = 0x100,
>  		.id = 1,
>  		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> -		.nconfigs = 10,
> +		.cfgs_offset = 0x2c,
>  		.layout = {
>  			.pos = 2,
>  			.size = 3,
> @@ -98,7 +98,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9x5_layers[] = {
>  		.regs_offset = 0x280,
>  		.id = 2,
>  		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> -		.nconfigs = 17,
> +		.cfgs_offset = 0x4c,
>  		.layout = {
>  			.pos = 2,
>  			.size = 3,
> @@ -109,6 +109,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9x5_layers[] = {
>  			.chroma_key = 10,
>  			.chroma_key_mask = 11,
>  			.general_config = 12,
> +			.scaler_config = 13,
>  			.csc = 14,
>  		},
>  	},
> @@ -118,9 +119,9 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9x5_layers[] = {
>  		.regs_offset = 0x340,
>  		.id = 3,
>  		.type = ATMEL_HLCDC_CURSOR_LAYER,
> -		.nconfigs = 10,
>  		.max_width = 128,
>  		.max_height = 128,
> +		.cfgs_offset = 0x2c,
>  		.layout = {
>  			.pos = 2,
>  			.size = 3,
> @@ -153,7 +154,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d3_layers[] = {
>  		.regs_offset = 0x40,
>  		.id = 0,
>  		.type = ATMEL_HLCDC_BASE_LAYER,
> -		.nconfigs = 7,
> +		.cfgs_offset = 0x2c,
>  		.layout = {
>  			.xstride = { 2 },
>  			.default_color = 3,
> @@ -168,7 +169,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d3_layers[] = {
>  		.regs_offset = 0x140,
>  		.id = 1,
>  		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> -		.nconfigs = 10,
> +		.cfgs_offset = 0x2c,
>  		.layout = {
>  			.pos = 2,
>  			.size = 3,
> @@ -186,7 +187,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d3_layers[] = {
>  		.regs_offset = 0x240,
>  		.id = 2,
>  		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> -		.nconfigs = 10,
> +		.cfgs_offset = 0x2c,
>  		.layout = {
>  			.pos = 2,
>  			.size = 3,
> @@ -204,7 +205,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d3_layers[] = {
>  		.regs_offset = 0x340,
>  		.id = 3,
>  		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> -		.nconfigs = 42,
> +		.cfgs_offset = 0x4c,
>  		.layout = {
>  			.pos = 2,
>  			.size = 3,
> @@ -215,6 +216,11 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d3_layers[] = {
>  			.chroma_key = 10,
>  			.chroma_key_mask = 11,
>  			.general_config = 12,
> +			.scaler_config = 13,
> +			.phicoeffs = {
> +				.x = 17,
> +				.y = 33,
> +			},
>  			.csc = 14,
>  		},
>  	},
> @@ -224,9 +230,9 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d3_layers[] = {
>  		.regs_offset = 0x440,
>  		.id = 4,
>  		.type = ATMEL_HLCDC_CURSOR_LAYER,
> -		.nconfigs = 10,
>  		.max_width = 128,
>  		.max_height = 128,
> +		.cfgs_offset = 0x2c,
>  		.layout = {
>  			.pos = 2,
>  			.size = 3,
> @@ -236,6 +242,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d3_layers[] = {
>  			.chroma_key = 7,
>  			.chroma_key_mask = 8,
>  			.general_config = 9,
> +			.scaler_config = 13,
>  		},
>  	},
>  };
> @@ -260,7 +267,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d4_layers[] = {
>  		.regs_offset = 0x40,
>  		.id = 0,
>  		.type = ATMEL_HLCDC_BASE_LAYER,
> -		.nconfigs = 7,
> +		.cfgs_offset = 0x2c,
>  		.layout = {
>  			.xstride = { 2 },
>  			.default_color = 3,
> @@ -275,7 +282,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d4_layers[] = {
>  		.regs_offset = 0x140,
>  		.id = 1,
>  		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> -		.nconfigs = 10,
> +		.cfgs_offset = 0x2c,
>  		.layout = {
>  			.pos = 2,
>  			.size = 3,
> @@ -293,7 +300,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d4_layers[] = {
>  		.regs_offset = 0x240,
>  		.id = 2,
>  		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> -		.nconfigs = 10,
> +		.cfgs_offset = 0x2c,
>  		.layout = {
>  			.pos = 2,
>  			.size = 3,
> @@ -311,7 +318,7 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d4_layers[] = {
>  		.regs_offset = 0x340,
>  		.id = 3,
>  		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> -		.nconfigs = 42,
> +		.cfgs_offset = 0x4c,
>  		.layout = {
>  			.pos = 2,
>  			.size = 3,
> @@ -322,6 +329,11 @@ static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d4_layers[] = {
>  			.chroma_key = 10,
>  			.chroma_key_mask = 11,
>  			.general_config = 12,
> +			.scaler_config = 13,
> +			.phicoeffs = {
> +				.x = 17,
> +				.y = 33,
> +			},
>  			.csc = 14,
>  		},
>  	},
> @@ -392,6 +404,14 @@ int atmel_hlcdc_dc_mode_valid(struct atmel_hlcdc_dc *dc,
>  	return MODE_OK;
>  }
>  
> +static void atmel_hlcdc_layer_irq(struct atmel_hlcdc_layer *layer)
> +{
> +	if (layer->type == ATMEL_HLCDC_BASE_LAYER ||
> +	    layer->type == ATMEL_HLCDC_OVERLAY_LAYER ||
> +	    layer->type == ATMEL_HLCDC_CURSOR_LAYER)
> +		atmel_hlcdc_plane_irq(layer->plane);
> +}
> +
>  static irqreturn_t atmel_hlcdc_dc_irq_handler(int irq, void *data)
>  {
>  	struct drm_device *dev = data;
> @@ -410,12 +430,8 @@ static irqreturn_t atmel_hlcdc_dc_irq_handler(int irq, void *data)
>  		atmel_hlcdc_crtc_irq(dc->crtc);
>  
>  	for (i = 0; i < ATMEL_HLCDC_MAX_LAYERS; i++) {
> -		struct atmel_hlcdc_layer *layer = dc->layers[i];
> -
> -		if (!(ATMEL_HLCDC_LAYER_STATUS(i) & status) || !layer)
> -			continue;
> -
> -		atmel_hlcdc_layer_irq(layer);
> +		if (ATMEL_HLCDC_LAYER_STATUS(i) & status)
> +			atmel_hlcdc_layer_irq(&dc->layers[i]);
>  	}
>  
>  	return IRQ_HANDLED;
> @@ -537,9 +553,7 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
>  static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
>  {
>  	struct atmel_hlcdc_dc *dc = dev->dev_private;
> -	struct atmel_hlcdc_planes *planes;
>  	int ret;
> -	int i;
>  
>  	drm_mode_config_init(dev);
>  
> @@ -549,25 +563,12 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
>  		return ret;
>  	}
>  
> -	planes = atmel_hlcdc_create_planes(dev);
> -	if (IS_ERR(planes)) {
> -		dev_err(dev->dev, "failed to create planes\n");
> -		return PTR_ERR(planes);
> +	ret = atmel_hlcdc_create_planes(dev);
> +	if (ret) {
> +		dev_err(dev->dev, "failed to create planes: %d\n", ret);
> +		return ret;
>  	}
>  
> -	dc->planes = planes;
> -
> -	dc->layers[planes->primary->layer.desc->id] =
> -						&planes->primary->layer;
> -
> -	if (planes->cursor)
> -		dc->layers[planes->cursor->layer.desc->id] =
> -							&planes->cursor->layer;
> -
> -	for (i = 0; i < planes->noverlays; i++)
> -		dc->layers[planes->overlays[i]->layer.desc->id] =
> -						&planes->overlays[i]->layer;
> -
>  	ret = atmel_hlcdc_crtc_create(dev);
>  	if (ret) {
>  		dev_err(dev->dev, "failed to create crtc\n");
> @@ -703,7 +704,7 @@ static int atmel_hlcdc_dc_irq_postinstall(struct drm_device *dev)
>  
>  	/* Enable interrupts on activated layers */
>  	for (i = 0; i < ATMEL_HLCDC_MAX_LAYERS; i++) {
> -		if (dc->layers[i])
> +		if (dc->layers[i].type != ATMEL_HLCDC_NO_LAYER)
>  			cfg |= ATMEL_HLCDC_LAYER_STATUS(i);
>  	}
>  
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index 7a47f8c094d0..67b80c3a2666 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -23,7 +23,9 @@
>  #define DRM_ATMEL_HLCDC_H
>  
>  #include <linux/clk.h>
> +#include <linux/dmapool.h>
>  #include <linux/irqdomain.h>
> +#include <linux/mfd/atmel-hlcdc.h>
>  #include <linux/pwm.h>
>  
>  #include <drm/drm_atomic.h>
> @@ -38,7 +40,7 @@
>  
>  #include "atmel_hlcdc_layer.h"
>  
> -#define ATMEL_HLCDC_MAX_LAYERS		5
> +#define ATMEL_HLCDC_MAX_LAYERS		6
>  
>  /**
>   * Atmel HLCDC Display Controller description structure.
> @@ -84,47 +86,19 @@ struct atmel_hlcdc_plane_properties {
>  };
>  
>  /**
> - * Atmel HLCDC Plane.
> + * Atmel HLCDC Layer.
>   *
> - * @base: base DRM plane structure
> - * @layer: HLCDC layer structure
> - * @properties: pointer to the property definitions structure
> - * @rotation: current rotation status
> - */
> -struct atmel_hlcdc_plane {
> -	struct drm_plane base;
> -	struct atmel_hlcdc_layer layer;
> -	struct atmel_hlcdc_plane_properties *properties;
> -};
> -
> -static inline struct atmel_hlcdc_plane *
> -drm_plane_to_atmel_hlcdc_plane(struct drm_plane *p)
> -{
> -	return container_of(p, struct atmel_hlcdc_plane, base);
> -}
> -
> -static inline struct atmel_hlcdc_plane *
> -atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *l)
> -{
> -	return container_of(l, struct atmel_hlcdc_plane, layer);
> -}
> -
> -/**
> - * Atmel HLCDC Planes.
> - *
> - * This structure stores the instantiated HLCDC Planes and can be accessed by
> - * the HLCDC Display Controller or the HLCDC CRTC.
> + * A layer can be a DRM plane of a post processing layer used to render
> + * HLCDC composition into memory.
>   *
> - * @primary: primary plane
> - * @cursor: hardware cursor plane
> - * @overlays: overlay plane table
> - * @noverlays: number of overlay planes
> + * @type: layer type
> + * @plane: pointer to the DRM plane exposed by this layer
>   */
> -struct atmel_hlcdc_planes {
> -	struct atmel_hlcdc_plane *primary;
> -	struct atmel_hlcdc_plane *cursor;
> -	struct atmel_hlcdc_plane **overlays;
> -	int noverlays;
> +struct atmel_hlcdc_layer {
> +	enum atmel_hlcdc_layer_type type;
> +	union {
> +		struct drm_plane *plane;
> +	};
>  };
>  
>  /**
> @@ -135,18 +109,18 @@ struct atmel_hlcdc_planes {
>   * @fbdev: framebuffer device attached to the Display Controller
>   * @crtc: CRTC provided by the display controller
>   * @planes: instantiated planes
> - * @layers: active HLCDC layer
> + * @layers: active HLCDC layers
>   * @wq: display controller workqueue
>   * @commit: used for async commit handling
>   */
>  struct atmel_hlcdc_dc {
>  	const struct atmel_hlcdc_dc_desc *desc;
> +	struct dma_pool *dscrpool;
>  	struct atmel_hlcdc *hlcdc;
>  	struct drm_fbdev_cma *fbdev;
>  	struct drm_crtc *crtc;
> -	struct atmel_hlcdc_planes *planes;
> -	struct atmel_hlcdc_layer *layers[ATMEL_HLCDC_MAX_LAYERS];
>  	struct workqueue_struct *wq;
> +	struct atmel_hlcdc_layer layers[ATMEL_HLCDC_MAX_LAYERS];
>  	struct {
>  		wait_queue_head_t wait;
>  		bool pending;
> @@ -159,8 +133,8 @@ extern struct atmel_hlcdc_formats atmel_hlcdc_plane_rgb_and_yuv_formats;
>  int atmel_hlcdc_dc_mode_valid(struct atmel_hlcdc_dc *dc,
>  			      struct drm_display_mode *mode);
>  
> -struct atmel_hlcdc_planes *
> -atmel_hlcdc_create_planes(struct drm_device *dev);
> +int atmel_hlcdc_create_planes(struct drm_device *dev);
> +void atmel_hlcdc_plane_irq(struct drm_plane *plane);
>  
>  int atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_state *c_state);
>  int atmel_hlcdc_plane_prepare_ahb_routing(struct drm_crtc_state *c_state);
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
> deleted file mode 100644
> index 377e43cea9dd..000000000000
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
> +++ /dev/null
> @@ -1,666 +0,0 @@
> -/*
> - * Copyright (C) 2014 Free Electrons
> - * Copyright (C) 2014 Atmel
> - *
> - * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program.  If not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -#include <linux/dma-mapping.h>
> -#include <linux/interrupt.h>
> -
> -#include "atmel_hlcdc_dc.h"
> -
> -static void
> -atmel_hlcdc_layer_fb_flip_release(struct drm_flip_work *work, void *val)
> -{
> -	struct atmel_hlcdc_layer_fb_flip *flip = val;
> -
> -	if (flip->fb)
> -		drm_framebuffer_unreference(flip->fb);
> -	kfree(flip);
> -}
> -
> -static void
> -atmel_hlcdc_layer_fb_flip_destroy(struct atmel_hlcdc_layer_fb_flip *flip)
> -{
> -	if (flip->fb)
> -		drm_framebuffer_unreference(flip->fb);
> -	kfree(flip->task);
> -	kfree(flip);
> -}
> -
> -static void
> -atmel_hlcdc_layer_fb_flip_release_queue(struct atmel_hlcdc_layer *layer,
> -					struct atmel_hlcdc_layer_fb_flip *flip)
> -{
> -	int i;
> -
> -	if (!flip)
> -		return;
> -
> -	for (i = 0; i < layer->max_planes; i++) {
> -		if (!flip->dscrs[i])
> -			break;
> -
> -		flip->dscrs[i]->status = 0;
> -		flip->dscrs[i] = NULL;
> -	}
> -
> -	drm_flip_work_queue_task(&layer->gc, flip->task);
> -	drm_flip_work_commit(&layer->gc, layer->wq);
> -}
> -
> -static void atmel_hlcdc_layer_update_reset(struct atmel_hlcdc_layer *layer,
> -					   int id)
> -{
> -	struct atmel_hlcdc_layer_update *upd = &layer->update;
> -	struct atmel_hlcdc_layer_update_slot *slot;
> -
> -	if (id < 0 || id > 1)
> -		return;
> -
> -	slot = &upd->slots[id];
> -	bitmap_clear(slot->updated_configs, 0, layer->desc->nconfigs);
> -	memset(slot->configs, 0,
> -	       sizeof(*slot->configs) * layer->desc->nconfigs);
> -
> -	if (slot->fb_flip) {
> -		atmel_hlcdc_layer_fb_flip_release_queue(layer, slot->fb_flip);
> -		slot->fb_flip = NULL;
> -	}
> -}
> -
> -static void atmel_hlcdc_layer_update_apply(struct atmel_hlcdc_layer *layer)
> -{
> -	struct atmel_hlcdc_layer_dma_channel *dma = &layer->dma;
> -	const struct atmel_hlcdc_layer_desc *desc = layer->desc;
> -	struct atmel_hlcdc_layer_update *upd = &layer->update;
> -	struct regmap *regmap = layer->hlcdc->regmap;
> -	struct atmel_hlcdc_layer_update_slot *slot;
> -	struct atmel_hlcdc_layer_fb_flip *fb_flip;
> -	struct atmel_hlcdc_dma_channel_dscr *dscr;
> -	unsigned int cfg;
> -	u32 action = 0;
> -	int i = 0;
> -
> -	if (upd->pending < 0 || upd->pending > 1)
> -		return;
> -
> -	slot = &upd->slots[upd->pending];
> -
> -	for_each_set_bit(cfg, slot->updated_configs, layer->desc->nconfigs) {
> -		regmap_write(regmap,
> -			     desc->regs_offset +
> -			     ATMEL_HLCDC_LAYER_CFG(layer, cfg),
> -			     slot->configs[cfg]);
> -		action |= ATMEL_HLCDC_LAYER_UPDATE;
> -	}
> -
> -	fb_flip = slot->fb_flip;
> -
> -	if (!fb_flip->fb)
> -		goto apply;
> -
> -	if (dma->status == ATMEL_HLCDC_LAYER_DISABLED) {
> -		for (i = 0; i < fb_flip->ngems; i++) {
> -			dscr = fb_flip->dscrs[i];
> -			dscr->ctrl = ATMEL_HLCDC_LAYER_DFETCH |
> -				     ATMEL_HLCDC_LAYER_DMA_IRQ |
> -				     ATMEL_HLCDC_LAYER_ADD_IRQ |
> -				     ATMEL_HLCDC_LAYER_DONE_IRQ;
> -
> -			regmap_write(regmap,
> -				     desc->regs_offset +
> -				     ATMEL_HLCDC_LAYER_PLANE_ADDR(i),
> -				     dscr->addr);
> -			regmap_write(regmap,
> -				     desc->regs_offset +
> -				     ATMEL_HLCDC_LAYER_PLANE_CTRL(i),
> -				     dscr->ctrl);
> -			regmap_write(regmap,
> -				     desc->regs_offset +
> -				     ATMEL_HLCDC_LAYER_PLANE_NEXT(i),
> -				     dscr->next);
> -		}
> -
> -		action |= ATMEL_HLCDC_LAYER_DMA_CHAN;
> -		dma->status = ATMEL_HLCDC_LAYER_ENABLED;
> -	} else {
> -		for (i = 0; i < fb_flip->ngems; i++) {
> -			dscr =  fb_flip->dscrs[i];
> -			dscr->ctrl = ATMEL_HLCDC_LAYER_DFETCH |
> -				     ATMEL_HLCDC_LAYER_DMA_IRQ |
> -				     ATMEL_HLCDC_LAYER_DSCR_IRQ |
> -				     ATMEL_HLCDC_LAYER_DONE_IRQ;
> -
> -			regmap_write(regmap,
> -				     desc->regs_offset +
> -				     ATMEL_HLCDC_LAYER_PLANE_HEAD(i),
> -				     dscr->next);
> -		}
> -
> -		action |= ATMEL_HLCDC_LAYER_A2Q;
> -	}
> -
> -	/* Release unneeded descriptors */
> -	for (i = fb_flip->ngems; i < layer->max_planes; i++) {
> -		fb_flip->dscrs[i]->status = 0;
> -		fb_flip->dscrs[i] = NULL;
> -	}
> -
> -	dma->queue = fb_flip;
> -	slot->fb_flip = NULL;
> -
> -apply:
> -	if (action)
> -		regmap_write(regmap,
> -			     desc->regs_offset + ATMEL_HLCDC_LAYER_CHER,
> -			     action);
> -
> -	atmel_hlcdc_layer_update_reset(layer, upd->pending);
> -
> -	upd->pending = -1;
> -}
> -
> -void atmel_hlcdc_layer_irq(struct atmel_hlcdc_layer *layer)
> -{
> -	struct atmel_hlcdc_layer_dma_channel *dma = &layer->dma;
> -	const struct atmel_hlcdc_layer_desc *desc = layer->desc;
> -	struct regmap *regmap = layer->hlcdc->regmap;
> -	struct atmel_hlcdc_layer_fb_flip *flip;
> -	unsigned long flags;
> -	unsigned int isr, imr;
> -	unsigned int status;
> -	unsigned int plane_status;
> -	u32 flip_status;
> -
> -	int i;
> -
> -	regmap_read(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_IMR, &imr);
> -	regmap_read(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_ISR, &isr);
> -	status = imr & isr;
> -	if (!status)
> -		return;
> -
> -	spin_lock_irqsave(&layer->lock, flags);
> -
> -	flip = dma->queue ? dma->queue : dma->cur;
> -
> -	if (!flip) {
> -		spin_unlock_irqrestore(&layer->lock, flags);
> -		return;
> -	}
> -
> -	/*
> -	 * Set LOADED and DONE flags: they'll be cleared if at least one
> -	 * memory plane is not LOADED or DONE.
> -	 */
> -	flip_status = ATMEL_HLCDC_DMA_CHANNEL_DSCR_LOADED |
> -		      ATMEL_HLCDC_DMA_CHANNEL_DSCR_DONE;
> -	for (i = 0; i < flip->ngems; i++) {
> -		plane_status = (status >> (8 * i));
> -
> -		if (plane_status &
> -		    (ATMEL_HLCDC_LAYER_ADD_IRQ |
> -		     ATMEL_HLCDC_LAYER_DSCR_IRQ) &
> -		    ~flip->dscrs[i]->ctrl) {
> -			flip->dscrs[i]->status |=
> -					ATMEL_HLCDC_DMA_CHANNEL_DSCR_LOADED;
> -			flip->dscrs[i]->ctrl |=
> -					ATMEL_HLCDC_LAYER_ADD_IRQ |
> -					ATMEL_HLCDC_LAYER_DSCR_IRQ;
> -		}
> -
> -		if (plane_status &
> -		    ATMEL_HLCDC_LAYER_DONE_IRQ &
> -		    ~flip->dscrs[i]->ctrl) {
> -			flip->dscrs[i]->status |=
> -					ATMEL_HLCDC_DMA_CHANNEL_DSCR_DONE;
> -			flip->dscrs[i]->ctrl |=
> -					ATMEL_HLCDC_LAYER_DONE_IRQ;
> -		}
> -
> -		if (plane_status & ATMEL_HLCDC_LAYER_OVR_IRQ)
> -			flip->dscrs[i]->status |=
> -					ATMEL_HLCDC_DMA_CHANNEL_DSCR_OVERRUN;
> -
> -		/*
> -		 * Clear LOADED and DONE flags if the memory plane is either
> -		 * not LOADED or not DONE.
> -		 */
> -		if (!(flip->dscrs[i]->status &
> -		      ATMEL_HLCDC_DMA_CHANNEL_DSCR_LOADED))
> -			flip_status &= ~ATMEL_HLCDC_DMA_CHANNEL_DSCR_LOADED;
> -
> -		if (!(flip->dscrs[i]->status &
> -		      ATMEL_HLCDC_DMA_CHANNEL_DSCR_DONE))
> -			flip_status &= ~ATMEL_HLCDC_DMA_CHANNEL_DSCR_DONE;
> -
> -		/*
> -		 * An overrun on one memory plane impact the whole framebuffer
> -		 * transfer, hence we set the OVERRUN flag as soon as there's
> -		 * one memory plane reporting such an overrun.
> -		 */
> -		flip_status |= flip->dscrs[i]->status &
> -			       ATMEL_HLCDC_DMA_CHANNEL_DSCR_OVERRUN;
> -	}
> -
> -	/* Get changed bits */
> -	flip_status ^= flip->status;
> -	flip->status |= flip_status;
> -
> -	if (flip_status & ATMEL_HLCDC_DMA_CHANNEL_DSCR_LOADED) {
> -		atmel_hlcdc_layer_fb_flip_release_queue(layer, dma->cur);
> -		dma->cur = dma->queue;
> -		dma->queue = NULL;
> -	}
> -
> -	if (flip_status & ATMEL_HLCDC_DMA_CHANNEL_DSCR_DONE) {
> -		atmel_hlcdc_layer_fb_flip_release_queue(layer, dma->cur);
> -		dma->cur = NULL;
> -	}
> -
> -	if (flip_status & ATMEL_HLCDC_DMA_CHANNEL_DSCR_OVERRUN) {
> -		regmap_write(regmap,
> -			     desc->regs_offset + ATMEL_HLCDC_LAYER_CHDR,
> -			     ATMEL_HLCDC_LAYER_RST);
> -		if (dma->queue)
> -			atmel_hlcdc_layer_fb_flip_release_queue(layer,
> -								dma->queue);
> -
> -		if (dma->cur)
> -			atmel_hlcdc_layer_fb_flip_release_queue(layer,
> -								dma->cur);
> -
> -		dma->cur = NULL;
> -		dma->queue = NULL;
> -	}
> -
> -	if (!dma->queue) {
> -		atmel_hlcdc_layer_update_apply(layer);
> -
> -		if (!dma->cur)
> -			dma->status = ATMEL_HLCDC_LAYER_DISABLED;
> -	}
> -
> -	spin_unlock_irqrestore(&layer->lock, flags);
> -}
> -
> -void atmel_hlcdc_layer_disable(struct atmel_hlcdc_layer *layer)
> -{
> -	struct atmel_hlcdc_layer_dma_channel *dma = &layer->dma;
> -	struct atmel_hlcdc_layer_update *upd = &layer->update;
> -	struct regmap *regmap = layer->hlcdc->regmap;
> -	const struct atmel_hlcdc_layer_desc *desc = layer->desc;
> -	unsigned long flags;
> -	unsigned int isr;
> -
> -	spin_lock_irqsave(&layer->lock, flags);
> -
> -	/* Disable the layer */
> -	regmap_write(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_CHDR,
> -		     ATMEL_HLCDC_LAYER_RST | ATMEL_HLCDC_LAYER_A2Q |
> -		     ATMEL_HLCDC_LAYER_UPDATE);
> -
> -	/* Clear all pending interrupts */
> -	regmap_read(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_ISR, &isr);
> -
> -	/* Discard current and queued framebuffer transfers. */
> -	if (dma->cur) {
> -		atmel_hlcdc_layer_fb_flip_release_queue(layer, dma->cur);
> -		dma->cur = NULL;
> -	}
> -
> -	if (dma->queue) {
> -		atmel_hlcdc_layer_fb_flip_release_queue(layer, dma->queue);
> -		dma->queue = NULL;
> -	}
> -
> -	/*
> -	 * Then discard the pending update request (if any) to prevent
> -	 * DMA irq handler from restarting the DMA channel after it has
> -	 * been disabled.
> -	 */
> -	if (upd->pending >= 0) {
> -		atmel_hlcdc_layer_update_reset(layer, upd->pending);
> -		upd->pending = -1;
> -	}
> -
> -	dma->status = ATMEL_HLCDC_LAYER_DISABLED;
> -
> -	spin_unlock_irqrestore(&layer->lock, flags);
> -}
> -
> -int atmel_hlcdc_layer_update_start(struct atmel_hlcdc_layer *layer)
> -{
> -	struct atmel_hlcdc_layer_dma_channel *dma = &layer->dma;
> -	struct atmel_hlcdc_layer_update *upd = &layer->update;
> -	struct regmap *regmap = layer->hlcdc->regmap;
> -	struct atmel_hlcdc_layer_fb_flip *fb_flip;
> -	struct atmel_hlcdc_layer_update_slot *slot;
> -	unsigned long flags;
> -	int i, j = 0;
> -
> -	fb_flip = kzalloc(sizeof(*fb_flip), GFP_KERNEL);
> -	if (!fb_flip)
> -		return -ENOMEM;
> -
> -	fb_flip->task = drm_flip_work_allocate_task(fb_flip, GFP_KERNEL);
> -	if (!fb_flip->task) {
> -		kfree(fb_flip);
> -		return -ENOMEM;
> -	}
> -
> -	spin_lock_irqsave(&layer->lock, flags);
> -
> -	upd->next = upd->pending ? 0 : 1;
> -
> -	slot = &upd->slots[upd->next];
> -
> -	for (i = 0; i < layer->max_planes * 4; i++) {
> -		if (!dma->dscrs[i].status) {
> -			fb_flip->dscrs[j++] = &dma->dscrs[i];
> -			dma->dscrs[i].status =
> -				ATMEL_HLCDC_DMA_CHANNEL_DSCR_RESERVED;
> -			if (j == layer->max_planes)
> -				break;
> -		}
> -	}
> -
> -	if (j < layer->max_planes) {
> -		for (i = 0; i < j; i++)
> -			fb_flip->dscrs[i]->status = 0;
> -	}
> -
> -	if (j < layer->max_planes) {
> -		spin_unlock_irqrestore(&layer->lock, flags);
> -		atmel_hlcdc_layer_fb_flip_destroy(fb_flip);
> -		return -EBUSY;
> -	}
> -
> -	slot->fb_flip = fb_flip;
> -
> -	if (upd->pending >= 0) {
> -		memcpy(slot->configs,
> -		       upd->slots[upd->pending].configs,
> -		       layer->desc->nconfigs * sizeof(u32));
> -		memcpy(slot->updated_configs,
> -		       upd->slots[upd->pending].updated_configs,
> -		       DIV_ROUND_UP(layer->desc->nconfigs,
> -				    BITS_PER_BYTE * sizeof(unsigned long)) *
> -		       sizeof(unsigned long));
> -		slot->fb_flip->fb = upd->slots[upd->pending].fb_flip->fb;
> -		if (upd->slots[upd->pending].fb_flip->fb) {
> -			slot->fb_flip->fb =
> -				upd->slots[upd->pending].fb_flip->fb;
> -			slot->fb_flip->ngems =
> -				upd->slots[upd->pending].fb_flip->ngems;
> -			drm_framebuffer_reference(slot->fb_flip->fb);
> -		}
> -	} else {
> -		regmap_bulk_read(regmap,
> -				 layer->desc->regs_offset +
> -				 ATMEL_HLCDC_LAYER_CFG(layer, 0),
> -				 upd->slots[upd->next].configs,
> -				 layer->desc->nconfigs);
> -	}
> -
> -	spin_unlock_irqrestore(&layer->lock, flags);
> -
> -	return 0;
> -}
> -
> -void atmel_hlcdc_layer_update_rollback(struct atmel_hlcdc_layer *layer)
> -{
> -	struct atmel_hlcdc_layer_update *upd = &layer->update;
> -
> -	atmel_hlcdc_layer_update_reset(layer, upd->next);
> -	upd->next = -1;
> -}
> -
> -void atmel_hlcdc_layer_update_set_fb(struct atmel_hlcdc_layer *layer,
> -				     struct drm_framebuffer *fb,
> -				     unsigned int *offsets)
> -{
> -	struct atmel_hlcdc_layer_update *upd = &layer->update;
> -	struct atmel_hlcdc_layer_fb_flip *fb_flip;
> -	struct atmel_hlcdc_layer_update_slot *slot;
> -	struct atmel_hlcdc_dma_channel_dscr *dscr;
> -	struct drm_framebuffer *old_fb;
> -	int nplanes = 0;
> -	int i;
> -
> -	if (upd->next < 0 || upd->next > 1)
> -		return;
> -
> -	if (fb)
> -		nplanes = drm_format_num_planes(fb->pixel_format);
> -
> -	if (nplanes > layer->max_planes)
> -		return;
> -
> -	slot = &upd->slots[upd->next];
> -
> -	fb_flip = slot->fb_flip;
> -	old_fb = slot->fb_flip->fb;
> -
> -	for (i = 0; i < nplanes; i++) {
> -		struct drm_gem_cma_object *gem;
> -
> -		dscr = slot->fb_flip->dscrs[i];
> -		gem = drm_fb_cma_get_gem_obj(fb, i);
> -		dscr->addr = gem->paddr + offsets[i];
> -	}
> -
> -	fb_flip->ngems = nplanes;
> -	fb_flip->fb = fb;
> -
> -	if (fb)
> -		drm_framebuffer_reference(fb);
> -
> -	if (old_fb)
> -		drm_framebuffer_unreference(old_fb);
> -}
> -
> -void atmel_hlcdc_layer_update_cfg(struct atmel_hlcdc_layer *layer, int cfg,
> -				  u32 mask, u32 val)
> -{
> -	struct atmel_hlcdc_layer_update *upd = &layer->update;
> -	struct atmel_hlcdc_layer_update_slot *slot;
> -
> -	if (upd->next < 0 || upd->next > 1)
> -		return;
> -
> -	if (cfg >= layer->desc->nconfigs)
> -		return;
> -
> -	slot = &upd->slots[upd->next];
> -	slot->configs[cfg] &= ~mask;
> -	slot->configs[cfg] |= (val & mask);
> -	set_bit(cfg, slot->updated_configs);
> -}
> -
> -void atmel_hlcdc_layer_update_commit(struct atmel_hlcdc_layer *layer)
> -{
> -	struct atmel_hlcdc_layer_dma_channel *dma = &layer->dma;
> -	struct atmel_hlcdc_layer_update *upd = &layer->update;
> -	struct atmel_hlcdc_layer_update_slot *slot;
> -	unsigned long flags;
> -
> -	if (upd->next < 0  || upd->next > 1)
> -		return;
> -
> -	slot = &upd->slots[upd->next];
> -
> -	spin_lock_irqsave(&layer->lock, flags);
> -
> -	/*
> -	 * Release pending update request and replace it by the new one.
> -	 */
> -	if (upd->pending >= 0)
> -		atmel_hlcdc_layer_update_reset(layer, upd->pending);
> -
> -	upd->pending = upd->next;
> -	upd->next = -1;
> -
> -	if (!dma->queue)
> -		atmel_hlcdc_layer_update_apply(layer);
> -
> -	spin_unlock_irqrestore(&layer->lock, flags);
> -
> -
> -	upd->next = -1;
> -}
> -
> -static int atmel_hlcdc_layer_dma_init(struct drm_device *dev,
> -				      struct atmel_hlcdc_layer *layer)
> -{
> -	struct atmel_hlcdc_layer_dma_channel *dma = &layer->dma;
> -	dma_addr_t dma_addr;
> -	int i;
> -
> -	dma->dscrs = dma_alloc_coherent(dev->dev,
> -					layer->max_planes * 4 *
> -					sizeof(*dma->dscrs),
> -					&dma_addr, GFP_KERNEL);
> -	if (!dma->dscrs)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < layer->max_planes * 4; i++) {
> -		struct atmel_hlcdc_dma_channel_dscr *dscr = &dma->dscrs[i];
> -
> -		dscr->next = dma_addr + (i * sizeof(*dscr));
> -	}
> -
> -	return 0;
> -}
> -
> -static void atmel_hlcdc_layer_dma_cleanup(struct drm_device *dev,
> -					  struct atmel_hlcdc_layer *layer)
> -{
> -	struct atmel_hlcdc_layer_dma_channel *dma = &layer->dma;
> -	int i;
> -
> -	for (i = 0; i < layer->max_planes * 4; i++) {
> -		struct atmel_hlcdc_dma_channel_dscr *dscr = &dma->dscrs[i];
> -
> -		dscr->status = 0;
> -	}
> -
> -	dma_free_coherent(dev->dev, layer->max_planes * 4 *
> -			  sizeof(*dma->dscrs), dma->dscrs,
> -			  dma->dscrs[0].next);
> -}
> -
> -static int atmel_hlcdc_layer_update_init(struct drm_device *dev,
> -				struct atmel_hlcdc_layer *layer,
> -				const struct atmel_hlcdc_layer_desc *desc)
> -{
> -	struct atmel_hlcdc_layer_update *upd = &layer->update;
> -	int updated_size;
> -	void *buffer;
> -	int i;
> -
> -	updated_size = DIV_ROUND_UP(desc->nconfigs,
> -				    BITS_PER_BYTE *
> -				    sizeof(unsigned long));
> -
> -	buffer = devm_kzalloc(dev->dev,
> -			      ((desc->nconfigs * sizeof(u32)) +
> -				(updated_size * sizeof(unsigned long))) * 2,
> -			      GFP_KERNEL);
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < 2; i++) {
> -		upd->slots[i].updated_configs = buffer;
> -		buffer += updated_size * sizeof(unsigned long);
> -		upd->slots[i].configs = buffer;
> -		buffer += desc->nconfigs * sizeof(u32);
> -	}
> -
> -	upd->pending = -1;
> -	upd->next = -1;
> -
> -	return 0;
> -}
> -
> -int atmel_hlcdc_layer_init(struct drm_device *dev,
> -			   struct atmel_hlcdc_layer *layer,
> -			   const struct atmel_hlcdc_layer_desc *desc)
> -{
> -	struct atmel_hlcdc_dc *dc = dev->dev_private;
> -	struct regmap *regmap = dc->hlcdc->regmap;
> -	unsigned int tmp;
> -	int ret;
> -	int i;
> -
> -	layer->hlcdc = dc->hlcdc;
> -	layer->wq = dc->wq;
> -	layer->desc = desc;
> -
> -	regmap_write(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_CHDR,
> -		     ATMEL_HLCDC_LAYER_RST);
> -	for (i = 0; i < desc->formats->nformats; i++) {
> -		int nplanes = drm_format_num_planes(desc->formats->formats[i]);
> -
> -		if (nplanes > layer->max_planes)
> -			layer->max_planes = nplanes;
> -	}
> -
> -	spin_lock_init(&layer->lock);
> -	drm_flip_work_init(&layer->gc, desc->name,
> -			   atmel_hlcdc_layer_fb_flip_release);
> -	ret = atmel_hlcdc_layer_dma_init(dev, layer);
> -	if (ret)
> -		return ret;
> -
> -	ret = atmel_hlcdc_layer_update_init(dev, layer, desc);
> -	if (ret)
> -		return ret;
> -
> -	/* Flush Status Register */
> -	regmap_write(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_IDR,
> -		     0xffffffff);
> -	regmap_read(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_ISR,
> -		    &tmp);
> -
> -	tmp = 0;
> -	for (i = 0; i < layer->max_planes; i++)
> -		tmp |= (ATMEL_HLCDC_LAYER_DMA_IRQ |
> -			ATMEL_HLCDC_LAYER_DSCR_IRQ |
> -			ATMEL_HLCDC_LAYER_ADD_IRQ |
> -			ATMEL_HLCDC_LAYER_DONE_IRQ |
> -			ATMEL_HLCDC_LAYER_OVR_IRQ) << (8 * i);
> -
> -	regmap_write(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_IER, tmp);
> -
> -	return 0;
> -}
> -
> -void atmel_hlcdc_layer_cleanup(struct drm_device *dev,
> -			       struct atmel_hlcdc_layer *layer)
> -{
> -	const struct atmel_hlcdc_layer_desc *desc = layer->desc;
> -	struct regmap *regmap = layer->hlcdc->regmap;
> -
> -	regmap_write(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_IDR,
> -		     0xffffffff);
> -	regmap_write(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_CHDR,
> -		     ATMEL_HLCDC_LAYER_RST);
> -
> -	atmel_hlcdc_layer_dma_cleanup(dev, layer);
> -	drm_flip_work_cleanup(&layer->gc);
> -}
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
> index 9beabc940bce..fd766827f651 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
> @@ -20,40 +20,39 @@
>  #ifndef DRM_ATMEL_HLCDC_LAYER_H
>  #define DRM_ATMEL_HLCDC_LAYER_H
>  
> -#include <linux/mfd/atmel-hlcdc.h>
> -
> -#include <drm/drm_crtc.h>
> -#include <drm/drm_flip_work.h>
> -#include <drm/drmP.h>
> -
> -#define ATMEL_HLCDC_LAYER_CHER			0x0
> -#define ATMEL_HLCDC_LAYER_CHDR			0x4
> -#define ATMEL_HLCDC_LAYER_CHSR			0x8
> -#define ATMEL_HLCDC_LAYER_DMA_CHAN		BIT(0)
> +#define ATMEL_HLCDC_LAYER_CHER(l)		((l)->regs_offset + 0x0)
> +#define ATMEL_HLCDC_LAYER_CHDR(l)		((l)->regs_offset + 0x4)
> +#define ATMEL_HLCDC_LAYER_CHSR(l)		((l)->regs_offset + 0x8)
> +#define ATMEL_HLCDC_LAYER_EN			BIT(0)
>  #define ATMEL_HLCDC_LAYER_UPDATE		BIT(1)
>  #define ATMEL_HLCDC_LAYER_A2Q			BIT(2)
>  #define ATMEL_HLCDC_LAYER_RST			BIT(8)
>  
> -#define ATMEL_HLCDC_LAYER_IER			0xc
> -#define ATMEL_HLCDC_LAYER_IDR			0x10
> -#define ATMEL_HLCDC_LAYER_IMR			0x14
> -#define ATMEL_HLCDC_LAYER_ISR			0x18
> +#define ATMEL_HLCDC_LAYER_IER(l)		((l)->regs_offset + 0xc)
> +#define ATMEL_HLCDC_LAYER_IDR(l)		((l)->regs_offset + 0x10)
> +#define ATMEL_HLCDC_LAYER_IMR(l)		((l)->regs_offset + 0x14)
> +#define ATMEL_HLCDC_LAYER_ISR(l)		((l)->regs_offset + 0x18)
>  #define ATMEL_HLCDC_LAYER_DFETCH		BIT(0)
>  #define ATMEL_HLCDC_LAYER_LFETCH		BIT(1)
> -#define ATMEL_HLCDC_LAYER_DMA_IRQ		BIT(2)
> -#define ATMEL_HLCDC_LAYER_DSCR_IRQ		BIT(3)
> -#define ATMEL_HLCDC_LAYER_ADD_IRQ		BIT(4)
> -#define ATMEL_HLCDC_LAYER_DONE_IRQ		BIT(5)
> -#define ATMEL_HLCDC_LAYER_OVR_IRQ		BIT(6)
> -
> -#define ATMEL_HLCDC_LAYER_PLANE_HEAD(n)		(((n) * 0x10) + 0x1c)
> -#define ATMEL_HLCDC_LAYER_PLANE_ADDR(n)		(((n) * 0x10) + 0x20)
> -#define ATMEL_HLCDC_LAYER_PLANE_CTRL(n)		(((n) * 0x10) + 0x24)
> -#define ATMEL_HLCDC_LAYER_PLANE_NEXT(n)		(((n) * 0x10) + 0x28)
> -#define ATMEL_HLCDC_LAYER_CFG(p, c)		(((c) * 4) + ((p)->max_planes * 0x10) + 0x1c)
> -
> -#define ATMEL_HLCDC_LAYER_DMA_CFG_ID		0
> -#define ATMEL_HLCDC_LAYER_DMA_CFG(p)		ATMEL_HLCDC_LAYER_CFG(p, ATMEL_HLCDC_LAYER_DMA_CFG_ID)
> +#define ATMEL_HLCDC_LAYER_DMA_IRQ(p)		BIT(2 + (8 * (p)))
> +#define ATMEL_HLCDC_LAYER_DSCR_IRQ(p)		BIT(3 + (8 * (p)))
> +#define ATMEL_HLCDC_LAYER_ADD_IRQ(p)		BIT(4 + (8 * (p)))
> +#define ATMEL_HLCDC_LAYER_DONE_IRQ(p)		BIT(5 + (8 * (p)))
> +#define ATMEL_HLCDC_LAYER_OVR_IRQ(p)		BIT(6 + (8 * (p)))
> +
> +#define ATMEL_HLCDC_LAYER_PLANE_HEAD(l, p)	\
> +	((l)->regs_offset + ((p) * 0x10) + 0x1c)
> +#define ATMEL_HLCDC_LAYER_PLANE_ADDR(l, p)	\
> +	((l)->regs_offset + ((p) * 0x10) + 0x20)
> +#define ATMEL_HLCDC_LAYER_PLANE_CTRL(l, p)	\
> +	((l)->regs_offset + ((p) * 0x10) + 0x24)
> +#define ATMEL_HLCDC_LAYER_PLANE_NEXT(l, p)	\
> +	((l)->regs_offset + ((p) * 0x10) + 0x28)
> +
> +#define ATMEL_HLCDC_LAYER_CFG(l, c)		\
> +	((l)->regs_offset + (l)->cfgs_offset + ((c) * 4))
> +
> +#define ATMEL_HLCDC_LAYER_DMA_CFG(l)		ATMEL_HLCDC_LAYER_CFG(l, 0)
>  #define ATMEL_HLCDC_LAYER_DMA_SIF		BIT(0)
>  #define ATMEL_HLCDC_LAYER_DMA_BLEN_MASK		GENMASK(5, 4)
>  #define ATMEL_HLCDC_LAYER_DMA_BLEN_SINGLE	(0 << 4)
> @@ -64,48 +63,65 @@
>  #define ATMEL_HLCDC_LAYER_DMA_ROTDIS		BIT(12)
>  #define ATMEL_HLCDC_LAYER_DMA_LOCKDIS		BIT(13)
>  
> -#define ATMEL_HLCDC_LAYER_FORMAT_CFG_ID		1
> -#define ATMEL_HLCDC_LAYER_FORMAT_CFG(p)		ATMEL_HLCDC_LAYER_CFG(p, ATMEL_HLCDC_LAYER_FORMAT_CFG_ID)
> +#define ATMEL_HLCDC_LAYER_FORMAT_CFG(p)		ATMEL_HLCDC_LAYER_CFG(p, 1)
>  #define ATMEL_HLCDC_LAYER_RGB			(0 << 0)
>  #define ATMEL_HLCDC_LAYER_CLUT			(1 << 0)
>  #define ATMEL_HLCDC_LAYER_YUV			(2 << 0)
> -#define ATMEL_HLCDC_RGB_MODE(m)			(((m) & 0xf) << 4)
> -#define ATMEL_HLCDC_CLUT_MODE(m)		(((m) & 0x3) << 8)
> -#define ATMEL_HLCDC_YUV_MODE(m)			(((m) & 0xf) << 12)
> +#define ATMEL_HLCDC_RGB_MODE(m)			\
> +	(ATMEL_HLCDC_LAYER_RGB | (((m) & 0xf) << 4))
> +#define ATMEL_HLCDC_CLUT_MODE(m)		\
> +	(ATMEL_HLCDC_LAYER_CLUT | (((m) & 0x3) << 8))
> +#define ATMEL_HLCDC_YUV_MODE(m)			\
> +	(ATMEL_HLCDC_LAYER_YUV | (((m) & 0xf) << 12))
>  #define ATMEL_HLCDC_YUV422ROT			BIT(16)
>  #define ATMEL_HLCDC_YUV422SWP			BIT(17)
>  #define ATMEL_HLCDC_DSCALEOPT			BIT(20)
>  
> -#define ATMEL_HLCDC_XRGB4444_MODE		(ATMEL_HLCDC_LAYER_RGB | ATMEL_HLCDC_RGB_MODE(0))
> -#define ATMEL_HLCDC_ARGB4444_MODE		(ATMEL_HLCDC_LAYER_RGB | ATMEL_HLCDC_RGB_MODE(1))
> -#define ATMEL_HLCDC_RGBA4444_MODE		(ATMEL_HLCDC_LAYER_RGB | ATMEL_HLCDC_RGB_MODE(2))
> -#define ATMEL_HLCDC_RGB565_MODE			(ATMEL_HLCDC_LAYER_RGB | ATMEL_HLCDC_RGB_MODE(3))
> -#define ATMEL_HLCDC_ARGB1555_MODE		(ATMEL_HLCDC_LAYER_RGB | ATMEL_HLCDC_RGB_MODE(4))
> -#define ATMEL_HLCDC_XRGB8888_MODE		(ATMEL_HLCDC_LAYER_RGB | ATMEL_HLCDC_RGB_MODE(9))
> -#define ATMEL_HLCDC_RGB888_MODE			(ATMEL_HLCDC_LAYER_RGB | ATMEL_HLCDC_RGB_MODE(10))
> -#define ATMEL_HLCDC_ARGB8888_MODE		(ATMEL_HLCDC_LAYER_RGB | ATMEL_HLCDC_RGB_MODE(12))
> -#define ATMEL_HLCDC_RGBA8888_MODE		(ATMEL_HLCDC_LAYER_RGB | ATMEL_HLCDC_RGB_MODE(13))
> -
> -#define ATMEL_HLCDC_AYUV_MODE			(ATMEL_HLCDC_LAYER_YUV | ATMEL_HLCDC_YUV_MODE(0))
> -#define ATMEL_HLCDC_YUYV_MODE			(ATMEL_HLCDC_LAYER_YUV | ATMEL_HLCDC_YUV_MODE(1))
> -#define ATMEL_HLCDC_UYVY_MODE			(ATMEL_HLCDC_LAYER_YUV | ATMEL_HLCDC_YUV_MODE(2))
> -#define ATMEL_HLCDC_YVYU_MODE			(ATMEL_HLCDC_LAYER_YUV | ATMEL_HLCDC_YUV_MODE(3))
> -#define ATMEL_HLCDC_VYUY_MODE			(ATMEL_HLCDC_LAYER_YUV | ATMEL_HLCDC_YUV_MODE(4))
> -#define ATMEL_HLCDC_NV61_MODE			(ATMEL_HLCDC_LAYER_YUV | ATMEL_HLCDC_YUV_MODE(5))
> -#define ATMEL_HLCDC_YUV422_MODE			(ATMEL_HLCDC_LAYER_YUV | ATMEL_HLCDC_YUV_MODE(6))
> -#define ATMEL_HLCDC_NV21_MODE			(ATMEL_HLCDC_LAYER_YUV | ATMEL_HLCDC_YUV_MODE(7))
> -#define ATMEL_HLCDC_YUV420_MODE			(ATMEL_HLCDC_LAYER_YUV | ATMEL_HLCDC_YUV_MODE(8))
> -
> -#define ATMEL_HLCDC_LAYER_POS_CFG(p)		ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.pos)
> -#define ATMEL_HLCDC_LAYER_SIZE_CFG(p)		ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.size)
> -#define ATMEL_HLCDC_LAYER_MEMSIZE_CFG(p)	ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.memsize)
> -#define ATMEL_HLCDC_LAYER_XSTRIDE_CFG(p)	ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.xstride)
> -#define ATMEL_HLCDC_LAYER_PSTRIDE_CFG(p)	ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.pstride)
> -#define ATMEL_HLCDC_LAYER_DFLTCOLOR_CFG(p)	ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.default_color)
> -#define ATMEL_HLCDC_LAYER_CRKEY_CFG(p)		ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.chroma_key)
> -#define ATMEL_HLCDC_LAYER_CRKEY_MASK_CFG(p)	ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.chroma_key_mask)
> -
> -#define ATMEL_HLCDC_LAYER_GENERAL_CFG(p)	ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.general_config)
> +#define ATMEL_HLCDC_XRGB4444_MODE		ATMEL_HLCDC_RGB_MODE(0)
> +#define ATMEL_HLCDC_ARGB4444_MODE		ATMEL_HLCDC_RGB_MODE(1)
> +#define ATMEL_HLCDC_RGBA4444_MODE		ATMEL_HLCDC_RGB_MODE(2)
> +#define ATMEL_HLCDC_RGB565_MODE			ATMEL_HLCDC_RGB_MODE(3)
> +#define ATMEL_HLCDC_ARGB1555_MODE		ATMEL_HLCDC_RGB_MODE(4)
> +#define ATMEL_HLCDC_XRGB8888_MODE		ATMEL_HLCDC_RGB_MODE(9)
> +#define ATMEL_HLCDC_RGB888_MODE			ATMEL_HLCDC_RGB_MODE(10)
> +#define ATMEL_HLCDC_ARGB8888_MODE		ATMEL_HLCDC_RGB_MODE(12)
> +#define ATMEL_HLCDC_RGBA8888_MODE		ATMEL_HLCDC_RGB_MODE(13)
> +
> +#define ATMEL_HLCDC_AYUV_MODE			ATMEL_HLCDC_YUV_MODE(0)
> +#define ATMEL_HLCDC_YUYV_MODE			ATMEL_HLCDC_YUV_MODE(1)
> +#define ATMEL_HLCDC_UYVY_MODE			ATMEL_HLCDC_YUV_MODE(2)
> +#define ATMEL_HLCDC_YVYU_MODE			ATMEL_HLCDC_YUV_MODE(3)
> +#define ATMEL_HLCDC_VYUY_MODE			ATMEL_HLCDC_YUV_MODE(4)
> +#define ATMEL_HLCDC_NV61_MODE			ATMEL_HLCDC_YUV_MODE(5)
> +#define ATMEL_HLCDC_YUV422_MODE			ATMEL_HLCDC_YUV_MODE(6)
> +#define ATMEL_HLCDC_NV21_MODE			ATMEL_HLCDC_YUV_MODE(7)
> +#define ATMEL_HLCDC_YUV420_MODE			ATMEL_HLCDC_YUV_MODE(8)
> +
> +#define ATMEL_HLCDC_LAYER_POS_CFG(l)		\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.pos)
> +#define ATMEL_HLCDC_LAYER_POS(x, y)		((x) | ((y) << 16))
> +
> +#define ATMEL_HLCDC_LAYER_SIZE_CFG(l)		\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.size)
> +#define ATMEL_HLCDC_LAYER_MEMSIZE_CFG(l)	\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.memsize)
> +#define ATMEL_HLCDC_LAYER_SIZE(w, h)		(((w) - 1) | (((h) - 1) << 16))
> +
> +#define ATMEL_HLCDC_LAYER_XSTRIDE_CFG(l, p)	\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.xstride[p])
> +
> +#define ATMEL_HLCDC_LAYER_PSTRIDE_CFG(l, p)	\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.pstride[p])
> +
> +#define ATMEL_HLCDC_LAYER_DFLTCOLOR_CFG(l)	\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.default_color)
> +#define ATMEL_HLCDC_LAYER_CRKEY_CFG(l)		\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.chroma_key)
> +#define ATMEL_HLCDC_LAYER_CRKEY_MASK_CFG(l)	\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.chroma_key_mask)
> +
> +#define ATMEL_HLCDC_LAYER_GENERAL_CFG(l)	\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.general_config)
>  #define ATMEL_HLCDC_LAYER_CRKEY			BIT(0)
>  #define ATMEL_HLCDC_LAYER_INV			BIT(1)
>  #define ATMEL_HLCDC_LAYER_ITER2BL		BIT(2)
> @@ -119,14 +135,32 @@
>  #define ATMEL_HLCDC_LAYER_DSTKEY		BIT(10)
>  #define ATMEL_HLCDC_LAYER_DISCEN		BIT(11)
>  #define ATMEL_HLCDC_LAYER_GA_SHIFT		16
> -#define ATMEL_HLCDC_LAYER_GA_MASK		GENMASK(23, ATMEL_HLCDC_LAYER_GA_SHIFT)
> -#define ATMEL_HLCDC_LAYER_GA(x)			((x) << ATMEL_HLCDC_LAYER_GA_SHIFT)
> +#define ATMEL_HLCDC_LAYER_GA_MASK		\
> +	GENMASK(23, ATMEL_HLCDC_LAYER_GA_SHIFT)
> +#define ATMEL_HLCDC_LAYER_GA(x)			\
> +	((x) << ATMEL_HLCDC_LAYER_GA_SHIFT)
>  
> -#define ATMEL_HLCDC_LAYER_CSC_CFG(p, o)		ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.csc + o)
> +#define ATMEL_HLCDC_LAYER_CSC_CFG(l, o)		\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.csc + (o))
>  
> -#define ATMEL_HLCDC_LAYER_DISC_POS_CFG(p)	ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.disc_pos)
> +#define ATMEL_HLCDC_LAYER_DISC_POS_CFG(l)	\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.disc_pos)
> +#define ATMEL_HLCDC_LAYER_DISC_POS(x, y)	((x) | ((y) << 16))
>  
> -#define ATMEL_HLCDC_LAYER_DISC_SIZE_CFG(p)	ATMEL_HLCDC_LAYER_CFG(p, (p)->desc->layout.disc_size)
> +#define ATMEL_HLCDC_LAYER_DISC_SIZE_CFG(l)	\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.disc_size)
> +#define ATMEL_HLCDC_LAYER_DISC_SIZE(w, h)	(((w) - 1) | (((h) - 1) << 16))
> +
> +#define ATMEL_HLCDC_LAYER_SCALER_CFG(l)		\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.scaler_config)
> +#define ATMEL_HLCDC_LAYER_SCALER_FACTORS(x, y)	((x) | ((y) << 16))
> +#define ATMEL_HLCDC_LAYER_SCALER_ENABLE		BIT(31)
> +
> +#define ATMEL_HLCDC_LAYER_XPHICOEFF_CFG(l, i)	\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.phicoeffs.x + ((i) * 4))
> +
> +#define ATMEL_HLCDC_LAYER_YPHICOEFF_CFG(l, i)	\
> +	ATMEL_HLCDC_LAYER_CFG(l, (l)->layout.phicoeffs.y + ((i) * 4))
>  
>  #define ATMEL_HLCDC_MAX_PLANES			3
>  
> @@ -158,6 +192,8 @@
>   * @chroma_key: chroma key register
>   * @chroma_key_mask: chroma key mask register
>   * @general_config: general layer config register
> + * @sacler_config: scaler factors register
> + * @phicoeffs: X/Y PHI coefficient registers
>   * @disc_pos: discard area position register
>   * @disc_size: discard area size register
>   * @csc: color space conversion register
> @@ -172,33 +208,17 @@ struct atmel_hlcdc_layer_cfg_layout {
>  	int chroma_key;
>  	int chroma_key_mask;
>  	int general_config;
> +	int scaler_config;
> +	struct {
> +		int x;
> +		int y;
> +	} phicoeffs;
>  	int disc_pos;
>  	int disc_size;
>  	int csc;
>  };
>  
>  /**
> - * Atmel HLCDC framebuffer flip structure
> - *
> - * This structure is allocated when someone asked for a layer update (most
> - * likely a DRM plane update, either primary, overlay or cursor plane) and
> - * released when the layer do not need to reference the framebuffer object
> - * anymore (i.e. the layer was disabled or updated).
> - *
> - * @dscrs: DMA descriptors
> - * @fb: the referenced framebuffer object
> - * @ngems: number of GEM objects referenced by the fb element
> - * @status: fb flip operation status
> - */
> -struct atmel_hlcdc_layer_fb_flip {
> -	struct atmel_hlcdc_dma_channel_dscr *dscrs[ATMEL_HLCDC_MAX_PLANES];
> -	struct drm_flip_task *task;
> -	struct drm_framebuffer *fb;
> -	int ngems;
> -	u32 status;
> -};
> -
> -/**
>   * Atmel HLCDC DMA descriptor structure
>   *
>   * This structure is used by the HLCDC DMA engine to schedule a DMA transfer.
> @@ -210,19 +230,20 @@ struct atmel_hlcdc_layer_fb_flip {
>   * @addr: buffer DMA address
>   * @ctrl: DMA transfer options
>   * @next: next DMA descriptor to fetch
> - * @gem_flip: the attached gem_flip operation
> + * @self: descriptor DMA address
>   */
>  struct atmel_hlcdc_dma_channel_dscr {
>  	dma_addr_t addr;
>  	u32 ctrl;
>  	dma_addr_t next;
> -	u32 status;
> +	dma_addr_t self;
>  } __aligned(sizeof(u64));
>  
>  /**
>   * Atmel HLCDC layer types
>   */
>  enum atmel_hlcdc_layer_type {
> +	ATMEL_HLCDC_NO_LAYER,
>  	ATMEL_HLCDC_BASE_LAYER,
>  	ATMEL_HLCDC_OVERLAY_LAYER,
>  	ATMEL_HLCDC_CURSOR_LAYER,
> @@ -251,7 +272,7 @@ struct atmel_hlcdc_formats {
>   * @type: layer type
>   * @id: layer id
>   * @regs_offset: offset of the layer registers from the HLCDC registers base
> - * @nconfigs: number of config registers provided by this layer
> + * @cfgs_offset: CFGX registers offset from the layer registers base
>   * @formats: supported formats
>   * @layout: config registers layout
>   * @max_width: maximum width supported by this layer (0 means unlimited)
> @@ -262,138 +283,11 @@ struct atmel_hlcdc_layer_desc {
>  	enum atmel_hlcdc_layer_type type;
>  	int id;
>  	int regs_offset;
> -	int nconfigs;
> +	int cfgs_offset;
>  	struct atmel_hlcdc_formats *formats;
>  	struct atmel_hlcdc_layer_cfg_layout layout;
>  	int max_width;
>  	int max_height;
>  };
>  
> -/**
> - * Atmel HLCDC Layer Update Slot structure
> - *
> - * This structure stores layer update requests to be applied on next frame.
> - * This is the base structure behind the atomic layer update infrastructure.
> - *
> - * Atomic layer update provides a way to update all layer's parameters
> - * simultaneously. This is needed to avoid incompatible sequential updates
> - * like this one:
> - * 1) update layer format from RGB888 (1 plane/buffer) to YUV422
> - *    (2 planes/buffers)
> - * 2) the format update is applied but the DMA channel for the second
> - *    plane/buffer is not enabled
> - * 3) enable the DMA channel for the second plane
> - *
> - * @fb_flip: fb_flip object
> - * @updated_configs: bitmask used to record modified configs
> - * @configs: new config values
> - */
> -struct atmel_hlcdc_layer_update_slot {
> -	struct atmel_hlcdc_layer_fb_flip *fb_flip;
> -	unsigned long *updated_configs;
> -	u32 *configs;
> -};
> -
> -/**
> - * Atmel HLCDC Layer Update structure
> - *
> - * This structure provides a way to queue layer update requests.
> - *
> - * At a given time there is at most:
> - *  - one pending update request, which means the update request has been
> - *    committed (or validated) and is waiting for the DMA channel(s) to be
> - *    available
> - *  - one request being prepared, which means someone started a layer update
> - *    but has not committed it yet. There cannot be more than one started
> - *    request, because the update lock is taken when starting a layer update
> - *    and release when committing or rolling back the request.
> - *
> - * @slots: update slots. One is used for pending request and the other one
> - *	   for started update request
> - * @pending: the pending slot index or -1 if no request is pending
> - * @next: the started update slot index or -1 no update has been started
> - */
> -struct atmel_hlcdc_layer_update {
> -	struct atmel_hlcdc_layer_update_slot slots[2];
> -	int pending;
> -	int next;
> -};
> -
> -enum atmel_hlcdc_layer_dma_channel_status {
> -	ATMEL_HLCDC_LAYER_DISABLED,
> -	ATMEL_HLCDC_LAYER_ENABLED,
> -	ATMEL_HLCDC_LAYER_DISABLING,
> -};
> -
> -/**
> - * Atmel HLCDC Layer DMA channel structure
> - *
> - * This structure stores information on the DMA channel associated to a
> - * given layer.
> - *
> - * @status: DMA channel status
> - * @cur: current framebuffer
> - * @queue: next framebuffer
> - * @dscrs: allocated DMA descriptors
> - */
> -struct atmel_hlcdc_layer_dma_channel {
> -	enum atmel_hlcdc_layer_dma_channel_status status;
> -	struct atmel_hlcdc_layer_fb_flip *cur;
> -	struct atmel_hlcdc_layer_fb_flip *queue;
> -	struct atmel_hlcdc_dma_channel_dscr *dscrs;
> -};
> -
> -/**
> - * Atmel HLCDC Layer structure
> - *
> - * This structure stores information on the layer instance.
> - *
> - * @desc: layer description
> - * @max_planes: maximum planes/buffers that can be associated with this layer.
> - *	       This depends on the supported formats.
> - * @hlcdc: pointer to the atmel_hlcdc structure provided by the MFD device
> - * @dma: dma channel
> - * @gc: fb flip garbage collector
> - * @update: update handler
> - * @lock: layer lock
> - */
> -struct atmel_hlcdc_layer {
> -	const struct atmel_hlcdc_layer_desc *desc;
> -	int max_planes;
> -	struct atmel_hlcdc *hlcdc;
> -	struct workqueue_struct *wq;
> -	struct drm_flip_work gc;
> -	struct atmel_hlcdc_layer_dma_channel dma;
> -	struct atmel_hlcdc_layer_update update;
> -	spinlock_t lock;
> -};
> -
> -void atmel_hlcdc_layer_irq(struct atmel_hlcdc_layer *layer);
> -
> -int atmel_hlcdc_layer_init(struct drm_device *dev,
> -			   struct atmel_hlcdc_layer *layer,
> -			   const struct atmel_hlcdc_layer_desc *desc);
> -
> -void atmel_hlcdc_layer_cleanup(struct drm_device *dev,
> -			       struct atmel_hlcdc_layer *layer);
> -
> -void atmel_hlcdc_layer_disable(struct atmel_hlcdc_layer *layer);
> -
> -int atmel_hlcdc_layer_update_start(struct atmel_hlcdc_layer *layer);
> -
> -void atmel_hlcdc_layer_update_cfg(struct atmel_hlcdc_layer *layer, int cfg,
> -				  u32 mask, u32 val);
> -
> -void atmel_hlcdc_layer_update_set_fb(struct atmel_hlcdc_layer *layer,
> -				     struct drm_framebuffer *fb,
> -				     unsigned int *offsets);
> -
> -void atmel_hlcdc_layer_update_set_finished(struct atmel_hlcdc_layer *layer,
> -					   void (*finished)(void *data),
> -					   void *finished_data);
> -
> -void atmel_hlcdc_layer_update_rollback(struct atmel_hlcdc_layer *layer);
> -
> -void atmel_hlcdc_layer_update_commit(struct atmel_hlcdc_layer *layer);
> -
>  #endif /* DRM_ATMEL_HLCDC_LAYER_H */
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 246ed1e33d8a..4fcd91f3d124 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -37,7 +37,6 @@
>   * @xstride: value to add to the pixel pointer between each line
>   * @pstride: value to add to the pixel pointer between each pixel
>   * @nplanes: number of planes (deduced from pixel_format)
> - * @prepared: plane update has been prepared
>   */
>  struct atmel_hlcdc_plane_state {
>  	struct drm_plane_state base;
> @@ -67,7 +66,9 @@ struct atmel_hlcdc_plane_state {
>  	int xstride[ATMEL_HLCDC_MAX_PLANES];
>  	int pstride[ATMEL_HLCDC_MAX_PLANES];
>  	int nplanes;
> -	bool prepared;
> +
> +	/* DMA descriptors. */
> +	struct atmel_hlcdc_dma_channel_dscr *dscrs[ATMEL_HLCDC_MAX_PLANES];
>  };
>  
>  static inline struct atmel_hlcdc_plane_state *
> @@ -76,6 +77,27 @@ drm_plane_state_to_atmel_hlcdc_plane_state(struct drm_plane_state *s)
>  	return container_of(s, struct atmel_hlcdc_plane_state, base);
>  }
>  
> +/**
> + * Atmel HLCDC Plane.
> + *
> + * @base: base DRM plane structure
> + * @desc: HLCDC layer desc structure
> + * @properties: pointer to the property definitions structure
> + * @regmap: HLCDC regmap
> + */
> +struct atmel_hlcdc_plane {
> +	struct drm_plane base;
> +	const struct atmel_hlcdc_layer_desc *desc;
> +	struct atmel_hlcdc_plane_properties *properties;
> +	struct regmap *regmap;
> +};
> +
> +static inline struct atmel_hlcdc_plane *
> +drm_plane_to_atmel_hlcdc_plane(struct drm_plane *p)
> +{
> +	return container_of(p, struct atmel_hlcdc_plane, base);
> +}
> +
>  #define SUBPIXEL_MASK			0xffff
>  
>  static uint32_t rgb_formats[] = {
> @@ -259,130 +281,145 @@ static u32 heo_upscaling_ycoef[] = {
>  	0x00205907,
>  };
>  
> +#define ATMEL_HLCDC_XPHIDEF	4
> +#define ATMEL_HLCDC_YPHIDEF	4
> +
> +static u32 atmel_hlcdc_plane_phiscaler_get_factor(u32 srcsize,
> +						  u32 dstsize,
> +						  u32 phidef)
> +{
> +	u32 factor, max_memsize;
> +
> +	factor = (256 * ((8 * (srcsize - 1)) - phidef)) / (dstsize - 1);
> +	max_memsize = ((factor * (dstsize - 1)) + (256 * phidef)) / 2048;
> +
> +	if (max_memsize > srcsize - 1)
> +		factor--;
> +
> +	return factor;
> +}
> +
>  static void
> -atmel_hlcdc_plane_update_pos_and_size(struct atmel_hlcdc_plane *plane,
> -				      struct atmel_hlcdc_plane_state *state)
> +atmel_hlcdc_plane_scaler_set_phicoeff(struct atmel_hlcdc_plane *plane,
> +				      const u32 *coeff_tab, int size,
> +				      unsigned int reg_offs)
>  {
> -	const struct atmel_hlcdc_layer_cfg_layout *layout =
> -						&plane->layer.desc->layout;
> -
> -	if (layout->size)
> -		atmel_hlcdc_layer_update_cfg(&plane->layer,
> -					     layout->size,
> -					     0xffffffff,
> -					     (state->crtc_w - 1) |
> -					     ((state->crtc_h - 1) << 16));
> -
> -	if (layout->memsize)
> -		atmel_hlcdc_layer_update_cfg(&plane->layer,
> -					     layout->memsize,
> -					     0xffffffff,
> -					     (state->src_w - 1) |
> -					     ((state->src_h - 1) << 16));
> -
> -	if (layout->pos)
> -		atmel_hlcdc_layer_update_cfg(&plane->layer,
> -					     layout->pos,
> -					     0xffffffff,
> -					     state->crtc_x |
> -					     (state->crtc_y  << 16));
> -
> -	/* TODO: rework the rescaling part */
> -	if (state->crtc_w != state->src_w || state->crtc_h != state->src_h) {
> -		u32 factor_reg = 0;
> -
> -		if (state->crtc_w != state->src_w) {
> -			int i;
> -			u32 factor;
> -			u32 *coeff_tab = heo_upscaling_xcoef;
> -			u32 max_memsize;
> -
> -			if (state->crtc_w < state->src_w)
> -				coeff_tab = heo_downscaling_xcoef;
> -			for (i = 0; i < ARRAY_SIZE(heo_upscaling_xcoef); i++)
> -				atmel_hlcdc_layer_update_cfg(&plane->layer,
> -							     17 + i,
> -							     0xffffffff,
> -							     coeff_tab[i]);
> -			factor = ((8 * 256 * state->src_w) - (256 * 4)) /
> -				 state->crtc_w;
> -			factor++;
> -			max_memsize = ((factor * state->crtc_w) + (256 * 4)) /
> -				      2048;
> -			if (max_memsize > state->src_w)
> -				factor--;
> -			factor_reg |= factor | 0x80000000;
> -		}
> +	struct regmap *regmap = plane->regmap;
> +	int i;
>  
> -		if (state->crtc_h != state->src_h) {
> -			int i;
> -			u32 factor;
> -			u32 *coeff_tab = heo_upscaling_ycoef;
> -			u32 max_memsize;
> -
> -			if (state->crtc_h < state->src_h)
> -				coeff_tab = heo_downscaling_ycoef;
> -			for (i = 0; i < ARRAY_SIZE(heo_upscaling_ycoef); i++)
> -				atmel_hlcdc_layer_update_cfg(&plane->layer,
> -							     33 + i,
> -							     0xffffffff,
> -							     coeff_tab[i]);
> -			factor = ((8 * 256 * state->src_h) - (256 * 4)) /
> -				 state->crtc_h;
> -			factor++;
> -			max_memsize = ((factor * state->crtc_h) + (256 * 4)) /
> -				      2048;
> -			if (max_memsize > state->src_h)
> -				factor--;
> -			factor_reg |= (factor << 16) | 0x80000000;
> -		}
> +	for (i = 0; i < size; i++)
> +		regmap_write(regmap, reg_offs + (i * 4), coeff_tab[i]);
> +}
>  
> -		atmel_hlcdc_layer_update_cfg(&plane->layer, 13, 0xffffffff,
> -					     factor_reg);
> +void atmel_hlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
> +				    struct atmel_hlcdc_plane_state *state)
> +{
> +	const struct atmel_hlcdc_layer_desc *desc = plane->desc;
> +	struct regmap *regmap = plane->regmap;
> +	u32 xfactor, yfactor;
> +
> +	if (!desc->layout.scaler_config)
> +		return;
> +
> +	if (state->crtc_w == state->src_w && state->crtc_h == state->src_h) {
> +		regmap_write(regmap, ATMEL_HLCDC_LAYER_SCALER_CFG(desc), 0);
> +		return;
> +	}
> +
> +	if (desc->layout.phicoeffs.x) {
> +		xfactor = atmel_hlcdc_plane_phiscaler_get_factor(state->src_w,
> +							state->crtc_w,
> +							ATMEL_HLCDC_XPHIDEF);
> +
> +		yfactor = atmel_hlcdc_plane_phiscaler_get_factor(state->src_h,
> +							state->crtc_h,
> +							ATMEL_HLCDC_YPHIDEF);
> +
> +		atmel_hlcdc_plane_scaler_set_phicoeff(plane,
> +				state->crtc_w < state->src_w ?
> +				heo_downscaling_xcoef :
> +				heo_upscaling_xcoef,
> +				ARRAY_SIZE(heo_upscaling_xcoef),
> +				ATMEL_HLCDC_LAYER_XPHICOEFF_CFG(desc, 0));
> +
> +		atmel_hlcdc_plane_scaler_set_phicoeff(plane,
> +				state->crtc_h < state->src_h ?
> +				heo_downscaling_ycoef :
> +				heo_upscaling_ycoef,
> +				ARRAY_SIZE(heo_upscaling_ycoef),
> +				ATMEL_HLCDC_LAYER_YPHICOEFF_CFG(desc, 0));
>  	} else {
> -		atmel_hlcdc_layer_update_cfg(&plane->layer, 13, 0xffffffff, 0);
> +		xfactor = (1024 * state->src_w) / state->crtc_w;
> +		yfactor = (1024 * state->src_h) / state->crtc_h;
>  	}
> +
> +	regmap_write(regmap,
> +		     ATMEL_HLCDC_LAYER_SCALER_CFG(desc),
> +		     ATMEL_HLCDC_LAYER_SCALER_ENABLE |
> +		     ATMEL_HLCDC_LAYER_SCALER_FACTORS(xfactor, yfactor));
> +}
> +
> +static void
> +atmel_hlcdc_plane_update_pos_and_size(struct atmel_hlcdc_plane *plane,
> +				      struct atmel_hlcdc_plane_state *state)
> +{
> +	const struct atmel_hlcdc_layer_desc *desc = plane->desc;
> +	struct regmap *regmap = plane->regmap;
> +
> +	if (desc->layout.size)
> +		regmap_write(regmap, ATMEL_HLCDC_LAYER_SIZE_CFG(desc),
> +			     ATMEL_HLCDC_LAYER_SIZE(state->crtc_w,
> +						    state->crtc_h));
> +
> +	if (desc->layout.memsize)
> +		regmap_write(regmap, ATMEL_HLCDC_LAYER_MEMSIZE_CFG(desc),
> +			     ATMEL_HLCDC_LAYER_SIZE(state->src_w,
> +						    state->src_h));
> +
> +	if (desc->layout.pos)
> +		regmap_write(regmap, ATMEL_HLCDC_LAYER_POS_CFG(desc),
> +			     ATMEL_HLCDC_LAYER_POS(state->crtc_x,
> +						   state->crtc_y));
> +
> +	atmel_hlcdc_plane_setup_scaler(plane, state);
>  }
>  
>  static void
>  atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
>  					struct atmel_hlcdc_plane_state *state)
>  {
> -	const struct atmel_hlcdc_layer_cfg_layout *layout =
> -						&plane->layer.desc->layout;
>  	unsigned int cfg = ATMEL_HLCDC_LAYER_DMA;
> +	struct regmap *regmap = plane->regmap;
>  
>  	if (plane->base.type != DRM_PLANE_TYPE_PRIMARY) {
> +		u32 format = state->base.fb->pixel_format;
> +
>  		cfg |= ATMEL_HLCDC_LAYER_OVR | ATMEL_HLCDC_LAYER_ITER2BL |
>  		       ATMEL_HLCDC_LAYER_ITER;
>  
> -		if (atmel_hlcdc_format_embeds_alpha(state->base.fb->pixel_format))
> +		if (atmel_hlcdc_format_embeds_alpha(format))
>  			cfg |= ATMEL_HLCDC_LAYER_LAEN;
>  		else
>  			cfg |= ATMEL_HLCDC_LAYER_GAEN |
>  			       ATMEL_HLCDC_LAYER_GA(state->alpha);
>  	}
>  
> -	atmel_hlcdc_layer_update_cfg(&plane->layer,
> -				     ATMEL_HLCDC_LAYER_DMA_CFG_ID,
> -				     ATMEL_HLCDC_LAYER_DMA_BLEN_MASK |
> -				     ATMEL_HLCDC_LAYER_DMA_SIF,
> -				     ATMEL_HLCDC_LAYER_DMA_BLEN_INCR16 |
> -				     state->ahb_id);
> -
> -	atmel_hlcdc_layer_update_cfg(&plane->layer, layout->general_config,
> -				     ATMEL_HLCDC_LAYER_ITER2BL |
> -				     ATMEL_HLCDC_LAYER_ITER |
> -				     ATMEL_HLCDC_LAYER_GAEN |
> -				     ATMEL_HLCDC_LAYER_GA_MASK |
> -				     ATMEL_HLCDC_LAYER_LAEN |
> -				     ATMEL_HLCDC_LAYER_OVR |
> -				     ATMEL_HLCDC_LAYER_DMA, cfg);
> +	regmap_update_bits(regmap, ATMEL_HLCDC_LAYER_DMA_CFG(plane->desc),
> +			   ATMEL_HLCDC_LAYER_DMA_BLEN_MASK |
> +			   ATMEL_HLCDC_LAYER_DMA_SIF,
> +			   ATMEL_HLCDC_LAYER_DMA_BLEN_INCR16 | state->ahb_id);
> +
> +	regmap_update_bits(regmap, ATMEL_HLCDC_LAYER_GENERAL_CFG(plane->desc),
> +			   ATMEL_HLCDC_LAYER_ITER2BL | ATMEL_HLCDC_LAYER_ITER |
> +			   ATMEL_HLCDC_LAYER_GAEN | ATMEL_HLCDC_LAYER_GA_MASK |
> +			   ATMEL_HLCDC_LAYER_LAEN | ATMEL_HLCDC_LAYER_OVR |
> +			   ATMEL_HLCDC_LAYER_DMA, cfg);
>  }
>  
>  static void atmel_hlcdc_plane_update_format(struct atmel_hlcdc_plane *plane,
>  					struct atmel_hlcdc_plane_state *state)
>  {
> +	struct regmap *regmap = plane->regmap;
>  	u32 cfg;
>  	int ret;
>  
> @@ -396,10 +433,7 @@ static void atmel_hlcdc_plane_update_format(struct atmel_hlcdc_plane *plane,
>  	    drm_rotation_90_or_270(state->base.rotation))
>  		cfg |= ATMEL_HLCDC_YUV422ROT;
>  
> -	atmel_hlcdc_layer_update_cfg(&plane->layer,
> -				     ATMEL_HLCDC_LAYER_FORMAT_CFG_ID,
> -				     0xffffffff,
> -				     cfg);
> +	regmap_write(regmap, ATMEL_HLCDC_LAYER_FORMAT_CFG(plane->desc), cfg);
>  
>  	/*
>  	 * Rotation optimization is not working on RGB888 (rotation is still
> @@ -410,36 +444,51 @@ static void atmel_hlcdc_plane_update_format(struct atmel_hlcdc_plane *plane,
>  	else
>  		cfg = 0;
>  
> -	atmel_hlcdc_layer_update_cfg(&plane->layer,
> -				     ATMEL_HLCDC_LAYER_DMA_CFG_ID,
> -				     ATMEL_HLCDC_LAYER_DMA_ROTDIS, cfg);
> +	regmap_update_bits(regmap, ATMEL_HLCDC_LAYER_DMA_CFG(plane->desc),
> +			   ATMEL_HLCDC_LAYER_DMA_ROTDIS, cfg);
>  }
>  
>  static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
>  					struct atmel_hlcdc_plane_state *state)
>  {
> -	struct atmel_hlcdc_layer *layer = &plane->layer;
> -	const struct atmel_hlcdc_layer_cfg_layout *layout =
> -							&layer->desc->layout;
> +	const struct atmel_hlcdc_layer_desc *desc = plane->desc;
> +	struct drm_framebuffer *fb = state->base.fb;
> +	struct regmap *regmap = plane->regmap;
> +	u32 sr;
>  	int i;
>  
> -	atmel_hlcdc_layer_update_set_fb(&plane->layer, state->base.fb,
> -					state->offsets);
> +	regmap_read(regmap, ATMEL_HLCDC_LAYER_CHSR(desc), &sr);
>  
>  	for (i = 0; i < state->nplanes; i++) {
> -		if (layout->xstride[i]) {
> -			atmel_hlcdc_layer_update_cfg(&plane->layer,
> -						layout->xstride[i],
> -						0xffffffff,
> -						state->xstride[i]);
> -		}
> +		struct drm_gem_cma_object *gem = drm_fb_cma_get_gem_obj(fb, i);
>  
> -		if (layout->pstride[i]) {
> -			atmel_hlcdc_layer_update_cfg(&plane->layer,
> -						layout->pstride[i],
> -						0xffffffff,
> -						state->pstride[i]);
> +		state->dscrs[i]->addr = gem->paddr + state->offsets[i];
> +
> +		regmap_write(regmap,
> +			     ATMEL_HLCDC_LAYER_PLANE_HEAD(desc, i),
> +			     state->dscrs[i]->self);
> +
> +		if (!(sr & ATMEL_HLCDC_LAYER_EN)) {
> +			regmap_write(regmap,
> +				     ATMEL_HLCDC_LAYER_PLANE_ADDR(desc, i),
> +				     state->dscrs[i]->addr);
> +			regmap_write(regmap,
> +				     ATMEL_HLCDC_LAYER_PLANE_CTRL(desc, i),
> +				     state->dscrs[i]->ctrl);
> +			regmap_write(regmap,
> +				     ATMEL_HLCDC_LAYER_PLANE_NEXT(desc, i),
> +				     state->dscrs[i]->self);
>  		}
> +
> +		if (desc->layout.xstride[i])
> +			regmap_write(regmap,
> +				     ATMEL_HLCDC_LAYER_XSTRIDE_CFG(desc, i),
> +				     state->xstride[i]);
> +
> +		if (desc->layout.pstride[i])
> +			regmap_write(regmap,
> +				     ATMEL_HLCDC_LAYER_PSTRIDE_CFG(desc, i),
> +				     state->pstride[i]);
>  	}
>  }
>  
> @@ -489,7 +538,7 @@ atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_state *c_state)
>  	struct drm_plane *ovl;
>  
>  	primary = drm_plane_to_atmel_hlcdc_plane(c_state->crtc->primary);
> -	layout = &primary->layer.desc->layout;
> +	layout = &primary->desc->layout;
>  	if (!layout->disc_pos || !layout->disc_size)
>  		return 0;
>  
> @@ -548,8 +597,7 @@ static void
>  atmel_hlcdc_plane_update_disc_area(struct atmel_hlcdc_plane *plane,
>  				   struct atmel_hlcdc_plane_state *state)
>  {
> -	const struct atmel_hlcdc_layer_cfg_layout *layout =
> -						&plane->layer.desc->layout;
> +	struct regmap *regmap = plane->regmap;
>  	int disc_surface = 0;
>  
>  	if (!state->disc_updated)
> @@ -557,23 +605,19 @@ atmel_hlcdc_plane_update_disc_area(struct atmel_hlcdc_plane *plane,
>  
>  	disc_surface = state->disc_h * state->disc_w;
>  
> -	atmel_hlcdc_layer_update_cfg(&plane->layer, layout->general_config,
> -				ATMEL_HLCDC_LAYER_DISCEN,
> -				disc_surface ? ATMEL_HLCDC_LAYER_DISCEN : 0);
> +	regmap_update_bits(regmap, ATMEL_HLCDC_LAYER_GENERAL_CFG(plane->desc),
> +			   ATMEL_HLCDC_LAYER_DISCEN,
> +			   disc_surface ? ATMEL_HLCDC_LAYER_DISCEN : 0);
>  
>  	if (!disc_surface)
>  		return;
>  
> -	atmel_hlcdc_layer_update_cfg(&plane->layer,
> -				     layout->disc_pos,
> -				     0xffffffff,
> -				     state->disc_x | (state->disc_y << 16));
> +	regmap_write(regmap, ATMEL_HLCDC_LAYER_DISC_POS_CFG(plane->desc),
> +		     ATMEL_HLCDC_LAYER_DISC_POS(state->disc_x, state->disc_y));
>  
> -	atmel_hlcdc_layer_update_cfg(&plane->layer,
> -				     layout->disc_size,
> -				     0xffffffff,
> -				     (state->disc_w - 1) |
> -				     ((state->disc_h - 1) << 16));
> +	regmap_write(regmap, ATMEL_HLCDC_LAYER_DISC_SIZE_CFG(plane->desc),
> +		     ATMEL_HLCDC_LAYER_DISC_SIZE(state->disc_w,
> +						 state->disc_h));
>  }
>  
>  static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
> @@ -582,8 +626,6 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>  	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
>  	struct atmel_hlcdc_plane_state *state =
>  				drm_plane_state_to_atmel_hlcdc_plane_state(s);
> -	const struct atmel_hlcdc_layer_cfg_layout *layout =
> -						&plane->layer.desc->layout;
>  	struct drm_framebuffer *fb = state->base.fb;
>  	const struct drm_display_mode *mode;
>  	struct drm_crtc_state *crtc_state;
> @@ -726,21 +768,19 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>  	state->crtc_w = patched_crtc_w;
>  	state->crtc_h = patched_crtc_h;
>  
> -	if (!layout->size &&
> +	if (!plane->desc->layout.size &&
>  	    (mode->hdisplay != state->crtc_w ||
>  	     mode->vdisplay != state->crtc_h))
>  		return -EINVAL;
>  
> -	if (plane->layer.desc->max_height &&
> -	    state->crtc_h > plane->layer.desc->max_height)
> +	if (plane->desc->max_height && state->crtc_h > plane->desc->max_height)
>  		return -EINVAL;
>  
> -	if (plane->layer.desc->max_width &&
> -	    state->crtc_w > plane->layer.desc->max_width)
> +	if (plane->desc->max_width && state->crtc_w > plane->desc->max_width)
>  		return -EINVAL;
>  
>  	if ((state->crtc_h != state->src_h || state->crtc_w != state->src_w) &&
> -	    (!layout->memsize ||
> +	    (!plane->desc->layout.memsize ||
>  	     atmel_hlcdc_format_embeds_alpha(state->base.fb->pixel_format)))
>  		return -EINVAL;
>  
> @@ -754,65 +794,14 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>  	return 0;
>  }
>  
> -static int atmel_hlcdc_plane_prepare_fb(struct drm_plane *p,
> -					struct drm_plane_state *new_state)
> -{
> -	/*
> -	 * FIXME: we should avoid this const -> non-const cast but it's
> -	 * currently the only solution we have to modify the ->prepared
> -	 * state and rollback the update request.
> -	 * Ideally, we should rework the code to attach all the resources
> -	 * to atmel_hlcdc_plane_state (including the DMA desc allocation),
> -	 * but this require a complete rework of the atmel_hlcdc_layer
> -	 * code.
> -	 */
> -	struct drm_plane_state *s = (struct drm_plane_state *)new_state;
> -	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> -	struct atmel_hlcdc_plane_state *state =
> -			drm_plane_state_to_atmel_hlcdc_plane_state(s);
> -	int ret;
> -
> -	ret = atmel_hlcdc_layer_update_start(&plane->layer);
> -	if (!ret)
> -		state->prepared = true;
> -
> -	return ret;
> -}
> -
> -static void atmel_hlcdc_plane_cleanup_fb(struct drm_plane *p,
> -					 struct drm_plane_state *old_state)
> -{
> -	/*
> -	 * FIXME: we should avoid this const -> non-const cast but it's
> -	 * currently the only solution we have to modify the ->prepared
> -	 * state and rollback the update request.
> -	 * Ideally, we should rework the code to attach all the resources
> -	 * to atmel_hlcdc_plane_state (including the DMA desc allocation),
> -	 * but this require a complete rework of the atmel_hlcdc_layer
> -	 * code.
> -	 */
> -	struct drm_plane_state *s = (struct drm_plane_state *)old_state;
> -	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> -	struct atmel_hlcdc_plane_state *state =
> -			drm_plane_state_to_atmel_hlcdc_plane_state(s);
> -
> -	/*
> -	 * The Request has already been applied or cancelled, nothing to do
> -	 * here.
> -	 */
> -	if (!state->prepared)
> -		return;
> -
> -	atmel_hlcdc_layer_update_rollback(&plane->layer);
> -	state->prepared = false;
> -}
> -
>  static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
>  					    struct drm_plane_state *old_s)
>  {
>  	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
>  	struct atmel_hlcdc_plane_state *state =
>  			drm_plane_state_to_atmel_hlcdc_plane_state(p->state);
> +	struct regmap *regmap = plane->regmap;
> +	u32 sr;
>  
>  	if (!p->state->crtc || !p->state->fb)
>  		return;
> @@ -823,15 +812,37 @@ static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
>  	atmel_hlcdc_plane_update_buffers(plane, state);
>  	atmel_hlcdc_plane_update_disc_area(plane, state);
>  
> -	atmel_hlcdc_layer_update_commit(&plane->layer);
> +	/* Enable the overrun interrupts. */
> +	regmap_write(regmap, ATMEL_HLCDC_LAYER_IER(plane->desc),
> +		     ATMEL_HLCDC_LAYER_OVR_IRQ(0) |
> +		     ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
> +		     ATMEL_HLCDC_LAYER_OVR_IRQ(2));
> +
> +	/* Apply the new config at the next SOF event. */
> +	regmap_read(regmap, ATMEL_HLCDC_LAYER_CHSR(plane->desc), &sr);
> +	regmap_write(regmap, ATMEL_HLCDC_LAYER_CHER(plane->desc),
> +		     ATMEL_HLCDC_LAYER_UPDATE |
> +		     (sr & ATMEL_HLCDC_LAYER_EN ?
> +		      ATMEL_HLCDC_LAYER_A2Q : ATMEL_HLCDC_LAYER_EN));
>  }
>  
>  static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
>  					     struct drm_plane_state *old_state)
>  {
>  	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> +	struct regmap *regmap = plane->regmap;
> +	unsigned int isr;
> +
> +	/* Disable interrupts */
> +	regmap_write(regmap, ATMEL_HLCDC_LAYER_IDR(plane->desc), 0xffffffff);
> +
> +	/* Disable the layer */
> +	regmap_write(regmap, ATMEL_HLCDC_LAYER_CHDR(plane->desc),
> +		     ATMEL_HLCDC_LAYER_RST | ATMEL_HLCDC_LAYER_A2Q |
> +		     ATMEL_HLCDC_LAYER_UPDATE);
>  
> -	atmel_hlcdc_layer_disable(&plane->layer);
> +	/* Clear all pending interrupts */
> +	regmap_read(regmap, ATMEL_HLCDC_LAYER_ISR(plane->desc), &isr);
>  }
>  
>  static void atmel_hlcdc_plane_destroy(struct drm_plane *p)
> @@ -841,10 +852,7 @@ static void atmel_hlcdc_plane_destroy(struct drm_plane *p)
>  	if (plane->base.fb)
>  		drm_framebuffer_unreference(plane->base.fb);
>  
> -	atmel_hlcdc_layer_cleanup(p->dev, &plane->layer);
> -
>  	drm_plane_cleanup(p);
> -	devm_kfree(p->dev->dev, plane);
>  }
>  
>  static int atmel_hlcdc_plane_atomic_set_property(struct drm_plane *p,
> @@ -884,25 +892,23 @@ static int atmel_hlcdc_plane_atomic_get_property(struct drm_plane *p,
>  }
>  
>  static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane,
> -					     const struct atmel_hlcdc_layer_desc *desc,
> -					     struct atmel_hlcdc_plane_properties *props)
> +				struct atmel_hlcdc_plane_properties *props)
>  {
> -	struct regmap *regmap = plane->layer.hlcdc->regmap;
> +	struct regmap *regmap = plane->regmap;
>  
> -	if (desc->type == ATMEL_HLCDC_OVERLAY_LAYER ||
> -	    desc->type == ATMEL_HLCDC_CURSOR_LAYER) {
> +	if (plane->desc->type == ATMEL_HLCDC_OVERLAY_LAYER ||
> +	    plane->desc->type == ATMEL_HLCDC_CURSOR_LAYER) {
>  		drm_object_attach_property(&plane->base.base,
>  					   props->alpha, 255);
>  
>  		/* Set default alpha value */
>  		regmap_update_bits(regmap,
> -				desc->regs_offset +
> -				ATMEL_HLCDC_LAYER_GENERAL_CFG(&plane->layer),
> -				ATMEL_HLCDC_LAYER_GA_MASK,
> -				ATMEL_HLCDC_LAYER_GA_MASK);
> +				   ATMEL_HLCDC_LAYER_GENERAL_CFG(plane->desc),
> +				   ATMEL_HLCDC_LAYER_GA_MASK,
> +				   ATMEL_HLCDC_LAYER_GA_MASK);
>  	}
>  
> -	if (desc->layout.xstride && desc->layout.pstride) {
> +	if (plane->desc->layout.xstride && plane->desc->layout.pstride) {
>  		int ret;
>  
>  		ret = drm_plane_create_rotation_property(&plane->base,
> @@ -915,36 +921,81 @@ static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane,
>  			return ret;
>  	}
>  
> -	if (desc->layout.csc) {
> +	if (plane->desc->layout.csc) {
>  		/*
>  		 * TODO: decare a "yuv-to-rgb-conv-factors" property to let
>  		 * userspace modify these factors (using a BLOB property ?).
>  		 */
> -		regmap_write(regmap,
> -			     desc->regs_offset +
> -			     ATMEL_HLCDC_LAYER_CSC_CFG(&plane->layer, 0),
> +		regmap_write(regmap, ATMEL_HLCDC_LAYER_CSC_CFG(plane->desc, 0),
>  			     0x4c900091);
> -		regmap_write(regmap,
> -			     desc->regs_offset +
> -			     ATMEL_HLCDC_LAYER_CSC_CFG(&plane->layer, 1),
> +		regmap_write(regmap, ATMEL_HLCDC_LAYER_CSC_CFG(plane->desc, 1),
>  			     0x7a5f5090);
> -		regmap_write(regmap,
> -			     desc->regs_offset +
> -			     ATMEL_HLCDC_LAYER_CSC_CFG(&plane->layer, 2),
> +		regmap_write(regmap, ATMEL_HLCDC_LAYER_CSC_CFG(plane->desc, 2),
>  			     0x40040890);
>  	}
>  
>  	return 0;
>  }
>  
> +void atmel_hlcdc_plane_irq(struct drm_plane *p)
> +{
> +	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> +	struct regmap *regmap = plane->regmap;
> +	u32 isr;
> +
> +	regmap_read(regmap, ATMEL_HLCDC_LAYER_ISR(plane->desc), &isr);
> +
> +	/*
> +	 * There's not much we can do in case of overrun except informing
> +	 * the user. However, we are in interrupt context here, hence the
> +	 * use of dev_dbg().
> +	 */
> +	if (isr &
> +	    (ATMEL_HLCDC_LAYER_OVR_IRQ(0) | ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
> +	     ATMEL_HLCDC_LAYER_OVR_IRQ(2)))
> +		dev_dbg(p->dev->dev, "overrun on plane %s\n",
> +			plane->desc->name);
> +}
> +
>  static struct drm_plane_helper_funcs atmel_hlcdc_layer_plane_helper_funcs = {
> -	.prepare_fb = atmel_hlcdc_plane_prepare_fb,
> -	.cleanup_fb = atmel_hlcdc_plane_cleanup_fb,
>  	.atomic_check = atmel_hlcdc_plane_atomic_check,
>  	.atomic_update = atmel_hlcdc_plane_atomic_update,
>  	.atomic_disable = atmel_hlcdc_plane_atomic_disable,
>  };
>  
> +static int atmel_hlcdc_plane_alloc_dscrs(struct drm_plane *p,
> +					 struct atmel_hlcdc_plane_state *state)
> +{
> +	struct atmel_hlcdc_dc *dc = p->dev->dev_private;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(state->dscrs); i++) {
> +		struct atmel_hlcdc_dma_channel_dscr *dscr;
> +		dma_addr_t dscr_dma;
> +
> +		dscr = dma_pool_alloc(dc->dscrpool, GFP_KERNEL, &dscr_dma);
> +		if (!dscr)
> +			goto err;
> +
> +		dscr->addr = 0;
> +		dscr->next = dscr_dma;
> +		dscr->self = dscr_dma;
> +		dscr->ctrl = ATMEL_HLCDC_LAYER_DFETCH;
> +
> +		state->dscrs[i] = dscr;
> +	}
> +
> +	return 0;
> +
> +err:
> +	for (i--; i >= 0; i--) {
> +		dma_pool_free(dc->dscrpool, state->dscrs[i],
> +			      state->dscrs[i]->self);
> +	}
> +
> +	return -ENOMEM;
> +}
> +
>  static void atmel_hlcdc_plane_reset(struct drm_plane *p)
>  {
>  	struct atmel_hlcdc_plane_state *state;
> @@ -961,6 +1012,13 @@ static void atmel_hlcdc_plane_reset(struct drm_plane *p)
>  
>  	state = kzalloc(sizeof(*state), GFP_KERNEL);
>  	if (state) {
> +		if (atmel_hlcdc_plane_alloc_dscrs(p, state)) {
> +			kfree(state);
> +			dev_err(p->dev->dev,
> +				"Failed to allocate initial plane state\n");
> +			return;
> +		}
> +
>  		state->alpha = 255;
>  		p->state = &state->base;
>  		p->state->plane = p;
> @@ -979,7 +1037,13 @@ atmel_hlcdc_plane_atomic_duplicate_state(struct drm_plane *p)
>  		return NULL;
>  
>  	copy->disc_updated = false;
> -	copy->prepared = false;
> +	copy->nplanes = 0;
> +	memset(copy->dscrs, 0, sizeof(copy->dscrs));
> +
> +	if (atmel_hlcdc_plane_alloc_dscrs(p, copy)) {
> +		kfree(copy);
> +		return NULL;
> +	}
>  
>  	if (copy->base.fb)
>  		drm_framebuffer_reference(copy->base.fb);
> @@ -987,11 +1051,18 @@ atmel_hlcdc_plane_atomic_duplicate_state(struct drm_plane *p)
>  	return &copy->base;
>  }
>  
> -static void atmel_hlcdc_plane_atomic_destroy_state(struct drm_plane *plane,
> +static void atmel_hlcdc_plane_atomic_destroy_state(struct drm_plane *p,
>  						   struct drm_plane_state *s)
>  {
>  	struct atmel_hlcdc_plane_state *state =
>  			drm_plane_state_to_atmel_hlcdc_plane_state(s);
> +	struct atmel_hlcdc_dc *dc = p->dev->dev_private;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(state->dscrs); i++) {
> +		dma_pool_free(dc->dscrpool, state->dscrs[i],
> +			      state->dscrs[i]->self);
> +	}
>  
>  	if (s->fb)
>  		drm_framebuffer_unreference(s->fb);
> @@ -1011,22 +1082,22 @@ static struct drm_plane_funcs layer_plane_funcs = {
>  	.atomic_get_property = atmel_hlcdc_plane_atomic_get_property,
>  };
>  
> -static struct atmel_hlcdc_plane *
> -atmel_hlcdc_plane_create(struct drm_device *dev,
> -			 const struct atmel_hlcdc_layer_desc *desc,
> -			 struct atmel_hlcdc_plane_properties *props)
> +static int atmel_hlcdc_plane_create(struct drm_device *dev,
> +				    const struct atmel_hlcdc_layer_desc *desc,
> +				    struct atmel_hlcdc_plane_properties *props)
>  {
> +	struct atmel_hlcdc_dc *dc = dev->dev_private;
>  	struct atmel_hlcdc_plane *plane;
>  	enum drm_plane_type type;
>  	int ret;
>  
>  	plane = devm_kzalloc(dev->dev, sizeof(*plane), GFP_KERNEL);
>  	if (!plane)
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>  
> -	ret = atmel_hlcdc_layer_init(dev, &plane->layer, desc);
> -	if (ret)
> -		return ERR_PTR(ret);
> +	plane->regmap = dc->hlcdc->regmap;
> +	plane->desc = desc;
> +	plane->properties = props;
>  
>  	if (desc->type == ATMEL_HLCDC_BASE_LAYER)
>  		type = DRM_PLANE_TYPE_PRIMARY;
> @@ -1040,17 +1111,20 @@ atmel_hlcdc_plane_create(struct drm_device *dev,
>  				       desc->formats->formats,
>  				       desc->formats->nformats, type, NULL);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return ret;
>  
>  	drm_plane_helper_add(&plane->base,
>  			     &atmel_hlcdc_layer_plane_helper_funcs);
>  
>  	/* Set default property values*/
> -	ret = atmel_hlcdc_plane_init_properties(plane, desc, props);
> +	ret = atmel_hlcdc_plane_init_properties(plane, props);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return ret;
> +
> +	dc->layers[desc->id].type = desc->type;
> +	dc->layers[desc->id].plane = &plane->base;
>  
> -	return plane;
> +	return 0;
>  }
>  
>  static struct atmel_hlcdc_plane_properties *
> @@ -1069,72 +1143,34 @@ atmel_hlcdc_plane_create_properties(struct drm_device *dev)
>  	return props;
>  }
>  
> -struct atmel_hlcdc_planes *
> -atmel_hlcdc_create_planes(struct drm_device *dev)
> +int atmel_hlcdc_create_planes(struct drm_device *dev)
>  {
>  	struct atmel_hlcdc_dc *dc = dev->dev_private;
>  	struct atmel_hlcdc_plane_properties *props;
> -	struct atmel_hlcdc_planes *planes;
>  	const struct atmel_hlcdc_layer_desc *descs = dc->desc->layers;
>  	int nlayers = dc->desc->nlayers;
> -	int i;
> -
> -	planes = devm_kzalloc(dev->dev, sizeof(*planes), GFP_KERNEL);
> -	if (!planes)
> -		return ERR_PTR(-ENOMEM);
> -
> -	for (i = 0; i < nlayers; i++) {
> -		if (descs[i].type == ATMEL_HLCDC_OVERLAY_LAYER)
> -			planes->noverlays++;
> -	}
> -
> -	if (planes->noverlays) {
> -		planes->overlays = devm_kzalloc(dev->dev,
> -						planes->noverlays *
> -						sizeof(*planes->overlays),
> -						GFP_KERNEL);
> -		if (!planes->overlays)
> -			return ERR_PTR(-ENOMEM);
> -	}
> +	int i, ret;
>  
>  	props = atmel_hlcdc_plane_create_properties(dev);
>  	if (IS_ERR(props))
> -		return ERR_CAST(props);
> +		return PTR_ERR(props);
>  
> -	planes->noverlays = 0;
> -	for (i = 0; i < nlayers; i++) {
> -		struct atmel_hlcdc_plane *plane;
> +	dc->dscrpool = dmam_pool_create("atmel-hlcdc-dscr", dev->dev,
> +				sizeof(struct atmel_hlcdc_dma_channel_dscr),
> +				sizeof(u64), 0);
> +	if (!dc->dscrpool)
> +		return -ENOMEM;
>  
> -		if (descs[i].type == ATMEL_HLCDC_PP_LAYER)
> +	for (i = 0; i < nlayers; i++) {
> +		if (descs[i].type != ATMEL_HLCDC_BASE_LAYER &&
> +		    descs[i].type != ATMEL_HLCDC_OVERLAY_LAYER &&
> +		    descs[i].type != ATMEL_HLCDC_CURSOR_LAYER)
>  			continue;
>  
> -		plane = atmel_hlcdc_plane_create(dev, &descs[i], props);
> -		if (IS_ERR(plane))
> -			return ERR_CAST(plane);
> -
> -		plane->properties = props;
> -
> -		switch (descs[i].type) {
> -		case ATMEL_HLCDC_BASE_LAYER:
> -			if (planes->primary)
> -				return ERR_PTR(-EINVAL);
> -			planes->primary = plane;
> -			break;
> -
> -		case ATMEL_HLCDC_OVERLAY_LAYER:
> -			planes->overlays[planes->noverlays++] = plane;
> -			break;
> -
> -		case ATMEL_HLCDC_CURSOR_LAYER:
> -			if (planes->cursor)
> -				return ERR_PTR(-EINVAL);
> -			planes->cursor = plane;
> -			break;
> -
> -		default:
> -			break;
> -		}
> +		ret = atmel_hlcdc_plane_create(dev, &descs[i], props);
> +		if (ret)
> +			return ret;
>  	}
>  
> -	return planes;
> +	return 0;
>  }
> 


-- 
Nicolas Ferre
