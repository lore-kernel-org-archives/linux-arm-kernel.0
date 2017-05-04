From: icenowy@aosc.io (icenowy at aosc.io)
Date: Fri, 05 May 2017 01:14:44 +0800
Subject: [PATCH v6 08/13] drm/sun4i: add support for Allwinner DE2 mixers
In-Reply-To: <7f2ef89c2a78015ec31ba83266ac0d0e@aosc.io>
References: <20170504114858.9008-1-icenowy@aosc.io>
 <20170504114858.9008-9-icenowy@aosc.io>
 <20170504130535.6nokhni5a3uxwy66@lukather>
 <522ab8cb2939f0017917c5e9b4065089@aosc.io>
 <7f2ef89c2a78015ec31ba83266ac0d0e@aosc.io>
Message-ID: <70ab91933ecba67747ef50edbd33033d@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-05-05 00:57?icenowy at aosc.io ???
> ? 2017-05-05 00:50?icenowy at aosc.io ???
>> ? 2017-05-04 21:05?Maxime Ripard ???
>>> On Thu, May 04, 2017 at 07:48:53PM +0800, Icenowy Zheng wrote:
>>>> Allwinner have a new "Display Engine 2.0" in their new SoCs, which 
>>>> comes
>>>> with mixers to do graphic processing and feed data to TCON, like the 
>>>> old
>>>> backends and frontends.
>>>> 
>>>> Add support for the mixer on Allwinner V3s SoC; it's the simplest 
>>>> one.
>>>> 
>>>> Currently a lot of functions are still missing -- more 
>>>> investigations
>>>> are needed to gain enough information for them.
>>>> 
>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>> ---
>>>> Changes in v6:
>>>> - Rebased on wens's multi-pipeline patchset.
>>>> Changes in v5:
>>>> - Changed some code alignment.
>>>> - Request real 32-bit DMA (prepare for 64-bit SoCs).
>>>> Changes in v4:
>>>> - Killed some dead code according to Jernej.
>>>> 
>>>>  drivers/gpu/drm/sun4i/Kconfig       |  10 +
>>>>  drivers/gpu/drm/sun4i/Makefile      |   3 +
>>>>  drivers/gpu/drm/sun4i/sun8i_layer.c | 140 +++++++++++++
>>>>  drivers/gpu/drm/sun4i/sun8i_layer.h |  36 ++++
>>>>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 394 
>>>> ++++++++++++++++++++++++++++++++++++
>>>>  drivers/gpu/drm/sun4i/sun8i_mixer.h | 137 +++++++++++++
>>>>  6 files changed, 720 insertions(+)
>>>>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.c
>>>>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.h
>>>>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.c
>>>>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.h
>>>> 
>>>> diff --git a/drivers/gpu/drm/sun4i/Kconfig 
>>>> b/drivers/gpu/drm/sun4i/Kconfig
>>>> index 5a8227f37cc4..15557484520d 100644
>>>> --- a/drivers/gpu/drm/sun4i/Kconfig
>>>> +++ b/drivers/gpu/drm/sun4i/Kconfig
>>>> @@ -22,3 +22,13 @@ config DRM_SUN4I_BACKEND
>>>>  	  original Allwinner Display Engine, which has a backend to
>>>>  	  do some alpha blending and feed graphics to TCON. If M is
>>>>  	  selected the module will be called sun4i-backend.
>>>> +
>>>> +config DRM_SUN4I_SUN8I_MIXER
>>> 
>>> DRM_SUN8I_MIXER?
>>> 
>>>> +	tristate "Support for Allwinner Display Engine 2.0 Mixer"
>>>> +	depends on DRM_SUN4I
>>>> +	default MACH_SUN8I
>>>> +	help
>>>> +	  Choose this option if you have an Allwinner SoC with the
>>>> +	  Allwinner Display Engine 2.0, which has a mixer to do some
>>>> +	  graphics mixture and feed graphics to TCON, If M is
>>>> +	  selected the module will be called sun8i-mixer.
>>>> diff --git a/drivers/gpu/drm/sun4i/Makefile 
>>>> b/drivers/gpu/drm/sun4i/Makefile
>>>> index a08df56759e3..a876c6b3027c 100644
>>>> --- a/drivers/gpu/drm/sun4i/Makefile
>>>> +++ b/drivers/gpu/drm/sun4i/Makefile
>>>> @@ -8,7 +8,10 @@ sun4i-tcon-y += sun4i_crtc.o
>>>> 
>>>>  sun4i-backend-y += sun4i_backend.o sun4i_layer.o
>>>> 
>>>> +sun8i-mixer-y += sun8i_mixer.o sun8i_layer.o
>>>> +
>>>>  obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
>>>>  obj-$(CONFIG_DRM_SUN4I_BACKEND)		+= sun4i-backend.o
>>>> +obj-$(CONFIG_DRM_SUN4I_SUN8I_MIXER)	+= sun8i-mixer.o
>>>>  obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
>>>>  obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
>>>> diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.c 
>>>> b/drivers/gpu/drm/sun4i/sun8i_layer.c
>>>> new file mode 100644
>>>> index 000000000000..48f33d8e013b
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/sun4i/sun8i_layer.c
>>>> @@ -0,0 +1,140 @@
>>>> +/*
>>>> + * Copyright (C) Icenowy Zheng <icenowy@aosc.io>
>>>> + *
>>>> + * Based on sun4i_layer.h, which is:
>>>> + *   Copyright (C) 2015 Free Electrons
>>>> + *   Copyright (C) 2015 NextThing Co
>>>> + *
>>>> + *   Maxime Ripard <maxime.ripard@free-electrons.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU General Public License as
>>>> + * published by the Free Software Foundation; either version 2 of
>>>> + * the License, or (at your option) any later version.
>>>> + */
>>>> +
>>>> +#include <drm/drm_atomic_helper.h>
>>>> +#include <drm/drm_plane_helper.h>
>>>> +#include <drm/drmP.h>
>>>> +
>>>> +#include "sun8i_layer.h"
>>>> +#include "sun8i_mixer.h"
>>>> +
>>>> +struct sun8i_plane_desc {
>>>> +	       enum drm_plane_type     type;
>>>> +	       const uint32_t          *formats;
>>>> +	       uint32_t                nformats;
>>>> +};
>>>> +
>>>> +static int sun8i_mixer_layer_atomic_check(struct drm_plane *plane,
>>>> +					    struct drm_plane_state *state)
>>>> +{
>>>> +	return 0;
>>>> +}
>>> 
>>> This isn't needed.
>>> 
>>>> +static void sun8i_mixer_layer_atomic_disable(struct drm_plane 
>>>> *plane,
>>>> +					       struct drm_plane_state *old_state)
>>>> +{
>>>> +	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
>>>> +	struct sun8i_mixer *mixer = layer->mixer;
>>>> +
>>>> +	sun8i_mixer_layer_enable(mixer, layer->id, false);
>>>> +}
>>>> +
>>>> +static void sun8i_mixer_layer_atomic_update(struct drm_plane 
>>>> *plane,
>>>> +					      struct drm_plane_state *old_state)
>>>> +{
>>>> +	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
>>>> +	struct sun8i_mixer *mixer = layer->mixer;
>>>> +
>>>> +	sun8i_mixer_update_layer_coord(mixer, layer->id, plane);
>>>> +	sun8i_mixer_update_layer_formats(mixer, layer->id, plane);
>>>> +	sun8i_mixer_update_layer_buffer(mixer, layer->id, plane);
>>>> +	sun8i_mixer_layer_enable(mixer, layer->id, true);
>>>> +}
>>>> +
>>>> +static struct drm_plane_helper_funcs sun8i_mixer_layer_helper_funcs 
>>>> = {
>>>> +	.atomic_check	= sun8i_mixer_layer_atomic_check,
>>>> +	.atomic_disable	= sun8i_mixer_layer_atomic_disable,
>>>> +	.atomic_update	= sun8i_mixer_layer_atomic_update,
>>>> +};
>>>> +
>>>> +static const struct drm_plane_funcs sun8i_mixer_layer_funcs = {
>>>> +	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
>>>> +	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
>>>> +	.destroy		= drm_plane_cleanup,
>>>> +	.disable_plane		= drm_atomic_helper_disable_plane,
>>>> +	.reset			= drm_atomic_helper_plane_reset,
>>>> +	.update_plane		= drm_atomic_helper_update_plane,
>>>> +};
>>>> +
>>>> +static const uint32_t sun8i_mixer_layer_formats[] = {
>>>> +	DRM_FORMAT_RGB888,
>>>> +	DRM_FORMAT_XRGB8888,
>>>> +};
>>>> +
>>>> +static const struct sun8i_plane_desc sun8i_mixer_planes[] = {
>>>> +	{
>>>> +		.type = DRM_PLANE_TYPE_PRIMARY,
>>>> +		.formats = sun8i_mixer_layer_formats,
>>>> +		.nformats = ARRAY_SIZE(sun8i_mixer_layer_formats),
>>>> +	},
>>>> +};
>>>> +
>>>> +static struct sun8i_layer *sun8i_layer_init_one(struct drm_device 
>>>> *drm,
>>>> +						struct sun8i_mixer *mixer,
>>>> +						const struct sun8i_plane_desc *plane)
>>>> +{
>>>> +	struct sun8i_layer *layer;
>>>> +	int ret;
>>>> +
>>>> +	layer = devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
>>>> +	if (!layer)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	/* possible crtcs are set later */
>>>> +	ret = drm_universal_plane_init(drm, &layer->plane, 0,
>>>> +				       &sun8i_mixer_layer_funcs,
>>>> +				       plane->formats, plane->nformats,
>>>> +				       plane->type, NULL);
>>>> +	if (ret) {
>>>> +		dev_err(drm->dev, "Couldn't initialize layer\n");
>>>> +		return ERR_PTR(ret);
>>>> +	}
>>>> +
>>>> +	drm_plane_helper_add(&layer->plane,
>>>> +			     &sun8i_mixer_layer_helper_funcs);
>>>> +	layer->mixer = mixer;
>>>> +
>>>> +	return layer;
>>>> +}
>>>> +
>>>> +struct drm_plane **sun8i_layers_init(struct drm_device *drm,
>>>> +				     struct sunxi_engine *engine)
>>>> +{
>>>> +	struct drm_plane **planes;
>>>> +	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
>>>> +	int i;
>>>> +
>>>> +	planes = devm_kcalloc(drm->dev, ARRAY_SIZE(sun8i_mixer_planes) + 
>>>> 1,
>>>> +			      sizeof(*planes), GFP_KERNEL);
>>>> +	if (!planes)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	for (i = 0; i < ARRAY_SIZE(sun8i_mixer_planes); i++) {
>>>> +		const struct sun8i_plane_desc *plane = &sun8i_mixer_planes[i];
>>>> +		struct sun8i_layer *layer;
>>>> +
>>>> +		layer = sun8i_layer_init_one(drm, mixer, plane);
>>>> +		if (IS_ERR(layer)) {
>>>> +			dev_err(drm->dev, "Couldn't initialize %s plane\n",
>>>> +				i ? "overlay" : "primary");
>>>> +			return ERR_CAST(layer);
>>>> +		};
>>>> +
>>>> +		layer->id = i;
>>>> +		planes[i] = &layer->plane;
>>>> +	};
>>>> +
>>>> +	return planes;
>>>> +}
>>>> diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.h 
>>>> b/drivers/gpu/drm/sun4i/sun8i_layer.h
>>>> new file mode 100644
>>>> index 000000000000..e5eccd27cff0
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/sun4i/sun8i_layer.h
>>>> @@ -0,0 +1,36 @@
>>>> +/*
>>>> + * Copyright (C) Icenowy Zheng <icenowy@aosc.io>
>>>> + *
>>>> + * Based on sun4i_layer.h, which is:
>>>> + *   Copyright (C) 2015 Free Electrons
>>>> + *   Copyright (C) 2015 NextThing Co
>>>> + *
>>>> + *   Maxime Ripard <maxime.ripard@free-electrons.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU General Public License as
>>>> + * published by the Free Software Foundation; either version 2 of
>>>> + * the License, or (at your option) any later version.
>>>> + */
>>>> +
>>>> +#ifndef _SUN8I_LAYER_H_
>>>> +#define _SUN8I_LAYER_H_
>>>> +
>>>> +struct sunxi_engine;
>>>> +
>>>> +struct sun8i_layer {
>>>> +	struct drm_plane	plane;
>>>> +	struct sun4i_drv	*drv;
>>>> +	struct sun8i_mixer	*mixer;
>>>> +	int			id;
>>>> +};
>>>> +
>>>> +static inline struct sun8i_layer *
>>>> +plane_to_sun8i_layer(struct drm_plane *plane)
>>>> +{
>>>> +	return container_of(plane, struct sun8i_layer, plane);
>>>> +}
>>>> +
>>>> +struct drm_plane **sun8i_layers_init(struct drm_device *drm,
>>>> +				     struct sunxi_engine *engine);
>>>> +#endif /* _SUN8I_LAYER_H_ */
>>>> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c 
>>>> b/drivers/gpu/drm/sun4i/sun8i_mixer.c
>>>> new file mode 100644
>>>> index 000000000000..e216b84d5bb2
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
>>>> @@ -0,0 +1,394 @@
>>>> +/*
>>>> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
>>>> + *
>>>> + * Based on sun4i_backend.c, which is:
>>>> + *   Copyright (C) 2015 Free Electrons
>>>> + *   Copyright (C) 2015 NextThing Co
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU General Public License as
>>>> + * published by the Free Software Foundation; either version 2 of
>>>> + * the License, or (at your option) any later version.
>>>> + */
>>>> +
>>>> +#include <drm/drmP.h>
>>>> +#include <drm/drm_atomic_helper.h>
>>>> +#include <drm/drm_crtc.h>
>>>> +#include <drm/drm_crtc_helper.h>
>>>> +#include <drm/drm_fb_cma_helper.h>
>>>> +#include <drm/drm_gem_cma_helper.h>
>>>> +#include <drm/drm_plane_helper.h>
>>>> +
>>>> +#include <linux/component.h>
>>>> +#include <linux/dma-mapping.h>
>>>> +#include <linux/reset.h>
>>>> +#include <linux/of_device.h>
>>>> +
>>>> +#include "sun4i_drv.h"
>>>> +#include "sun8i_mixer.h"
>>>> +#include "sun8i_layer.h"
>>>> +#include "sunxi_engine.h"
>>>> +
>>>> +void sun8i_mixer_commit(struct sunxi_engine *engine)
>>>> +{
>>>> +	DRM_DEBUG_DRIVER("Committing changes\n");
>>>> +
>>>> +	regmap_write(engine->regs, SUN8I_MIXER_GLOBAL_DBUFF,
>>>> +		     SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
>>>> +}
>>> 
>>> This function can be static
>>> 
>>>> +
>>>> +void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
>>>> +				int layer, bool enable)
>>>> +{
>>>> +	u32 val;
>>>> +	/* Currently the first UI channel is used */
>>>> +	int chan = mixer->cfg->vi_num;
>>>> +
>>>> +	DRM_DEBUG_DRIVER("Enabling layer %d in channel %d\n", layer, 
>>>> chan);
>>>> +
>>>> +	if (enable)
>>>> +		val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
>>>> +	else
>>>> +		val = 0;
>>>> +
>>>> +	regmap_update_bits(mixer->engine.regs,
>>>> +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
>>>> +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
>>>> +
>>>> +	/* Set the alpha configuration */
>>>> +	regmap_update_bits(mixer->engine.regs,
>>>> +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
>>>> +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK,
>>>> +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF);
>>>> +	regmap_update_bits(mixer->engine.regs,
>>>> +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
>>>> +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK,
>>>> +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF);
>>>> +}
>>> 
>>> This one too.
>> 
>> It's called from sun8i_layer.c, so it cannot be static.
>> 
>>> 
>>>> +static int sun8i_mixer_drm_format_to_layer(struct drm_plane *plane,
>>>> +					     u32 format, u32 *mode)
>>>> +{
>>>> +	switch (format) {
>>>> +	case DRM_FORMAT_XRGB8888:
>>>> +		*mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_XRGB8888;
>>>> +		break;
>>>> +
>>>> +	case DRM_FORMAT_RGB888:
>>>> +		*mode = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_RGB888;
>>>> +		break;
>>>> +
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
>>>> +				     int layer, struct drm_plane *plane)
>>>> +{
>>>> +	struct drm_plane_state *state = plane->state;
>>>> +	struct drm_framebuffer *fb = state->fb;
>>>> +	/* Currently the first UI channel is used */
>>>> +	int chan = mixer->cfg->vi_num;
>>>> +
>>>> +	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
>>>> +
>>>> +	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
>>>> +		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: 
>>>> %u\n",
>>>> +				 state->crtc_w, state->crtc_h);
>>>> +		regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_SIZE,
>>>> +			     SUN8I_MIXER_SIZE(state->crtc_w,
>>>> +					      state->crtc_h));
>>>> +		DRM_DEBUG_DRIVER("Updating blender size\n");
>>>> +		regmap_write(mixer->engine.regs,
>>>> +			     SUN8I_MIXER_BLEND_ATTR_INSIZE(0),
>>>> +			     SUN8I_MIXER_SIZE(state->crtc_w,
>>>> +					      state->crtc_h));
>>>> +		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTSIZE,
>>>> +			     SUN8I_MIXER_SIZE(state->crtc_w,
>>>> +					      state->crtc_h));
>>>> +		DRM_DEBUG_DRIVER("Updating channel size\n");
>>>> +		regmap_write(mixer->engine.regs,
>>>> +			     SUN8I_MIXER_CHAN_UI_OVL_SIZE(chan),
>>>> +			     SUN8I_MIXER_SIZE(state->crtc_w,
>>>> +					      state->crtc_h));
>>>> +	}
>>>> +
>>>> +	/* Set the line width */
>>>> +	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
>>>> +	regmap_write(mixer->engine.regs,
>>>> +		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(chan, layer),
>>>> +		     fb->pitches[0]);
>>>> +
>>>> +	/* Set height and width */
>>>> +	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n",
>>>> +			 state->crtc_w, state->crtc_h);
>>>> +	regmap_write(mixer->engine.regs,
>>>> +		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(chan, layer),
>>>> +		     SUN8I_MIXER_SIZE(state->crtc_w, state->crtc_h));
>>>> +
>>>> +	/* Set base coordinates */
>>>> +	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
>>>> +			 state->crtc_x, state->crtc_y);
>>>> +	regmap_write(mixer->engine.regs,
>>>> +		     SUN8I_MIXER_CHAN_UI_LAYER_COORD(chan, layer),
>>>> +		     SUN8I_MIXER_COORD(state->crtc_x, state->crtc_y));
>>> 
>>> X and Y are fixed point numbers. You want to keep only the higher 16
>>> bits there.
>> 
>> Do you mean "lower 16 bits"? Thus should I (x & 0xffff) or ((u16)x) ?
> 
> Oh sorry, it's 16.16 ...

Went wrong again... it's surely not 16.16 .
crtc_* is integer, and src_* is 16.16 .

> 
> I'm misled by the sun4i_backend driver.
> 
> May I soon send out a patch to fix the sun4i_backend?
> 
>> 
>> P.S. The negative coordinates are broken, how should I deal with it? 
>> or
>> is the coordinates promised to be not negative?

But surely we should deal with the failure of negative values.

I think I should hack the update_layer_buffer function to deal with the
failure of negative coordinates. -- The status of negative coordinate is
that the display size is croped, but at (0,0) the pixel displayed is 
still
the original (0,0), not the (-crtc_x, -crtc_y).

>> 
>>> 
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
>>>> +				       int layer, struct drm_plane *plane)
>>>> +{
>>>> +	struct drm_plane_state *state = plane->state;
>>>> +	struct drm_framebuffer *fb = state->fb;
>>>> +	bool interlaced = false;
>>>> +	u32 val;
>>>> +	/* Currently the first UI channel is used */
>>>> +	int chan = mixer->cfg->vi_num;
>>>> +	int ret;
>>>> +
>>>> +	if (plane->state->crtc)
>>>> +		interlaced = plane->state->crtc->state->adjusted_mode.flags
>>>> +			& DRM_MODE_FLAG_INTERLACE;
>>>> +
>>>> +	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTCTL,
>>>> +			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
>>>> +			   interlaced ?
>>>> +			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED : 0);
>>>> +
>>>> +	DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
>>>> +			 interlaced ? "on" : "off");
>>>> +
>>>> +	ret = sun8i_mixer_drm_format_to_layer(plane, fb->format->format,
>>>> +						&val);
>>>> +	if (ret) {
>>>> +		DRM_DEBUG_DRIVER("Invalid format\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	regmap_update_bits(mixer->engine.regs,
>>>> +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
>>>> +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
>>>> +				      int layer, struct drm_plane *plane)
>>>> +{
>>>> +	struct drm_plane_state *state = plane->state;
>>>> +	struct drm_framebuffer *fb = state->fb;
>>>> +	struct drm_gem_cma_object *gem;
>>>> +	dma_addr_t paddr;
>>>> +	/* Currently the first UI channel is used */
>>>> +	int chan = mixer->cfg->vi_num;
>>>> +	int bpp;
>>>> +
>>>> +	/* Get the physical address of the buffer in memory */
>>>> +	gem = drm_fb_cma_get_gem_obj(fb, 0);
>>>> +
>>>> +	DRM_DEBUG_DRIVER("Using GEM @ %pad\n", &gem->paddr);
>>>> +
>>>> +	/* Compute the start of the displayed memory */
>>>> +	bpp = fb->format->cpp[0];
>>>> +	paddr = gem->paddr + fb->offsets[0];
>>>> +	paddr += (state->src_x >> 16) * bpp;
>>>> +	paddr += (state->src_y >> 16) * fb->pitches[0];
>>>> +
>>>> +	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
>>>> +
>>>> +	regmap_write(mixer->engine.regs,
>>>> +		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(chan, layer),
>>>> +		     lower_32_bits(paddr));
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct sunxi_engine_ops sun8i_engine_ops = {
>>>> +	.commit		= sun8i_mixer_commit,
>>>> +	.layers_init	= sun8i_layers_init,
>>>> +};
>>>> +
>>>> +static struct regmap_config sun8i_mixer_regmap_config = {
>>>> +	.reg_bits	= 32,
>>>> +	.val_bits	= 32,
>>>> +	.reg_stride	= 4,
>>>> +	.max_register	= 0xbfffc, /* guessed */
>>>> +};
>>>> +
>>>> +static int sun8i_mixer_bind(struct device *dev, struct device 
>>>> *master,
>>>> +			      void *data)
>>>> +{
>>>> +	struct platform_device *pdev = to_platform_device(dev);
>>>> +	struct drm_device *drm = data;
>>>> +	struct sun4i_drv *drv = drm->dev_private;
>>>> +	struct sun8i_mixer *mixer;
>>>> +	struct resource *res;
>>>> +	void __iomem *regs;
>>>> +	int i, ret;
>>>> +
>>>> +	/*
>>>> +	 * The mixer uses single 32-bit register to store memory
>>>> +	 * addresses, so that it cannot deal with 64-bit memory
>>>> +	 * addresses.
>>>> +	 * Restrict the DMA mask so that the mixer won't be
>>>> +	 * allocated some memory that is too high.
>>>> +	 */
>>>> +	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Cannot do 32-bit DMA.\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	mixer = devm_kzalloc(dev, sizeof(*mixer), GFP_KERNEL);
>>>> +	if (!mixer)
>>>> +		return -ENOMEM;
>>>> +	dev_set_drvdata(dev, mixer);
>>>> +	mixer->engine.ops = &sun8i_engine_ops;
>>>> +	mixer->engine.node = dev->of_node;
>>>> +
>>>> +	mixer->cfg = of_device_get_match_data(dev);
>>>> +	if (!mixer->cfg)
>>>> +		return -EINVAL;
>>>> +
>>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +	regs = devm_ioremap_resource(dev, res);
>>>> +	if (IS_ERR(regs))
>>>> +		return PTR_ERR(regs);
>>>> +
>>>> +	mixer->engine.regs = devm_regmap_init_mmio(dev, regs,
>>>> +						   &sun8i_mixer_regmap_config);
>>>> +	if (IS_ERR(mixer->engine.regs)) {
>>>> +		dev_err(dev, "Couldn't create the mixer regmap\n");
>>>> +		return PTR_ERR(mixer->engine.regs);
>>>> +	}
>>>> +
>>>> +	mixer->reset = devm_reset_control_get(dev, NULL);
>>>> +	if (IS_ERR(mixer->reset)) {
>>>> +		dev_err(dev, "Couldn't get our reset line\n");
>>>> +		return PTR_ERR(mixer->reset);
>>>> +	}
>>>> +
>>>> +	ret = reset_control_deassert(mixer->reset);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Couldn't deassert our reset line\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	mixer->bus_clk = devm_clk_get(dev, "bus");
>>>> +	if (IS_ERR(mixer->bus_clk)) {
>>>> +		dev_err(dev, "Couldn't get the mixer bus clock\n");
>>>> +		ret = PTR_ERR(mixer->bus_clk);
>>>> +		goto err_assert_reset;
>>>> +	}
>>>> +	clk_prepare_enable(mixer->bus_clk);
>>>> +
>>>> +	mixer->mod_clk = devm_clk_get(dev, "mod");
>>>> +	if (IS_ERR(mixer->mod_clk)) {
>>>> +		dev_err(dev, "Couldn't get the mixer module clock\n");
>>>> +		ret = PTR_ERR(mixer->mod_clk);
>>>> +		goto err_disable_bus_clk;
>>>> +	}
>>>> +	clk_prepare_enable(mixer->mod_clk);
>>>> +
>>>> +	list_add_tail(&mixer->engine.list, &drv->engine_list);
>>> 
>>> You didn't call INIT_LIST_HEAD on that list.
>>> 
>>>> +
>>>> +	/* Reset the registers */
>>>> +	for (i = 0x0; i < 0x20000; i += 4)
>>>> +		regmap_write(mixer->engine.regs, i, 0);
>>>> +
>>>> +	/* Enable the mixer */
>>>> +	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_CTL,
>>>> +		     SUN8I_MIXER_GLOBAL_CTL_RT_EN);
>>>> +
>>>> +	/* Initialize blender */
>>>> +	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_FCOLOR_CTL,
>>>> +		     SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF);
>>>> +	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PREMULTIPLY,
>>>> +		     SUN8I_MIXER_BLEND_PREMULTIPLY_DEF);
>>>> +	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR,
>>>> +		     SUN8I_MIXER_BLEND_BKCOLOR_DEF);
>>>> +	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(0),
>>>> +		     SUN8I_MIXER_BLEND_MODE_DEF);
>>>> +	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_CK_CTL,
>>>> +		     SUN8I_MIXER_BLEND_CK_CTL_DEF);
>>>> +
>>>> +	regmap_write(mixer->engine.regs,
>>>> +		     SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
>>>> +		     SUN8I_MIXER_BLEND_ATTR_FCOLOR_DEF);
>>>> +
>>>> +	/* Select the first UI channel */
>>>> +	DRM_DEBUG_DRIVER("Selecting channel %d (first UI channel)\n",
>>>> +			 mixer->cfg->vi_num);
>>>> +	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ROUTE,
>>>> +		     mixer->cfg->vi_num);
>>>> +
>>>> +	return 0;
>>>> +
>>>> +	clk_disable_unprepare(mixer->mod_clk);
>>> 
>>> This line cannot be reached.
>>> 
>>> Maxime
