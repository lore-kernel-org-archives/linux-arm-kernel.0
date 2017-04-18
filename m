From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Apr 2017 10:55:48 +0200
Subject: [PATCH v4 05/11] drm/sun4i: abstract a engine type
In-Reply-To: <20170416120849.54542-6-icenowy@aosc.io>
References: <20170416120849.54542-1-icenowy@aosc.io>
 <20170416120849.54542-6-icenowy@aosc.io>
Message-ID: <20170418085548.4cisone2yfcuizcp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for that rework.

On Sun, Apr 16, 2017 at 08:08:43PM +0800, Icenowy Zheng wrote:
> As we are going to add support for the Allwinner DE2 engine in sun4i-drm
> driver, we will finally have two types of display engines -- the DE1
> backend and the DE2 mixer. They both do some display blending and feed
> graphics data to TCON, so I choose to call them both "engine" here.
> 
> Abstract the engine type to void * and a ops struct, which contains
> functions that should be called outside the engine-specified code (in
> TCON, CRTC or TV Encoder code).
> 
> A dedicated Kconfig option is also added to control whether
> sun4i-backend-specified code (sun4i_backend.c and sun4i_layer.c) should
> be built. As we removed the codes in CRTC code that directly call the
> layer code, we can now extract the layer part and combine it with the
> backend part into a new module, sun4i-backend.ko.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Comments to tag the color correction functions as optional.
> - Check before calling the optional functions.
> - Change layers_init to satisfy new PATCH v4 04/11.
> 
>  drivers/gpu/drm/sun4i/Kconfig         | 10 ++++++++++
>  drivers/gpu/drm/sun4i/Makefile        |  6 ++++--
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 26 +++++++++++++++++++-------
>  drivers/gpu/drm/sun4i/sun4i_backend.h |  5 -----
>  drivers/gpu/drm/sun4i/sun4i_crtc.c    | 14 +++++++-------
>  drivers/gpu/drm/sun4i/sun4i_crtc.h    |  7 ++++---
>  drivers/gpu/drm/sun4i/sun4i_drv.h     |  3 ++-
>  drivers/gpu/drm/sun4i/sun4i_layer.c   |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_layer.h   |  3 ++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.c    |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_tv.c      | 11 ++++++-----
>  drivers/gpu/drm/sun4i/sunxi_engine.h  | 35 +++++++++++++++++++++++++++++++++++
>  12 files changed, 91 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sunxi_engine.h
> 
> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
> index a4b357db8856..5a8227f37cc4 100644
> --- a/drivers/gpu/drm/sun4i/Kconfig
> +++ b/drivers/gpu/drm/sun4i/Kconfig
> @@ -12,3 +12,13 @@ config DRM_SUN4I
>  	  Choose this option if you have an Allwinner SoC with a
>  	  Display Engine. If M is selected the module will be called
>  	  sun4i-drm.
> +
> +config DRM_SUN4I_BACKEND
> +	tristate "Support for Allwinner A10 Display Engine Backend"
> +	depends on DRM_SUN4I
> +	default DRM_SUN4I
> +	help
> +	  Choose this option if you have an Allwinner SoC with the
> +	  original Allwinner Display Engine, which has a backend to
> +	  do some alpha blending and feed graphics to TCON. If M is
> +	  selected the module will be called sun4i-backend.
> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
> index 59b757350a1f..1db1068b9be1 100644
> --- a/drivers/gpu/drm/sun4i/Makefile
> +++ b/drivers/gpu/drm/sun4i/Makefile
> @@ -5,9 +5,11 @@ sun4i-tcon-y += sun4i_tcon.o
>  sun4i-tcon-y += sun4i_rgb.o
>  sun4i-tcon-y += sun4i_dotclock.o
>  sun4i-tcon-y += sun4i_crtc.o
> -sun4i-tcon-y += sun4i_layer.o
> +
> +sun4i-backend-y += sun4i_layer.o
> +sun4i-backend-y += sun4i_backend.o
>  
>  obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
> -obj-$(CONFIG_DRM_SUN4I)		+= sun4i_backend.o
> +obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o
>  obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
>  obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index d660741ba475..a16c96a002a4 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -23,6 +23,8 @@
>  
>  #include "sun4i_backend.h"
>  #include "sun4i_drv.h"
> +#include "sun4i_layer.h"
> +#include "sunxi_engine.h"
>  
>  static const u32 sunxi_rgb2yuv_coef[12] = {
>  	0x00000107, 0x00000204, 0x00000064, 0x00000108,
> @@ -30,9 +32,10 @@ static const u32 sunxi_rgb2yuv_coef[12] = {
>  	0x000001c1, 0x00003e88, 0x00003fb8, 0x00000808
>  };
>  
> -void sun4i_backend_apply_color_correction(struct sun4i_backend *backend)
> +static void sun4i_backend_apply_color_correction(void *engine)
>  {
>  	int i;
> +	struct sun4i_backend *backend = engine;

I'm not really fond of passing an opaque pointer here, and hope that
things will work out.

I think having a common structure, holding the common thingsand a more
specific structure for that one would work better.

Something like

struct sunxi_engine {
       struct regmap	*regs;
};

struct sun4i_backend {
       struct sunxi_engine	engine;

	struct clk		*sat_clk;
	struct reset_control	*sat_reset;
	
};

static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
       struct sun4i_backend *backend = container_of(engine, struct sun4i_backend, engine);

...

> +static const struct sunxi_engine_ops sun4i_backend_engine_ops = {
> +	.commit = sun4i_backend_commit,
> +	.layers_init = sun4i_layers_init,
> +	.apply_color_correction = sun4i_backend_apply_color_correction,
> +	.disable_color_correction = sun4i_backend_disable_color_correction,

Please align the values with tabs, like done in the other structures
created that way in this driver.

>  static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
> @@ -56,7 +55,7 @@ static void sun4i_crtc_atomic_flush(struct drm_crtc *crtc,
>  
>  	DRM_DEBUG_DRIVER("Committing plane changes\n");
>  
> -	sun4i_backend_commit(scrtc->backend);
> +	scrtc->engine_ops->commit(scrtc->engine);

You rely on the backend having setup things properly, which is pretty
fragile. Ideally, you should have a function to check that engine_ops
and commit is !NULL, and call it, and the consumers would use that
function...

> @@ -362,7 +361,9 @@ static void sun4i_tv_disable(struct drm_encoder *encoder)
>  	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
>  			   SUN4I_TVE_EN_ENABLE,
>  			   0);
> -	sun4i_backend_disable_color_correction(backend);
> +
> +	if (crtc->engine_ops->disable_color_correction)
> +		crtc->engine_ops->disable_color_correction(crtc->engine);
>  }

... Instead of having to do it in some cases, but not always ...

>  static void sun4i_tv_enable(struct drm_encoder *encoder)
> @@ -370,11 +371,11 @@ static void sun4i_tv_enable(struct drm_encoder *encoder)
>  	struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
>  	struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
>  	struct sun4i_tcon *tcon = crtc->tcon;
> -	struct sun4i_backend *backend = crtc->backend;
>  
>  	DRM_DEBUG_DRIVER("Enabling the TV Output\n");
>  
> -	sun4i_backend_apply_color_correction(backend);
> +	if (crtc->engine_ops->apply_color_correction)
> +		crtc->engine_ops->apply_color_correction(crtc->engine);
>  
>  	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
>  			   SUN4I_TVE_EN_ENABLE,
> diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
> new file mode 100644
> index 000000000000..a9128abda66f
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
> @@ -0,0 +1,35 @@
> +/*
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#ifndef _SUNXI_ENGINE_H_
> +#define _SUNXI_ENGINE_H_
> +
> +struct sun4i_crtc;
> +
> +struct sunxi_engine_ops {
> +	/* Commit the changes to the engine */
> +	void (*commit)(void *engine);
> +	/* Initialize layers (planes) for this engine */
> +	struct drm_plane **(*layers_init)(struct drm_device *drm,
> +					  struct sun4i_crtc *crtc);
> +
> +	/*
> +	 * These are optional functions for the TV Encoder. Please check
> +	 * their presence before calling them.
> +	 *
> +	 * The first function applies the color space correction needed
> +	 * for outputing correct TV signal.
> +	 *
> +	 * The second function disabled the correction.
> +	 */
> +	void (*apply_color_correction)(void *engine);
> +	void (*disable_color_correction)(void *engine);

... And have to document it.

Please also use kerneldoc for those comments.

Thanks again!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170418/751ea7b2/attachment.sig>
